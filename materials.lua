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

function Metal(albedo)
    local metal = Material()

    metal.scatter = function (ray, hitmemory)
        local reflected = reflectvector(ray.direction, hitmemory.normal)
        local scattered = instanceray(hitmemory.p, reflected)
        local attenuation = albedo
        return true, scattered, attenuation
    end


    return metal
end