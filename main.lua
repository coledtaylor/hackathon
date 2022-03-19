function love.load()
    require("/src/init")
    loadAll()

    showWorld = false
end

function love.update(dt)
    player:update(dt)
    world:update(dt)
    camera:update(dt)
    updateEnemy(dt)
    updateHUD(dt)
    updateBullet(dt)
    Gun:update(dt)
    state:update(dt)
end

function love.draw()
    camera:attach()
        drawMap()
        player:draw()
        drawBullet()        
        Gun:draw()
        drawEnemies()
        if showWorld then
            world:draw()
        end
        drawMapForeground()
    camera:detach()
    drawHUD()
end

function love:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "q" then
        showWorld = not showWorld
    end

    -- if key == "e" then
    --     spawnZombie()
    -- end 

    if key == "u" then
        state.kills = 100
    end 

    if key == "return" then
        player.health = 4
        for i, enemy in pairs(enemies) do
            deleteEnemy(enemy)
        end
    end
end