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

function cinematic_death()
if cd_enable == 0 then return end

if cd_deathinprogress != nil then return end
cd_deathinprogress = true

game.SetTimeScale(0.25)

net.Start("cinematic_death_c2s")
net.WriteInt(math.random(0,27),8)
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

sound.Add( { 
name = "cinematic_drama",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama.ogg"
} )

sound.Add( { 
name = "cinematic_drama2",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama2.ogg"
} )

sound.Add( { 
name = "cinematic_drama3",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama3.ogg"
} )

sound.Add( { 
name = "cinematic_drama4",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama4.ogg"
} )

sound.Add( { 
name = "cinematic_drama5",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama5.ogg"
} )

sound.Add( { 
name = "cinematic_drama6",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama6.ogg"
} )

sound.Add( { 
name = "cinematic_drama7",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama7.ogg"
} )

sound.Add( { 
name = "cinematic_drama8",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama8.ogg"
} )

sound.Add( { 
name = "cinematic_drama9",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama9.ogg"
} )

sound.Add( { 
name = "cinematic_drama10",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama10.ogg"
} )

sound.Add( { 
name = "cinematic_drama11",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama11.ogg"
} )

sound.Add( { 
name = "cinematic_drama12",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama12.ogg"
} )

sound.Add( { 
name = "cinematic_drama13",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama13.ogg"
} )

sound.Add( { 
name = "cinematic_drama14",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama14.ogg"
} )

sound.Add( { 
name = "cinematic_drama15",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama15.ogg"
} )

sound.Add( { 
name = "cinematic_drama16",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama16.ogg"
} )

sound.Add( { 
name = "cinematic_drama17",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama17.ogg"
} )

sound.Add( { 
name = "cinematic_drama18",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama18.ogg"
} )

sound.Add( { 
name = "cinematic_drama19",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama19.ogg"
} )

sound.Add( { 
name = "cinematic_drama20",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama20.ogg"
} )

sound.Add( { 
name = "cinematic_drama21",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama21.ogg"
} )

sound.Add( { 
name = "cinematic_drama22",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama22.ogg"
} )

sound.Add( { 
name = "cinematic_drama23",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama23.ogg"
} )

sound.Add( { 
name = "cinematic_drama24",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama24.ogg"
} )

sound.Add( { 
name = "cinematic_drama25",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama25.ogg"
} )

sound.Add( { 
name = "cinematic_drama26",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama26.ogg"
} )

sound.Add( { 
name = "cinematic_drama27",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama27.ogg"
} )

sound.Add( { 
name = "cinematic_drama28",
channel = CHAN_REPLACE,
volume = 1.0,
level = 0,
pitch = 100,
sound = "cinematic_deaths/cd_drama28.ogg"
} )