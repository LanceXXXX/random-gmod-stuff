function parkcore_main(ply,key)
if key != IN_JUMP then return end

if ply:OnGround() then return end

if ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 1.5708
pc_tracedist = 50
elseif ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 0.785398
pc_tracedist = 75
elseif !ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 0
pc_tracedist = 50
elseif !ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 5.49779
pc_tracedist = 75
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 4.71239
pc_tracedist = 50
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 3.92699
pc_tracedist = 75
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 3.14159
pc_tracedist = 50
elseif ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 2.35619
pc_tracedist = 75
else return
end

local pc_playerpos = ply:GetPos() + Vector(0,0,40)
local pc_playerang = math.rad(ply:EyeAngles().yaw)

local pc_tracex = math.cos(pc_playerang + pc_ang)
local pc_tracey = math.sin(pc_playerang + pc_ang)

local pc_tracefront = pc_playerpos + Vector(-pc_tracex * pc_tracedist,-pc_tracey * pc_tracedist,0)
local pc_traceback = pc_playerpos + Vector(pc_tracex * pc_tracedist,pc_tracey * pc_tracedist,0)

local pc_front = util.TraceLine( { start = pc_playerpos, endpos = pc_tracefront, filter = ply } )
local pc_back = util.TraceLine( { start = pc_playerpos, endpos = pc_traceback, filter = ply } )

if pc_front.Hit && !pc_back.Hit then
local pc_speed = ply:GetVelocity().z

if pc_speed > -750 then
ply:SetLocalVelocity(Vector(pc_tracex * 250,pc_tracey * 250,325))
else
ply:SetLocalVelocity(Vector(pc_tracex * 250,pc_tracey * 250,pc_speed / 2))
end

if SERVER then
ply.pc_kicked = true
else
if IsFirstTimePredicted() then ply:EmitSound(pc_sounds[math.random(1,4)]) end
end
end
end

pc_sounds = { 
"player/footsteps/concrete1.wav", 
"player/footsteps/concrete2.wav", 
"player/footsteps/concrete3.wav", 
"player/footsteps/concrete4.wav" 
}

hook.Add("KeyPress","Parkcore Main",parkcore_main)
