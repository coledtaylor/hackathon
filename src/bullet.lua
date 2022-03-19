bulletList = {}

function spawnBullet()
    Bullet = world:newRectangleCollider(player:getX(), player:getY(), 10, 5, {collision_class = "Bullet"})
    Bullet.speed = 400
    Bullet.playerPosistionSet = false
    Bullet.angleX = bulletMouseAngle(Bullet)
    Bullet.angleY = bulletMouseAngle(Bullet)

    table.insert(bulletList, Bullet)
end

function bulletOutOfBounds(bullet)
    if bullet:getX() > love.graphics.getWidth() or bullet:getX() < 0 or bullet:getY() > love.graphics.getHeight() or bullet:getY() < 0 then
        return true
    else
        return false
    end
end

function updateBullet(dt)
    for i=#bulletList, 1, -1 do
        bulletList[i]:setX(bulletList[i]:getX() + (math.cos( bulletList[i].angleX ) * bulletList[i].speed * dt))
        bulletList[i]:setY(bulletList[i]:getY() + (math.sin( bulletList[i].angleY ) * bulletList[i].speed * dt))
        if bulletList[i]:enter("Zombie") or bulletOutOfBounds(bulletList[i]) then
            bulletList[i]:destroy()
            table.remove(bulletList, i)
        end
    end
end

function bulletMouseAngle(bullet)
    return math.atan2( bullet:getY() - love.mouse.getY(), bullet:getX() - love.mouse.getX() ) + math.pi
end

function checkInput()
    if love.keyboard.isDown("space") then
        spawnBullet()
    end
end

function drawBullet()
    for i=#bulletList, 1, -1 do
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", bulletList[i]:getX() - (10/ 2), bulletList[i]:getY() - (10 / 2), 10, 5)
    end
end


