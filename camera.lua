hittable = require("hittable")
materials = require("materials")
love = require("love")


function Camera()
    local camera = {}

    camera.renderpixel = function (x, y, r, g, b, a)
        if x == 1 and y % 10 == 0 then
            print(camera.y-y, "SCANLINES REMAIN")
        end
        local tmpr,tmpg,tmpb,retr,retg,retb,first
        if r == 0 and g == 0 and b == 0 then
            first = true
        else 
            first = false
            tmpr,tmpg,tmpb = 0,0,0
            r,g,b = (camera.noisereduction-1)*r/camera.noisereduction,(camera.noisereduction-1)*g/camera.noisereduction,(camera.noisereduction-1)*b/camera.noisereduction
        end

        for sample=1,camera.samples do
            local offset = camera.samplerange()

            local pixel_sample = camera.pixel00_loc.addvec(
            camera.pixel_delta_u.multnum(x+offset.x())).addvec(
            camera.pixel_delta_v.multnum(y+offset.y()))
            local ray_direction = pixel_sample.subvec(camera.camera_center)
            local ray = instanceray(camera.camera_center, ray_direction)
            retr,retg,retb = camera.gammacorrect(camera.ReturnColour(ray, world, camera.bouncedepth).returnvals())
            if first then
                r,g,b = r+retr,r+retg,r+retb
            else
                tmpr,tmpg,tmpb = tmpr+retr,tmpg+retg,tmpb+retb
            end
        end

        if first then
            r,g,b = r/camera.samples,g/camera.samples,b/camera.samples 
        end

        if not first then
            r,g,b = r+tmpr/(camera.samples*camera.noisereduction),g+tmpg/(camera.samples*camera.noisereduction),b+tmpb/(camera.samples*camera.noisereduction)
        end

        return r, g, b, 1.0
    end

    camera.initialize = function ()
        camera.noisereduction = 3
        camera.samples = 4
        camera.bouncedepth = 15
        camera.ASPECT_RATIO = camera.x/camera.y

        camera.buffer = love.image.newImageData(camera.x, camera.y)
        camera.screen = love.graphics.newArrayImage(camera.buffer)

        camera.focal_length = 1.0
        camera.viewport_height = 2.0
        camera.viewport_width = camera.viewport_height * camera.ASPECT_RATIO
        camera.camera_center = instancepoint3(0,0,0)
        camera.viewport_u = instancevec3(camera.viewport_width,0,0)
        camera.viewport_v = instancevec3(0,-camera.viewport_height,0)

        camera.pixel_delta_u = camera.viewport_u.divbynum(camera.x)
        camera.pixel_delta_v = camera.viewport_v.divbynum(camera.y)

        camera.viewport_upper_left = camera.camera_center.subvec(instancevec3(0,0,camera.focal_length)).subvec(camera.viewport_u.divbynum(2)).subvec(camera.viewport_v.divbynum(2))
        camera.pixel00_loc = camera.viewport_upper_left.addvec(camera.pixel_delta_u.addvec(camera.pixel_delta_v).multnum(0.5))

    end

    camera.ReturnColour = function (ray, world, depth)
        if depth <= 0 then
            return instancevec3(0,0,0)
        end

        local hit_anything, hitmemory = world.hit(ray, Interval(0.001,INFINITY))

        if hit_anything then
            local bounce, scattered, attenuation = hitmemory.material.scatter(ray, hitmemory)
            if bounce then
                return attenuation.multvec(camera.ReturnColour(scattered, world, depth-1))
            end
            return instancevec3(0,0,0)
        end

        local unit_direction = ray.direction.unit()
        local alpha = 0.5*(unit_direction.y() + 1)
        local colour = instancevec3(1,1,1).multnum(1-alpha).addvec(instancevec3(0.5,0.7,1.0).multnum(alpha))
        return colour
    end

    camera.samplerange = function ()
        return instancevec3(random()-0.5,random()-0.5,0)
    end

    camera.gammacorrect = function (r,g,b)
        return math.sqrt(r),math.sqrt(g),math.sqrt(b)
    end

    return camera
end