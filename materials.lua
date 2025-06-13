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

function Dielectric(refractionindex)
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