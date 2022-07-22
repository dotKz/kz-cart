local currentStable = nil

-------------------------------------------------------------------------------------------

local function ClearMenu()
	exports['qbr-menu']:closeMenu()
end

local function closeMenuFull()
    currentStable = nil
    ClearMenu()
end

-------------------------------------------------------------------------------------------
-- Menu
-------------------------------------------------------------------------------------------


local function MenuCart()
    exports['qbr-menu']:openMenu({
        {
            header = "<center><img src="..Config.MenuImg.." width=100%>",
            isMenuHeader = true
        },
        {
            header = Lang:t('menu.wagon'),
            txt = Lang:t('menu.wagon_sub'),
            params = {
                event = "kz-cart:client:CartList"
            }
        },
        {
            header = Lang:t('menu.buywagon'),
            txt = Lang:t('menu.buywagon_sub'),
            params = {
                event = "kz-cart:client:MenuShop"
            }
        },
        {
            header = Lang:t('menu.sellwagon'),
            txt = Lang:t('menu.sellwagon_sub'),
            params = {
                event = "kz-cart:client:CartListSell"
            }
        },
        {
            header = Lang:t('menu.givewagon'),
            txt = Lang:t('menu.givewagon_sub'),
            params = {
                event = "kz-cart:client:CartListGive"
            }
        },
        {
            header = "⬅ "..Lang:t('menu.close'),
            txt = "",
            params = {
                event = "qbr-menu:closeMenu"
            }
        },
    })
end


RegisterNetEvent("kz-cart:client:CartList", function()
    exports['qbr-core']:TriggerCallback('kz-cart:server:GetUserCart', function(result)
        if result == nil then
            local MenuPublicStableNocart = {
                {
                    header = "| "..Lang:t('menu.header')..": "..StableCart[currentStable].name.." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            MenuPublicStableNocart[#MenuPublicStableNocart+1] = {
                header = Lang:t('menu.nowagon'),
                txt = Lang:t('menu.nowagon_sub'),
                isMenuHeader = true
            }
            MenuPublicStableNocart[#MenuPublicStableNocart+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuPublicStableNocart)
        else
            local MenuPublicStableOptions = {
                {
                    header = "| "..Lang:t('menu.header')..": "..StableCart[currentStable].name.." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                name = v.name
                cid = v.cid
                model = v.model
                plate = v.plate

                if v.state == 0 then
                    v.state = Lang:t('state._out')
                elseif v.state == 1 then
                    v.state = Lang:t('state._in')
                elseif v.state == 2 then
                    v.state = Lang:t('state._ss')
                end

                MenuPublicStableOptions[#MenuPublicStableOptions+1] = {
                    header = Lang:t('menu.takeout')..": "..name,
                    txt = Lang:t('menu.etat')..": "..v.state.." <br>ID: "..plate.." | Model: "..model,
                    params = {
                        event = "kz-cart:client:TakeOutPublic",
                        args = v,
                    }
                }
            end

            MenuPublicStableOptions[#MenuPublicStableOptions+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuPublicStableOptions)
        end
    end, currentStable)
end)


RegisterNetEvent("kz-cart:client:CartListSell", function()
    exports['qbr-core']:TriggerCallback('kz-cart:server:GetUserCartAll', function(result)
        if result == nil then
            local MenuCartSellNo = {
                {
                    header = "| "..Lang:t('menu.header_glob').." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            MenuCartSellNo[#MenuCartSellNo+1] = {
                header = Lang:t('menu.nowagon'),
                txt = Lang:t('menu.nowagon_global_sub'),
                isMenuHeader = true
            }
            MenuCartSellNo[#MenuCartSellNo+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuCartSellNo)
        else
            local MenuCartSell = {
                {
                    header = "| "..Lang:t('menu.header_glob').." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                name = v.name
                cid = v.cid
                model = v.model
                plate = v.plate

                MenuCartSell[#MenuCartSell+1] = {
                    header = Lang:t('menu.sellm')..": "..name,
                    txt = "ID: "..plate.." | Model: "..model,
                    params = {
                        event = "kz-cart:client:CartListSellValidate",
                        args = v,
                    }
                }
            end

            MenuCartSell[#MenuCartSell+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuCartSell)
        end
    end)
end)


RegisterNetEvent("kz-cart:client:CartListSellValidate", function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| "..Lang:t('menu.sell').." |",
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.sell_confirm'),
            txt = Lang:t('menu.sell_confirm_sub'),
            params = {
                isServer = true,
                event = 'kz-cart:server:SellCart',
                args = {
                    plate = data.plate,
                    cid = data.cid,
                    model = data.model
                }
            }
        },
        {
            header = "⬅ "..Lang:t('menu.close'),
            txt = "",
            params = {
                event = "qbr-menu:closeMenu"
            }
        },
    })
end)


RegisterNetEvent("kz-cart:client:MenuShop", function()
    local g = {
        {
            header = "| "..Lang:t('menu.buy').." |",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.CartList) do
        g[#g+1] = {
            header = v.label,
            txt = Lang:t('menu.price')..": $" ..v.price.. " | ".." " .." Model:" .." " ..v.model,
            params = {
                event = "kz-cart:client:TypeOfPayment",
                args = {
                    price = v.price,
                    model = v.model,
                    label = v.label,
                    image = v.image
                }
            }
        }
    end
    g[#g+1] = {
        header = "⬅ "..Lang:t('menu.close'),
        params = {
            event = "qbr-menu:closeMenu",
        }
    }
    exports['qbr-menu']:openMenu(g)
end)


RegisterNetEvent("kz-cart:client:TypeOfPayment", function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| "..data.label.." |",
            isMenuHeader = true,
        },
        {
            header = "<center><img src="..data.image.." width=100%></center>",
            isMenuHeader = true,
        },
        {
            header = "| "..Lang:t('menu.typebuy').." |",
            isMenuHeader = true,
        },
        {
            header = Lang:t('menu.cash'),
            txt = Lang:t('menu.cash_sub1')..' $' ..data.price.. " "..Lang:t('menu.cash_sub2'),
            params = {
                event = 'kz-cart:client:NameOfCart',
                args = {
                    price = data.price,
                    model = data.model,
                    label = data.label,
                    paiement = "cash"
                }
            }
        },
        {
            header = Lang:t('menu.bank'),
            txt = Lang:t('menu.bank_sub1')..' $' ..data.price.. " "..Lang:t('menu.bank_sub2'),
            params = {
                event = 'kz-cart:client:NameOfCart',
                args = {
                    price = data.price,
                    model = data.model,
                    label = data.label,
                    paiement = "bank"
                }
            }
        },
        {
            header = "⬅ "..Lang:t('menu.close'),
            txt = "",
            params = {
                event = "qbr-menu:closeMenu"
            }
        },
    })
end)


RegisterNetEvent("kz-cart:client:CartListGive", function()
    exports['qbr-core']:TriggerCallback('kz-cart:server:GetUserCartAll', function(result)
        if result == nil then
            local MenuCartGiveNo = {
                {
                    header = "| "..Lang:t('menu.header_glob').." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            MenuCartGiveNo[#MenuCartGiveNo+1] = {
                header = Lang:t('menu.nowagon'),
                txt = Lang:t('menu.nowagon_global_sub'),
                isMenuHeader = true
            }
            MenuCartGiveNo[#MenuCartGiveNo+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuCartGiveNo)
        else
            local MenuCartGive = {
                {
                    header = "| "..Lang:t('menu.header_glob').." |",
                    header = Lang:t('menu.header_sub'),
                    isMenuHeader = true
                },
            }
            for k, v in pairs(result) do
                plate = v.plate
                name = v.name
                model = v.model

                MenuCartGive[#MenuCartGive+1] = {
                    header = Lang:t('menu.give')..": "..name,
                    txt = "ID: "..plate.." | Model: "..model,
                    params = {
                        event = "kz-cart:client:GiveNameOfCart",
                        args = v,
                    }
                }
            end

            MenuCartGive[#MenuCartGive+1] = {
                header = "⬅ "..Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qbr-menu:closeMenu",
                }
            }
            exports['qbr-menu']:openMenu(MenuCartGive)
        end
    end)
end)


-------------------------------------------------------------------------------------------
-- Input
-------------------------------------------------------------------------------------------


RegisterNetEvent("kz-cart:client:NameOfCart", function(data)

    local price = data.price
    local model = data.model
    local paiement = data.paiement

    local dialog = exports['qbr-input']:ShowInput({
        header = Lang:t('input.namewagon'),
        submitText = Lang:t('input.validate'),
        inputs = {
            {
                text = Lang:t('input.namewagon_text'),
                name = "nameofcart",
                type = "text",
                isRequired = true,
            }
        },
    })

    if dialog ~= nil then
            TriggerServerEvent('kz-cart:BuyCart', price, model, paiement, dialog.nameofcart, currentStable)
    end
end)


RegisterNetEvent("kz-cart:client:GiveNameOfCart", function(data)
    local plate = data.plate
    local dialoggive = exports['qbr-input']:ShowInput({
        header = Lang:t('input.giveid'),
        submitText = Lang:t('input.validate'),
        inputs = {
            {
                text = Lang:t('input.giveid_text'),
                name = "tocid",
                type = "text",
                isRequired = true,
            }
        },
    })

    if dialoggive ~= nil then
            TriggerServerEvent('kz-cart:server:GiveCart', plate, dialoggive.tocid)
    end
end)


-------------------------------------------------------------------------------------------
-- Event
-------------------------------------------------------------------------------------------


RegisterNetEvent('kz-cart:client:TakeOutPublic', function(vehicle)
    if vehicle.state == Lang:t('state._in') then
        --local TakeOutDist = #(GetEntityCoords(PlayerPedId()) - StableCart[currentStable].pz)
            --if TakeOutDist >= 1 and TakeOutDist <= 4 then
                name = vehicle.name
                cid = vehicle.cid
                model = vehicle.model
                plate = vehicle.plate
                exports['qbr-core']:Notify(9, Lang:t('state.check'), 2000, 0, 'toast_awards_set_q', 'awards_set_q_011', 'COLOR_WHITE')
                Wait(1000)
                exports['qbr-core']:SpawnVehicle(model, function(veh)
                    SetEntityHeading(veh, StableCart[currentStable].spawnPoint.w)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    Citizen.InvokeNative(0x400F9556, veh, plate)
                    SetEntityAsMissionEntity(veh, true, true)
                    closeMenuFull()
                    local tempplate = exports['qbr-core']:GetPlate(veh)
                    TriggerServerEvent('kz-cart:server:UpdateState', 0, plate, tempplate)
                end, StableCart[currentStable].spawnPoint, true)

            --elseif TakeOutDist <= 1 then
            --    exports['qbr-core']:Notify(9, "Veuillez faire de l'espace pour que nous puissions apporter votre chariot !", 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            --end
    elseif vehicle.state == Lang:t('state._out') then
        exports['qbr-core']:Notify(9, Lang:t('state.out'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    elseif vehicle.state == Lang:t('state._ss') then
        exports['qbr-core']:Notify(9, Lang:t('state.ssheriff'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('kz-cart:client:PutInStable', function()
    for k, v in pairs(StableCart) do
        local PutInDist = #(GetEntityCoords(PlayerPedId()) - StableCart[k].putCart)
        if PutInDist <= 10 then
            local ped = PlayerPedId()
            local cart = exports['qbr-core']:GetClosestVehicle()
            local tempplate = exports['qbr-core']:GetPlate(cart)
            if (tempplate ~= nil) then
                exports['qbr-core']:TriggerCallback('kz-cart:server:CheckVehicleOwner', function(owned)
                    if owned then
                        TriggerServerEvent('kz-cart:server:UpdateStatePut', 1, k, tempplate)
                        Wait(500)
                        exports['qbr-core']:DeleteVehicle(cart)
                        exports['qbr-core']:Notify(9, Lang:t('success.putin'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                    else
                        exports['qbr-core']:Notify(9, Lang:t('error.putinno'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                    end
                end, tempplate)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.putinerr'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end
    end
end)

RegisterNetEvent('kz-cart:client:PutOutStable', function()
    for k, v in pairs(StableCart) do
        local PutOutDist = #(GetEntityCoords(PlayerPedId()) - StableCart[k].takeCart)
        if PutOutDist <= 4 then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                MenuCart()
                currentStable = k
            end
        end
    end
end)


RegisterNetEvent('kz-cart:client:CartInventory', function()
	local vehicle = exports['qbr-core']:GetClosestVehicle()
    local plate = exports['qbr-core']:GetPlate(vehicle)

    exports['qbr-core']:TriggerCallback('kz-cart:server:CheckPlateInventory', function(result) 
        if result == nil then
            exports['qbr-core']:Notify(9, Lang:t('error.inverr'), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        else
            for k, v in pairs(result) do
                TriggerServerEvent("inventory:server:OpenInventory", "stash", v.plate, { maxweight = Config.CartInvWeight, slots = Config.CartInvSlots, })
                TriggerEvent("inventory:client:SetCurrentStash", v.plate)
            end
        end
    end, plate)
end)


-------------------------------------------------------------------------------------------
-- Blips & Prompt
----------------------------------------------------------------------------------------


CreateThread(function()
    for k, v in pairs(StableCart) do
		local blip = N_0x554d9d53f696d002(1664425300, StableCart[k].takeCart)
		SetBlipSprite(blip, -992598136, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, Lang:t('other.blips'))

        exports['qbr-core']:createPrompt(StableCart[k].name, StableCart[k].takeCart, 0xF3830D8E, Lang:t('other.prompt'), {
            type = 'client',
            event = 'kz-cart:client:PutOutStable'
        })
	end
end)


-------------------------------------------------------------------------------------------
-- onResourceStop
----------------------------------------------------------------------------------------


AddEventHandler("onResourceStop",function(resourceName)
	if resourceName == GetCurrentResourceName() then
        for k, v in pairs(StableCart) do
            PromptDelete(StableCart[k].name)
        end
	end
end)
-------------------------------------------------------------------------------------------
-- Debug
-------------------------------------------------------------------------------------------


--[[
RegisterCommand('debug_iccart', function()
    local plate = exports['qbr-core']:GetPlate(GetVehiclePedIsIn(PlayerPedId()))
    print(plate)
end)

RegisterCommand('debug_bpcart', function()
    local vehicle = exports['qbr-core']:GetClosestVehicle()
    local plate = exports['qbr-core']:GetPlate(vehicle)
    print(plate)
end)

]]--
