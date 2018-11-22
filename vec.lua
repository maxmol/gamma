-- 2d vector
vec = {}
vec.__index = vec

function vec.__add(a, b)
    return vec(a.x + b.x, a.y + b.y)
end

function vec.__sub(a, b)
    return vec(a.x - b.x, a.y - b.y)
end

function vec.__mul(a, b)
    if type(a) == "number" then
        return vec(b.x * a, b.y * a)
    elseif type(b) == "number" then
        return vec(a.x * b, a.y * b)
    else
        return vec(a.x * b.x, a.y * b.y)
    end
end

function vec.__div(a, b)
    if type(a) == "number" then
        return vec(b.x / a, b.y / a)
    elseif type(b) == "number" then
        return vec(a.x / b, a.y / b)
    else
        return vec(a.x / b.x, a.y / b.y)
    end
end

function vec.__eq(a, b)
    return a.x == b.x and a.y == b.y
end

function vec.__lt(a, b)
    return a.x < b.x or (a.x == b.x and a.y < b.y)
end

function vec.__le(a, b)
    return a.x <= b.x and a.y <= b.y
end

function vec.__tostring(a)
    return a.x .. ' ' .. a.y
end

function vec:distance(a)
    return (self - a):len()
end

function vec:copy()
    return vec(self.x, self.y)
end

function vec:len()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function vec:lenSqr()
    return self.x * self.x + self.y * self.y
end

function vec:normal()
    return self / self:len()
end

function vec:rotate(phi)
    local c = math.cos(phi)
    local s = math.sin(phi)
    self.x = c * self.x - s * self.y
    self.y = s * self.x + c * self.y
    return self
end

function vec:rotated(phi)
    return self:copy():rotate(phi)
end

setmetatable(vec, {
    __call = function(_, x, y) 
        return setmetatable({
            x = x or 0, 
            y = y or 0
        }, vec) 
    end,
    __index = function()
        return nil
    end
})