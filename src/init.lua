function loadAll()
    love.graphics.setDefaultFilter("nearest", "nearest")
    vector = require("libs/hump/vector")
    anim8 = require("libs/anim8/anim8")
    sti = require("libs/sti/sti")

    local windfield = require("libs/windfield/windfield")
    world = windfield.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('Player')
    world:addCollisionClass('Bullet')

    sprites = {}
    sprites.playerSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_idle.png")
    sprites.playerSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_run.png")
    sprites.famas_idle = love.graphics.newImage("/assets/gun/famas_idle.png")
    sprites.famas_fireing = love.graphics.newImage("/assets/gun/famas_fireing.png")

    require 'src/player'
    -- require("enemy")
    require 'src/bullet'
end
