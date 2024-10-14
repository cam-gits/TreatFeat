local pd <const> = playdate
local gfx <const> = playdate.graphics

import "cannonball"

class('Cannon').extends(gfx.sprite)

function Cannon:init(x, y, cannonImageTable)

    self.cannonImageTable = gfx.imagetable.new("images/cannon-table-32-32")
    self.cannonSprite = gfx.sprite.new(self.cannonImageTable:getImage(1))
    self.cannonAngle = 0

    self.fireSound = pd.sound.sampleplayer.new("sound/cannon")
    
    self.fireSound:setVolume(0.33)

    self.cannonSprite:add()

    self:moveTo(x, y)
    self.cannonSprite:moveTo(x, y)
    self:add()

end

function Cannon:aimAt(angle)
    local cannonImageIndex = math.floor(angle / 22.5) + 1
    -- self.cannonAngle = (cannonImageIndex - 1) * 22.5 << use an equiv  of this if you have time to expand sprite sheet
    self.cannonAngle = angle
    local cannonImage = self.cannonImageTable:getImage(cannonImageIndex)
    self.cannonSprite:setImage(cannonImage)
end

function Cannon:fire()

    local cannonOffset = 16

    local xOffset = math.cos(math.rad(self.cannonAngle - 90)) * cannonOffset
    local yOffset = math.sin(math.rad(self.cannonAngle - 90)) * cannonOffset

    Cannonball(self.x + xOffset, self.y + yOffset, self.cannonAngle)
end

function Cannon:update()
    local crankChange = pd.getCrankChange()

    if crankChange ~= 0 then
        local crankPos = pd.getCrankPosition()
        self:aimAt(crankPos)
    end

    if pd.buttonJustPressed(pd.kButtonB) then
        self:fire()
        self.fireSound:play()
    end

end