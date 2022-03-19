boxX = 5
boxY = 5
statsFont = love.graphics.newFont(18)

-- Game Status:
-- 0 = Before start
-- 1 = Game
-- 2 = Game Over

function drawHUD()
    if state.gameStatus == 0 then
        drawMenu()
    elseif state.gameStatus == 1 then
        drawStatsBox()
        drawStatsText()
    elseif state.gameStatus == 2 then
        showGameOverText()
    end
end

function drawMenu()
    startText = love.graphics.newText(love.graphics.newFont(30), "Press 'Enter' key to start")
    love.graphics.draw(startText, love.graphics.getWidth()/2 - startText:getWidth()/2, love.graphics.getHeight()/2)
    love.graphics.reset()
end

function drawStatsBox()
    love.graphics.setColor(169, 169, 169, 0.4)
    love.graphics.rectangle("fill", 10, 10, 165, 95, 15, 15)
    love.graphics.reset()
end

function drawStatsText()
    -- Health
    local person = love.graphics.newImage("icons/player.png")
    love.graphics.draw(person, boxX + 20, boxY + 10, 0, 1.2, 1.2)
    love.graphics.setColor(225, 0, 0)
    local heart = love.graphics.newImage("icons/heart.png")
    local xPosition = boxX + 45
    for i=1, player.health, 1 do
        love.graphics.draw(heart, xPosition, boxY + 8, 0, 0.04, 0.04)
        xPosition = xPosition + 25
    end
    love.graphics.reset()

    -- Zombie
    local zombie = love.graphics.newImage("icons/zombie_full.png")
    love.graphics.draw(zombie, boxX + 22, boxY + 42, 0, 1.2, 1.2)
    love.graphics.setColor(0, 0, 0, 1)
    local zombieText = love.graphics.newText(statsFont, state.kills)
    love.graphics.draw(zombieText, boxX + 45, boxY + 42)

    -- Level
    local levelText = love.graphics.newText(statsFont, "Level: "..state.level)
    love.graphics.draw(levelText, boxX + 20, boxY + 70)
    love.graphics.reset()
end

function showGameOverText()
    gameOverText = love.graphics.newText(love.graphics.newFont(28), "Oh no, the zombies ate what little brains you had!")
    playAgainText = love.graphics.newText(love.graphics.newFont(25), "Press 'Enter' key to play again or 'Esc' to exit")
    love.graphics.draw(gameOverText, love.graphics.getWidth()/2 - gameOverText:getWidth()/2, love.graphics.getHeight()/2 - 20)
    love.graphics.draw(playAgainText, love.graphics.getWidth()/2 - playAgainText:getWidth()/2, love.graphics.getHeight()/2 + 20)
end