net.Receive("loadout_c2s",function(len,ply)
ply.cl_spawned = true

ply.cl_loadout = { }

local cl_storedweapons = net.ReadTable()
if cl_storedweapons[1] != nil then
for k, v in pairs(cl_storedweapons) do
ply.cl_loadout[v] = true
end
else
for k, v in pairs(cl_weapons) do
if ply:HasWeapon(v.ClassName) then
ply.cl_loadout[v.ClassName] = true
end
end
end

ply:RemoveAllAmmo()
ply:StripWeapons()
for k, v in pairs(cl_weapons) do
if ply.cl_loadout[v.ClassName] != nil then
ply:Give(v.ClassName)
if v.Primary.Ammo != nil then
if v.Primary.Ammo != "none" then
if v.Primary.ClipSize != nil then
if v.Primary.ClipSize > 0 then
ply:GiveAmmo(v.Primary.ClipSize * 16,v.Primary.Ammo,true)
else
ply:GiveAmmo(16,v.Primary.Ammo,true)
end
end
end
end
if v.Secondary.Ammo != nil then
if v.Secondary.Ammo != "none" then
if v.Secondary.ClipSize != nil then
if v.Secondary.ClipSize > 0 then
ply:GiveAmmo(v.Secondary.ClipSize * 16,v.Secondary.Ammo,true)
else
ply:GiveAmmo(16,v.Secondary.Ammo,true)
end
end
end
end
end
end
end)

net.Receive("loadout_giveweapon",function(len,ply)
local cl_weapon = net.ReadInt(16)
ply.cl_loadout[cl_weapons[cl_weapon].ClassName] = true
ply:Give(cl_weapons[cl_weapon].ClassName)
if cl_weapons[cl_weapon].Primary.Ammo != nil then
if cl_weapons[cl_weapon].Primary.Ammo != "none" then
if cl_weapons[cl_weapon].Primary.ClipSize != nil then
if cl_weapons[cl_weapon].Primary.ClipSize > 0 then
ply:GiveAmmo(cl_weapons[cl_weapon].Primary.ClipSize * 16,cl_weapons[cl_weapon].Primary.Ammo,true)
else
ply:GiveAmmo(16,cl_weapons[cl_weapon].Primary.Ammo,true)
end
else
ply:GiveAmmo(16,cl_weapons[cl_weapon].Primary.Ammo,true)
end
end
end
if cl_weapons[cl_weapon].Secondary.Ammo != nil then
if cl_weapons[cl_weapon].Secondary.Ammo != "none" then
if cl_weapons[cl_weapon].Secondary.ClipSize != nil then
if cl_weapons[cl_weapon].Secondary.ClipSize > 0 then
ply:GiveAmmo(cl_weapons[cl_weapon].Secondary.ClipSize * 16,cl_weapons[cl_weapon].Secondary.Ammo,true)
else
ply:GiveAmmo(16,cl_weapons[cl_weapon].Secondary.Ammo,true)
end
else
ply:GiveAmmo(16,cl_weapons[cl_weapon].Secondary.Ammo,true)
end
end
end
end)

net.Receive("loadout_removeweapon",function(len,ply)
local cl_weapon = net.ReadInt(16)
ply.cl_loadout[cl_weapons[cl_weapon].ClassName] = nil
ply:StripWeapon(cl_weapons[cl_weapon].ClassName)
end)

net.Receive("loadout_unmarkall",function(len,ply)
for k, v in pairs(cl_weapons) do
if ply.cl_loadout[v.ClassName] != nil then
ply.cl_loadout[v.ClassName] = nil
end
end
ply:StripWeapons()
ply:StripAmmo()
end)

function loadout_initialize()
local cl_hl2 = { "weapon_crowbar", "weapon_pistol", "weapon_357", "weapon_smg1", "weapon_ar2", "weapon_shotgun", "weapon_crossbow", "weapon_frag", "weapon_rpg", "weapon_physcannon", "weapon_bugbait" }
local cl_hl2_names = { "Crowbar", "9mm Pistol", ".357 Magnum", "SMG", "Pulse Rifle", "Shotgun", "Crossbow", "Frag Grenade", "RPG", "Gravity Gun", "Bug Bait" }

local cl_hl2_ammo = { "none", "Pistol", "357", "SMG1", "AR2", "Buckshot", "XBowBolt", "Grenade", "RPG_Round", "none", "none" }
local cl_hl2_clip = { -1, 18, 6, 45, 30, 6, 1, -1, -1, -1, -1 }

local cl_hl2_ammo2 = { "none", "none", "none", "SMG1_Grenade", "AR2AltFire", "none", "none", "Grenade", "RPG_Round", "none", "none" }
local cl_hl2_clip2 = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }

cl_weapons = { }

for i = 1, 11 do
table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_hl2[i], PrintName = cl_hl2_names[i], Category = "Half-Life 2", Primary = { Ammo = cl_hl2_ammo[i], ClipSize = cl_hl2_clip[i] }, Secondary = { Ammo = cl_hl2_ammo2[i], ClipSize = cl_hl2_clip2[i] } } )
end

local cl_hl2dm = { "weapon_stunstick", "weapon_slam" }
local cl_hl2dm_names = { "Stun Stick", "S.L.A.M" }

local cl_hl2dm_ammo = { "none", "slam" }
local cl_hl2dm_clip = { -1, -1 }

local cl_hl2dm_ammo2 = { "none", "none" }
local cl_hl2dm_clip2 = { -1, -1 }

for i = 1, 2 do
table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_hl2dm[i], PrintName = cl_hl2dm_names[i], Category = "Half-Life 2: Deathmatch", Primary = { Ammo = cl_hl2dm_ammo[i], ClipSize = cl_hl2dm_clip[i] }, Secondary = { Ammo = cl_hl2dm_ammo2[i], ClipSize = cl_hl2dm_clip2[i] } } )
end

local cl_gmod = { "weapon_physgun" }
local cl_gmod_names = { "Physics Gun" }

table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_gmod[1], PrintName = cl_gmod_names[1], Category = "Other", Primary = { }, Secondary = { } } )

table.Add(cl_weapons,weapons.GetList())
end

function loadout_spawn(ply)
if ply.cl_spawned == nil then return end

ply:RemoveAllAmmo()
for k, v in pairs(cl_weapons) do
if ply.cl_loadout[v.ClassName] != nil then
ply:Give(v.ClassName)
if v.Primary.Ammo != nil then
if v.Primary.Ammo != "none" then
if v.Primary.ClipSize != nil then
if v.Primary.ClipSize > 0 then
ply:GiveAmmo(v.Primary.ClipSize * 16,v.Primary.Ammo,true)
else
ply:GiveAmmo(16,v.Primary.Ammo,true)
end
end
end
end
if v.Secondary.Ammo != nil then
if v.Secondary.Ammo != "none" then
if v.Secondary.ClipSize != nil then
if v.Secondary.ClipSize > 0 then
ply:GiveAmmo(v.Secondary.ClipSize * 16,v.Secondary.Ammo,true)
else
ply:GiveAmmo(16,v.Secondary.Ammo,true)
end
end
end
end
end
end
return true
end

util.AddNetworkString("loadout_c2s")
util.AddNetworkString("loadout_giveweapon")
util.AddNetworkString("loadout_removeweapon")
util.AddNetworkString("loadout_unmarkall")

hook.Add("Initialize","Loadout Initialize",loadout_initialize)
hook.Add("PlayerLoadout","Loadout Spawn",loadout_spawn)
