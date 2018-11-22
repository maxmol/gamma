-- time, is it really?
timer = {}
timer._ = {}

local getTime = love.timer.getTime
timer.create = function(name, secs, reps, func)
    if isfunction(func) then
        table.insert(timer._, {
            name = tostring(name),
            secs = tonumber(secs) or 0,
            start = getTime(),
            reps = reps,
            func = func
        })
    end
end

timer.remove = function(name)
    for i, t in ipairs(timer._) do
        if t.name == name then
            t.reps = 0
            return
        end
    end
end

timer.simple = function(secs, func)
    if isfunction(func) then
        table.insert(timer._, {
            name = false,
            secs = tonumber(secs) or 0,
            start = getTime(),
            reps = 1,
            func = func
        })
    end
end

function timer:tick()
    local i = 1
    while i <= #timer._ do
        local t = timer._[i]
        if t.reps and t.reps < 1 then
            table.remove(timer._, i)
        else
            local when = t.start + t.secs
            if getTime() >= when then
                t.func()
                if t.reps then t.reps = t.reps - 1 end
                t.start = when
            end

            i = i + 1 
        end
    end
end