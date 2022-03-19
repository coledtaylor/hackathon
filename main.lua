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
    updateBullet(dt)
end

function love.draw()
    camera:attach()
        gameMap:draw()
        player:draw()
        drawBullet()
        drawEnemies()
        if showWorld then
            world:draw()
        end
        gameMap:drawForeground()
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

    if key == "w" then
        spawnZombie()
    end 
end