local authors = {}
function Entry(t)
    authors[t.author] = true
end
dofile("self-describe.txt")
for name in pairs(authors) do
    print(name)
end

local function serialize(o, file, padding)
    file = file or io
    padding = padding or 0
    if type(o) == type(1) then
        file:write(string.format('%a', o)) -- writes number in 0x... format
    elseif type(o) == type('a') then
        file:write(string.format('%q', o)) -- handles ", \, / correctly
    elseif type(o) == type({}) then
        file:write('{\n')
        local keys = {}
        for k=1,#o do
            if o[k] then
                keys[k] = true
            end
        end
        for k,v in pairs(o) do
            file:write(string.rep('\t', padding))
            if type(k) ~= type(1) and not load('return o.'..k) then -- task 12.3
                k = '[\'' .. k .. '\']'
            end
            if not keys[k] then -- task 12.4
                file:write(k,'=')
            end
            serialize(v, file, padding + 1)
            file:write(',\n')
        end
        file:write(string.rep('\t', padding-1))
        file:write('}\n')
    end
end
local file = io.open("serialize.txt", 'w')
--serialize(12415, file)
--serialize("hello 'Mike'", file)
serialize({['1var']=1, a=234,{cd="aa", q={22,23}}, 23, 56},file)
io.close(file)