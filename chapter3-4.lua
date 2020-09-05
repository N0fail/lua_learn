local full_angle = 34
local normal_angle = full_angle%(2*math.pi)
io.write(normal_angle .. '\n')
local negative_angle = -math.pi*0.5
normal_angle = negative_angle%(2*math.pi)
io.write(normal_angle .. '\n')

print(4 and 5)
print(false and 5)
print(4 or 5)
print(false or 5)

local x = 4
local y = 5
local max = (x > y) and x or y -- same as (x>y)?x:y for c

local a = {}
a[#a+1] = "hello"   -- same as a.push_back()
x = a[#a]           -- same as a.back()
a[#a] = nil         -- same as a.pop()
-- a must be a sequence (table with int keys, starting from 1) or string

local sunday = "monday" 
local monday = "sunday"
local t = {sunday = 'fryday', [sunday] = 'monday'}
print(t.sunday)
print(t[sunday])   -- sunday is a variable
print(t['sunday']) -- equals t.sunday
print(t['monday']) -- value of sunday
print(t.monday)    -- equal to t['monday']
sunday = "thuesday"
print(t[sunday])   -- no key "thuesday  "
-- print(t.sunday, t[sunday], t[t.sunday], t['monday'])
