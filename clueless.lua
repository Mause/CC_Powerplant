local sizeX, sizeY = term.getSize()
os.unloadAPI("sensorsUI")
os.loadAPI("/rom/apis/sensorsUI")
os.unloadAPI("sensorsData")
os.loadAPI("/rom/apis/sensorsData")

term.clear()
term.setCursorPos(1,1)

side = sensors.getController()
all_sensors = sensors.getSensors(side)
selected_sensor = all_sensors[1]
all_probes = sensors.getProbes(side,selected_sensor)
selected_probe = all_probes[3]
targets = sensors.getAvailableTargetsforProbe(side, selected_sensor, selected_probe)
selected_target = Targets[1]

if #targets ~= 0 then
    reading = sensors.getSensorReadingAsDict(side, selected_sensor, selected_target, selected_probe)

    -- for k, v in pairs(reading) do
    --     print(k, V)
    -- end

    if reading.tier == 1 then unit = "BatBox"
    elseif reading.tier == 2 then unit = "MFE"
    elseif reading.tier == 3 then unit = "MFSU" end

    print ('===='..all_sensors[1]..'====')
    print ('Max;'..reading.maxStorage)
    print ('Energy;'..reading.energy)
    print ('Tier;'..unit)
    print ('redstoneMode;'..reading.redstoneMode)
    print ('Output;'..reading.output)
    print ('EnergyNet?;'..tostring(reading.addedToEnergyNet))


else
    print ('No targets found')
end