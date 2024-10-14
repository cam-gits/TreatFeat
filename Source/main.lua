import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "sceneManager"
import "gameOverScene"

import "health"
import "score"

local pd <const> = playdate
local gfx <const> = playdate.graphics

highScore = 0
GAME_MUSIC = pd.sound.sampleplayer.new("sound/Fantasy Retreat Cut 30")
GAME_MUSIC:setVolume(0.2)

local gameData = playdate.datastore.read()

if gameData then
    highScore = gameData.myHighScore
end

pd.display.setInverted(true)

SCENE_MANAGER = SceneManager()
GameOverScene()

function playdate.update()

    if pd.buttonIsPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end

    gfx.sprite.update()
    pd.timer.updateTimers()
end

function saveGameData()
    local gameData = {
        myHighScore = highScore,
    }
    playdate.datastore.write(gameData)
end

function playdate.gameWillTerminate()
    saveGameData()
end

function playdate.gameWillSleep()
    saveGameData()
end