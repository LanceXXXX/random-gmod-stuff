net.Receive("chatbot_sound_s2c",function(len,ply)
local cb_sound = net.ReadString()

surface.PlaySound(cb_sound)
end)