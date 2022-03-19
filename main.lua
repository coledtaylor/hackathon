function love.load()
    require("/src/init")
    loadAll()

end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    -- world:draw()
end

function love:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end