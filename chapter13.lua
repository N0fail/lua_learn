Set = {}
local mt={}
function Set.new(list)
    local set = {}
    setmetatable(set, mt)
    for _,v in pairs(list) do
        set[v] = true
    end
    return set
end

function Set.union(a,b)
    local set = Set.new{}
    for k in pairs(a) do set[k] = true end    
    for k in pairs(b) do set[k] = true end
    return set
end

function Set.intersection(a,b)
    local set = Set.new{}
    for k in pairs(a) do
        set[k] = b[k]
    end
    return set
end

function Set.to_string(set)
    local list = {}
    for k in pairs(set) do
        list[#list + 1] = k
    end    
    return '{' .. table.concat(list,',') .. '}'
end


mt.__add = Set.union
mt.__mul = Set.intersection
mt.__tostring = Set.to_string
mt.__metatable = "don't touch"

function mt.__le(a,b) -- a <= b (b contains a)
    for k in pairs(a) do
        if not b[k] then
            return false
        end
    end
    return true 
end

function mt.__lt(a,b) -- a < b (b contains a, a ~= b)
    return (a<=b) and not (b<=a)
end

function mt.__eq(a,b) -- a==b
    return (a<=b) and (b<=a)
end

function mt.__sub(a,b) -- task 13.1
    local res = {}
    for k in pairs(a) do
        res[k] = ~b[k]
    end
    return res
end

function mt.__len(a) -- task 13.2
    local len = 0
    for _ in pairs(a) do
        len = len+1
    end
    return len
end

a = Set.new{1,2,3,4}
b = Set.new{3,4,5,6}
c = a+b
d = a*b
print(c)
print(d)
print("a <= b: ", a <= b)
print("a <= c: ", a <= c)
print("a <= d: ", a <= d)
print("d < a:  ", d < a)
print("a == a: ", a==a)

local prototype={x=0,y=0,width=640,height=480}
mt2={}
-- mt2.__index = function (_, key)
--     return prototype[key]
-- end
mt2.__index = prototype -- same as function, works only for __index
function New(o)
    setmetatable(o, mt2)
    return o
end

mt2.__newindex = prototype

local w = New{x=10,y=20}
local ww = New{x=100, y=200}
print(w.width) -- width undefined -> callas metatable.__index(w, width) -- doesn't set the width for w
print(rawget(w, 'width')) -- no metamethod call
print(ww.height) -- 480
w.height = 100 -- sets height for metatable prototype
print(rawget(w, 'height')) -- still nil
print(ww.height) -- not 480 since prototype was changed


local function set_default(table, default_value)
    local mt = {__index = function () return default_value end}
    setmetatable(table, mt) -- uses closure
end

local default_example={x=2, y=34}
print(default_example.z)
set_default(default_example, 0)
print(default_example.z)

local unique_key = {}
local default_example2={__index = function (table) return table[unique_key] end}
local function set_default2(talbe, default_value)
    talbe[unique_key] = default_value
    setmetatable(table, default_example2) -- no closure used
end

function readOnly(t)
    local proxy = {}
    local mt = {
      --__index = t,
      __index = function (_, key)
          return t[key]
      end,
      __newindex = function (t, k, v)
        error('attempt to update a read-only table', 2)
      end
    }
    setmetatable(proxy, mt)
    return proxy
end

local days = readOnly{"Monday, Thuesday, Wednesday"}
print(days[1])
days[2] = "Saturday"


