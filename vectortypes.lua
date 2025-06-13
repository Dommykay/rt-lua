function instancevec3(v1, v2, v3)
    local vec3 = {}
    
    if v1 ~= nil then
        vec3.v1 = v1
    else
        vec3.v1 = nil
    end

    if v2 ~= nil then
        vec3.v2 = v2
    else
        vec3.v2 = nil
    end

    if v3 ~= nil then
        vec3.v3 = v3
    else
        vec3.v3 = nil
    end
    
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

    vec3.returnvals = function ()
        return vec3.x(),vec3.y(),vec3.z()
    end

    
    vec3.nearzero = function ()
        local threshold = 1e-8
        return vec3.x() < threshold and vec3.y() < threshold and vec3.z() < threshold
    end

    return vec3
end

function randomvec3(min, max)
    if min ~= nil and max ~= nil then
        return instancevec3(randomrange(min, max),randomrange(min, max),randomrange(min, max))
    end
    return instancevec3(random(),random(),random())
end


function randomunitvec3()
    while true do
        local unit_vector = randomvec3(-1,1)
        local lensq = unit_vector.lensq()
        if lensq > 1e-160 and lensq < 1 then
            return unit_vector.divbynum(math.sqrt(lensq))
        end
    end
end

function randomonhemisphere(normal)
    local onunitsphere = randomunitvec3()
    if normal.dot(onunitsphere) > 0 then
        return onunitsphere
    else
        return onunitsphere.negative()
    end
end

function instancepoint3(v1,v2,v3)
    return instancevec3(v1,v2,v3)
end

function reflectvector(vec,normal)
    return vec.subvec(normal.multnum(vec.dot(normal)).multnum(2))
end

function refractvector(vec, normal, etaioveretat)
    local costheta = math.min(normal.dot(vec.negative()), 1.0)
    local routperp = vec.addvec(normal.mulnum(costheta)).mulnum(etaioveretat)
    local routparallel = normal.mulnum(-math.sqrt(math.abs(1 - (routperp.lensq()))))
    return routperp.addvec(routparallel)
    
end

function instanceray(origin, direction)
    local ray = {}

    if origin ~= nil then
        ray.origin = origin
    else 
        ray.origin = nil
    end

    if direction ~= nil then
        ray.direction = direction
    else 
        ray.direction = nil
    end
    
    ray.at = function (distance)
        return ray.origin.addvec(ray.direction.multnum(distance))
    end

    return ray
end