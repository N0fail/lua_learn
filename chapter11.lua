local t={first=1, last = 0}

local function push_back(t, value)
    t.last = t.last + 1
    t[t.last] = value
end

local function push_front(t, value)
    t.first = t.first - 1
    t[t.first] = value
end

local function pop_back(t)
    if t.last < t.first then
        t.first = 1 -- task 11.1
        t.last = 0
        error("Queue is empty")
    end
    local value = t[t.last]
    t[t.last] = nil -- free mem
    t.last = t.last - 1
    return value
end

local function pop_front(t)
    if t.last < t.first then
        t.first = 1 -- task 11.1
        t.last = 0
        error("Queue is empty")
    end
    local value = t[t.first]
    t[t.first] = nil -- free mem
    t.first = t.first + 1
    return value
end


io.input("input.txt")
local s = ''
for line in io.lines() do -- O(n^2)
    s = s .. line .. '\n'
end
print(s)

io.input("input.txt")
local t = {}
for line in io.lines() do  -- O(n)
    t[#t+1] = line .. '\n'
end
local s = table.concat(t)
print(s)


local function name2node(graph, name)  
    local node = graph[name]
    if not node then
        node = {adj={}, name = name}
        graph[name] = node
    end
    return node
end

local function read_graph()
    local graph = {}
    for line in io.lines() do
        local name_from, dist, name_to = string.match(line, "(%S)%s+(%d+)%s+(%S+)")
        local from = name2node(graph, name_from)
        local to = name2node(graph, name_to)
        from.adj[to] = dist -- task 11.3
    end
    return graph
end

local function find_path(curr, to, path, visited)
    path = path or {}
    visited = visited or {}
    if visited[curr] then
        return nil
    end
    visited[curr] = true
    path[#path + 1] = curr -- add node to path
    if curr == to then
        return path
    end
    for node in pairs(curr.adj) do
        local p = find_path(node, to, path, visited)
        if p then return p end
    end
    path[#path] = nil -- remove node from path
end

local function print_path(path)
    for i = 1, #path do
        print(path[i].name)
    end    
end

local function Dijkstra(from, to, graph) -- task 11.4
    local res = {}
    local visited = {count = 0}
    local node_count = 0
    for name, node in pairs(graph) do
        res[node] = math.huge
        node_count = node_count + 1
    end
    res[from] = 0

    local min_res = from

    while visited.count < node_count do
        for node, dist in pairs(res) do
            if dist < res[min_res] and visited[node] == false then
                min_res = node
            end
        end
        local tmp
        for node, dist in pairs(min_res.adj) do
            if not visited[node] and (res[min_res] + min_res.adj[node] < res[node]) then
                res[node] = res[min_res] + min_res.adj[node]
                tmp = node
            end
        end
        visited[min_res] = true
        visited.count = visited.count + 1
        min_res = tmp
    end
    return res[to]
end

io.input("graph.txt")
local graph = read_graph()
local from = name2node(graph, 'a')
local to = name2node(graph, 'b')
local path = find_path(from, to)
if path then print_path(path) end
print(Dijkstra(from, to, graph))

