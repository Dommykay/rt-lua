function ReturnHittable()
    
end

function HitMemory(point, vector, dist)
    local memory = {}

    memory.p = point
    memory.normal = vector
    memory.t = dist

    return memory
end