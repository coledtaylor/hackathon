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
        self:nextLevel()
    end
end

function state:nextLevel()
    self.kills = 0
    self.goal = self.goal + self.level * 5
    self.level = self.level + 1
    self.gameStatus = 0
    
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

function state:restart()
    self.kills = 0
    self.goal = 10
    self.level = 0
    self.gameStatus = 0
    
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
