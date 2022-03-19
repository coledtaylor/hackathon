-- Game Status:
-- 0 = Before start
-- 1 = Game
-- 2 = Game Over

state = {
    kills = 0,
    level = 1,
    goal = 10,
    gameStatus = 1,
}

function state:update()
    if state.kills >= state.goal then
        state.kills = 0
        state.goal = state.goal + state.level * 5
        state.level = state.level + 1

        for i=#bulletList,1,-1 do
            bulletList[i]:destroy()
            table.remove(bulletList, i)
        end
        for i=#enemies,1,-1 do
            enemies[i]:destroy()
            table.remove(enemies, i)
        end

        player.health = 4

        loadMap()
    end
end
