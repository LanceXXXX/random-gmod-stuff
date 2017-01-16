net.Receive("cinematic_death_c2s",function(len,ply)
local cd_death = net.ReadInt(8)
cd_deathinprogress = true

cinematic_grayscale()
if cd_death == 0 then
cd_sound = "cinematic_deaths/cd_drama.ogg"
elseif cd_death == 1 then
cd_sound = "cinematic_deaths/cd_drama2.ogg"
elseif cd_death == 2 then
cd_sound = "cinematic_deaths/cd_drama3.ogg"
elseif cd_death == 3 then
cd_sound = "cinematic_deaths/cd_drama4.ogg"
elseif cd_death == 4 then
cd_sound = "cinematic_deaths/cd_drama5.ogg"
elseif cd_death == 5 then
cd_sound = "cinematic_deaths/cd_drama6.ogg"
elseif cd_death == 6 then
cd_sound = "cinematic_deaths/cd_drama7.ogg"
elseif cd_death == 7 then
cd_sound = "cinematic_deaths/cd_drama8.ogg"
elseif cd_death == 8 then
cd_sound = "cinematic_deaths/cd_drama9.ogg"
elseif cd_death == 9 then
cd_sound = "cinematic_deaths/cd_drama10.ogg"
elseif cd_death == 10 then
cd_sound = "cinematic_deaths/cd_drama11.ogg"
elseif cd_death == 11 then
cd_sound = "cinematic_deaths/cd_drama12.ogg"
elseif cd_death == 12 then
cd_sound = "cinematic_deaths/cd_drama13.ogg"
elseif cd_death == 13 then
cd_sound = "cinematic_deaths/cd_drama14.ogg"
elseif cd_death == 14 then
cd_sound = "cinematic_deaths/cd_drama15.ogg"
elseif cd_death == 15 then
cd_sound = "cinematic_deaths/cd_drama16.ogg"
elseif cd_death == 16 then
cd_sound = "cinematic_deaths/cd_drama17.ogg"
elseif cd_death == 17 then
cd_sound = "cinematic_deaths/cd_drama18.ogg"
elseif cd_death == 18 then
cd_sound = "cinematic_deaths/cd_drama19.ogg"
elseif cd_death == 19 then
cd_sound = "cinematic_deaths/cd_drama20.ogg"
elseif cd_death == 20 then
cd_sound = "cinematic_deaths/cd_drama21.ogg"
elseif cd_death == 21 then
cd_sound = "cinematic_deaths/cd_drama22.ogg"
elseif cd_death == 22 then
cd_sound = "cinematic_deaths/cd_drama23.ogg"
elseif cd_death == 23 then
cd_sound = "cinematic_deaths/cd_drama24.ogg"
elseif cd_death == 24 then
cd_sound = "cinematic_deaths/cd_drama25.ogg"
elseif cd_death == 25 then
cd_sound = "cinematic_deaths/cd_drama26.ogg"
elseif cd_death == 26 then
cd_sound = "cinematic_deaths/cd_drama27.ogg"
elseif cd_death == 27 then
cd_sound = "cinematic_deaths/cd_drama28.ogg"
end

surface.PlaySound(cd_sound)
end)

net.Receive("cinematic_spawn_c2s",function(len,ply)
if cd_deathinprogress == nil then return end
cd_deathinprogress = nil

RunConsoleCommand("stopsound")
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
