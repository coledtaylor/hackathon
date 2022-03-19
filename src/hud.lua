boxX = 5
boxY = 5
statsFont = love.graphics.newFont(18)

zombies = 0
level = 1

gameState = 1
-- 1 = before start
-- 2 = during game
-- 3 = game over

function drawHUD()
    if gameState == 1 then
        drawMenu()
    elseif gameState == 2 then
        drawStatsBox()
        drawStatsText()
    end
end

function drawMenu()
    startText = love.graphics.newText(love.graphics.newFont(30), "Press 'Enter' key to start")
    love.graphics.draw(startText, love.graphics.getWidth()/2 - startText:getWidth()/2, love.graphics.getHeight()/2)
    love.graphics.reset()
end

function drawStatsBox()
    love.graphics.setColor(169, 169, 169, 0.4)
    love.graphics.rectangle("fill", 10, 10, 165, 100, 15, 15)
    love.graphics.reset()
end

function drawStatsText()
    -- Health
    local person = love.graphics.newImage("icons/man.png")
    love.graphics.draw(person, boxX + 10, boxY + 10, 0, 0.04, 0.04)
    love.graphics.setColor(225, 0, 0)
    local heart = love.graphics.newImage("icons/heart.png")
    local xPosition = boxX + 45
    for i=1, player.health, 1 do
        love.graphics.draw(heart, xPosition, boxY + 8, 0, 0.04, 0.04)
        xPosition = xPosition + 25
    end
    love.graphics.reset()

    -- Zombie
    local zombie = love.graphics.newImage("icons/zombie.png")
    love.graphics.draw(zombie, boxX + 10, boxY + 40, 0, 0.04, 0.04)
    love.graphics.setColor(0, 0, 0, 1)
    local zombieText = love.graphics.newText(statsFont, zombies)
    love.graphics.draw(zombieText, boxX + 45, boxY + 40)

    -- Level
    local levelText = love.graphics.newText(statsFont, "Level: "..level)
    love.graphics.draw(levelText, boxX + 10, boxY + 70)
    love.graphics.reset()
end

function updateHUD(dt)
    if gameState == 1 then
        if love.keyboard.isDown("return") then
            gameState = 2
            drawStatsBox()
        end
    elseif gameState == 2 then
        drawStatsBox()
        if player.health <= 0 then
            gameState = 3
            showGameOverText()
        end
    elseif gameState == 3 and love.keyboard.isDown("return") then
        gameState = 1
        drawStatsBox()
    end
end

function showGameOverText()
    gameOverText = love.graphics.newText(love.graphics.newFont(30), "Game Over!\nPress 'Enter' key to play again or 'Esc' to exit")
    love.graphics.draw(gameOverText, love.graphics.getWidth()/2 - startText:getWidth()/2, love.graphics.getHeight()/2)
end