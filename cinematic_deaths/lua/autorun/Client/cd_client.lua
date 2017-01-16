net.Receive("cinematic_death_c2s",function(len,ply)
local cd_death = net.ReadInt(8)
cd_deathinprogress = true

cinematic_grayscale()
if cd_death == 0 then
cd_sound = "cinematic_drama"
elseif cd_death == 1 then
cd_sound = "cinematic_drama2"
elseif cd_death == 2 then
cd_sound = "cinematic_drama3"
elseif cd_death == 3 then
cd_sound = "cinematic_drama4"
elseif cd_death == 4 then
cd_sound = "cinematic_drama5"
elseif cd_death == 5 then
cd_sound = "cinematic_drama6"
elseif cd_death == 6 then
cd_sound = "cinematic_drama7"
elseif cd_death == 7 then
cd_sound = "cinematic_drama8"
elseif cd_death == 8 then
cd_sound = "cinematic_drama9"
elseif cd_death == 9 then
cd_sound = "cinematic_drama10"
elseif cd_death == 10 then
cd_sound = "cinematic_drama11"
elseif cd_death == 11 then
cd_sound = "cinematic_drama12"
elseif cd_death == 12 then
cd_sound = "cinematic_drama13"
elseif cd_death == 13 then
cd_sound = "cinematic_drama14"
elseif cd_death == 14 then
cd_sound = "cinematic_drama15"
elseif cd_death == 15 then
cd_sound = "cinematic_drama16"
elseif cd_death == 16 then
cd_sound = "cinematic_drama17"
elseif cd_death == 17 then
cd_sound = "cinematic_drama18"
elseif cd_death == 18 then
cd_sound = "cinematic_drama19"
elseif cd_death == 19 then
cd_sound = "cinematic_drama20"
elseif cd_death == 20 then
cd_sound = "cinematic_drama21"
elseif cd_death == 21 then
cd_sound = "cinematic_drama22"
elseif cd_death == 22 then
cd_sound = "cinematic_drama23"
elseif cd_death == 23 then
cd_sound = "cinematic_drama24"
elseif cd_death == 24 then
cd_sound = "cinematic_drama25"
elseif cd_death == 25 then
cd_sound = "cinematic_drama26"
elseif cd_death == 26 then
cd_sound = "cinematic_drama27"
elseif cd_death == 27 then
cd_sound = "cinematic_drama28"
end

LocalPlayer():EmitSound(cd_sound)
end)

net.Receive("cinematic_spawn_c2s",function(len,ply)
if cd_deathinprogress == nil then return end
cd_deathinprogress = nil

LocalPlayer():StopSound(cd_sound)
end)

function cinematic_grayscale()
if cd_deathinprogress == nil then return end
DrawColorModify(cd_grayscale_color)
end

cd_grayscale_color = { 
["$pp_colour_addr"] = 0, 
["$pp_colour_addg"] = 0, 
["$pp_colour_addb"] = 0, 
["$pp_colour_brightness"] = 0, 
["$pp_colour_colour"] = 0, 
["$pp_colour_contrast"] = 1, 
["$pp_colour_mulr"] = 0, 
["$pp_colour_mulg"] = 0, 
["$pp_colour_mulb"] = 0 
}

hook.Add("RenderScreenspaceEffects","Cinematic Grayscale",cinematic_grayscale)