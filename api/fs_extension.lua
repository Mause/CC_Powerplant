function list( path )
  return fs.list( path )
end

function exists( path )
  return fs.exists( path )
end

function isDir( path )
  return fs.isDir( path )
end

function isReadOnly( path )
  return fs.isReadOnly( path )
end

function getName( path )
  return fs.getName( path )
end

function getDrive( path )
  return fs.getDrive( path )
end

function makeDir( path )
  return fs.makeDir( path )
end

function move( path, path )
  return fs.move( path, path )
end

function copy( path, path )
  return fs.copy( path, path )
end

function delete( path )
  return fs.delete( path )
end

function combine( path, localpath )
  return fs.combine( path, localpath )
end

function open( path, mode )
  return fs.open( path, mode )
end

function saveFile(filename, data)
  local file = io.open(filename, 'w')
  file:write(data.readAll())
  file:close()
  return nil
end
