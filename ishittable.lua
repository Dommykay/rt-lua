function HittableList()
    local hittablelist = {}
    hittablelist.list = {}
    hittablelist.add = function(object)
        table.insert(hittablelist.list, object)
    end
    hittablelist.clear = function ()
        hittablelist.list = {}
    end
    hittablelist.hit = function (ray, interval)
        local temporary_memory = HitMemory()
        local hit_anything = false
        local closest_so_far = interval.max
        for object=1,#hittablelist.list do
            local hit, temporary_memory = hittablelist.list[object].hit(ray, interval.min, closest_so_far, temporary_memory)
            if hit then
                hit_anything = true
                closest_so_far = temporary_memory.t
            end
        end
        return hit_anything, temporary_memory
    end
    return hittablelist
end


-- returns a template for hittable objects
function ReturnHittable()
    local hittable = {}
    hittable.hit = function (ray, interval, hitmemory) return 0 end
    return hittable
end

function HitMemory(point, vector, dist, front_face)
    local memory = {}

    if point ~= nil then
        memory.p = point
    else
        memory.p = nil
    end

    if vector ~= nil then
        memory.normal = vector
    else
        memory.normal = nil
    end

    if dist ~= nil then
        memory.t = dist
    else
        memory.t = nil
    end

    if front_face ~= nil then
        memory.front_face = front_face
    else
        memory.front_face = nil
    end

    memory.set_face_normal = function (ray, outward_normal)
        memory.front_face = ray.direction.dot(outward_normal) < 0
        if not memory.front_face then
            outward_normal = outward_normal.negative()
        end
        memory.normal = outward_normal
    end

    return memory
end