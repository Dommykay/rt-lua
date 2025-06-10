function instancevec3(v1, v2, v3)
    local vec3 = {}

    vec3.v1 = v1
    vec3.v2 = v2
    vec3.v3 = v3

    vec3.x = function () return vec3.v1 end
    vec3.y = function () return vec3.v2 end
    vec3.z = function () return vec3.v3 end

    vec3.pos = function (num)
        if num == 1 then
            return vec3.x()
        elseif num == 2 then
            return vec3.y()
        elseif num == 3 then
            return vec3.z()
        else
            return 0.0
        end
    end
    vec3.negative = function ()
        return instancevec3(-vec3.x(), -vec3.y(), -vec3.z())
    end

    vec3.addvec = function (vec)
        return instancevec3(vec3.x() + vec.x(), vec3.y() + vec.y(), vec3.z() + vec.z())
    end

    vec3.addnum = function (num)
        return instancevec3(vec3.x() + num, vec3.y() + num, vec3.z() + num)
    end

    vec3.subvec = function (vec)
        return instancevec3(vec3.x() - vec.x(), vec3.y() - vec.y(), vec3.z() - vec.z())
    end

    vec3.subnum = function (num)
        return instancevec3(vec3.x() - num, vec3.y() - num, vec3.z() - num)
    end

    vec3.multnum = function (num)
        return instancevec3(vec3.x() * num, vec3.y() * num, vec3.z() * num)
    end

    vec3.multvec = function (vec)
        return instancevec3(vec3.x() * vec.x(), vec3.y() * vec.y(), vec3.z() * vec.z())
    end

    vec3.divbynum = function (num)
        return instancevec3(vec3.x() / num, vec3.y() / num, vec3.z() / num)
    end

    vec3.divbyvec = function (vec)
        return instancevec3(vec3.x() / vec.x(), vec3.y() / vec.y(), vec3.z() / vec.z())
    end

    vec3.lensq = function ()
        return vec3.x()*vec3.x() + vec3.y()*vec3.y() + vec3.z()*vec3.z()
    end

    vec3.len = function ()
        return math.sqrt(vec3.lensq())
    end

    vec3.dot = function (vec)
        return vec3.x()*vec.x() + vec3.y()*vec.y() + vec3.z()*vec.z()
    end

    vec3.cross = function(vec)
        return instancevec3(
            vec3.y()*vec.z() - vec3.z()*vec.y(),
            vec3.z()*vec.x() - vec3.x()*vec.z(),
            vec3.x()*vec.y() - vec3.y()*vec.x()
        )
    end

    vec3.unit = function ()
        return vec3.divbynum(vec3.len())
    end

    vec3.printinfo = function ()
       print(vec3.x(),vec3.y(),vec3.z()) 
    end

    return vec3
end

function instancepoint3(v1,v2,v3)
    return instancevec3(v1,v2,v3)
end

function instanceray(origin, direction)
    local ray = {}

    ray.origin = origin
    ray.direction = direction
    ray.at = function (distance)
        return ray.origin.addvec(ray.direction.multnum(distance))
    end

    return ray
end