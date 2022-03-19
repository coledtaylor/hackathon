-- Game Status:
-- 0 = Before start
-- 1 = Game
-- 2 = Game Over

state = {
    kills = 0,
    level = 1,
    goal = 10,
    gameStatus = 0,
}

-- Used to spaws zombies in the enemies folder
maxTime = state.level
timer = maxTime
maxZombies = state.level * 3

if maxZombies > 15 then
    maxZombies = 15
end

function state:update()
    if player.state == 2 then
        state.gameStatus = 2
    end

    if self.kills >= self.goal then
        self.kills = 0
        self.goal = self.goal + self.level * 5
        self.level = self.level + 1
        self.gameStatus = 0
        
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
