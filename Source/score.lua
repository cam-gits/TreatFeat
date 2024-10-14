local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite
local score

function createScoreDisplay(x, y)
    scoreSprite = gfx.sprite.new()
    score = 0
    updateDisplay()
    scoreSprite:setCenter(0,0)
    scoreSprite:moveTo(x, y)
    scoreSprite:add()
end

function updateDisplay()
    local scoreText = "Treats: " .. score
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    scoreSprite:setImage(scoreImage)
end

function incrementScore()
    score += 1
    if score > highScore then
        highScore = score
    end
    updateDisplay()
end

function resetScore()
    score = 0
    updateDisplay()
end