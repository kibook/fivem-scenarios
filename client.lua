local radius = 1.5

local function displayHelp(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

local function canPedUseScenarioNearCoords(playerPed, coords)
	return DoesScenarioExistInArea(coords, radius, true) and
		not IsScenarioOccupied(coords, radius, true) and
		not IsPedInAnyVehicle(playerPed, true)
end

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsPedUsingAnyScenario(playerPed) then
			displayHelp("Press ~INPUT_ENTER~ to end the scenario")

			if IsControlJustPressed(0, 23) then
				ClearPedTasks(playerPed)
			end

			Citizen.Wait(0)
		elseif canPedUseScenarioNearCoords(playerPed, coords) then
			displayHelp("Press ~INPUT_CONTEXT~ to use a scenario")

			if IsControlJustPressed(0, 38) then
				TaskUseNearestScenarioToCoordWarp(playerPed, coords, radius, -1)
			end

			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)
