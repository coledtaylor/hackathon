enemies = {}

function spawnZombie()
    enemy = world:newBSGRectangleCollider(150, 256, 30, 50, 4, {collision_class = "Zombie"})
    enemy.animSpeed = 0.12
    enemy.xVector = 1
    enemy.moving = true
    enemy.damage = math.random(1, 2)
    enemy.animTimer = 0.7

    enemy:setFixedRotation(true)
    
    if enemy.damage == 1 then
        enemy.speed = 140
        enemy.health = 2
    else
        enemy.speed = 100
        enemy.health = 4
    end
    
    -- 0 = walking
    -- 1 = attacking
    -- 2 = idle
    -- 3 = dying
    enemy.state = 0

    --1 = left
    --2 = right
    --3 = top
    --4 = bottom
    local side = math.random(1, 4)
    if side == 1 then
        enemy:setX(-10)
        enemy:setY(math.random(10, love.graphics.getHeight() + 10)) 
    elseif side == 2 then
        enemy:setX(love.graphics.getWidth() + 10) 
        enemy:setY(math.random(10, love.graphics.getHeight() + 10))
    elseif side == 3 then
        enemy:setX(math.random(10, love.graphics.getWidth() - 10))
        enemy:setY(-10)
    elseif side == 4 then
        enemy:setX(math.random(10, love.graphics.getWidth() - 10))
        enemy:setY(love.graphics.getHeight() + 10)
    end

    enemy.idle_grid = anim8.newGrid(32, 32, sprites.zombieSheet_idle:getWidth(), sprites.zombieSheet_idle:getHeight())
    enemy.run_grid = anim8.newGrid(32, 32, sprites.zombieSheet_run:getWidth(), sprites.zombieSheet_run:getHeight())
    enemy.attack_grid = anim8.newGrid(32, 32, sprites.zombieSheet_attack:getWidth(), sprites.zombieSheet_attack:getHeight())
    enemy.die_grid = anim8.newGrid(32, 32, sprites.zombieSheet_die:getWidth(), sprites.zombieSheet_die:getHeight())

    enemy.idle_grid_chungus = anim8.newGrid(32, 32, sprites.zombieSheet_idle_chungus:getWidth(), sprites.zombieSheet_idle:getHeight())
    enemy.run_grid_chungus = anim8.newGrid(32, 32, sprites.zombieSheet_run_chungus:getWidth(), sprites.zombieSheet_run:getHeight())
    enemy.attack_grid_chungus = anim8.newGrid(32, 32, sprites.zombieSheet_attack_chungus:getWidth(), sprites.zombieSheet_attack:getHeight())
    enemy.die_grid_chungus = anim8.newGrid(32, 32, sprites.zombieSheet_die_chungus:getWidth(), sprites.zombieSheet_die:getHeight())

    enemy.animations = {}
    enemy.animations.idle = anim8.newAnimation(enemy.idle_grid('1-2', 1), enemy.animSpeed)
    enemy.animations.run = anim8.newAnimation(enemy.run_grid('1-4', 1), enemy.animSpeed)
    enemy.animations.attack = anim8.newAnimation(enemy.attack_grid('1-4', 1), enemy.animSpeed)
    enemy.animations.die = anim8.newAnimation(enemy.die_grid('1-4', 1), enemy.animSpeed)

    enemy.animations.idle_chungus = anim8.newAnimation(enemy.idle_grid_chungus('1-2', 1), enemy.animSpeed)
    enemy.animations.run_chungus = anim8.newAnimation(enemy.run_grid_chungus('1-4', 1), enemy.animSpeed)
    enemy.animations.attack_chungus = anim8.newAnimation(enemy.attack_grid_chungus('1-4', 1), enemy.animSpeed)
    enemy.animations.die_chungus = anim8.newAnimation(enemy.die_grid_chungus('1-4', 1), enemy.animSpeed)

    enemy.anim = enemy.animations.run

    table.insert(enemies, enemy)
end

function updateEnemy(dt)
    timer = timer - dt
    if timer <= 0 and #enemies < maxZombies then
        spawnZombie()
        maxTime = 0.95 * maxTime
        timer = maxTime
    end

    for i, zombie in ipairs(enemies) do

        if zombie.body and player.body and zombie.state <= 2 then 
            if math.cos(zombiePlayerAngle(zombie)) < 0 then
                zombie.xVector = -1
            else
                zombie.xVector = 1
            end

            if zombie.state == 2 then
                zombie.animTimer = zombie.animTimer - dt
            end 

            if zombie.moving then
                zombie:setX(zombie:getX() + (math.cos( zombiePlayerAngle(zombie) ) * zombie.speed * dt))
                zombie:setY(zombie:getY() + (math.sin( zombiePlayerAngle(zombie) ) * zombie.speed * dt))
            end

            if distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) < 50 then
                zombie.state = 1
                zombie.anim = zombie.animations.attack
                sounds.attack_zombie:play()
                zombie.moving = false
            elseif distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) > 50 and zombie.state == 1 then
                zombie.state = 2
                zombie.anim = zombie.animations.idle
                zombie.moving = false
                sounds.idle_zombie:play()
            elseif distanceBetween(zombie:getX(), zombie:getY(), player:getX(), player:getY()) > 50 and zombie.animTimer <= 0 and zombie.state == 2 then
                zombie.state = 0
                zombie.anim = zombie.animations.run
                zombie.animTimer = 0.7
                zombie.moving = true
            end
            checkDamage()
        end

        zombie.anim:update(dt)
    end

    for i=#enemies, 1, -1 do
        if enemies[i].state == 3 then
            enemies[i].animTimer = enemies[i].animTimer - dt
            sounds.zombie_death:play()
            if enemies[i].animTimer <= 0 then
                enemies[i]:destroy()
                table.remove(enemies, i)
                state.kills = state.kills + 1
            end
        end
    end
end

function drawEnemies()
    for i,zombie in ipairs(enemies) do

        if zombie.body then
            local px, py = zombie:getPosition()

            if zombie.state == 0 and zombie.damage == 1 then
                zombie.anim:draw(sprites.zombieSheet_run, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 2 and zombie.damage == 1 then
                zombie.anim:draw(sprites.zombieSheet_idle, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 1 and zombie.damage == 1 then
                zombie.anim:draw(sprites.zombieSheet_attack, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 3 and zombie.damage == 1 then
                zombie.anim:draw(sprites.zombieSheet_die, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            end

            if zombie.state == 0 and zombie.damage == 2 then
                zombie.anim:draw(sprites.zombieSheet_run_chungus, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 2 and zombie.damage == 2 then
                zombie.anim:draw(sprites.zombieSheet_idle_chungus, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 1 and zombie.damage == 2 then
                zombie.anim:draw(sprites.zombieSheet_attack_chungus, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            elseif zombie.state == 3 and zombie.damage == 2 then
                zombie.anim:draw(sprites.zombieSheet_die_chungus, px, py, nil, 2 * zombie.xVector, 2, 16, 16)
            end
        end

    end
end

function zombiePlayerAngle(enemy)
    return math.atan2(player:getY() - enemy:getY(), player:getX() - enemy:getX())
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function getSpawnPositions()
    --1 = left
    --2 = right
    --3 = top
    --4 = bottom

    camera = Camera(player:getPosition())

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    local limitX = w/2
    local limitY = h/2

    -- get width/height of map
    local mapW = gameMap.width * gameMap.tilewidth * scale
    local mapH = gameMap.height * gameMap.tileheight * scale

    -- Left border
    if camera.x < limitX then
        min = 2
    end

    -- Top border
    if camera.y < limitY then
        max = 4
    end

    -- Right border
    if camera.x > (mapW - limitX) then
        min = 1
    end

    -- Bottom border
    if camera.y > (mapH - limitY) then
        
    end

end

function checkDamage()
    for i = #enemies, 1, -1 do
        if enemies[i].body then
            if enemies[i]:enter('Bullet') and enemies[i].health > 0 then
                enemies[i].health = enemies[i].health - 1
            end
        
            if enemies[i].health <= 0 and enemies[i].state < 3 then
                enemies[i].anim = enemies[i].animations.die
                enemies[i].state = 3
                enemies[i].animTimer = 0.4
                enemies[i].moving = false
            end
        end
    end
end