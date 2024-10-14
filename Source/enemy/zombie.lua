local pd <const> = playdate
local gfx <const> = pd.graphics

import "enemy/animatedSprite.lua"
import "health"

class('Zombie').extends(gfx.sprite)

function Zombie:init(x, y)

    imagetable = playdate.graphics.imagetable.new('images/zombie-table-32-32')

    zombie = AnimatedSprite.new(imagetable) 
    zombie:addState("idle", 1, 4, {tickStep = 6})
    zombie:playAnimation()

    zombie:setCollideRect(8, 0, 18, 32)

    zombie:moveTo(x,y)
    zombie:add()

end

function AnimatedSprite:update()

    self:moveBy(-1, 0)
	self:updateAnimation()

    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x -1, self.y)

    if length > 0 then
        for index, collision in ipairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(House) then
                self.damageSound = pd.sound.sampleplayer.new("sound/damage") 
                self.damageSound:setVolume(0.45)
                self.damageSound:play()
                incrementDamage()
                self:remove()
            end
        end
    end
end

