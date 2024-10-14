local pd <const> = playdate
local gfx <const> = pd.graphics

import "health"

class('Witch').extends(gfx.sprite)

local targetX = 48
local targetY = 189

function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

function Witch:init(x, y, moveSpeed)
    local witchImage = gfx.image.new("images/witch")
    self:setImage(witchImage)
    self:moveTo(x, y)
    self:add()

    self.damageSound = pd.sound.sampleplayer.new("sound/damage")
    
    self.damageSound:setVolume(0.45)

    self.angle = (math.deg(math.atan(targetY - self.y, targetX - self.x)) + 90) % 360

    self:setCollideRect(8, 4, 18, 22)

    self.speed = moveSpeed
end

function Witch:update()
    local xDist = math.cos(math.rad(self.angle - 90)) * self.speed
    local yDist = math.sin(math.rad(self.angle - 90)) * self.speed
    self:moveBy(xDist, yDist)

    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + xDist, self.y + yDist)

    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(House) then
                self.damageSound:play()
                incrementDamage()
                self:remove()
            end
        end
    end

end
