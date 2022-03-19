enemies = {}

function spawnZombie()
    enemy = world:newBSGRectangleCollider(150, 256, 30, 50, 4, {collision_class = "Zombie"})
    enemy:setType('static')
    enemy.speed = 140
    enemy.dead = false
    enemy.animSpeed = .12
    enemy.xVector = 1
    enemy.moving = true

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
        if player:enter('Zombie') then
            local e = player:getEnterCollisionData('Zombie')
        end
    end

    enemy.state = 0

    enemy.idle_grid = anim8.newGrid(32, 32, sprites.zombieSheet_idle:getWidth(), sprites.zombieSheet_idle:getHeight())
    enemy.run_grid = anim8.newGrid(32, 32, sprites.zombieSheet_run:getWidth(), sprites.zombieSheet_run:getHeight())

    enemy.animations = {}
    enemy.animations.idle = anim8.newAnimation(enemy.idle_grid('1-2', 1), enemy.animSpeed)
    enemy.animations.run = anim8.newAnimation(enemy.run_grid('1-4', 1), enemy.animSpeed)

    enemy.anim = enemy.animations.run

    table.insert(enemies, enemy)
end

function updateEnemy(dt)
    local delta = vector(0,0)

    for i,zombie in ipairs(enemies) do
        if math.cos(zombiePlayerAngle(zombie)) < 0 then
            zombie.xVector = -1
        else
            zombie.xVector = 1
        end
        zombie:setX(zombie:getX() + (math.cos( zombiePlayerAngle(zombie) ) * zombie.speed * dt))
        zombie:setY(zombie:getY() + (math.sin( zombiePlayerAngle(zombie) ) * zombie.speed * dt))

        zombie.anim:update(dt)
        zombie:checkDamage()
    end
end

function drawEnemies()
    for i,zombie in ipairs(enemies) do
        local px, py = zombie:getPosition()
        if zombie.moving then
            zombie.anim:draw(sprites.zombieSheet_run, px, py, nil, 3 * zombie.xVector, 3, 16, 16)
        else
            zombie.anim:draw(sprites.zombieSheet_idle, px, py, nil, 3 * zombie.xVector, 3, 16, 16)
        end
    end
end

function zombiePlayerAngle(enemy)
    return math.atan2( player:getY() - enemy:getY(), player:getX() - enemy:getX() )
end
