local menu = MenuV:CreateMenu('Admin', 'Logged in as Admin', 'topleft', 255, 0, 0, 'size-150', 'default', 'menuv', 'admin_namespace')

local dv = menu:AddButton({ icon = '', label = 'Delete Vehicle', value = false })
local heal = menu:AddButton({ icon = '', label = 'Heal Player', value = false })
local revive = menu:AddButton({ label = 'Revive Player'})
local godmode = menu:AddCheckbox({ icon = '', label = 'Godmode', value = false })
local weapons = menu:AddSlider({ icon = '', label = 'Weapons', value = true, values = {
    { label = 'Pistol', value = weapon_pistol, description = 'Give Pistol' },
    { label = 'Rifle', value = weapon_rifle, description = 'Give Rifle' },
    { label = 'Sniper', value = weapon_sniper, description = 'Give Sniper' },
    { label = 'Knife', value = weapon_knife, description = 'Give Knife' }
}})
local clearloadout = menu:AddButton({ label = 'Clear Loadout'})
local coords = menu:AddButton({ label = 'Get Coords'})

dv:On('select', function(i)
    TriggerEvent( "R1-DeleteVehicle:deleteVehicle" )
end)

heal:On('select', function(i)
    SetEntityHealth(PlayerPedId(), 200)
    notify("Player Healed")
end)

godmode:On('check', function(item)
    SetEntityHealth(PlayerPedId(), 200)
    SetEntityInvincible(GetPlayerPed(-1), true)
    notify("Godmode Enabled")
end)

godmode:On('uncheck', function(item)
    SetEntityInvincible(GetPlayerPed(-1), false)
    notify("Godmode Disabled")
end)

-- Weapons

weapons:On('select', function(weapons, weapon_pistol)
    GiveWeaponToPed(GetPlayerPed(-1), Config.Weapons.pistol, Config.Weapons.ammo, false, true)
end)

weapons:On('select', function(weapons, weapon_rifle)
    GiveWeaponToPed(GetPlayerPed(-1), Config.Weapons.rifle, 250, false, true)
end)

weapons:On('select', function(weapons, weapon_sniper)
    GiveWeaponToPed(GetPlayerPed(-1), Config.Weapons.sniper, 250, false, true)
end)

weapons:On('select', function(weapons, weapon_knife)
    GiveWeaponToPed(GetPlayerPed(-1), Config.Weapons.knife, 250, false, true)
end)

revive:On('select', function(i)
    SetEntityHealth(PlayerPedId(), 200)
end)

coords:On('select', function(i)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    notify(coords .. "")
end)

clearloadout:On('select', function(i)
    RemoveAllPedWeapons(GetPlayerPed(-1), p1)
end)

RegisterCommand("admin", function()
    MenuV:OpenMenu(menu)
    notify("Admin Menu")
end)

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end