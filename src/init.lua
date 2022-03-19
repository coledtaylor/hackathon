function loadAll()
    math.randomseed(os.time())
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    vector = require("libs/hump/vector")
    anim8 = require("libs/anim8/anim8")
    sti = require("libs/sti/sti")
    Camera = require ("libs/hump/camera")
    scale = 3
    
    local windfield = require("libs/windfield/windfield")
    world = windfield.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)
    
    world:addCollisionClass('Player')
    world:addCollisionClass('Obstacle')
    world:addCollisionClass('Zombie')
    
    sprites = {}
    sprites.playerSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_idle.png")
    sprites.playerSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_run.png")
    sprites.playerSheet_die = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_dead.png")
    sprites.zombieSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_idle.png")
    sprites.zombieSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_run.png")
    sprites.zombieSheet_attack = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_attack.png")
    sprites.zombieSheet_idle_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_idle.png")
    sprites.zombieSheet_run_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_run.png")
    sprites.zombieSheet_attack_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_attack.png")
    
    require("src/player")
    require("src/gameMap")
    require("src/camera")
    require("src/enemy")
end
