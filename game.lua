local game = {}

function game.setup()
    -- 0 for start screen state; 1 for in-game state; and 2 for end screen state.
    game.state = 0
    game.dots = {}

    game.score = 0
    game.highscore = 0
    game.misses = 0

    game.tSinceLastSpawn = 0
    game.tBtwnSpawns = 1.5
    game.minTBtwnSpawns = 0.65

    -- If the highscore.txt file does not yet exist, create it and write 0.
    if not love.filesystem.getInfo("highscore.txt") then
        love.filesystem.write("highscore.txt", "0\n")
    end
    -- Read the highscore as the last line in the highscore.txt file.
    for line in love.filesystem.lines("highscore.txt") do
        game.highscore = tonumber(line)
    end
end

function game.stop()
    game.state = 2
    -- Store the highscore in a .txt file to save the highscore across sessions.
    love.filesystem.write("highscore.txt", game.highscore)
end

function game.spawnDot()
    -- Set minimum and maximum values for the radius depending on the score.
    local rMin, rMax
    if game.score <= 50 then
        rMin = 100
        rMax = 125
    else
        rMin = 75
        rMax = 100
    end

    -- Find a position to spawn the dot at that does not overlap any other dots.
    local x, y, radius
    repeat
        radius = love.math.random(rMin, rMax)
        x = love.math.random(radius, W - radius)
        y = love.math.random(radius, H - radius)
        -- Assume the spawn position DOES work, then set false if we find it does not.
        local doesSpawnPosWork = true
        for i = 1, #game.dots do
            local distBtwnDotsSquared = math.pow(x - game.dots[i].x, 2) + 
                                        math.pow(y - game.dots[i].y, 2)
            local sumRadiiSquared = math.pow(radius + game.dots[i].radius, 2)
            if distBtwnDotsSquared < sumRadiiSquared then
                doesSpawnPosWork = false
                break
            end
        end
    until doesSpawnPosWork

    table.insert(game.dots, newDot(x, y, radius))
end

function game.update(dt)
    if game.state == 1 then
        -- Update the time since the last spawn and spawn a new dot if it has
        -- been long enough since the last spawn.
        game.tSinceLastSpawn = game.tSinceLastSpawn + dt
        if game.tSinceLastSpawn > game.tBtwnSpawns then
            game.spawnDot()
            game.tSinceLastSpawn = 0
            if game.tBtwnSpawns > game.minTBtwnSpawns then
                game.tBtwnSpawns = game.tBtwnSpawns - (game.tBtwnSpawns * 0.05)
            end
        end
        -- Iterate through the table of dots in reverse order to ensure the
        -- indices will always be correct if a dot is inserted or removed.
        for i = #game.dots, 1, -1 do
            game.dots[i].update(i, dt)
        end
    end
end

return game
