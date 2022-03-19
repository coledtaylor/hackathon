mapNames = {"map-alexis", "map-luke", "map-ben"}
objects = {}

function loadMap()

    -- destroy objects
    for i=#objects,1,-1 do
        objects[i]:destroy()
        table.remove(objects, i)
    end

    -- load new map
    gameMap = sti("/assets/maps/" .. mapNames[math.random(#mapNames)] .. ".lua")

    -- collisions for objects
    for i, obj in pairs(gameMap.layers["Objects"].objects) do
        collider = world:newBSGRectangleCollider(scale*obj.x, scale*obj.y, scale*obj.width, scale*obj.height, 3, {collision_class = "Obstacle"})
        collider:setType('static')
        table.insert(objects, collider)
    end
    
    -- collisions for interactables
    for i, obj in pairs(gameMap.layers["Interactables"].objects) do
        collider = world:newBSGRectangleCollider(scale*obj.x, scale*obj.y, scale*obj.width, scale*obj.height, 3, {collision_class = "Interactables"})
        collider:setType('static')
        table.insert(objects, collider)
    end
end

function drawMap()
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

function drawMapForeground()
    love.graphics.scale( scale, scale )
    if gameMap.layers["Foreground"] then
        gameMap:drawLayer(gameMap.layers["Foreground"])
    end
    love.graphics.scale( 1/scale, 1/scale )
end


