baseurl = 'http://git.dropdev.org/computercraft-programs/raw/master/'

function download(url, filename)
  http.request(url)

  while true do
    local event, p1, p2, p3, p4, p5 = os.pullEvent()

    if 'http_success' == event then
      local contents = p2.readAll()
      local file = io.open(filename, 'w')
      file:write(contents)
      file:close()
      return true
    elseif 'http_failure' == event then
      return false
    end
  end
end

print('Creating Directories...')
assert(not fs.isReadOnly('/'), 'Unable to create directories in read-only filesystem.')

if not fs.isDir('/api/') then
  fs.makeDir('/api/')
end
if not fs.isDir('/cache/') then
  fs.makeDir('/cache/')
end
if not fs.isDir('/programs/') then
  fs.makeDir('/programs/')
end

print('Downloading Download System...')
assert(download(baseurl .. 'api/fs_extension.lua', '/api/fs_ext'))
assert(download(baseurl .. 'api/http_extension.lua', '/api/http_ext'))

print('Loading API Extensions')
os.loadAPI('/api/fs_ext')
os.loadAPI('/api/http_ext')

print('Downloading Package List Parser')
assert(http_ext.save(baseurl .. 'api/tabledata.lua', '/api/tabledata'))

print('Loading API Additions')
os.loadAPI('/api/tabledata')
