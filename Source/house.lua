local pd <const> = playdate
local gfx <const> = playdate.graphics

class('House').extends(gfx.sprite)

function House:init(x, y, z)
    if z == 0 then
        local houseImage = gfx.image.new("images/house")
        self:setImage(houseImage)
        self:moveTo(x, y)
        self:add()
        self:setCollideRect(0, 32, 64, 80)
    else
        local houseImage = gfx.image.new("images/houseEnd")
        self:setImage(houseImage)
        self:moveTo(x, y)
        self:add()
    end

end

