function expand(file)
  data = {}
  for line in file:lines() do
    local offset = string.find(line, ':', 1, true)
    local key = string.sub(line, 1, offset - 1)
    local value = string.sub(line, offset + 1)
    data[key] = value
  end
  return data
end

function load(filename)
  if fs.exists(filename) then
    local file = io.open(filename, 'r')
    local data = tabledata.expand(file)
    file:close()
    return data
  else
    return nil
  end
end

function save(data, filename)
  local file = io.open(filename, 'w')
  for key, value in pairs(data) do
    local line = string.format("%s:%s\n", key, value)
    file:write(line)
  end
  file:close()
  return nil
end
