net.Receive("ragdolize_toggle",function(len,ply)
if !ply:Alive() then return end
if ply.rd_ragdolized == nil then

ply.invul = ply:HasGodMode()
if !ply.invul then ply:AddFlags(FL_GODMODE) end

ply.rd_ragdoll = ents.Create("prop_ragdoll")
ply.rd_ragdoll:SetModel(ply:GetModel())
ply.rd_ragdoll:SetSkin(ply:GetSkin())

for k, v in pairs(ply:GetBodyGroups()) do
ply.rd_ragdoll:SetBodygroup(k,ply:GetBodygroup(k))
end

ply.rd_ragdoll:SetPos(ply:GetPos())

ply:SetMoveType(MOVETYPE_NONE)
ply:AddFlags(FL_FROZEN)
ply:SetNotSolid(true)
ply:SetNoDraw(true)
ply:DrawWorldModel(false)
ply:DrawViewModel(false)

ply.rd_ragdoll:SetOwner(ply)
ply.rd_ragdoll:SetNWBool("IsRagdolized",true)

local rd_vel = ply:GetVelocity()

ply.rd_ragdoll:Spawn()

for i = 0, ply.rd_ragdoll:GetPhysicsObjectCount() - 1 do
local rd_bone = ply.rd_ragdoll:GetPhysicsObjectNum(i)
if IsValid(rd_bone) then
local rd_pos, rd_ang = ply:GetBonePosition(ply.rd_ragdoll:TranslatePhysBoneToBone(i))
rd_bone:SetPos(rd_pos)
rd_bone:SetAngles(rd_ang)
rd_bone:SetVelocity(rd_vel)
end
end

ply:SetParent(ply.rd_ragdoll)

ply:SetObserverMode(OBS_MODE_CHASE)
ply:SpectateEntity(ply.rd_ragdoll)

ply.rd_ragdolized = true
else
local rd_velz = ply.rd_ragdoll:GetVelocity().z
if rd_velz < -10 || rd_velz > 10 then return end

ply:SetParent(nil)
ply.rd_ragdoll:SetNWBool("IsRagdolized",false)

ply:SetLocalVelocity(Vector(0,0,0))
ply:SetPos(ply.rd_ragdoll:GetPos())
ply:SetEyeAngles(Angle(0,ply:EyeAngles().yaw,0))
ply:SetNotSolid(false)
ply:SetNoDraw(false)
ply:SetObserverMode(0)
ply:DrawWorldModel(true)
ply:DrawViewModel(true)
ply.rd_ragdoll:Remove()
ply.rd_ragdoll = nil

ply:SetMoveType(MOVETYPE_WALK)
ply:RemoveFlags(FL_FROZEN)

if !ply.invul then ply:RemoveFlags(FL_GODMODE) end

ply.rd_ragdolized = nil
end
end)

function ragdolize_remove(ragdoll)
if !ragdoll:GetNWBool("IsRagdolized",false) then return end
local ply = ragdoll:GetOwner()

ply:SetParent(nil)
ragdoll:SetNWBool("IsRagdolized",false)

ply:SetLocalVelocity(Vector(0,0,0))
ply:SetPos(ragdoll:GetPos())
ply:SetEyeAngles(Angle(0,ply:EyeAngles().yaw,0))
ply:SetNotSolid(false)
ply:SetNoDraw(false)
ply:SetObserverMode(0)
ply:DrawWorldModel(true)
ply:DrawViewModel(true)

ply:SetMoveType(MOVETYPE_WALK)
ply:RemoveFlags(FL_FROZEN)

if !ply.invul then ply:RemoveFlags(FL_GODMODE) end

ply.rd_ragdoll = nil
ply.rd_ragdolized = nil
end

function ragdolize_death(ply)
if ply.rd_ragdoll == nil then return end

ply:SetParent(nil)
ply.rd_ragdoll:SetNWBool("IsRagdolized",false)

if ply:GetRagdollEntity() != nil then
ply.rd_deathrag = ply:GetRagdollEntity()

local rd_vel = ply:GetVelocity()

for i = 0, ply.rd_deathrag:GetPhysicsObjectCount() - 1 do
local rd_bone = ply.rd_deathrag:GetPhysicsObjectNum(i)
if IsValid(rd_bone) then
local rd_pos, rd_ang = ply.ragdoll:GetBonePosition(ply.rd_deathrag:TranslatePhysBoneToBone(i))
rd_bone:SetPos(rd_pos)
rd_bone:SetAngles(rd_ang)
rd_bone:SetVelocity(rd_vel)
end
end
end

ply:SetNotSolid(false)
ply:SetNoDraw(false)
ply:SetObserverMode(0)
ply:DrawWorldModel(true)
ply:DrawViewModel(true)

ply:SetMoveType(MOVETYPE_WALK)
ply:RemoveFlags(FL_FROZEN)

if !ply.invul then ply:RemoveFlags(FL_GODMODE) end

ply.rd_ragdoll:Remove()
ply.rd_ragdoll = nil
ply.rd_ragdolized = nil
end

util.AddNetworkString("ragdolize_toggle")

hook.Add("EntityRemoved","Ragdolize Remove",ragdolize_remove)
hook.Add("PlayerDeath","Ragdolize Death",ragdolize_death)
