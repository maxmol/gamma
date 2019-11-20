-- our main table
game = {}

-- store images
game.images = {}
game.image = function(path)
    local img = game.images[path]

    if img == nil then
        img = love.graphics.newImage(path)
        game.images[path] = img
    end

    return img
end

-- all entities
game.ents = {}
game.addEnt = function(e)
    game.ents[game.ents_counter] = e
    game.ents_counter = game.ents_counter + 1
end

game.ents_counter = 0

love.graphics.setDefaultFilter("nearest", "nearest") 

-- includes
require 'glob'
require 'timer'
require 'vec'
require 'vgui'
require 'button'
require 'ent'
require 'particle'
require 'levels'
require 'animation'

-- init vars
love.load = function()
    levels:load('menu')
end

-- draw the game
love.draw = function()
    levels:draw()

    for _, e in pairs(game.ents) do
        if e and not e._null then e:draw() end
    end
    
    for _, e in pairs(vgui._) do
        if e and not e._null then e:draw() end
    end
end

love.update = function(dt)
    levels:update(dt)

    for _, e in pairs(game.ents) do
        if e and not e._null then e:think(dt) end
    end

    for _, e in pairs(vgui._) do
        if e and not e._null then e:think(dt) end
    end

    timer:tick(dt)
end

function love.keypressed(key, scancode, isrepeat)
    levels:keypressed(key, scancode, isrepeat)

    if key == 'escape' then
        levels:load('menu')
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    local a = false
    for _, e in pairs(vgui._) do
        local ex, ey = e:getPos().x, e:getPos().y
        if e and not e._null and x > ex and y > ey and x < ex + e:getWidth() and y < ey + e:getHeight() then 
            e:click(x, y, istouch, presses) 
            a = true 
            break 
        end
    end

    if not a then
        levels:mousepressed(x, y, button, istouch, presses)
    end
end