boxX = 5
boxY = 5
statsFont = love.graphics.newFont(18)

zombies = 0
level = 1

function drawHUD()
    drawMenu()
    drawStatsBox()
    drawStatsText()
end

function drawMenu()
    startText = love.graphics.newText(love.graphics.newFont(20), "Press any key to start")
    love.graphics.draw(startText, love.graphics.getWidth() / 2 - 25, love.graphics.getHeight() / 2)
end

function drawStatsBox()
    love.graphics.print(camera.x)
    love.graphics.setColor(169, 169, 169, 0.4)
    love.graphics.rectangle("fill", camera.x - 395, camera.y - 295, 165, 100, 15, 15)
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
    drawStatsBox()
end