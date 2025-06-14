trace = require("trace")
vector = require("vectortypes")
shapegen = require("shapegen")
interval = require("interval")
camera = require("camera")
materials = require("materials")

_G.INFINITY = math.huge

_G.PI = math.pi

function DegreesToRadians(degrees)
    return degrees * PI / 180
end

function random()
    return math.random()
end

function randomrange(a,b)
    return math.random() * (b-a) + a
end

local randomcolour = function ()
    return instancevec3(random(),random(),random())
end

local randompos = function ()
    return instancevec3(randomrange(-5,5),randomrange(0,3),randomrange(-10,-3))
end

local randommetal = function ()
    return Metal(instancevec3(1,1,1), random())        
end

local randomlambertian = function ()
    return Lambertian(randomcolour())
end

local randommaterial = function ()
    if random() > 0.5 then
        return randommetal()
    else
        return randomlambertian()
    end
end

local randomsize = function ()
    return randomrange(0.5,2)
end

randomsphere = function ()
    return Sphere(randompos(), randomsize(), randommaterial())
end