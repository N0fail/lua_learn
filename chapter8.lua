io.input("input.txt")

-- local l = io.read()
-- local func = assert(load('return '.. l))
-- print('the value of expression is '.. func())

-- print 'enter function to be plotted (with variable "x"):'
-- local l = io.read()
-- local f = assert(load('local x = ...; return ' .. l)) -- load(block) == function(...) block end
-- for i = 1, 20 do
--     print(string.rep('*', f(i)))
-- end

x = 1
local add = string.dump(function () -- lua bin code
    x = x + 10
end)
print(x)
load(add)()
print(x)

-- tasks ????