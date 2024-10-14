local pd <const> = playdate
local gfx <const> = pd.graphics

import "witch"

local spawnTimer
difficultyMod = 160
witchSpeed = 2

function startSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
end

function createTimer()
    dice = math.random(1,6)
    local spawnTime = math.random(500+(dice*difficultyMod), 1500+(dice*difficultyMod))
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function()
        createTimer()
        spawnEnemy(dice)
    end)
end

function spawnEnemy(dice)
    if (dice > 3) then
        toss = math.random(1, 3)
        if (toss == 1) then
            local spawnX = math.random(175, 415)
            Witch(spawnX, 0, witchSpeed)        
        else
            local spawnY = math.random(0, 180)
            Witch(430, spawnY, witchSpeed)
        end
    else 
        Zombie(430, 220)
    end
 
end

function difficultyModifier(modifier)
    difficultyMod = difficultyMod - modifier
end
