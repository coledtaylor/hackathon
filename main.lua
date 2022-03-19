function love.load()
    require("/src/init")
    loadAll()
end

function love.update(dt)
    player:update(dt)
    world:update(dt)
    camera:update(dt)
end 

function love.draw()
    camera:attach()

    gameMap:draw()
    player:draw()
    gameMap:drawForeground()
    world:draw()
    
    camera:detach()
end

function love:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end