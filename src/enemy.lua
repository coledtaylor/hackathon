enemies = {}

function spawnZombie()
    enemy = world:newBSGRectangleCollider(150, 256, 30, 50, 4, {collision_class = "Zombie"})
    enemy.speed = 140
    enemy.dead = false
    enemy.animSpeed = 0.12
    enemy.xVector = 1
    enemy.moving = true
    enemy.damage = math.random(1, 2)
    enemy.animTimer = 0.5

    -- 0 = walking
    -- 1 = attacking
    -- 3 = idle
    enemy.state = 0

    local side = math.random(1, 4)
    if side == 1 then
        enemy:setX(-30)
        enemy:setY(math.random(0, love.graphics.getHeight())) 
    elseif side == 2 then
        enemy:setX(love.graphics.getWidth() + 30) 
        enemy:setY(math.random(0, love.graphics.getHeight()))
    elseif side == 3 then
        enemy:setX(math.random(0, love.graphics.getWidth()))
        enemy:setY(-30)
    elseif side == 4 then
        enemy:setX(math.random(0, love.graphics.getWidth()))
        enemy:setY(love.graphics.getHeight() + 30)
    end
    
    function enemy:checkDamage()
        -- Will check for bullets
    end

    enemy.idle_grid = anim8.newGrid(32, 32, sprites.zombieSheet_idle:getWidth(), sprites.zombieSheet_idle:getHeight())
    enemy.run_grid = anim8.newGrid(32, 32, sprites.zombieSheet_run:getWidth(), sprites.zombieSheet_run:getHeight())
    enemy.attack_grid = anim8.newGrid(32, 32, sprites.zombieSheet_attack:getWidth(), sprites.zombieSheet_attack:getHeight())

    enemy.animations = {}
    enemy.animations.idle = anim8.newAnimation(enemy.idle_grid('1-2', 1), enemy.animSpeed)
    enemy.animations.run = anim8.newAnimation(enemy.run_grid('1-4', 1), enemy.animSpeed)
    enemy.animations.attack = anim8.newAnimation(enemy.attack_grid('1-4', 1), enemy.animSpeed)

    enemy.anim = enemy.animations.run

    table.insert(enemies, enemy)
end

function updateEnemy(dt)
    local delta = vector(0,0)

    for i, zombie in ipairs(enemies) do

        if math.cos(zombiePlayerAngle(zombie)) < 0 then
            zombie.xVector = -1
        else
            zombie.xVector = 1
        end

        if zombie.state == 3 then
            zombie.animTimer = zombie.animTimer - dt
        end 

        if zombie.moving then
            zombie:setX(zombie:getX() + (math.cos( zombiePlayerAngle(zombie) ) * zombie.speed * dt))
            zombie:setY(zombie:getY() + (math.sin( zombiePlayerAngle(zombie) ) * zombie.speed * dt))
        end

        if distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) < 50 then
            zombie.state = 1
            zombie.anim = zombie.animations.attack
            zombie.moving = false
        elseif distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) > 50 and zombie.state == 1 then
            zombie.state = 3
            zombie.anim = zombie.animations.idle
            zombie.moving = false
        elseif distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) > 50 and zombie.animTimer <= 0 and zombie.state == 3 then
            zombie.state = 0
            zombie.anim = zombie.animations.run
            zombie.moving = true
            zombie.animTimer = 0.5
        end

        zombie.anim:update(dt)
        zombie:checkDamage()
    end
end

function drawEnemies()
    for i,zombie in ipairs(enemies) do
        local px, py = zombie:getPosition()
        if zombie.moving then
            zombie.anim:draw(sprites.zombieSheet_run, px, py, nil, 3 * zombie.xVector, 3, 16, 16)
        elseif not zombie.moving and zombie.state == 3 then
            zombie.anim:draw(sprites.zombieSheet_idle, px, py, nil, 3 * zombie.xVector, 3, 16, 16)
        else
            zombie.anim:draw(sprites.zombieSheet_attack, px, py, nil, 3 * zombie.xVector, 3, 16, 16)
        end
    end
end

function zombiePlayerAngle(enemy)
    return math.atan2( player:getY() - enemy:getY(), player:getX() - enemy:getX() )
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end