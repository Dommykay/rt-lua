hittable = require("hittable")

function Material()
    local material = {}
    return material
end

function Lambertian(albedo)
    local lambertian = Material()

    lambertian.scatter = function (ray, hitmemory)
        local scatterdirection = hitmemory.normal.addvec(randomunitvec3())
        if scatterdirection.nearzero() then
            scatterdirection = hitmemory.normal
        end
        local scattered = instanceray(hitmemory.p, scatterdirection)
        local attenuation = albedo
        return true, scattered, attenuation
    end


    return lambertian
end

function Metal(albedo, glossiness)
    local metal = Material()
    
    metal.finish = 1 - math.max(math.min(glossiness, 1), 0)

    metal.scatter = function (ray, hitmemory)
        local reflected = reflectvector(ray.direction, hitmemory.normal)
        reflected = reflected.unit().addvec(randomunitvec3().multnum(metal.finish))
        local scattered = instanceray(hitmemory.p, reflected)
        local attenuation = albedo
        return (hitmemory.normal.dot(scattered.direction)) > 0, scattered, attenuation
    end


    return metal
end

function Dielectric(refractionindex, albedo)
    local dielectric = Material()
    dielectric.refractionindex = refractionindex
    dielectric.findside = function (hitmemory) if hitmemory.front_face then return dielectric.refractionindex else return 1/dielectric.refractionindex end end

    if albedo ~= nil then
        dielectric.albedo = instancevec3(1,1,1)
    else
        dielectric.albedo = albedo
    end


    dielectric.scatter = function (ray, hitmemory)
        local attenuation = dielectric.albedo
        local memoryi = dielectric.findside(hitmemory)
        local unitdirection = ray.direction.unit()

        local costheta = math.min(hitmemory.normal.dot(unitdirection.negative()), 1.0)
        local sintheta = math.sqrt(1 - costheta*costheta)
        local result

        if (memoryi * sintheta) > 1 then -- critical angle reached
            result = reflectvector(unitdirection, hitmemory.normal)
        else
            result = refractvector(unitdirection, hitmemory.normal, memoryi, costheta)
        end

        local scattered = instanceray(hitmemory.p, result)
        return true, scattered, attenuation
    end

    return dielectric
end