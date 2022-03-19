player = world:newBSGRectangleCollider(190, 256, 30, 50, 4, {collision_class = "Player"})
player.dir = "down"
player.xVector = 1
player.speed = 200
player.animSpeed = 0.12
player.moving = false
player.animTimer = 0
player.health = 4
player.fireRate = 0.1
player.fireTimer = 0

player.state = 0

player:setFixedRotation(true)

player.idle_grid = anim8.newGrid(24, 24, sprites.playerSheet_idle:getWidth(), sprites.playerSheet_idle:getHeight())
player.run_grid = anim8.newGrid(24, 24, sprites.playerSheet_run:getWidth(), sprites.playerSheet_run:getHeight())
player.die_grid = anim8.newGrid(24, 24, sprites.playerSheet_die:getWidth(), sprites.playerSheet_die:getHeight())

player.animations = {}
player.animations.idle = anim8.newAnimation(player.idle_grid('1-4', 1), player.animSpeed)
player.animations.run = anim8.newAnimation(player.run_grid('1-4', 1), player.animSpeed)
player.animations.die = anim8.newAnimation(player.die_grid('1-7', 1), player.animSpeed)

player.anim = player.animations.idle

player:setLinearVelocity(0,0)

function player:update(dt)
    local delta = vector(0,0)

    if player.health >= 1 then 
        local px, py = player:getPosition()
        if love.keyboard.isDown("right") then
            delta.x = 1
            self.anim = self.animations.run
            self.dir = "right"
            self.xVector = 1
            self:setX(px + self.speed*dt)
        end

        if love.keyboard.isDown("left") then
            delta.x = -1
            self.anim = self.animations.run
            self.dir = "left"
            self.xVector = -1
            self:setX(px - self.speed*dt)
        end

        if love.keyboard.isDown("down") then
            delta.y = 1
            self.anim = self.animations.run
            self.dir = "down"
            self:setY(py + self.speed*dt)
        end

        if love.keyboard.isDown("up") then
            delta.y = -1
            self.anim = self.animations.run
            self.dir = "up"
            self:setY(py - self.speed*dt)
        end

        if delta.x == 0 and delta.y == 0 then
            self.moving = false
            self.anim = self.animations.idle
        else
            self.moving = true
        end
    end

    self:checkForBorders()
    self.anim:update(dt)
    self:checkDamage()
end

function player:draw()
    local px, py = player:getPosition()
    if self.moving and self.health > 0 then
        self.anim:draw(sprites.playerSheet_run, px, py, nil, 2 * player.xVector, 2, 12, 12)
    elseif not self.moving and self.health > 0 then
        self.anim:draw(sprites.playerSheet_idle, px, py, nil, 2 * player.xVector, 2, 12, 12)
    else
        self.anim:draw(sprites.playerSheet_die, px, py, nil, 2 * player.xVector, 2, 12, 12)
    end
end

function player:checkDamage()
    if player:enter('Zombie') and self.health > 0 then
        local zombie = player:getEnterCollisionData('Zombie')
        self.health = self.health - zombie.collider.damage
    end

    if self.health <= 0 then
        self.anim = self.animations.die
        -- self:destroy()
    end
end

function player:checkForBorders()
    local px, py = self:getPosition()
    local mapW = gameMap.width * gameMap.tilewidth * scale
    local mapH = gameMap.height * gameMap.tileheight * scale

    if px < 10 then
        self:setX(10)
    end

    if px > mapW - 10 then
        self:setX(mapW - 10)
    end

    if py < 15 then
        self:setY(15)
    end

    if py > mapH - 15 then
        self:setY(mapH - 15)
    end
end