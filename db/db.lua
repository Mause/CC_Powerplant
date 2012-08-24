local db_root_dir = '/db'

-- checks if a folder exists before creating it
function safe_mkdir(dir_name)
    if not fs.isDir(dir_name) then
        fs.makeDir(dir_name)
    end
end

-- downloads a file into the requested filename
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

-- takes the url of a lua api, downloads it into the specified filename, and loads it
function download_api(url, filename)
    if not fs.exists(filename)
        then
        assert(download(url, filename))
    end
    os.loadAPI(filename)
end


function setup_database()
    print("Database will be setup in root directory; continue?")
    answer = read()
    if answer == "yes"
    then
        print('Creating Directories...')
        assert(not fs.isReadOnly('/'), 'Unable to create directories in read-only filesystem.')
        safe_mkdir('/api/')

        safe_mkdir(db_root_dir)
        safe_mkdir(db_root_dir.."users")

        print 'Downloading json api...'
        download_api('http://raw.github.com/luaforge/json/master/trunk/json/json.lua')
    end
end


if not fs.isDir(db_root_dir)
    then
    print 'First time setup initialising...'
    setup_database()
else
    print 'Starting up database...'
end

