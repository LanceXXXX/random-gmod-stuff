function clientsound_c2s(ply,cmd,args)
if args[1] == nil then return end
net.Start("clientsound_server")
net.WriteString(args[1])

net.SendToServer()
end

function globalsound_c2s(ply,cmd,args)
if args[1] == nil then return end
net.Start("globalsound_server")
net.WriteString(args[1])

net.SendToServer()
end

function globalstopsound_c2s(ply,cmd,args)
net.Start("globalstopsound_server")

net.SendToServer()
end

function localsound_client(ply,cmd,args)
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

function stopsound_client(ply,cmd,args)
RunConsoleCommand("stopsound")
end

net.Receive("globalsound_s2c",function(len,ply)
local cs_sound = net.ReadString()

RunConsoleCommand("play",cs_sound)
end)

net.Receive("globalstopsound_s2c",function(len,ply)
RunConsoleCommand("stopsound")
end)

concommand.Add("snd",clientsound_c2s)
concommand.Add("gsnd",globalsound_c2s)
concommand.Add("gssnd",globalstopsound_c2s)

concommand.Add("lsnd",localsound_client)
concommand.Add("ssnd",stopsound_client)