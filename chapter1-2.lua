X = 5
print("Hello world!")

print(5*4)
print("Thank You!")
dofile("func.lua")
print(Sqr(3))
print(arg[0])

io.write(type("Hello") .. '\n')
io.write(type(11) .. '\n')
io.write(type(1.1) .. '\n')
io.write(type(false) .. '\n')
io.write(type({0, 1}) .. '\n')
io.write(type(nil) .. '\n')
io.write(type(print) .. '\n')
io.write('There is also thread' .. '\n')
io.write('And userdata' .. '\n')

io.write('\x1F \44\n')

local big_string = [=[
Here's a little story
I'd like to tell
]=]
io.write(big_string)

local tbl = {}
tbl[0] = 1
tbl[1] = 0
tbl['z'] = 2
tbl['azbuka'] = 3
io.write(#tbl .. '\n')

io.write(type(nil) .. '\n')
io.write((type(nil) == nil))
io.write('\n')

local x = .0e12
io.write(x  .. '\n')
x = 0x12
io.write(x .. '\n')
x = 0xABF
io.write(x .. '\n')
x = 1e-11
io.write(x .. '\n')
x = 0x0.1p1
io.write(x .. '\n')

local a = {}
a.a = a
io.write(a.a.a.a)
io.write('\n')
a.a.a.a = 3
io.write(a.a)
io.write('\n')










