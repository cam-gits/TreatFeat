import "gameScene"
import "sceneManager"
import "score"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init()

    resetDamage()

    if not GAME_MUSIC:isPlaying() then
        GAME_MUSIC:play(0)
    end

    House(48, 189, 1)

        local text = "Start Ⓐ   Shoot Ⓑ   Aim 🎣\n" .. "High Score: " .. highScore
        local gameOverImage = gfx.image.new(gfx.getTextSize(text))
        gfx.pushContext(gameOverImage)
            gfx.drawText(text, 0, 0)
        gfx.popContext()
        local gameOverSprite = gfx.sprite.new(gameOverImage)
        gameOverSprite:moveTo(125, 100)
        gameOverSprite:add()

    local backgroundImage = gfx.image.new("images/backgroundTitled")
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            gfx.setClipRect(x, y, width, height)
            backgroundImage:draw(0, 0)
            gfx.clearClipRect()
        end
    )

end