spherecol = require("spherecol")

function ReturnColour(ray)
    local unit_direction = ray.direction.unit()
    local alpha = 0.5*(unit_direction.y() + 1)
    local colour = instancevec3(1,1,1).multnum(1-alpha).addvec(instancevec3(0.5,0.7,1.0).multnum(alpha))
    local dist = HitSphereCheck(instancevec3(0,0,-1), 0.5, ray)
    if dist > 0 then 
        local normal = ray.at(dist).subvec(instancevec3(0,0,-1)).unit()
        colour = instancevec3(normal.x() + 1, normal.y() + 1, normal.z() + 1).multnum(0.5)
    end
    return colour.x(),colour.y(),colour.z()
end