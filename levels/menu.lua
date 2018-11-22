local _ = {}

local all
local selected = 1
function _:load()
    all = {}
    for k, v in ipairs(love.filesystem.getDirectoryItems('levels')) do
        local f = string.find(v, '.lua')
        table.insert(all, f and string.sub(v, 0, f - 1) or v)
    end
end

function _:draw()
    love.graphics.clear(0, 0, 0)

    for k, v in ipairs(all) do
        if selected == k then love.graphics.setColor(1, 0, 0) end
        love.graphics.print(v, 10, k * 40)
        if selected == k then love.graphics.setColor(1, 1, 1) end
    end
end

function _:keypressed(key)
    if key == 'up' then
        selected = selected - 1
        if selected == 0 then
            selected = #all
        end
    elseif key == 'down' then
        selected = selected + 1
        if selected > #all then
            selected = 1
        end
    elseif key == 'return' then
        levels:load(all[selected])
    end
end

return _