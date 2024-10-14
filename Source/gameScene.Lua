local pd <const> = playdate
local gfx <const> = playdate.graphics

import "gameOverScene"
import "cannon"
import "house"
import "enemy/spawner"
import "enemy/witch"
import "enemy/zombie"

class('GameScene').extends(gfx.sprite)

houseX = 48
houseY = 189


function GameScene:init()

    House(houseX,houseY, 0)
    Cannon(houseX + 16, houseY - 32)
    Health(150, 14)
    createScoreDisplay(10, 6)
    startSpawner()

    if not GAME_MUSIC:isPlaying() then
        GAME_MUSIC:play(0)
    end

    local backgroundImage = gfx.image.new("images/background")
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.setClipRect(x, y, width, height)
            backgroundImage:draw(0, 0)
            gfx.clearClipRect()
        end
    )

end