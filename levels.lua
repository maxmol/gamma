-- game maps / levels whatev manager
levels = {}

function levels:draw()
end

function levels:update()
end

function levels:load(name)
    local level = require('levels/' .. name)
    if level.load then level:load() end
    self.draw = level.draw or self.draw
    self.update = level.update or self.update
end