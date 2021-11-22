function love.load()
    love.window.setTitle("Click The Dots!")
    W, H = love.graphics.getDimensions()
    
    require("dot")
    game = require("game")
    ui = require("ui")
    sounds = require("sounds")
    
    game.setup()
    love.audio.play(sounds.soundtrack)
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end    
    game.update(dt)
end

function love.draw()
    if game.state == 0 then
        ui.printStartScreen()
    elseif game.state == 1 then
        for i = 1, #game.dots do
            game.dots[i].draw()
        end
        ui.printHUD()
    elseif game.state == 2 then
        ui.printEndScreen()
    end
end

function love.mousepressed(x, y, button)
    if game.state == 0 then
        game.state = 1
    elseif game.state == 1 then
        local prevScore = game.score
        -- Iterate through the dots to see if any were clicked.
        for i = #game.dots, 1, -1 do
            local dot = game.dots[i]
            -- The player clicked an explosive dot.
            if dot.isMouseOver and dot.isExplosive then
                sounds.playRandomSound(sounds.explosions)
                game.stop()
            -- The player clicked a regular dot.
            elseif dot.isMouseOver then
                sounds.playRandomSound(sounds.blips)
                game.score = game.score + 1
                if game.score > game.highscore then
                    game.highscore = game.score
                end
                table.remove(game.dots, dot.index)
            end
        end
        -- If the current score matches the previous score, then the player misclicked.
        if game.score == prevScore then
            sounds.playRandomSound(sounds.misclicks)
            game.misses = game.misses + 1
            if game.misses >= 3 then
                game.stop()
            end
        end
    elseif game.state == 2 then
        game.setup()
    end
end
