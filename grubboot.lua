
grubversion = "GRUBCraft v0.1"
systems = {"CraftOS v1.1", "RedWorks v0.1", "Adventure"}
selecteditem = 1


function handleStartup(id)
    if id == 1 then os.run( {}, "rom/programs/shell") end
    if id == 2 then os.run( {}, "rom/red/programs/shell")end
    if id == 3 then os.run( {}, "rom/programs/adventure")end
end

function selectItem(item)
    if systems[item] ~= nil then
        drawItems()
        selecteditem = item
        term.setCursorPos(1,item+5)
        write(">")
        term.setCursorPos(0,0)
    end
end

function drawItems()
    for i,system in pairs(systems) do
        term.setCursorPos(1,i+5)
        write(" "..system)
    end
end

--print header
term.clear()
term.setCursorPos(1,1)
w,h = term.getSize()
print(string.rep("-",w))
print(string.rep(" ",w / 2 - string.len(grubversion) / 2) .. grubversion)
print(string.rep("-",w))

drawItems()
selectItem(1)
while true do
    event, key = os.pullEvent()
    if event == "key" and key == 208 then           --Down key pressed
        selectItem(selecteditem+1)

    elseif event == "key" and key == 200 then       --Up key pressed
        selectItem(selecteditem-1)

    elseif event == "key" and key ==28 then         --Enter key pressed
        term.clear()
        term.setCursorPos(1,h/2)
        print("Booting into "..systems[selecteditem])
        sleep(2.5)
        term.clear()
        term.setCursorPos(1,1)
        handleStartup(selecteditem)
        elseif event == "key" and key == 211 then   --Delete key pressed
        term.clear()
        term.setCursorPos(1,h/2)
        print("GrubCraft is shuttingdown...")
        sleep(2.5)
        os.shutdown()
        break
    end
end