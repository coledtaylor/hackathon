function love.load()
    require("/src/init")
    loadAll()

    showWorld = false
end

function love.update(dt)
    player:update(dt)
    camera:update(dt)
    world:update(dt)
    if state.gameStatus >= 1 then
        updateEnemy(dt)
        Gun:update(dt)
        updateBullet(dt)
        state:update(dt)
    end
end

function love.draw()
    camera:attach()
        drawMap()
        player:draw()
        if state.gameStatus == 1 then 
            drawBullet()        
            Gun:draw()
            drawEnemies()
        end
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
        state.gameStatus = 1
    end
end