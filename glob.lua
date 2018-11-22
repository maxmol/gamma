-- some global functions and variables

function valid(v)
    return v ~= nil and not v._null 
end

math.clamp = function(n, min, max)
    return math.max(math.min(n, max or n), min)
end

function isnumber(a)
    return type(a) == 'number'
end

function isstring(a)
    return type(a) == 'string'
end

function isfunction(a)
    return type(a) == 'function'
end

function istable(a)
    return type(a) == 'table'
end

local class_call = function(_, ...) 
    local c = _.extends and _.extends() or {}
    if _.generate then _.generate(c, ...) end
    if _.__index then 
        setmetatable(c, _)
    else
        setmetatable(c, {__index = _})
    end
    
    return c
end

function game.class(t)
    setmetatable(t, {
        __call = class_call,
        __index = t.extends or function() return nil end
    })
end
