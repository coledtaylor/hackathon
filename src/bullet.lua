bulletList = {}
flip = false
function spawnBullet()
    Bullet = world:newRectangleCollider(player:getX(), player:getY(), 10, 5, {collision_class = "Bullet"})
    Bullet.speed = 400
    Bullet.animSpeed = 0.5
    Bullet.playerPosistionSet = false
    Bullet.angle = bulletMouseAngle()
    Bullet.run_grid = anim8.newGrid(42, 14, sprites.famasSheet_bullet:getWidth(), sprites.famasSheet_bullet:getHeight())
    Bullet.animations = {}
    Bullet.animations.run = anim8.newAnimation(Bullet.run_grid('1-1', 1), Bullet.animSpeed)
    Bullet.anim = Bullet.animations.run
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

function collisionWithAnything(bullet)
    if bullet:enter("Obstacle") then
        return true
    else
        return false
    end
end

function updateBullet(dt)
    if player.body then
        for i=#bulletList, 1, -1 do
            bulletList[i]:setX(bulletList[i]:getX() + (math.cos( bulletList[i].angle ) * bulletList[i].speed * dt))
            bulletList[i]:setY(bulletList[i]:getY() + (math.sin( bulletList[i].angle ) * bulletList[i].speed * dt))
            bulletList[i].rotation = bulletList[i].angle
            if bulletList[i]:enter("Zombie") or bulletOutOfBounds(bulletList[i]) or collisionWithAnything(bulletList[i]) then
                bulletList[i]:destroy()
                table.remove(bulletList, i)
            end
        end
    end
end

function bulletMouseAngle()
    mouseX, mouseY = camera:mousePosition()
    return math.atan2((player:getY()) - mouseY, (player:getX()) - mouseX) + math.pi
end

function drawBullet()
    for i = 1, #bulletList do
        bulletList[i].anim:draw(sprites.famasSheet_bullet, bulletList[i]:getX(), bulletList[i]:getY(), bulletList[i].rotation, 0.5, 0.5, (65 / 2), (32 / 2))
    end
end


