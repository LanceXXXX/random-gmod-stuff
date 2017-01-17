resource.AddSingleFile("sound/cinematic_deaths/cd_drama.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama2.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama3.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama4.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama5.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama6.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama7.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama8.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama9.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama10.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama11.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama12.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama13.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama14.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama15.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama16.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama17.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama18.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama19.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama20.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama21.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama22.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama23.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama24.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama25.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama26.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama27.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama28.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama29.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama30.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama31.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama32.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama33.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama34.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama35.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama36.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama37.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama38.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama39.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama40.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama41.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama42.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama43.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama44.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama45.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama46.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama47.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama48.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama49.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama50.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama51.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama52.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama53.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama54.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama55.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama56.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama57.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama58.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama59.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama60.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama61.ogg")
resource.AddSingleFile("sound/cinematic_deaths/cd_drama62.ogg")

function cinematic_death()
if cd_enable == 0 then return end

if cd_deathinprogress != nil then return end
cd_deathinprogress = true

game.SetTimeScale(0.25)

net.Start("cinematic_death_c2s")
net.WriteInt(math.random(0,61),8)
net.Broadcast()
end

function cinematic_spawn()
if cd_deathinprogress != nil then
cd_deathinprogress = nil

game.SetTimeScale(1)

net.Start("cinematic_spawn_c2s")
net.Broadcast()
end
end

function cinematic_cvar_enable(ply,cmd,args)
local cd_cvar_enable = args[1]
if cd_cvar_enable == nil then
print("cd_enable" .. " = " .. cd_enable .. " ( def. \"1\" )\n - Enables Cinematic Deaths.")
else
cd_cvar_enable = tonumber(cd_cvar_enable)
if cd_cvar_enable == nil then return end
if cd_cvar_enable > 1 then cd_enable = 1 elseif cd_cvar_enable < 0 then cd_enable = 0 else cd_enable = cd_cvar_enable end

file.Write("cd_enable.txt",cd_enable)
end
end

function cinematic_initialize()
local cd_cvar_enable = file.Read("cd_enable.txt","DATA")
if cd_cvar_enable != nil then
cd_cvar_enable = tonumber(cd_cvar_enable)
if cd_cvar_enable == nil then cd_enable = 1 return end
cd_enable = cd_cvar_enable
else
cd_enable = 1
end
end

util.AddNetworkString("cinematic_death_c2s")
util.AddNetworkString("cinematic_spawn_c2s")

hook.Add("PostPlayerDeath","Cinematic Death",cinematic_death)
hook.Add("PlayerSpawn","Cinematic Spawn",cinematic_spawn)
hook.Add("Initialize","Cinematic Initialize",cinematic_initialize)

concommand.Add("cd_enable",cinematic_cvar_enable)
