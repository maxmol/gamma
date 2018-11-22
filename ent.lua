-- entity
ent = {}

function ent:getPos()
    return self._pos:copy()
end

function ent:setPos(vec)
    if vec and isnumber(vec.x) and isnumber(vec.y) then
        self._pos.x = vec.x
        self._pos.y = vec.y
    end
end

function ent:index()
    return self._index
end

function ent:draw() end

function ent:think() end

function ent:remove()
    love.ents[self:index()] = nil

    for k, v in pairs(self) do
        self[k] = nil
    end

    self._null = true
end

setmetatable(ent, {
    __call = function(_) 
        local e = setmetatable({
            _pos = vec(),
            _null = false,
            _index = love.ents_counter
        }, {__index = ent})

        love.ents[love.ents_counter] = e
        love.ents_counter = love.ents_counter + 1
        
        return e
    end,
    __index = function()
        return nil
    end
})