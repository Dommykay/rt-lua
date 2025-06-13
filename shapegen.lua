function Sphere(center, radius, material)
    local sphere = ReturnHittable()
    sphere.radius = math.max(0,radius)
    sphere.center = center

    if material ~= nil then
            sphere.material = material
        else 
            sphere.material = Lambertian(instancepoint3(0.5,0.5,0.5))
        end


    sphere.hit = function (ray, interval, hitmemory)

        --ray.origin.printinfo()
        local sphere_centre_vector = sphere.center.subvec(ray.origin)
        local a = ray.direction.lensq()
        local h = ray.direction.dot(sphere_centre_vector)
        local c = sphere_centre_vector.lensq() - sphere.radius*sphere.radius

        local discriminant = h*h - a*c


        if discriminant < 0 then
            return false, hitmemory
        end
        local sqrtd = math.sqrt(discriminant)
        local root = (h-sqrtd)/a
        if not interval.surrounds(root) then
            root = (h+sqrtd)/a
            if not interval.surrounds(root) then
                return false, hitmemory
            end
        end

        hitmemory.t = root
        hitmemory.p = ray.at(hitmemory.t)
        local outward_normal = hitmemory.p.subvec(sphere.center).divbynum(sphere.radius)
        hitmemory.set_face_normal(ray, outward_normal)
        hitmemory.material = sphere.material

        return true, hitmemory
    end
    return sphere
end