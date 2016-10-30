net.Receive("clientsounds_client_c2s",function(len,ply)
local cs_sound = net.ReadString()

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
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

PrintMessage(3,ply:GetName() .. " opened " .. cs_url)
net.Start("clientsounds_stream_s2c")
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

net.Start("clientsounds_client_s2c")
net.WriteEntity(ply)
net.WriteString(cs_sound .. cs_extension)
net.Broadcast()
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

util.AddNetworkString("clientsounds_client_c2s")
util.AddNetworkString("clientsounds_global_c2s")
util.AddNetworkString("clientsounds_globalstop_c2s")
util.AddNetworkString("clientsounds_stream_c2s")

util.AddNetworkString("clientsounds_client_s2c")
util.AddNetworkString("clientsounds_global_s2c")
util.AddNetworkString("clientsounds_globalstop_s2c")
util.AddNetworkString("clientsounds_stream_s2c")

hook.Add("PlayerSay","Clientsounds Text Sound",clientsounds_textsound)
