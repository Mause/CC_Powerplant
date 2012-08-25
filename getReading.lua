--[[
	Program: getReading
	
	display available sensor readings for a given sensor + probe combo

	Author: yoskaz01
	
	Version: 1
	
	API dependencies:
	sensorsUI
	sensors
	
	Changelog:
	- initial version

	input:
	name of a sensor (as set in the sensor GUI)
	probe name (use getProbes to get available probe names for a given sensor)

	output:
	all available sensor readings for all probe targets in range of the sensor.
	
]]--
---- init
local arg = {...};
local sensor="Sensor";
local pdata={};
os.unloadAPI("sensorsData")
os.loadAPI("/rom/apis/sensorsData")
os.unloadAPI("sensors")
os.loadAPI("/rom/apis/sensors")
os.unloadAPI("sensorsUI")
os.loadAPI("/rom/apis/sensorsUI")

local side = sensors.getController()

if #arg >0  then
	sensor = arg[1];
else
	print ("Syntax: getReading sensor [probe]")
	return;
end
if #arg>1 then 
	pdata.probes=arg[2];
else
	pdata = sensors.getSensorInfo(side,sensor,"probes")		
end



---- main

for probe in string.gmatch(pdata.probes,"%a+") do
	if probe =="TargetInfo" then
			-- print target info if needed
	else
		local targets = sensors.getAvailableTargetsforProbe(side,sensor,probe);
		if #targets==0 then
			print ("no target found on sensor:"..sensor.." probe:"..probe)
		else
			sensorsUI.printPaged("[Sensor:"..sensor.."] [probe:"..probe.."]");
			for t,target in pairs(targets) do
				local data = sensors.getSensorReadingAsDict(side,sensor,target,probe);
				sensorsUI.printPaged("  [Target:"..target.."]");
				for i,v in pairs(data) do
					sensorsUI.printPaged("    "..tostring(i)..":"..tostring(v));
				end
			end
		end
	end
	
end