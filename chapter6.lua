
local playlist = {
    {song = "Shampoo Bottles", author = "Peach Pit", year = 2020},
    {song = "Troublemaker", author = "Grizfolk", year = 2015},
    {song = "Bittersweet", author = "Greer", year = 2019},
}
table.sort(playlist, function (a,b) return a.song > b.song end) -- sorts by song name from most to least
print(playlist[1].song)
table.sort(playlist, function (a,b) return a.year > b.year end) -- sorts by year
print(playlist[1].song)

local function derivative(f, delta)
    delta = delta or 1e-4
    return function (x)
        return (f(x+delta) - f(x))/delta
    end    
end

print(math.cos(4), derivative(math.sin)(4)) -- ez clap

local names = {'Peter', 'Paul', 'Mary'}
local grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function (name1, name2) -- like ordered join 
    return grades[name1] > grades[name2]
end)

function Counter()
    local i = 0
    return function ()
        i = i + 1
        return i
    end    
end

-- closure, interesting feature
local c1 = Counter()
print(c1()) -- prints 1
print(c1()) -- prints 2
local c2 = Counter()
print(c2()) --prints 1
print(c2()) --prints 2
print(c2()) --prints 3
print(c1()) --prints 3

local function integral(f, step) -- task 6.1
    step = step or 1e-4
    return function (x)
        local sum = 0
        local prev_x = 0
        for cur_x = step, x, step do
            sum = sum + (f(cur_x) + f(prev_x))/2*step
            prev_x = cur_x
        end
        return sum
    end
end

local sqr = function (x) return x*x end
local int_sqr = integral(sqr)
print(sqr(2), int_sqr(2))

local function newpoly(t) -- task 6.2
    return function (x)
        local cur_x = 1
        local res = 0
        for i = #t, 1, -1 do
            res = res + cur_x * t[i]
            cur_x = cur_x * x
        end
        return res
    end
end

local np = newpoly{3,0,1}
print(np(0))
print(np(5))
print(np(10))



