net.Receive("clientsounds_clientc2s",function(len,ply)
local cs_sound = net.ReadString()

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

ply:EmitSound(cs_sound .. cs_extension,cs_dropoff,100,1,CHAN_REPLACE)
end)

net.Receive("clientsounds_globalc2s",function(len,ply)

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
net.Start("clientsounds_globals2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
end)

net.Receive("clientsounds_globalstopc2s",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

PrintMessage(3,ply:GetName() .. " stopped all sounds!")
net.Start("clientsounds_globalstops2c")

net.Broadcast()
end)

net.Receive("clientsounds_streamc2s",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

local cs_url = net.ReadString()

PrintMessage(3,ply:GetName() .. " opened " .. cs_url)
net.Start("clientsounds_streams2c")
net.WriteString(cs_url)

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

ply:EmitSound(cs_sound .. cs_extension,cs_dropoff,100,1,CHAN_REPLACE)
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
net.Start("clientsounds_globals2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
else
ply:ChatPrint("This function is restricted to admins!")
end
end

function clientsounds_cvar_dropoff(ply,cmd,args)
local cs_cvar_dropoff = args[1]
if cs_cvar_dropoff == nil then
print("cs_dropoff" .. " = " .. cs_dropoff .. " ( def. \"86\" )\n - Alters the dropoff of client-played sounds. Valid range is from 0 to 511.")
else
cs_cvar_dropoff = tonumber(cs_cvar_dropoff)
if cs_cvar_dropoff == nil then return end
if cs_cvar_dropoff > 511 then cs_dropoff = 511 elseif cs_cvar_dropoff < 0 then cs_dropoff = 0 else cs_dropoff = cs_cvar_dropoff end

file.Write("cs_dropoff.txt",cs_dropoff)
end
end

function clientsounds_initialize()
local cs_cvar_dropoff = file.Read("cs_dropoff.txt","DATA")
if cs_cvar_dropoff != nil then
cs_cvar_dropoff = tonumber(cs_cvar_dropoff)
if cs_cvar_dropoff == nil then return end
cs_dropoff = cs_cvar_dropoff
else
cs_dropoff = 86
end
end

util.AddNetworkString("clientsounds_clientc2s")
util.AddNetworkString("clientsounds_globalc2s")
util.AddNetworkString("clientsounds_globalstopc2s")
util.AddNetworkString("clientsounds_streamc2s")

util.AddNetworkString("clientsounds_globals2c")
util.AddNetworkString("clientsounds_globalstops2c")
util.AddNetworkString("clientsounds_streams2c")

hook.Add("PlayerSay","Clientsounds Text Sound",clientsounds_textsound)
hook.Add("Initialize","Clientsounds Initialize",clientsounds_initialize)

concommand.Add("cs_dropoff",clientsounds_cvar_dropoff)
