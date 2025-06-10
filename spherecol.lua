function HitSphereCheck(sphere_centre, sphere_radius, ray)

    local sphere_centre_vector = sphere_centre.subvec(ray.origin)
    local a = ray.direction.lensq()
    local h = ray.direction.dot(sphere_centre_vector)
    local c = sphere_centre_vector.lensq() - sphere_radius*sphere_radius

    local discriminant = h*h - a*c
    if discriminant > 0 then
        return (h - math.sqrt(discriminant)) / a
    else return 0 end
end