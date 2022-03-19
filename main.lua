function love.load()
    require("/src/init")
    loadAll()

end

function love.update(dt)
    player:update(dt)
    updateBullet(dt)
end

function love.draw()
    player:draw()
    -- world:draw()
    drawBullet()
end

function love:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end