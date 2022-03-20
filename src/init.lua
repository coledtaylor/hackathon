function loadAll()
    math.randomseed(os.time())
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    vector = require("libs/hump/vector")
    anim8 = require("libs/anim8/anim8")
    sti = require("libs/sti/sti")
    require("libs/show")

    sounds = {}
    sounds.music = love.audio.newSource("audio/background.mp3", "stream")
    sounds.shoot = love.audio.newSource("audio/gunshot.mp3", "stream")
    sounds.attack_zombie = love.audio.newSource("audio/attack.mp3", "static")
    sounds.idle_zombie = love.audio.newSource("audio/idle.mp3", "static")
    sounds.zombie_death = love.audio.newSource("audio/zombie_death.mp3", "static")
    sounds.player_death = love.audio.newSource("audio/player_death.wav", "static")
    sounds.music:setLooping(true)
    sounds.music:setVolume(0.1)
    sounds.shoot:setVolume(0.1)
    sounds.zombie_death:setVolume(0.1)
    sounds.attack_zombie:setVolume(0.5)
    sounds.idle_zombie:setVolume(0.5)
    sounds.music:play()

    -- sounds.jump:play()

    Camera = require ("libs/hump/camera")
    scale = 3
    
    local windfield = require("libs/windfield/windfield")
    world = windfield.newWorld(0, 0, false)
    world:setQueryDebugDrawing(true)
    
    world:addCollisionClass('Player')
    world:addCollisionClass('Obstacle')
    world:addCollisionClass('Zombie')
    world:addCollisionClass('Bullet', {ignores = {'Player'}})

    sprites = {}
    sprites.playerSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_idle.png")
    sprites.playerSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_run.png")
    sprites.playerSheet_die = love.graphics.newImage("/assets/Zombie Asset Pack/player/player_dead.png")
    sprites.zombieSheet_idle = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_idle.png")
    sprites.zombieSheet_run = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_run.png")
    sprites.zombieSheet_attack = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_attack.png")
    sprites.zombieSheet_die = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/zombie/zombie_die.png")
    sprites.zombieSheet_idle_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_idle.png")
    sprites.zombieSheet_run_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_run.png")
    sprites.zombieSheet_attack_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_attack.png")
    sprites.zombieSheet_die_chungus = love.graphics.newImage("/assets/Zombie Asset Pack/enemies/chonker/chonker_die.png")
    sprites.famasSheet_idle = love.graphics.newImage("/assets/gun/famas_idle.png")
    sprites.famasSheet_fireing = love.graphics.newImage("/assets/gun/famas_fireing.png")
    sprites.famasSheet_bullet = love.graphics.newImage("/assets/gun/bullet.png")
    
    require("src/gameState")
    require("src/hud")
    gameMap = require("src/gameMap")
    loadMap()
    require("src/player")
    require("src/camera")
    require("src/enemy")
    require 'src/bullet'
    require("src/famasGun")
    sprites.famas_idle = love.graphics.newImage("/assets/gun/famas_idle.png")
    sprites.famas_fireing = love.graphics.newImage("/assets/gun/famas_fireing.png")
end
