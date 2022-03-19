state = {
    kills = 0,
    level = 1,
    goal = 10,
}

function state:update()
    if state.kills >= state.goal then
        state.level = state.level + 1
        state.kills = 0
        state.goal = state.goal + state.level * 5

        for k,v in pairs(bulletList) do 
            bulletList[k]:destroy()
        end
        bulletList = {}
        for k,v in pairs(enemies) do 
            enemies[k]:destroy()
        end
        enemies = {}

        player.health = 4

        -- gameMap = sti("/assets/maps/" .. mapNames[math.random(#mapNames)] .. ".lua")
    end
end


