function clientsounds_client(ply,cmd,args)
if args[1] == nil then return end
net.Start("clientsounds_client_c2s")
net.WriteString(args[1])

net.SendToServer()
end

function clientsounds_global(ply,cmd,args)
if args[1] == nil then return end
net.Start("clientsounds_global_c2s")
net.WriteString(args[1])

net.SendToServer()
end

function clientsounds_globalstop(ply,cmd,args)
net.Start("clientsounds_globalstop_c2s")

net.SendToServer()
end

function clientsounds_stream(ply,cmd,args)
if args[1] == nil then return end
net.Start("clientsounds_stream_c2s")
net.WriteString(args[1])
if args[2] != nil then
args[2] = tonumber(args[2])
if args[2] != nil then
if args[2] > 0 then net.WriteBool(true) else net.WriteBool(false) end
end
else
net.WriteBool(false)
end
net.SendToServer()
end

function clientsounds_local(ply,cmd,args)
if args[1] == nil then return end
local cs_sound = args[1]

local cs_extension = string.GetExtensionFromFilename("garrysmod/sound/" .. cs_sound)

if cs_extension == nil then
cs_extension = ".ogg"
else
cs_sound = string.sub(cs_sound,1,string.len(cs_sound) - string.len(cs_extension))
end

RunConsoleCommand("play",cs_sound .. cs_extension)
end

function clientsounds_stop(ply,cmd,args)
RunConsoleCommand("stopsound")
end

net.Receive("clientsounds_client_s2c",function(len,ply)
local cs_player = net.ReadEntity()
local cs_sound = net.ReadString()

if cs_player != LocalPlayer() then
cs_player:EmitSound(cs_sound,86,100,1,CHAN_VOICE)
end
cs_player:EmitSound(cs_sound,86,100,1,CHAN_VOICE2)
end)

net.Receive("clientsounds_global_s2c",function(len,ply)
local cs_sound = net.ReadString()

RunConsoleCommand("play",cs_sound)
end)

net.Receive("clientsounds_globalstop_s2c",function(len,ply)
RunConsoleCommand("stopsound")
end)

net.Receive("clientsounds_stream_s2c",function(len,ply)
if cs_blockurl > 0 then return end

local cs_url = net.ReadString()
local cs_loop = net.ReadBool()

if cs_loop then
sound.PlayURL(cs_url,"noplay noblock",function(url)

if IsValid(url) then
if cs_currenturl != nil then cs_currenturl:Stop() end
cs_currenturl = url
url:SetVolume(cs_volume)
url:EnableLooping(true)
url:Play()
elseif IsValid(url) then

if cs_currenturl != nil then cs_currenturl:Stop() end
cs_currenturl = url
url:SetVolume(cs_volume)
url:EnableLooping(true)
url:Play()
else
LocalPlayer():ChatPrint("Invalid URL! Try accessing the stream directly.")
end
end)
else
sound.PlayURL(cs_url,"noplay",function(url)

if IsValid(url) then
if cs_currenturl != nil then cs_currenturl:Stop() end
cs_currenturl = url
url:SetVolume(cs_volume)
url:EnableLooping(false)
url:Play()
elseif IsValid(url) then

if cs_currenturl != nil then cs_currenturl:Stop() end
cs_currenturl = url
url:SetVolume(cs_volume)
url:EnableLooping(false)
url:Play()
else
LocalPlayer():ChatPrint("Invalid URL! Try accessing the stream directly.")
end
end)
end
end)

function clientsounds_cvar_volume(ply,cmd,args)
local cs_cvar_volume = args[1]
if cs_cvar_volume == nil then
print("cs_client_urlvolume" .. " = " .. cs_volume .. " ( def. \"1\" )\n - Controls the playback volume of streams.")
else
cs_cvar_volume = tonumber(cs_cvar_volume)
if cs_cvar_volume == nil then return end
if cs_cvar_volume > 1 then cs_volume = 1 elseif cs_cvar_volume < 0 then cs_volume = 0 else cs_volume = cs_cvar_volume end
if cs_currenturl != nil then cs_currenturl:SetVolume(cs_volume) end

file.Write("cs_volume.txt",cs_volume)
end
end

function clientsounds_cvar_blockurl(ply,cmd,args)
local cs_cvar_blockurl = args[1]
if cs_cvar_blockurl == nil then
print("cs_client_blockurl" .. " = " .. cs_blockurl .. " ( def. \"0\" )\n - Blocks the playback of streams.")
else
cs_cvar_blockurl = tonumber(cs_cvar_blockurl)
if cs_cvar_blockurl == nil then return end
if cs_cvar_blockurl > 1 then cs_blockurl = 1 elseif cs_cvar_blockurl < 0 then cs_blockurl = 0 else cs_blockurl = cs_cvar_blockurl end
if cs_currenturl != nil then if cs_blockurl > 0 then cs_currenturl:Stop() end end

file.Write("cs_blockurl.txt",cs_blockurl)
end
end

function clientsounds_initialize()
local cs_cvar_volume = file.Read("cs_volume.txt","DATA")
if cs_cvar_volume != nil then
cs_cvar_volume = tonumber(cs_cvar_volume)
if cs_cvar_volume == nil then return end
cs_volume = cs_cvar_volume
else
cs_volume = 1
end

local cs_cvar_blockurl = file.Read("cs_blockurl.txt","DATA")
if cs_cvar_blockurl != nil then
cs_cvar_blockurl = tonumber(cs_cvar_blockurl)
if cs_cvar_blockurl == nil then return end
cs_blockurl = cs_cvar_blockurl
else
cs_blockurl = 0
end
end

concommand.Add("snd",clientsounds_client)
concommand.Add("gsnd",clientsounds_global)
concommand.Add("gssnd",clientsounds_globalstop)
concommand.Add("url",clientsounds_stream)

concommand.Add("lsnd",clientsounds_local)
concommand.Add("ssnd",clientsounds_stop)

concommand.Add("cs_client_urlvolume",clientsounds_cvar_volume)
concommand.Add("cs_client_blockurl",clientsounds_cvar_blockurl)

hook.Add("Initialize","Clientsounds Initialize",clientsounds_initialize)
