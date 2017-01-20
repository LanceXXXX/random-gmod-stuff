net.Receive("cinematic_death_s2c",function(len,ply)
if cs_spawned == nil then return end
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
elseif cd_death == 28 then
cd_sound = "cinematic_deaths/cd_drama29.ogg"
elseif cd_death == 29 then
cd_sound = "cinematic_deaths/cd_drama30.ogg"
elseif cd_death == 30 then
cd_sound = "cinematic_deaths/cd_drama31.ogg"
elseif cd_death == 31 then
cd_sound = "cinematic_deaths/cd_drama32.ogg"
elseif cd_death == 32 then
cd_sound = "cinematic_deaths/cd_drama33.ogg"
elseif cd_death == 33 then
cd_sound = "cinematic_deaths/cd_drama34.ogg"
elseif cd_death == 34 then
cd_sound = "cinematic_deaths/cd_drama35.ogg"
elseif cd_death == 35 then
cd_sound = "cinematic_deaths/cd_drama36.ogg"
elseif cd_death == 36 then
cd_sound = "cinematic_deaths/cd_drama37.ogg"
elseif cd_death == 37 then
cd_sound = "cinematic_deaths/cd_drama38.ogg"
elseif cd_death == 38 then
cd_sound = "cinematic_deaths/cd_drama39.ogg"
elseif cd_death == 39 then
cd_sound = "cinematic_deaths/cd_drama40.ogg"
elseif cd_death == 40 then
cd_sound = "cinematic_deaths/cd_drama41.ogg"
elseif cd_death == 41 then
cd_sound = "cinematic_deaths/cd_drama42.ogg"
elseif cd_death == 42 then
cd_sound = "cinematic_deaths/cd_drama43.ogg"
elseif cd_death == 43 then
cd_sound = "cinematic_deaths/cd_drama44.ogg"
elseif cd_death == 44 then
cd_sound = "cinematic_deaths/cd_drama45.ogg"
elseif cd_death == 45 then
cd_sound = "cinematic_deaths/cd_drama46.ogg"
elseif cd_death == 46 then
cd_sound = "cinematic_deaths/cd_drama47.ogg"
elseif cd_death == 47 then
cd_sound = "cinematic_deaths/cd_drama48.ogg"
elseif cd_death == 48 then
cd_sound = "cinematic_deaths/cd_drama49.ogg"
elseif cd_death == 49 then
cd_sound = "cinematic_deaths/cd_drama50.ogg"
elseif cd_death == 50 then
cd_sound = "cinematic_deaths/cd_drama51.ogg"
elseif cd_death == 51 then
cd_sound = "cinematic_deaths/cd_drama52.ogg"
elseif cd_death == 52 then
cd_sound = "cinematic_deaths/cd_drama53.ogg"
elseif cd_death == 53 then
cd_sound = "cinematic_deaths/cd_drama54.ogg"
elseif cd_death == 54 then
cd_sound = "cinematic_deaths/cd_drama55.ogg"
elseif cd_death == 55 then
cd_sound = "cinematic_deaths/cd_drama56.ogg"
elseif cd_death == 56 then
cd_sound = "cinematic_deaths/cd_drama57.ogg"
elseif cd_death == 57 then
cd_sound = "cinematic_deaths/cd_drama58.ogg"
elseif cd_death == 58 then
cd_sound = "cinematic_deaths/cd_drama59.ogg"
elseif cd_death == 59 then
cd_sound = "cinematic_deaths/cd_drama60.ogg"
elseif cd_death == 60 then
cd_sound = "cinematic_deaths/cd_drama61.ogg"
elseif cd_death == 61 then
cd_sound = "cinematic_deaths/cd_drama62.ogg"
elseif cd_death == 62 then
cd_sound = "cinematic_deaths/cd_drama63.ogg"
elseif cd_death == 63 then
cd_sound = "cinematic_deaths/cd_drama64.ogg"
elseif cd_death == 64 then
cd_sound = "cinematic_deaths/cd_drama65.ogg"
elseif cd_death == 65 then
cd_sound = "cinematic_deaths/cd_drama65.ogg"
elseif cd_death == 66 then
cd_sound = "cinematic_deaths/cd_drama66.ogg"
elseif cd_death == 67 then
cd_sound = "cinematic_deaths/cd_drama67.ogg"
elseif cd_death == 68 then
cd_sound = "cinematic_deaths/cd_drama68.ogg"
elseif cd_death == 69 then
cd_sound = "cinematic_deaths/cd_drama69.ogg"
elseif cd_death == 70 then
cd_sound = "cinematic_deaths/cd_drama70.ogg"
elseif cd_death == 71 then
cd_sound = "cinematic_deaths/cd_drama71.ogg"
elseif cd_death == 72 then
cd_sound = "cinematic_deaths/cd_drama72.ogg"
elseif cd_death == 73 then
cd_sound = "cinematic_deaths/cd_drama73.ogg"
elseif cd_death == 74 then
cd_sound = "cinematic_deaths/cd_drama74.ogg"
elseif cd_death == 75 then
cd_sound = "cinematic_deaths/cd_drama75.ogg"
end

surface.PlaySound(cd_sound)
end)

net.Receive("cinematic_spawn_s2c",function(len,ply)
if cs_spawned == nil then return end
if cd_deathinprogress == nil then return end
cd_deathinprogress = nil

RunConsoleCommand("stopsound")
end)

function cinematic_grayscale()
if cd_deathinprogress == nil then return end
DrawColorModify(cd_grayscale_color)
end

function cinematic_spawn()
cd_spawned = true

net.Start("cinematic_spawn_c2s")
net.SendToServer()
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
hook.Add("InitPostEntity","Cinematic Spawn",cinematic_spawn)
