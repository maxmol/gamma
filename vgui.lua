-- entity
vgui = {}
vgui._ = {}
vgui._counter = 0

function vgui:getPos()
    return self._pos:copy()
end

function vgui:setPos(vec)
    if vec and isnumber(vec.x) and isnumber(vec.y) then
        self._pos.x = vec.x
        self._pos.y = vec.y
    end
end

function vgui:draw() end

function vgui:think() end

function vgui:index()
    return self._index
end

function vgui:remove()
    vgui._[self:index()] = nil

    for k, v in pairs(self) do
        self[k] = nil
    end

    self._null = true
end

function vgui:setSize(x, y)
    self._size.x = x
    self._size.y = y
end

function vgui:getWidth()
    return self._size.x
end

function vgui:getHeight()
    return self._size.y
end

function vgui:setWidth(x)
    self._size.x = x
end

function vgui:setHeight(y)
    self._size.y = y
end

function vgui:generate()
    self._pos = vec()
    self._size = vec(64, 64)
    self._null = false

    vgui._counter = vgui._counter + 1
    self._index = vgui._counter
    vgui._[vgui._counter] = self
end

function vgui:click(...)
end

game.class(vgui) 