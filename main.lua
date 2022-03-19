function love.load()
    require("/src/init")
    loadAll()

    showWorld = false
end

function love.update(dt)
    player:update(dt)
    updateEnemy(dt)
end

function love.draw()
    player:draw()
    drawEnemies()
    if showWorld then
        world:draw()
    end
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