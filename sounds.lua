local lans = love.audio.newSource
local root = "assets/audio/"

local sounds = {}
sounds.soundtrack = lans(root .. "soundtrack.mp3", "static")
sounds.soundtrack:setLooping(true)
sounds.blips = {}
sounds.misclicks = {}
sounds.explosions = {}
for i = 1, 2 do
    sounds.blips[i] = lans(root .. "blip" .. i .. ".wav", "static")
    sounds.misclicks[i] = lans(root .. "misclick" .. i .. ".wav", "static")
    sounds.explosions[i] = lans(root .. "explosion" .. i .. ".wav", "static")
end

function sounds.playRandomSound(sounds)
    local sound = sounds[love.math.random(1, #sounds)]
    love.audio.play(sound)
end

return sounds
