local function disableHelmetFor(ped)
    -- Completely disable helmet behavior and remove if one slipped on
    SetPedHelmet(ped, false)        -- stops auto-equip
    RemovePedHelmet(ped, true)      -- yanks it off if already on
end

CreateThread(function()
    -- initial delay to let player spawn
    Wait(1500)
    while true do
        local ped = PlayerPedId()

        -- Keep helmet disabled at all times (covers model changes, revive, etc.)
        disableHelmetFor(ped)

        -- If on a bike (motorcycle or bicycle), make sure it can't equip
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            if veh ~= 0 then
                local class = GetVehicleClass(veh)
                -- 8 = Motorcycles, 13 = Cycles (bicycles)
                if class == 8 or class == 13 then
                    disableHelmetFor(ped)
                end
            end
        end

        -- run light; you can bump this to 2000ms if you prefer
        Wait(1000)
    end
end)

-- Also cover common spawn events (ESX/QBCore/standalone)
AddEventHandler('playerSpawned', function()
    local ped = PlayerPedId()
    Wait(500)
    disableHelmetFor(ped)
end)
