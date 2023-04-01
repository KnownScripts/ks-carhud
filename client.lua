local PlayerData = QBCore.Functions.GetPlayerData()
local config = Config
local speedMultiplier = config.UseMPH or 3.6
local seatbeltOn = false
local cruiseOn = false
local showAltitude = false
local showSeatbelt = false
local showMenu = false
local Menu = config.Menu

local function loadSettings(settings)
    for k,v in pairs(settings) do
        if k == 'isToggleMapShapeChecked' then
            Menu.isToggleMapShapeChecked = v
            SendNUIMessage({ test = true, event = k, toggle = v})
        elseif k == 'isChangeFPSChecked' then
            Menu[k] = v
            local val = v and 'Optimized' or 'Synced'
            SendNUIMessage({ test = true, event = k, toggle = val})
        else
            Menu[k] = v
            SendNUIMessage({ test = true, event = k, toggle = v})
        end
    end
    QBCore.Functions.Notify(Lang:t("notify.hud_settings_loaded"), "success")
    Wait(1000)
    TriggerEvent("hud:client:LoadMap")
end

local function saveSettings()
    SetResourceKvp('hudSettings', json.encode(Menu))
end

local function hasHarness(items)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then return end

    local _harness = false
    if items then
        for _, v in pairs(items) do
            if v.name == 'harness' then
                _harness = true
            end
        end
    end

    harness = _harness
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
end)






-- Reset hud
local function restartHud()
    TriggerEvent("hud:client:playResetHudSounds")
    QBCore.Functions.Notify(Lang:t("notify.hud_restart"), "error")
    if IsPedInAnyVehicle(PlayerPedId()) then
        Wait(2600)
        SendNUIMessage({ action = 'car', show = false })
        SendNUIMessage({ action = 'car', show = true })
    end
    Wait(2600)
    SendNUIMessage({ action = 'hudtick', show = false })
    SendNUIMessage({ action = 'hudtick', show = true })
    Wait(2600)
    QBCore.Functions.Notify(Lang:t("notify.hud_start"), "success")
end

RegisterNUICallback('restartHud', function(_, cb)
    Wait(50)
    restartHud()
    cb("ok")
end)

RegisterCommand('resethud', function(_, cb)
    Wait(50)
    restartHud()
    cb("ok")
end)

RegisterNUICallback('resetStorage', function(_, cb)
    Wait(50)
    TriggerEvent("hud:client:resetStorage")
    cb("ok")
end)

RegisterNetEvent("hud:client:resetStorage", function()
    Wait(50)
    if Menu.isResetSoundsChecked then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.1)
    end
    QBCore.Functions.TriggerCallback('hud:server:getMenu', function(menu) loadSettings(menu); SetResourceKvp('hudSettings', json.encode(menu)) end)
end)



RegisterNetEvent('hud:client:ToggleShowSeatbelt', function()
    showSeatbelt = not showSeatbelt
end)

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function() -- Triggered in smallresources in qbcore
    seatbeltOn = not seatbeltOn
end)

RegisterNetEvent('seatbelt:client:ToggleCruise', function() -- Triggered in smallresources in qbcore
    cruiseOn = not cruiseOn
end)

RegisterNUICallback('showFuelAlert', function(_, cb)
    Wait(50)
    Menu.isLowFuelChecked = not Menu.isLowFuelChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
    cb("ok")
end)























RegisterNetEvent('hud:client:ToggleAirHud', function()
    showAltitude = not showAltitude
end)







local prevPlayerStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updatePlayerHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevPlayerStats[k] ~= v then
            shouldUpdate = true
            break
        end
    end
    prevPlayerStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'hudtick',
            show = data[1],
            speed = data[2],
            cruise = data[3],
        })
    end
end

local prevVehicleStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updateVehicleHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevVehicleStats[k] ~= v then shouldUpdate = true break end
    end
    prevVehicleStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'car',
            show = data[1],
            isPaused = data[2],
            seatbelt = data[3],
            speed = data[4],
            fuel = data[5],
            altitude = data[6],
            showAltitude = data[7],
            showSeatbelt = data[8],
        })
    end
end

local lastFuelUpdate = 0
local lastFuelCheck = {}

local function getFuelLevel(vehicle)
    local updateTick = GetGameTimer()
    if (updateTick - lastFuelUpdate) > 2000 then
        lastFuelUpdate = updateTick
        lastFuelCheck = math.floor(exports['ks-fuel']:GetFuel(vehicle))
    end
    return lastFuelCheck
end

-- HUD Update loop

CreateThread(function()
    local wasInVehicle = false
    while true do
        if Menu.isChangeFPSChecked then
            Wait(500)
        else
            Wait(50)
        end
        if LocalPlayer.state.isLoggedIn then
            local show = true
            local player = PlayerPedId()
            local playerId = PlayerId()
            playerDead = IsEntityDead(player) or PlayerData.metadata["inlaststand"] or PlayerData.metadata["isdead"] or false
            parachute = GetPedParachuteState(player)
            if IsPauseMenuActive() then
                show = false
            end
            local vehicle = GetVehiclePedIsIn(player)
            if not (IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle)) then
            updatePlayerHud({
                show,
                math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                cruiseOn,
                -1,
            })
            end
            -- Vehicle hud
            if IsPedInAnyHeli(player) or IsPedInAnyPlane(player) then
                showAltitude = true
                showSeatbelt = false
            end
            if IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle) then
                wasInVehicle = true
                updatePlayerHud({
                    show,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    showSeatbelt,
                })
                updateVehicleHud({
                    show,
                    IsPauseMenuActive(),
                    seatbeltOn,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    getFuelLevel(vehicle),
                    math.ceil(GetEntityCoords(player).z * 0.5),
                    showAltitude,
                    cruiseOn,
                    showSeatbelt,
                })
                showAltitude = false
                showSeatbelt = true
            else
                if wasInVehicle then
                    wasInVehicle = false
                    SendNUIMessage({
                        action = 'car',
                        show = false,
                        seatbelt = false,
                        cruise = false,
                    })
                    seatbeltOn = false
                    cruiseOn = false
                    harness = false
                end
                --DisplayRadar(Menu.isOutMapChecked)
            end
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false
            })
        end
    end
end)

-- Low fuel
CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) and not IsThisModelABicycle(GetEntityModel(GetVehiclePedIsIn(ped, false))) then
                if exports['ks-fuel']:GetFuel(GetVehiclePedIsIn(ped, false)) <= 20 then -- At 20% Fuel Left
                    if Menu.isLowFuelChecked then
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.10)
                        QBCore.Functions.Notify(Lang:t("notify.low_fuel"), "error")
                        Wait(60000) -- repeats every 1 min until empty
                    end
                end
            end
        end
        Wait(10000)
    end
end)

























