local pd <const> = playdate
local gfx <const> = pd.graphics

import "score"

class('Cannonball').extends(gfx.sprite)

function Cannonball:init(x, y, angle)
    local ballSize = 2
    local ballImage = gfx.image.new(ballSize * 2, ballSize * 2)
    gfx.pushContext(ballImage)
        gfx.drawCircleAtPoint(ballSize, ballSize, ballSize)
    gfx.popContext()
    self:setImage(ballImage)

    self.collideSound = pd.sound.sampleplayer.new("sound/hit")
    self.collideSound:setVolume(0.4)

    self.angle = angle
    self.speed = 2

    self:setCollideRect(0, 0, self:getSize())
    self:moveTo(x, y)
    self:add()

end

function Cannonball:update()
    
    local xDist = math.cos(math.rad(self.angle - 90)) * self.speed
    local yDist = math.sin(math.rad(self.angle - 90)) * self.speed
    self:moveBy(xDist, yDist)
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + xDist, self.y + yDist)

    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(AnimatedSprite) or collidedObject:isa(Witch) then
                self.collideSound:play()
                difficultyModifier(10)
                collidedObject:remove()
                incrementScore()
            end
        end
        self:remove()
    elseif actualX > 400 or actualX < 0 or actualY > 240 or actualY < 0 then
        self:remove()
    end
end