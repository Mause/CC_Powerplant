function downloadSetup()
  local url = 'http://git.dropdev.org/computercraft-programs/raw/master/setup.lua'
  local filename = 'setup.lua'

  http.request(url)
  print('Downloading Setup...')

  while true do
    local event, p1, p2, p3, p4, p5 = os.pullEvent()

    if 'http_success' == event then
      print('Download Complete.')
      local contents = p2.readAll()
      local file = io.open(filename, 'w')
      file:write(contents)
      file:close()
      return nil
    elseif 'http_failure' == event then
      print('Download Failed')
      return nil
    end
  end
end

downloadSetup()
