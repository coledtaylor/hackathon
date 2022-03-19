mapName = "map-luke"
gameMap = sti("/assets/maps/" .. mapName .. ".lua")

-- collisions for edges of map
    local mapW = gameMap.width * gameMap.tilewidth * scale
    local mapH = gameMap.height * gameMap.tileheight * scale
    top = world:newBSGRectangleCollider(0, 1, mapW, 1, 1, {collision_class = "Obstacle"})
    top:setType('static')
    right = world:newBSGRectangleCollider(mapW, 0, 1, mapH, 1, {collision_class = "Obstacle"})
    right:setType('static')
    bottom = world:newBSGRectangleCollider(0, mapH, mapW, 1, 1, {collision_class = "Obstacle"})
    bottom:setType('static')
    left = world:newBSGRectangleCollider(1, 0, 1, mapH, 1, {collision_class = "Obstacle"})
    left:setType('static')

-- collisions for objects
for i, obj in pairs(gameMap.layers["Objects"].objects) do
    collider = world:newBSGRectangleCollider(scale*obj.x, scale*obj.y, scale*obj.width, scale*obj.height, 3, {collision_class = "Obstacle"})
    collider:setType('static')
end

-- collisions for interactables
for i, obj in pairs(gameMap.layers["Interactables"].objects) do
    collider = world:newBSGRectangleCollider(scale*obj.x, scale*obj.y, scale*obj.width, scale*obj.height, 3, {collision_class = "Interactables"})
    collider:setType('static')
end

function gameMap:draw()
    love.graphics.scale( scale, scale )
    if gameMap.layers["1"] then
        gameMap:drawLayer(gameMap.layers["1"])
    end
    if gameMap.layers["2"] then
        gameMap:drawLayer(gameMap.layers["2"])
    end
    if gameMap.layers["3"] then
        gameMap:drawLayer(gameMap.layers["3"])
    end    
    love.graphics.scale( 1/scale, 1/scale )
end

function gameMap:drawForeground()
    love.graphics.scale( scale, scale )
    if gameMap.layers["Foreground"] then
        gameMap:drawLayer(gameMap.layers["Foreground"])
    end
    love.graphics.scale( 1/scale, 1/scale )
end


