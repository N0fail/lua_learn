local function foo()
end

local function foo1()
    return 'a'
end

local function foo2()
    return 'a', 'b'
end

local function foo3()
    return foo(), foo2()
end

local function foo4()
    return foo2(), foo()
end

-- Some bullshit down there
print(foo(), 1)
print(foo1(), 1) 
print(foo2())       -- prints all values
print(foo2(), 1)    -- prints only a 1
local t1 = {foo2()}  -- t1 contains a,b
local t2 = {foo2(), foo()} -- t2 contains a
local t3 = {foo(), foo2()} -- t3 contains nil, a, b
print(foo3())
print(foo4())
-- It's over

print(table.unpack{10, 11, 12}) -- unpack returns all values of the ARRAY
local tbl1 = {13, 14, 15}
local tbl2 = {a=16, b=17, c=18}
local tbl3 = {[-1]=19, [0]=20, [1]=21, [3]=23}
print(table.unpack(tbl1)) -- prints 13 14 15
print(table.unpack(tbl2)) -- prints nothing
print(table.unpack(tbl3)) -- prints sequence starting from elem 1

local function var_arg_sum(...) -- variadic function
    local sum = 0
    for _, v in pairs{...} do
        sum = sum + v
    end
    return sum
end

print(var_arg_sum(1,2,3,4,5)) -- prints 15

local function fwrite(fmt, ...)  -- fmt gets first argument
    return io.write(string.format(fmt, ...))
end

print(var_arg_sum(1,2,3,nil,5,6)) -- works like table.pack() since 5.3 or 5.4 ??

local function sql_like(select, from, where, group_by)
    -- do something
end

local function sql_like_wrapper(args)
    if type(args.select) ~= string then
        return nil
    end
    sql_like(args.select, args.from, args.where, args.group_by)
end

sql_like_wrapper{from="my_table", where="x<5", select="count"} -- call named fields, others nil

local function Combinations(tt, ...) -- task 5.4
    local k = ... or 1
    if k >= #tt then
        print(table.unpack(tt))
        return 
    else
        for i = k, #tt do
            tt[i], tt[k] = tt[k], tt[i]
            Combinations(tt, k+1)
            tt[i], tt[k] = tt[k], tt[i]
        end
    end
end

Combinations({1,2,3,4})
-- tt = {4,3,nil, 2}
-- for key, value in pairs(tt) do
--     print(value)
-- end
-- print(table.unpack(tt))