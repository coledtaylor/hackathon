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
maxTime = 1
timer = 1
maxZombies = 3

function state:update()
    if self.kills >= self.goal then
        self:startLevel(false)
    end
end

function state:startLevel(restart)
    if restart then
        self.goal = 10
        self.level = 1
    else
        self.goal = self.goal + self.level * 5
        self.level = self.level + 1
    end
    
    self.gameStatus = 0
    self.kills = 0

    maxTime = state.level
    timer = maxTime
    maxZombies = state.level * 3

    if maxZombies > 100 then
        maxZombies = 100
    end
    
    for i=#bulletList,1,-1 do
        bulletList[i]:destroy()
        table.remove(bulletList, i)
    end
    for i=#enemies,1,-1 do
        enemies[i]:destroy()
        table.remove(enemies, i)
    end
    
    player.moving = false
    player.health = 4
    player.state = 0
    player:setLinearVelocity(0,0)
    
    loadMap()
end
