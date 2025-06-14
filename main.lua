love = require("love")
hittable = require("hittable")
header = require("header")

function love.load()

    _G.camera = Camera()

    _G.RES_X, camera.x = love.graphics.getWidth(), love.graphics.getWidth()
    _G.RES_Y, camera.y = love.graphics.getHeight(), love.graphics.getHeight()

    camera.initialize()

    _G.world = HittableList()

    genericmirror = Metal(instancevec3(0.9,0.9,0.9), 1)
    genericmatte = Lambertian(instancevec3(0.8,0.5,0.5))
    glass = Dielectric(1/38.6, instancevec3(1,1,1))

    
    world.add(Sphere(instancepoint3(-0.5,0.0,-2.5),0.5, genericmirror)) -- the left normal Sphere
    world.add(Sphere(instancepoint3(-0.1,0,-1.5),0.5, glass)) -- the right normal Sphere
    world.add(Sphere(instancepoint3(0,-100.5, -1), 100, genericmatte)) -- the ground Sphere



end

function love.resize(w, h)
    _G.RES_X, camera.x = love.graphics.getWidth(), love.graphics.getWidth()
    _G.RES_Y, camera.y = love.graphics.getHeight(), love.graphics.getHeight()
    camera.ASPECT_RATIO = RES_X/RES_Y
    camera.initialize()
end

function love.update(dt)
    if camera.buffer:getWidth() ~= RES_X or camera.buffer:getHeight() ~= RES_Y then
        camera.buffer = love.image.newImageData(RES_X, RES_Y)
    end
    camera.buffer:mapPixel(camera.renderpixel)
    camera.noisereduction = camera.noisereduction + 0.5
    print("NOISE REDUCTION :", camera.noisereduction)
end

function love.draw()
    if camera.screen:getWidth() ~= camera.buffer:getWidth() or camera.screen:getHeight() ~= camera.buffer:getHeight() then
        camera.screen = love.graphics.newArrayImage(camera.buffer)
    else
        camera.screen:replacePixels(camera.buffer, 1)
    end
    love.graphics.draw(camera.screen)
end