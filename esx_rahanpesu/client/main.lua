local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  
  
  ESX = nil
  local GUI, CurrentActionData = {}, {}
  local HasAlreadyEnteredMarker = false
  local LastZone, CurrentAction, CurrentActionMsg
  GUI.Time = 0
  
  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
	  end
  end)
  
  RegisterNetEvent("esx_blanchisseur:notify")
  AddEventHandler("esx_blanchisseur:notify", function(icon, type, sender, title, text)
	  Citizen.CreateThread(function()
		  Wait(1)
		  SetNotificationTextEntry("STRING");
		  AddTextComponentString(text);
		  SetNotificationMessage(icon, icon, true, type, sender, title, text);
		  DrawNotification(false, true);
	  end)
  end)
  
  
  
  
  
  
  AddEventHandler('esx_blanchisseur:hasEnteredMarker', function(zone)
	  CurrentAction     = 'whitening'
	  CurrentActionMsg  = _U('press_menu')
	  CurrentActionData = {zone = zone}
  end)
  
  AddEventHandler('esx_blanchisseur:hasExitedMarker', function(zone)
	  CurrentAction = nil
	  TriggerServerEvent('esx_blanchisseur:stopWhitening')
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	  PlayerData = xPlayer
  end)
  
  Citizen.CreateThread(function()
	  while true do
		  Wait(0)
		  local coords      = GetEntityCoords(GetPlayerPed(-1))
		  local isInMarker  = false
		  local currentZone = nil
  
		  for k,v in pairs(Config.Zones) do
			  if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.MarkerSize.x / 1) then
				  isInMarker  = true
				  currentZone = k
				  percent     = v.percent
			  end
		  end
		  
		  if isInMarker and not HasAlreadyEnteredMarker then
			  HasAlreadyEnteredMarker = true
			  pesu = false
			  TriggerEvent('esx_blanchisseur:hasEnteredMarker', currentZone)
		  end
		  if not isInMarker and HasAlreadyEnteredMarker then
			  HasAlreadyEnteredMarker = false
			  pesu = false
			  TriggerEvent('esx_blanchisseur:hasExitedMarker', LastZone)
		  end
	  end
  end)
  
  
  
  RegisterNetEvent('esx_pesu:toi')
  AddEventHandler('esx_pesu:toi', function()
	  if IsPedUsingAnyScenario(GetPlayerPed(-1)) == false then
		  TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true);
	  end	
  end)
  
  
  Citizen.CreateThread(function()
	  Citizen.Wait(0)	
		 local HashKey = GetHashKey("bkr_prop_prtmachine_dryer_spin")
	  local SpawnObject = CreateObject(HashKey, 878.8, -2164.4, 32.27)
	  PlaceObjectOnGroundProperly(SpawnObject)
	  FreezeEntityPosition(SpawnObject, true)
  
  end)
  
  
  Citizen.CreateThread(function()
	  Citizen.Wait(0)	
		 local HashKey = GetHashKey("bkr_prop_prtmachine_dryer")
	  local SpawnObject1 = CreateObject(HashKey, 881.17, -2164.6, 32.27)
	  PlaceObjectOnGroundProperly(SpawnObject1)
	  FreezeEntityPosition(SpawnObject1, true)
  
  end)
  
  
  Citizen.CreateThread(function()
	  Citizen.Wait(0)	
		 local HashKey = GetHashKey("bkr_prop_prtmachine_dryer")
	  local SpawnObject2 = CreateObject(HashKey, 1911.78, 4929.27, 48.99)
	  PlaceObjectOnGroundProperly(SpawnObject2)
	  FreezeEntityPosition(SpawnObject2, true)
  
  end)
  
  function PesuAnimation()
	  local playerPed = GetPlayerPed(-1)
	  
	  Citizen.CreateThread(function()
  SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, 1)
		  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)               
	  end)
  end
  
  local Pesu = false
  
  Citizen.CreateThread(function()
  while true do
  Citizen.Wait(5)
  if Pesu then
  TriggerEvent('esx_pesu:toi')
  ESX.ShowHelpNotification('Paina ~INPUT_VEH_DUCK~ lopettaaksesi pesun')
  if IsControlJustReleased(0, 73) then
	  Pesu = false
  TriggerServerEvent('esx_paina:x') 
  Citizen.Wait(15000)
  CurrentAction = nil
  
			  HasAlreadyEnteredMarker = false
			  TriggerEvent('esx_blanchisseur:hasExitedMarker', LastZone)
  
  
  Pesu = false
  
  elseif IsPedDeadOrDying(PlayerPedId()) then
	  Pesu = false
  TriggerServerEvent('esx_paina:x') 
  Citizen.Wait(15000)
  CurrentAction = nil
  
			  HasAlreadyEnteredMarker = false
			  TriggerEvent('esx_blanchisseur:hasExitedMarker', LastZone)
  
  Pesu = false
  
  end
  end
  end
  end)
  
  
  -- Key Controls
  Citizen.CreateThread(function()
  ThreadID = GetIdOfThisThread()
	while true do
	  Citizen.Wait(0)
	  if CurrentAction ~= nil then
  
		SetTextComponentFormat('STRING')
		AddTextComponentString(CurrentActionMsg)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
		if IsControlJustReleased(0, 38) and (GetGameTimer() - GUI.Time) > 1000 then
		  heure		= tonumber(GetClockHours())
		  GUI.Time 	= GetGameTimer()
		  
		  if CurrentAction == 'whitening' then
			  if Config.Hours then
				  if heure > Config.openHours and heure < Config.closeHours then
					  if Config.Menu then	
						  OpenBlanchisseurMenu()
  PesuAnimation()
					  else
  Pesu = false
						  TriggerServerEvent('esx_blanchisseur:startWhitening', percent)
  --exports['mythic_notify']:SendAlert('inform','Aloitetaan pesua!')
  Pesu = true
  
					  end					
				  else
					  TriggerServerEvent('esx_blanchisseur:Nothere')
				  end
			  else
				  if Config.Menu then	
					  OpenBlanchisseurMenu()
  PesuAnimation()
				  else
  Pesu = false
					  TriggerServerEvent('esx_blanchisseur:startWhitening', percent)
  --exports['mythic_notify']:SendAlert('inform','Aloitetaan pesua!')
  
  PesuAnimation()
  Pesu = true
				  end					
			  end
		  end
  
		  CurrentAction = nil
		end
	  end
	end
  end)
  
  
  
  