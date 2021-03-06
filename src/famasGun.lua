-- function spawnFAMAS()
flip = false
Gun = {}
Gun.fireRate = 0.1
Gun.animSpeed = 0.01
Gun.idle_grid = anim8.newGrid(65, 32, sprites.famasSheet_idle:getWidth(), sprites.famasSheet_idle:getHeight())
Gun.run_grid = anim8.newGrid(65, 32, sprites.famasSheet_fireing:getWidth(), sprites.famasSheet_fireing:getHeight())
Gun.animations = {}
Gun.animations.idle = anim8.newAnimation(Gun.idle_grid('1-1', 1), Gun.animSpeed)
Gun.animations.run = anim8.newAnimation(Gun.run_grid('1-6', 1), Gun.animSpeed)
Gun.animations.idle_flipped = anim8.newAnimation(Gun.idle_grid('1-1', 1), Gun.animSpeed):flipV()
Gun.animations.run_flipped = anim8.newAnimation(Gun.run_grid('1-6', 1), Gun.animSpeed):flipV()
Gun.rotation = updateBullet()

Gun.anim = Gun.animations.run

function Gun:update()
    -- local px, py = player:getPosition()
    -- local gx, gy = Gun:getPosition()
    -- local dx = px - gx
    -- local dy = py - gy
    -- local angle = math.atan2(dy, dx)
    -- Gun:setRotation(angle)
    -- Gun.rotation = angle
    -- Gun.anim = Gun.animations.run
    -- Gun.anim:update(dt)   
    if player.body then 
        getAngle() 

        local degrees = math.deg(Gun.rotation)
        if degrees > 90 or degrees < -90 then
            flip = true
            Gun.anim = Gun.animations.run_flipped
        else
            flip = false
            Gun.anim = Gun.animations.run
        end
    end
    -- Gun.anim:update(dt)    

end

function getAngle()
    mouseX, mouseY = camera:mousePosition()
    Gun.rotation = math.atan2((player:getY()) - mouseY, (player:getX()) - mouseX)
end

function Gun:draw()
    if player.health > 0 then 
        self.anim:draw(sprites.famasSheet_fireing, player:getX(), player:getY() + 5, self.rotation, 0.8, 0.8, (65 / 2) + 18, (32 / 2))
    end
end
-- end