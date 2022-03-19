camera = Camera(player:getPosition())

function camera:update()
    if player.body then
        local px, py = player:getPosition()
        local dx,dy = px - camera.x, py - camera.y
        
        camera:move(dx/2, dy/2)
        
        -- First, get width/height of the game window
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()

        local limitX = w/2
        local limitY = h/2

        -- get width/height of map
        local mapW = gameMap.width * gameMap.tilewidth * scale
        local mapH = gameMap.height * gameMap.tileheight * scale

        -- Left border
        if camera.x < limitX then
            camera.x = limitX
        end

        -- Top border
        if camera.y < limitY then
            camera.y = limitY
        end

        -- Right border
        if camera.x > (mapW - limitX) then
            camera.x = (mapW - limitX)
        end

        -- Bottom border
        if camera.y > (mapH - limitY) then
            camera.y = (mapH - limitY)
        end
    end
end


