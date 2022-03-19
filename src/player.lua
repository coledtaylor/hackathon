player = world:newBSGRectangleCollider(190, 256, 30, 50, 3)
player.x = 0
player.y = 0
player.dir = "down"
player.speed = 90
player.animSpeed = 0.12
player.moving = false
player.animTimer = 0
player.health = 4

player.state = 0

player:setCollisionClass("Player")
-- player:setFixedRotation(true)

player.idle_grid = anim8.newGrid(32, 32, sprites.playerSheet_idle:getWidth(), sprites.playerSheet_idle:getHeight())
player.run_grid = anim8.newGrid(32, 32, sprites.playerSheet_run:getWidth(), sprites.playerSheet_run:getHeight())

player.animations = {}
player.animations.idle = anim8.newAnimation(player.idle_grid('1-4', 1), player.animSpeed)
player.animations.run = anim8.newAnimation(player.run_grid('1-4', 1), player.animSpeed)

player.anim = player.animations.idle

player:setLinearVelocity(0,0)

function player:update(dt)
    local delta = vector(0,0)

    if love.keyboard.isDown("right") then
        delta.x = 1
        player.anim = player.animations.run
        player.dir = "right"
    end

    if love.keyboard.isDown("left") then
        delta.x = -1
        player.anim = player.animations.run
        player.dir = "left"
    end

    if love.keyboard.isDown("down") then
        delta.y = 1
        player.anim = player.animations.run
        player.dir = "down"
    end

    if love.keyboard.isDown("up") then
        delta.y = -1
        player.anim = player.animations.run
        player.dir = "up"
    end

    local vec = vector(delta.x, delta.y):normalized() * player.speed
    player:setLinearVelocity(vec.x, vec.y)

    if delta.x == 0 and delta.y == 0 then
        player.moving = false
        player.anim = player.animations.idle
    else
        player.moving = true
    end

    player.anim:update(dt)
end

function player:draw()
    if self.moving then
        self.anim:draw(sprites.playerSheet_run, player:getX()-22, player:getY()-15, nil, 3, 3, 8, 12)
    else
        self.anim:draw(sprites.playerSheet_idle, player:getX()-22, player:getY()-15, nil, 3, 3, 8, 12)
    end
end

