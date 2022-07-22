
local cart

-------------------------------------------------------------------------------------------
-- onResourceStart
-------------------------------------------------------------------------------------------

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        if AutoRespawn then
            exports.oxmysql:execute('UPDATE cart SET state = 1 WHERE state = 0', {})
        end
    end
end)

-------------------------------------------------------------------------------------------
-- Function
-------------------------------------------------------------------------------------------


local function GeneratePlate()
    local plate = "CA" .. tostring(exports['qbr-core']:RandomInt(2) .. exports['qbr-core']:RandomStr(2) .. exports['qbr-core']:RandomInt(1) .. exports['qbr-core']:RandomStr(1))
    local result = MySQL.scalar.await('SELECT plate FROM cart WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end


-------------------------------------------------------------------------------------------
-- Command
-------------------------------------------------------------------------------------------

exports['qbr-core']:AddCommand('rcart', 'Reset Cart (Admin Only)', {{ name = 'identifiant', help = 'Plaque (ID) du Chariot' }}, true, function(args)
	TriggerEvent('kz-cart:server:AdminUpdateState', args)
  end, 'admin')


-------------------------------------------------------------------------------------------
-- Callback
-------------------------------------------------------------------------------------------


exports['qbr-core']:CreateCallback('kz-cart:server:GetUserCart', function(source, cb, currentStable)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM cart WHERE cid = ? AND ecurie = ? ', {Playercid, currentStable}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)


exports['qbr-core']:CreateCallback('kz-cart:server:GetUserCartAll', function(source, cb)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM cart WHERE cid = ? ', {Playercid}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)


exports['qbr-core']:CreateCallback('kz-cart:server:CheckVehicleOwner', function(source, cb, tempplate)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid
    exports.oxmysql:execute('SELECT * FROM cart WHERE temp_plate = ? AND cid = ?',{tempplate, Playercid}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)


exports['qbr-core']:CreateCallback('kz-cart:server:CheckPlateInventory', function(source, cb, plate)
	exports.oxmysql:execute('SELECT * FROM cart WHERE temp_plate = ? ', {plate}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)


-------------------------------------------------------------------------------------------
-- Event
-------------------------------------------------------------------------------------------


RegisterNetEvent('kz-cart:server:UpdateState', function(state, plate, tempplate)
    exports.oxmysql:execute('UPDATE cart SET state = ?, temp_plate = ? WHERE plate = ?',{state, tempplate, plate})
end)

RegisterNetEvent('kz-cart:server:UpdateStatePut', function(state, ecurie, tempplate)
    exports.oxmysql:execute('UPDATE cart SET state = ?, ecurie = ? WHERE temp_plate = ?',{state, ecurie, tempplate})
end)

RegisterNetEvent('kz-cart:server:AdminUpdateState', function(plate)
    exports.oxmysql:execute('UPDATE cart SET state = 1 WHERE plate = ?',{plate})
end)

RegisterNetEvent("kz-cart:BuyCart", function(price, model, paiement, name, currentStable)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid
	local plate = GeneratePlate()

	MySQL.Async.fetchAll('SELECT * FROM cart WHERE `cid`=@cid;', {cid = Playercid}, function(cart)
		if #cart >= 3 then
			TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('error.maxwagon'), 2000, Lang:t('error.maxwagon_sub'), 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			return
		end

		Wait(200)
		if paiement == "bank" then
			local currentBank = Player.Functions.GetMoney('bank')
			if price <= currentBank then
				local bank = Player.Functions.RemoveMoney("bank", price, "stable-bought-horse")
				TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('success.buy'), 2000, Lang:t('success.buy_sub'), 'blips', 'blip_ambient_lower', 'COLOR_WHITE')
			else
				TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('error.buy'), 2000, Lang:t('error.buy_sub_b'), 'satchel_textures', 'animal_horse', 'COLOR_WHITE')
				return
			end
		else
			if Player.Functions.RemoveMoney("cash", price, "stable-bought-horse") then
				TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('success.buy'), 2000, Lang:t('success.buy_sub'), 'blips', 'blip_ambient_lower', 'COLOR_WHITE')
			else
				TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('error.buy'), 2000, Lang:t('error.buy_sub_c'), 'satchel_textures', 'animal_horse', 'COLOR_WHITE')
				return
			end
		end
		
		MySQL.Async.execute('INSERT INTO cart (`cid`, `model`, `name`, `plate`, `ecurie`) VALUES (@Playercid, @model, @name, @plate, @currentStable);', {Playercid = Playercid, name = name, model = model, plate = plate, currentStable = currentStable}, function(rowsChanged) end)
		MySQL.Async.execute('INSERT INTO stashitems (`stash`) VALUES (@plate);', {plate = plate}, function(rowsChanged) end)
	end)
end)


RegisterNetEvent("kz-cart:server:SellCart", function(data)
	local dCid = data.cid
	local dPlate = data.plate
	local dModel = data.model

	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid

	MySQL.Async.fetchAll('DELETE FROM cart WHERE `cid`=@cid AND`plate`=@plate;', {cid = Playercid,  plate = dPlate}, function(result) end)
	MySQL.Async.fetchAll('DELETE FROM stashitems WHERE `stash`=@plate;', {plate = dPlate}, function(result)	end)
	for k, v in pairs(Config.Itemlist) do
		if v.model ~= "name" then
			if v.model == dModel then
				print(dModel)
				local price = tonumber(v.price/5)
					Player.Functions.AddMoney("cash", price, "stable-sell-horse")
					TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('success.sell'), 2000, Lang:t('success.sell_sub'), 'blips', 'blip_ambient_lower', 'COLOR_WHITE')
					TriggerEvent('qbr-log:server:CreateLog', 'shops', 'Stable', 'red', "**"..GetPlayerName(Player.PlayerData.source) .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** sold a horse for $"..price..".")
			end
		end
	end
end)


RegisterNetEvent("kz-cart:server:GiveCart", function(plate, cid)
	local src = source
	local plate = plate
	local cid = cid
	exports.oxmysql:execute('UPDATE cart SET cid = ? WHERE plate = ?',{cid, plate})
	TriggerClientEvent('QBCore:Notify', src, 8, Lang:t('success.give'), 2000, Lang:t('success.give_sub') ..plate.. " "..Lang:t('success.give_sub2').." "..cid.. " !", 'blips', 'blip_ambient_lower', 'COLOR_WHITE')
end)

