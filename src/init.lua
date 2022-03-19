function loadAll()
    love.graphics.setDefaultFilter("nearest", "nearest")
    vector = require("libs/hump/vector")
    anim8 = require("libs/anim8/anim8")
    sti = require("libs/sti/sti")

    local windfield = require("libs/windfield/windfield")
    world = windfield.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('Player')

    sprites = {}
    sprites.playerSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_idle.png")
    sprites.playerSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_run.png")

    require("src/player")
    -- require("enemy")
end
