function loadout_spawn()
local ply = LocalPlayer()

local cl_hl2 = { "weapon_crowbar", "weapon_pistol", "weapon_357", "weapon_smg1", "weapon_ar2", "weapon_shotgun", "weapon_crossbow", "weapon_frag", "weapon_rpg", "weapon_physcannon", "weapon_bugbait" }
local cl_hl2_names = { "Crowbar", "9mm Pistol", ".357 Magnum", "SMG", "Pulse Rifle", "Shotgun", "Crossbow", "Frag Grenade", "RPG", "Gravity Gun", "Bug Bait" }
cl_weapons = { }

for i = 1, 11 do
table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_hl2[i], PrintName = cl_hl2_names[i], Category = "Half-Life 2" } )
end

local cl_hl2dm = { "weapon_stunstick", "weapon_slam" }
local cl_hl2dm_names = { "Stun Stick", "S.L.A.M" }

for i = 1, 2 do
table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_hl2dm[i], PrintName = cl_hl2dm_names[i], Category = "Half-Life 2: Deathmatch" } )
end

local cl_gmod = { "weapon_physgun" }
local cl_gmod_names = { "Physics Gun" }

table.insert(cl_weapons,{ Spawnable = true, AdminOnly = false, ClassName = cl_gmod[1], PrintName = cl_gmod_names[1], Category = "Other" } )

table.Add(cl_weapons,weapons.GetList())

cl_loadout = { }

for k, v in pairs(cl_weapons) do
if ply:HasWeapon(v.ClassName) then
cl_loadout[v.ClassName] = true
else
cl_loadout[v.ClassName] = false
end
end
net.Start("loadout_c2s")
net.SendToServer()
end

function loadout_option()
spawnmenu.AddToolMenuOption("Utilities","User","Loadout Option","Customize Loadout","","", loadout_panel,{})
end

function loadout_panel(panel)
panel:ClearControls()

local cl_clabel = { }
local cl_cnum = 0

local cl_ci = { }

local cl_skip = false

for k, v in pairs(cl_weapons) do
if v.Spawnable != nil && v.ClassName != nil && v.PrintName != nil then
if v.Category == nil then v.Category = "Other" end
cl_skip = false
if v.AdminOnly != nil then if v.AdminOnly then cl_skip = true end end
if v.Spawnable && !cl_skip then

cl_clabel[cl_cnum] = vgui.Create("DCollapsibleCategory",panel)
if cl_clabel[v.Category] != nil then
cl_clabel[cl_cnum]:Remove()
else
cl_clabel[cl_cnum]:SetLabel(v.Category)
cl_clabel[cl_cnum]:SetExpanded(0)
cl_clabel[cl_cnum]:Dock(TOP)

cl_clabel[v.Category] = cl_clabel[cl_cnum]
cl_ci[v.Category] = 1
cl_cnum = cl_cnum + 1
end

v.cl_label = vgui.Create("DCheckBoxLabel",cl_clabel[v.Category])
v.cl_label:SetTextColor(Color(0,0,0))
v.cl_label:SetText(v.PrintName)
v.cl_label:SetPos(25,25 * cl_ci[v.Category])
if cl_loadout[v.ClassName] then
v.cl_label:SetValue(true)
else
v.cl_label:SetValue(false)
end
function v.cl_label:OnChange(checked)
if checked then
net.Start("loadout_giveweapon")
net.WriteInt(k,16)
net.SendToServer()
else
net.Start("loadout_removeweapon")
net.WriteInt(k,16)
net.SendToServer()
end
end
cl_ci[v.Category] = cl_ci[v.Category] + 1
end
end
end
cl_options = vgui.Create("DCollapsibleCategory",panel)
cl_options:SetLabel("[Options]")
cl_options:SetExpanded(1)
cl_options:Dock(TOP)

cl_unmarkall = vgui.Create("DButton",cl_options)
cl_unmarkall:SetTextColor(Color(0,0,0))
cl_unmarkall:SetText("Unmark All")
cl_unmarkall:SetPos(25,25)
function cl_unmarkall:DoClick()
for k, v in pairs(cl_weapons) do
if cl_loadout[v.ClassName] then
v.cl_label:SetValue(false)
end
end
net.Start("loadout_unmarkall")
net.SendToServer()
end
end

hook.Add("InitPostEntity","Loadout Spawn",loadout_spawn)
hook.Add("PopulateToolMenu","Loadout Option Hook",loadout_option)
