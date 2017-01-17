net.Receive("clientsounds_client_c2s",function(len,ply)
local cs_sound = net.ReadString()
local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

if cs_timescaling != 1 then
net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
else
if cs_time != 1.0 then
net.Start("clientsounds_scaled_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.WriteFloat(game.GetTimeScale())
net.Broadcast()
else
net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
end
end
end)

net.Receive("clientsounds_random_c2s",function(len,ply)
if cs_timescaling != 1 then
net.Start("clientsounds_random_s2c")
net.WriteEntity(ply)
net.WriteString(cs_random[math.random(1,cs_max)])
net.Broadcast()
else
if cs_time != 1.0 then
net.Start("clientsounds_randomscaled_s2c")
net.WriteEntity(ply)
net.WriteString(cs_random[math.random(1,cs_max)])
net.WriteFloat(game.GetTimeScale())
net.Broadcast()
else
net.Start("clientsounds_random_s2c")
net.WriteEntity(ply)
net.WriteString(cs_random[math.random(1,cs_max)])
net.Broadcast()
end
end
end)

net.Receive("clientsounds_global_c2s",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

local cs_sound = net.ReadString()
local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

PrintMessage(3,ply:GetName() .. " played " .. cs_sound .. cs_extension)
net.Start("clientsounds_global_s2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
end)

net.Receive("clientsounds_globalstop_c2s",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

PrintMessage(3,ply:GetName() .. " stopped all sounds!")
net.Start("clientsounds_globalstop_s2c")

net.Broadcast()
end)

net.Receive("clientsounds_stream_c2s",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

local cs_url = net.ReadString()
local cs_loop = net.ReadBool()

PrintMessage(3,ply:GetName() .. " opened " .. cs_url)
net.Start("clientsounds_stream_s2c")
net.WriteString(cs_url)
if cs_loop then net.WriteBool(true) else net.WriteBool(false) end

net.Broadcast()
end)

function clientsounds_textsound(ply,text,team)
if string.sub(text,1,1) == "." then
cs_global = false
elseif string.sub(text,1,1) == "," then
cs_global = true
else return end

if cs_global == 1 then
if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end
end

if cs_global == false then

local cs_sound = string.sub(text,2)
if cs_sound == "" then return end

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

if cs_timescaling != 1 then
net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
else
if cs_time != 1.0 then
net.Start("clientsounds_scaled_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.WriteFloat(game.GetTimeScale())
net.Broadcast()
else
net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
end
end

elseif ply:IsAdmin() || ply:IsSuperAdmin() then

local cs_sound = string.sub(text,2)
if cs_sound == "" then return end

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

PrintMessage(3,ply:GetName() .. " played " .. cs_sound .. cs_extension)
net.Start("clientsounds_global_s2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
else
ply:ChatPrint("This function is restricted to admins!")
end
end

function clientsounds_initialize()
cs_random = file.Find("sound/*.ogg","GAME","namedesc")
cs_max = table.getn(cs_random)

for k, v in pairs(cs_random) do
resource.AddSingleFile("sound/" .. v)
end

local cs_cvar_timescaling = file.Read("cs_timescaling.txt","DATA")
if cs_cvar_timescaling != nil then
cs_cvar_timescaling = tonumber(cs_cvar_timescaling)
if cs_cvar_timescaling == nil then cs_timescaling = 0 return end
cs_timescaling = cs_cvar_timescaling
else
cs_timescaling = 0
end
end

function clientsounds_cvar_timescaling(ply,cmd,args)
local cs_cvar_timescaling = args[1]
if cs_cvar_timescaling == nil then
print("cs_timescaling" .. " = " .. cs_timescaling .. " ( def. \"0\" )\n - Enables time scaling for client sounds.")
else
cs_cvar_timescaling = tonumber(cs_cvar_timescaling)
if cs_cvar_timescaling == nil then return end
if cs_cvar_timescaling > 1 then cs_timescaling = 1 elseif cs_cvar_timescaling < 0 then cs_timescaling = 0 else cs_timescaling = cs_cvar_timescaling end

file.Write("cs_timescaling.txt",cs_timescaling)
end
end

util.AddNetworkString("clientsounds_client_c2s")
util.AddNetworkString("clientsounds_random_c2s")
util.AddNetworkString("clientsounds_global_c2s")
util.AddNetworkString("clientsounds_globalstop_c2s")
util.AddNetworkString("clientsounds_stream_c2s")

util.AddNetworkString("clientsounds_client_s2c")
util.AddNetworkString("clientsounds_random_s2c")
util.AddNetworkString("clientsounds_global_s2c")
util.AddNetworkString("clientsounds_globalstop_s2c")
util.AddNetworkString("clientsounds_stream_s2c")

util.AddNetworkString("clientsounds_scaled_s2c")
util.AddNetworkString("clientsounds_randomscaled_s2c")

hook.Add("PlayerSay","Clientsounds Text Sound",clientsounds_textsound)
hook.Add("Initialize","Clientsounds Random",clientsounds_initialize)

concommand.Add("cs_timescaling",clientsounds_cvar_timescaling)
