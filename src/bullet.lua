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
    if bullet:getX() < player:getX() - (love.graphics.getWidth() / 2) 
    or bullet:getX() > player:getX() + (love.graphics.getWidth() / 2) 
    or bullet:getY() < player:getY() - (love.graphics.getHeight() / 2) 
    or bullet:getY() > player:getY() + (love.graphics.getHeight() / 2) then
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
    mouseX, mouseY = camera:mousePosition()
    return math.atan2(bullet:getX() - mouseY, bullet:getY() - mouseX) + math.pi
end

function drawBullet()
    for i = 1, #bulletList do
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", bulletList[i]:getX() - 5, bulletList[i]:getY() - (5 / 2), 10, 5)
    end
end


