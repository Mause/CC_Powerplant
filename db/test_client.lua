rednet.open("left")
rednet.announce()
while true do
    print rednet.recieve()
end