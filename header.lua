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