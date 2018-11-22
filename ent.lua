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
    game.ents[self:index()] = nil

    for k, v in pairs(self) do
        self[k] = nil
    end

    self._null = true
end

function ent:generate()
    self._pos = vec()
    self._null = false
    self._index = game.ents_counter

    game.addEnt(self)
end

game.class(ent)