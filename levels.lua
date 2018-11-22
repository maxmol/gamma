-- game maps / levels whatev manager
levels = {}

function levels:draw()
    if self.level and self.level.draw then
        self.level:draw()
    end
end

function levels:update(dt)
    if self.level and levels.level.update then
        self.level:update(dt)
    end
end

function levels:load(name)
    if self.level and self.level.exit then
        self.level:exit()
    end

    print('entering ' .. name .. '...')
    local level = require('levels/' .. name)
    if level.load then level:load() end
    self.level = level
end

function levels:keypressed(...)
    if self.level and levels.level.keypressed then
        self.level:keypressed(...)
    end
end