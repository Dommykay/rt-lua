love = require("love")
vector = require("vectortypes")
trace  = require("trace")

function love.load()

    _G.RES_X = love.graphics.getWidth()
    _G.RES_Y = love.graphics.getHeight()
    _G.ASPECT_RATIO = RES_X/RES_Y

    _G.buffer = love.image.newImageData(RES_X, RES_Y)
    _G.screen = love.graphics.newArrayImage(buffer)

    _G.focal_length = 1.0
    _G.viewport_height = 2.0
    _G.viewport_width = viewport_height * ASPECT_RATIO
    _G.camera_center = instancepoint3(0,0,0)
    _G.viewport_u = instancevec3(viewport_width,0,0)
    _G.viewport_v = instancevec3(0,-viewport_height,0)

    _G.pixel_delta_u = viewport_u.divbynum(RES_X)
    _G.pixel_delta_v = viewport_v.divbynum(RES_Y)

    _G.viewport_upper_left = camera_center.subvec(instancevec3(0,0,focal_length)).subvec(viewport_u.divbynum(2)).subvec(viewport_v.divbynum(2))
    _G.pixel00_loc = viewport_upper_left.addvec(pixel_delta_u.addvec(pixel_delta_v).multnum(0.5))





end

function love.resize(w, h)
    RES_X = love.graphics.getWidth()
    RES_Y = love.graphics.getHeight()
    ASPECT_RATIO = RES_X/RES_Y
end

function love.update(dt)
    if buffer:getWidth() ~= RES_X or buffer:getHeight() ~= RES_Y then
        buffer = love.image.newImageData(RES_X, RES_Y)
    end
    buffer:mapPixel(CastRay)
end

function CastRay(x, y, r, g, b, a)

    local pixel_center = pixel00_loc.addvec(pixel_delta_u.multnum(x)).addvec(pixel_delta_v.multnum(y))
    local ray_direction = pixel_center.subvec(camera_center)
    local ray = instanceray(camera_center, ray_direction)
    r,g,b = ReturnColour(ray)
    return r, g, b, 1.0
end

function love.draw()
    if screen:getWidth() ~= buffer:getWidth() or screen:getHeight() ~= buffer:getHeight() then
        screen = love.graphics.newArrayImage(buffer)
    else
        screen:replacePixels(buffer, 1)
    end
    love.graphics.draw(screen)
end