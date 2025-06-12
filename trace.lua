spherecol = require("spherecol")
is_hittable = require("ishittable")

function ReturnColour(ray, world)
    local hit_anything, hitmemory = world.hit(ray, Interval(0,INFINITY))
    if hit_anything then
        return hitmemory.normal.addvec(instancevec3(1,1,1)).multnum(0.5).returnvals()
    end

    local unit_direction = ray.direction.unit()
    local alpha = 0.5*(unit_direction.y() + 1)
    local colour = instancevec3(1,1,1).multnum(1-alpha).addvec(instancevec3(0.5,0.7,1.0).multnum(alpha))
    return colour.returnvals()
end