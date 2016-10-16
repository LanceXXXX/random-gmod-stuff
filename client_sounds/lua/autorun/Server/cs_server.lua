net.Receive("clientsound_server",function(len,ply)
local cs_sound = net.ReadString()

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

ply:EmitSound(cs_sound .. cs_extension,cvars.Number("cs_dropoff",86),100,1,CHAN_REPLACE)
end)

net.Receive("globalsound_server",function(len,ply)

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
net.Start("globalsound_s2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
end)

net.Receive("globalstopsound_server",function(len,ply)

if !ply:IsAdmin() && !ply:IsSuperAdmin() then
ply:ChatPrint("This function is restricted to admins!")
return
end

PrintMessage(3,ply:GetName() .. " stopped all sounds!")
net.Start("globalstopsound_s2c")

net.Broadcast()
end)

function text_sound(ply,text,team)
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

ply:EmitSound(cs_sound .. cs_extension,cvars.Number("cs_dropoff",86),100,1,CHAN_REPLACE)
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
net.Start("globalsound_s2c")
net.WriteString(cs_sound .. cs_extension)

net.Broadcast()
else
ply:ChatPrint("This function is restricted to admins!")
end
end

hook.Add("PlayerSay","Text Sound",text_sound)

util.AddNetworkString("clientsound_server")
util.AddNetworkString("globalsound_server")
util.AddNetworkString("globalstopsound_server")

util.AddNetworkString("globalsound_s2c")
util.AddNetworkString("globalstopsound_s2c")

CreateConVar("cs_dropoff",86,FCVAR_ARCHIVE,"Alters the dropoff of client-played sounds. Valid range is from 0 to 511. Default is 86.")