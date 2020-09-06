local function values(t) -- cool iterator
    local i = 0
    return function ()
        i = i + 1
        return t[i]
    end
end

local t = {10, 20, 30}
for val in values(t) do
    print(val)
end

local function allwords()
    local line = io.read()    
    local pos = 0
    return function ()
        while line do
            local s,e = string.find(line, '%w+', pos)
            if s then
                pos = e + 1
                return string.sub(line, s, e)
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

io.input("input.txt")
for word in allwords() do
    print(word)
end

local function getnext (list, node)
    if not node then
        return list
    else
        return node.next
    end
end
  
local function traverse (list)
    return getnext, list, nil
end


io.input("input.txt")
local list = nil
for line in io.lines() do
  list = {val = line, next = list}
end

for node in traverse(list) do
  print(node.val)
end

local function fromto(n,m) -- task 7.1 closure iterator
    local i = n - 1
    return function ()
        i = i + 1
        if i <= m then
            return i
        else
            return nil
        end
    end
end

for i in fromto(1, 10) do
    print(i)
end

-- very unintuitive syntax
local ifromto, no_closure_it
local function no_closure_it(m,i) -- task 7.1 without closure
    if i < m then
        return i + 1
    else
        return nil
    end
end

local function ifromto(n,m)
    return no_closure_it, m, n-1
end

for i in ifromto(1,5) do
    print(i)
end

local ifromto_step, no_closure_it_step
local function no_closure_it_step(state) -- task 7.2 no closure, with step
    if state.n + state.s <= state.m then
        state.n = state.n + state.s
        return state.n
    else
        return nil
    end
end

local function ifromto_step(n,m,s)
    return no_closure_it_step, {n=n-s,m=m,s=s}
end

for i in ifromto_step(1, 7, 3) do
    print(i)
end

local function uniquewords() -- task 7.3
    local line = io.read()    
    local pos = 0
    local set = {}
    return function ()
        while line do
            local s,e = string.find(line, '%w+', pos)
            if s then
                pos = e + 1
                local word = string.sub(line, s, e)
                if not set[word] then
                    set[word] = true
                    return word
                end
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

io.input("input.txt")
for word in uniquewords() do
    print(word)
end

local function allsubstrings(str) -- task 7.4
    local begin = 1
    local finish = 0
    return function ()
        finish = finish + 1
        if finish > #str then
            begin = begin + 1
            finish = begin
        end
        if begin > #str then
            return nil
        else
            return string.sub(str, begin, finish)
        end
    end
end

for sub in allsubstrings("1234") do
    print(sub)
end
