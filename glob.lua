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