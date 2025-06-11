function GenSphere(center, radius)
    local sphere = ReturnHittable()
    sphere.radius = math.max(0,radius)
    sphere.center = center
    sphere.hit = function (ray, distmin, distmax, hitmemory)
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
        if distmax < root or distmin > root then
            root = (h+sqrtd)/a
            if distmax < root or distmin > root then
                return false, hitmemory
            end
        end

        hitmemory.t = root
        hitmemory.p = ray.at(hitmemory.t)
        local outward_normal = hitmemory.p.subvec(center).divbynum(sphere.radius)
        hitmemory.set_face_normal(ray, outward_normal)

        return true, hitmemory

    end
end