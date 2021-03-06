AddCSLuaFile()

function parkcore_kick(ply,key)
if key != IN_JUMP then return end

if ply:OnGround() then return end
if ply.pc_dontkick != nil then return end

if ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 1.5708
pc_tracedist = 48
elseif ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 0.785398
pc_tracedist = 72
elseif !ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 0
pc_tracedist = 48
elseif !ply:KeyDown(IN_MOVELEFT) && ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 5.49779
pc_tracedist = 72
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && !ply:KeyDown(IN_BACK) then
pc_ang = 4.71239
pc_tracedist = 48
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 3.92699
pc_tracedist = 72
elseif !ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 3.14159
pc_tracedist = 48
elseif ply:KeyDown(IN_MOVELEFT) && !ply:KeyDown(IN_FORWARD) && !ply:KeyDown(IN_MOVERIGHT) && ply:KeyDown(IN_BACK) then
pc_ang = 2.35619
pc_tracedist = 72
else return
end

local pc_playerpos = ply:GetPos() + Vector(0,0,36)
local pc_playerang = math.rad(ply:EyeAngles().yaw)

local pc_angcos = math.cos(pc_playerang + pc_ang)
local pc_angsin = math.sin(pc_playerang + pc_ang)

local pc_front = util.TraceLine( { start = pc_playerpos, endpos = pc_playerpos + Vector(pc_angcos * pc_tracedist,pc_angsin * pc_tracedist,0), filter = ply } )
local pc_back = util.TraceLine( { start = pc_playerpos, endpos = pc_playerpos + Vector(-pc_angcos * pc_tracedist,-pc_angsin * pc_tracedist,0), filter = ply } )

if !pc_front.Hit && pc_back.Hit && !pc_back.HitSky then
local pc_speed = ply:GetVelocity().z

if pc_speed > -750 then
ply:SetLocalVelocity(Vector(pc_angcos * 250,pc_angsin * 250,325))
else
ply:SetLocalVelocity(Vector(pc_angcos * 250,pc_angsin * 250,pc_speed / 2))
end

if SERVER then
ply.pc_kicked = true
else
if IsFirstTimePredicted() then ply:EmitSound(pc_sounds[math.random(1,4)]) end
end
end
end

function parkcore_grab(ply)
if ply.pc_dontgrab != nil then
local pc_time = CurTime()
if ply.pc_delay == nil then ply.pc_delay = pc_time + 2 end
if pc_time < ply.pc_delay then return else ply.pc_dontgrab = nil ply.pc_delay = nil end
end

if ply:OnGround() then return end

if ply.pc_dontkick == nil then
if !ply:KeyDown(IN_USE) then return end

local pc_playerpos = ply:GetPos()
local pc_playerang = math.rad(ply:EyeAngles().yaw)

local pc_angcos = math.cos(pc_playerang)
local pc_angsin = math.sin(pc_playerang)

local pc_top = util.TraceLine( { start = pc_playerpos + Vector(0,0,108), endpos = (pc_playerpos + Vector(0,0,108)) + Vector(pc_angcos * 36,pc_angsin * 36,0), filter = ply } )
local pc_bottom = util.TraceLine( { start = (pc_playerpos + Vector(0,0,24)), endpos = (pc_playerpos + Vector(0,0,24)) + Vector(pc_angcos * 36,pc_angsin * 36,36), filter = ply } )

if !pc_top.Hit && pc_bottom.Hit then
if CLIENT then if IsFirstTimePredicted() then ply:EmitSound(pc_sounds[math.random(1,4)]) end end
ply:SetMoveType(MOVETYPE_NONE)
ply:SetLocalVelocity(Vector(0,0,0))
ply.pc_dontkick = true
end
else
local pc_playerpos = ply:GetPos()
local pc_playerang = math.rad(ply:EyeAngles().yaw)

local pc_angcos = math.cos(pc_playerang)
local pc_angsin = math.sin(pc_playerang)

local pc_top = util.TraceLine( { start = pc_playerpos + Vector(0,0,108), endpos = (pc_playerpos + Vector(0,0,108)) + Vector(pc_angcos * 36,pc_angsin * 36,0), filter = ply } )
local pc_bottom = util.TraceLine( { start = (pc_playerpos + Vector(0,0,24)), endpos = (pc_playerpos + Vector(0,0,24)) + Vector(pc_angcos * 36,pc_angsin * 36,36), filter = ply } )

if pc_top.Hit || !pc_bottom.Hit || !ply:Alive() then
ply.pc_dontkick = nil
ply.pc_dontgrab = true
ply:SetMoveType(MOVETYPE_WALK)
elseif ply:KeyPressed(IN_JUMP) then
ply.pc_dontkick = nil
ply.pc_dontgrab = true
ply:SetMoveType(MOVETYPE_WALK)
ply:SetLocalVelocity(Vector(0,0,325))
end
end
end

pc_sounds = { 
"player/footsteps/concrete1.wav", 
"player/footsteps/concrete2.wav", 
"player/footsteps/concrete3.wav", 
"player/footsteps/concrete4.wav" 
}

hook.Add("KeyPress","Parkcore Wall Kick",parkcore_kick)
hook.Add("PlayerPostThink","Parkcore Ledge Grab",parkcore_grab)
