love = require("love")
hittable = require("hittable")
header = require("header")

function love.load()

    _G.camera = Camera()

    _G.RES_X, camera.x = love.graphics.getWidth(), love.graphics.getWidth()
    _G.RES_Y, camera.y = love.graphics.getHeight(), love.graphics.getHeight()

    camera.initialize()

    _G.world = HittableList()

    genericmirror = Metal(instancevec3(0.9,0.9,0.9), 0.8)
    genericmatte = Lambertian(instancevec3(1,0.2,0.2))
    glass = Dielectric(1/1.33, instancevec3(1,1,1))
    glasshollow = Dielectric(1.33, instancevec3(1,1,1))

    for i=1,10 do
        world.add(randomsphere())
    end
    world.add(Sphere(instancepoint3(0,0.3,-2.75),0.5, Lambertian(instancevec3(0,1,0))))
    world.add(Sphere(instancepoint3(-1,0.0,-1.5),0.5, genericmirror))
    world.add(Sphere(instancepoint3(1,0.0,-1.5),0.5, Lambertian(instancevec3(0,0,1))))
    world.add(Sphere(instancepoint3(0,0.3,-0.91),0.5, glass))
    world.add(Sphere(instancepoint3(0,0.3,-0.91),0.4, glasshollow))
    world.add(Sphere(instancepoint3(0,-30.5, -1), 30, genericmatte)) -- the ground Sphere



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


    if camera.upscaling > 1 then
        camera.buffer:mapPixel(camera.nearestneighbor)
    end
    


    camera.noisereduction = camera.noisereduction + 1
    print("NOISE REDUCTION :", camera.noisereduction)
end

function love.draw()
    if camera.screen:getWidth() ~= camera.buffer:getWidth() or camera.screen:getHeight() ~= camera.buffer:getHeight() then
        print("CHANGING RES TO MATCH NEW WINDOW SIZE")
        camera.screen = love.graphics.newArrayImage(camera.buffer)
    else
        camera.screen:replacePixels(camera.buffer, 1)
    end
    love.graphics.draw(camera.screen)
end