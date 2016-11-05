resource.AddSingleFile("sound/chat_bot/cb_8ball.ogg")
resource.AddSingleFile("sound/chat_bot/cb_coinflip.ogg")
resource.AddSingleFile("sound/chat_bot/cb_coinland.ogg")
resource.AddSingleFile("sound/chat_bot/cb_dice.ogg")
resource.AddSingleFile("sound/chat_bot/cb_lottery.ogg")
resource.AddSingleFile("sound/chat_bot/cb_lotterybell.ogg")
resource.AddSingleFile("sound/chat_bot/cb_44dry.ogg")
resource.AddSingleFile("sound/chat_bot/cb_44fire.ogg")
resource.AddSingleFile("sound/chat_bot/cb_44load.ogg")

function chatbot_text(ply,text,team)
if string.sub(text,1,1) != "!" then return end

local cb_command = ""
local cb_arg = 0
local cb_args = 0

for i = 2, string.len(text) do
if string.sub(text,i,i) == " " then cb_args = i break end
end

if cb_args > 0 then
cb_command = string.sub(text,2,cb_args - 1)
cb_arg = string.sub(text,cb_args + 1)
cb_arg = tonumber(cb_arg)
if cb_arg == nil then return end
else
cb_command = string.sub(text,2)
end

if cb_command == "8ball" then
if cb_cooldown > 0 then
ply:ChatPrint("Please wait " .. cb_cooldown .. " seconds before using chatbot again!")
return ""
else
cb_cooldown = 10
timer.Create("Chatbot Cooldown",1,0,chatbot_cooldown)
end

net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_8ball.ogg")
net.Broadcast()

PrintMessage(3,"Chatbot: " .. ply:GetName() .. " shakes the magic 8-ball...")
timer.Simple(math.random(4,5),function() PrintMessage(3,cb_8balltext[math.random(1,17)]) end)
return ""
elseif cb_command == "flipcoin" then
if cb_cooldown > 0 then
ply:ChatPrint("Please wait " .. cb_cooldown .. " seconds before using chatbot again!")
return ""
else
cb_cooldown = 10
timer.Create("Chatbot Cooldown",1,0,chatbot_cooldown)
end

net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_coinflip.ogg")
net.Broadcast()

PrintMessage(3,"Chatbot: " .. ply:GetName() .. " flips the coin...")
timer.Simple(math.random(1,2),function()
net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_coinland.ogg")
net.Broadcast()

timer.Simple(math.random(4,5),function()
if math.random(0,1) > 0 then
PrintMessage(3,"Chatbot: ... And it's heads!")
else
PrintMessage(3,"Chatbot: ... And it's tails!")
end
end)
end)
return ""
elseif cb_command == "rolldice" then
if cb_cooldown > 0 then
ply:ChatPrint("Please wait " .. cb_cooldown .. " seconds before using chatbot again!")
return ""
else
cb_cooldown = 10
timer.Create("Chatbot Cooldown",1,0,chatbot_cooldown)
end

net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_dice.ogg")
net.Broadcast()

PrintMessage(3,"Chatbot: " .. ply:GetName() .. " rolls the dice...")
timer.Simple(math.random(4,5),function()
if ply:GetName() == nil then return end

if cb_arg <= 0 then cb_arg = 6 end
PrintMessage(3,"Chatbot: " .. ply:GetName() .. " rolls a " .. math.random(1,cb_arg) .. " out of " .. cb_arg)
end)
return ""
elseif cb_command == "lottery" then
if cb_cooldown > 0 then
ply:ChatPrint("Please wait " .. cb_cooldown .. " seconds before using chatbot again!")
return ""
else
cb_cooldown = 10
timer.Create("Chatbot Cooldown",1,0,chatbot_cooldown)
end

net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_lottery.ogg")
net.Broadcast()

PrintMessage(3,"Chatbot: " .. ply:GetName() .. " starts the lottery...")
timer.Simple(math.random(3,4),function()
if ply:GetName() == nil then return end

net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_lotterybell.ogg")
net.Broadcast()

local cb_players = player.GetAll()
PrintMessage(3,"Chatbot: " .. Entity(cb_players[math.random(1,#cb_players)]:EntIndex()):GetName() .. " has won the lottery!")
end)
return ""
elseif cb_command == "roulette" then
if !ply:Alive() then ply:ChatPrint("lol! You can't play Russian Roulette. You're already DEAD!") return "" end

local cb_chance = 0

if cb_cooldown > 0 then
ply:ChatPrint("Please wait " .. cb_cooldown .. " seconds before using chatbot again!")
return ""
else
cb_chance = math.random(1,cb_shots)

if cb_chance > 1 || !cb_roulette then
cb_cooldown = 5
else
cb_cooldown = 10
end
timer.Create("Chatbot Cooldown",1,0,chatbot_cooldown)
end

if cb_roulette then
if cb_chance > 1 then
cb_shots = cb_shots - 1
net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_44dry.ogg")
net.Broadcast()

if cb_shots > 1 then
PrintMessage(3,ply:GetName() .. " dryfires the gun! " .. cb_shots .. " shots left!")
else
PrintMessage(3,ply:GetName() .. " dryfires the gun! " .. cb_shots .. " shot left!")
end
return ""
else
net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_44fire.ogg")
net.Broadcast()

ply:Kill()

PrintMessage(3,ply:GetName() .. " discharges the weapon! Game over for you " .. ply:GetName() .. "!")

cb_roulette = false
cb_shots = 0
return ""
end
else
cb_roulette = true
cb_shots = 6
net.Start("chatbot_sound_s2c")
net.WriteString("chat_bot/cb_44load.ogg")
net.Broadcast()

PrintMessage(3,ply:GetName() .. " gets out a .44 and loads it with a single bullet...")
return ""
end
end
end

function chatbot_cooldown()
cb_cooldown = cb_cooldown - 1
if cb_cooldown <= 0 then timer.Remove("Chatbot Cooldown") end
end

cb_8balltext = { 
"Chatbot: Yes", 
"Chatbot: Definitely", 
"Chatbot: For sure!", 
"Chatbot: Without a doubt", 
"Chatbot: Certainly!", 
"Chatbot: Totally!", 
"Chatbot: No", 
"Chatbot: Nope", 
"Chatbot: No way!", 
"Chatbot: Definitely not", 
"Chatbot: Not in a million years!", 
"Chatbot: Certainly not!", 
"Chatbot: Maybe", 
"Chatbot: Probably", 
"Chatbot: Not very likely...", 
"Chatbot: Chances are slim", 
"Chatbot: That's a question you should ask yourself" 
}

cb_cooldown = 0
cb_roulette = false
cb_shots = 0

util.AddNetworkString("chatbot_sound_s2c")

hook.Add("PlayerSay","Chatbot Text",chatbot_text)