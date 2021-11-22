local lg = love.graphics
local filename = "assets/fonts/arcadeFont.ttf"

local fonts = {}
fonts.xl = lg.newFont(filename, 48)
fonts.lg = lg.newFont(filename, 32)
fonts.md = lg.newFont(filename, 16)

local ui = {}

function ui.printStartScreen()
    lg.setColor(1, 1, 1)

    lg.setFont(fonts.lg)
    lg.printf(string.rep("-", 24), 0, 16, W, "center")
    lg.printf("CLICK THE DOTS!", 0, 48, W, "center")
    lg.printf(string.rep("-", 24), 0, 80, W, "center")

    lg.setFont(fonts.md)
    lg.printf("HOW TO PLAY:", 32, 160, W, "left")
    lg.printf(string.rep("-", 12), 30, 192, W, "left")
    lg.printf("* DOTS WILL APPEAR ON THE SCREEN...", 32, 224, W, "left")
    lg.printf("* CLICK THE DOTS BEFORE THEY DISAPPEAR!", 32, 256, W, "left")
    lg.printf("* DON'T CLICK THE RED DOTS OR YOU LOSE!", 32, 288, W, "left")
    lg.printf("* ONCE YOU MISS 3 DOTS, IT'S GAME OVER!", 32, 320, W, "left")

    lg.printf("** CLICK ANYWHERE TO START **", 0, H - 80, W, "center")
    lg.printf("***** PRESS ESC TO EXIT *****", 0, H - 48, W, "center")
end

function ui.printHUD()
    lg.setColor(1, 1, 1)

    lg.setFont(fonts.md)
    lg.printf("SCORE: " .. game.score, 8, 8, W, "left")
    lg.printf("HIGHSCORE: " .. game.highscore, 8, 32, W, "left")
    lg.printf("MISSES: " .. game.misses, 8, 56, W, "left")
end

function ui.printEndScreen()
    lg.setColor(1, 1, 1)

    lg.setFont(fonts.xl)
    lg.printf(string.rep("=", 12), 0, 120, W, "center")
    lg.printf("GAME OVER!", 0, 168, W, "center")
    lg.printf(string.rep("=", 12), 0, 216, W, "center")

    lg.setFont(fonts.md)
    lg.printf("** CLICK ANYWHERE TO RESTART **", 0, H - 80, W, "center")
    lg.printf("****** PRESS ESC TO EXIT ******", 0, H - 48, W, "center")
end

return ui
