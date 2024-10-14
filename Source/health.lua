local pd <const> = playdate
local gfx <const> = pd.graphics

import "score"

local damage = 1

class('Health').extends(gfx.sprite)

function Health:init(x, y, healthImageTable)

    self.healthImageTable = gfx.imagetable.new("images/health-table-100-16")
    self.healthSprite = gfx.sprite.new(self.healthImageTable:getImage(1))

    self.healthSprite:add()

    self:moveTo(x, y)
    self.healthSprite:moveTo(x, y)
    self:add()

end

function incrementDamage()
    damage += 1
end

function Health:update()
    if damage == 6 then
        SCENE_MANAGER:switchScene(GameOverScene)

    elseif damage ~= imageIndex then
        local healthImage = self.healthImageTable:getImage(damage)
        self.healthSprite:setImage(healthImage)
    end
end

function resetDamage()
    damage = 1
end