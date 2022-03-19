-- function spawnFAMAS()
Gun = {}
Gun.fireRate = 0.1
Gun.animSpeed = 0.5
Gun.idle_grid = anim8.newGrid(65, 32, sprites.famasSheet_idle:getWidth(), sprites.famasSheet_idle:getHeight())
Gun.run_grid = anim8.newGrid(65, 32, sprites.famasSheet_fireing:getWidth(), sprites.famasSheet_fireing:getHeight())
Gun.animations = {}
Gun.animations.idle = anim8.newAnimation(Gun.idle_grid('1-1', 1), Gun.animSpeed)
Gun.animations.run = anim8.newAnimation(Gun.run_grid('1-6', 1), Gun.animSpeed)
Gun.rotation = 0

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
end

function Gun:draw()
    if player.health > 0 then 
        self.anim:draw(sprites.famasSheet_fireing, player:getX() - (65 / 2), player:getY() - (32 / 2), self.rotation, 1, 1, nil, nil)
    end
end
-- end