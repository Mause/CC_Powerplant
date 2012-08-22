if not http then
  error('HTTP Functionality not Availble')
end

os.loadAPI('/api/fs_ext')

function get(url)
  return http.get(url)
end

function request(url)
  return http.request(url)
end

function download(url)
  http_ext.request(url)

  while true do
    local event, p1, p2, p3, p4, p5 = os.pullEvent()

    if 'http_success' == event then
      return p2
    elseif 'http_failure' == event then
      return nil
    end
  end
end

function save(url, filename)
  local data = http_ext.download(url)

  if data then
    fs_ext.saveFile(filename, data)
    return true
  else
    return false
  end
end
