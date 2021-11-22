local lg = love.graphics

function newDot(x, y, radius)
    local dot = {}

    dot.x = x
    dot.y = y
    dot.radius = radius
    dot.isExplosive = (love.math.random() < 0.1)

    function dot.update(index, dt)
        -- As dots are inserted and removed from the dots table, the indices of each
        -- dot should be updated to remain accurate.
        dot.index = index
        -- Decrease the radius of the dot if possible, otherwise handle its disappearance
        if dot.radius > 0 then
            dot.radius = dot.radius - 0.5
        else
            if not dot.isExplosive then
                sounds.playRandomSound(sounds.misclicks)
                game.misses = game.misses + 1
                if game.misses >= 3 then
                    game.stop()
                end
            end
            -- "Delete" the dot
            table.remove(game.dots, dot.index)
        end

        -- Update the distance to the mouse and determine if the mouse is hovering
		local mx, my = love.mouse.getPosition()
        local distToMouse = math.sqrt(math.pow(mx - dot.x, 2) + math.pow(my - dot.y, 2))
        dot.isMouseOver = (distToMouse < dot.radius)
    end

    function dot.draw()
        if dot.isMouseOver and dot.isExplosive then
            lg.setColor(1, 0, 0)
        elseif dot.isMouseOver then
            lg.setColor(0.85, 0.85, 0.85)
        else
            lg.setColor(1, 1, 1)
        end

        lg.circle("fill", dot.x, dot.y, dot.radius)
    end

	return dot
end
