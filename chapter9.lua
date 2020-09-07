local co = coroutine.create(function ()
    print('hi')
end)

print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co = coroutine.create(function ()
    for i = 1, 10 do
        print(i)
        coroutine.yield(12) -- returns run
    end
end)

x, y, z = coroutine.resume(co)
print(x, y, z)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)


local function permgen(a,n)
    n = n or #a
    if n<=1 then
        coroutine.yield(a)
    else
        for i = 1, n do
            a[n], a[i] = a[i], a[n]
            permgen(a, n-1)
            a[n], a[i] = a[i], a[n]
        end
    end
end

local function permutations(a)
    local co = coroutine.create(function () permgen(a) end)
    return function ()
        local code, res = coroutine.resume(co)
        return res
    end
end

-- function permutations(a) -- does the same as prev func
--     return coroutine.wrap(function () permgen(a) end)
-- end

local function print_sequence(s)
    for i = 1, #s do
        io.write(s[i])
    end
    io.write('\n')    
end

for p in permutations({1,2,3}) do
    print_sequence(p)
end


