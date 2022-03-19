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

player.animations = {}
player.animations.idle = anim8.newAnimation(player.idle_grid('1-4', 1), player.animSpeed)
player.animations.run = anim8.newAnimation(player.run_grid('1-4', 1), player.animSpeed)

player.anim = player.animations.idle

player:setLinearVelocity(0,0)

function player:update(dt)
    local delta = vector(0,0)

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

    self.fireTimer = self.fireTimer + dt
    if love.keyboard.isDown("space") then
        if self.fireTimer > self.fireRate then
            self.fireTimer = 0
            spawnBullet()
        end
    end

    if delta.x == 0 and delta.y == 0 then
        self.moving = false
        self.anim = self.animations.idle
    else
        self.moving = true
    end

    self.anim:update(dt)

    self:checkDamage()
end

function player:draw()
    local px, py = player:getPosition()
    if self.moving then
        self.anim:draw(sprites.playerSheet_run, px, py, nil, 3 * player.xVector, 3, 12, 12)
    else
        self.anim:draw(sprites.playerSheet_idle, px, py, nil, 3 * player.xVector, 3, 12, 12)
    end
end

function player:checkDamage()
    if player:enter('Zombie') then
        local e = player:getEnterCollisionData('Zombie')
        self.health = self.health - e.collider.damage
    end
end