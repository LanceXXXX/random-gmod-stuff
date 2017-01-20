AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
self:SetModel("models/props_c17/furnitureStove001a.mdl")

self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)

local phys = self:GetPhysicsObject()

if phys:IsValid() then
phys:Wake()
end

end

function ENT:StartTouch(entity)
if entity:IsPlayer() || entity:IsNPC() || entity:IsRagdoll() then return end

if entity:GetClass() != "ca_food" then
if entity:GetClass() == "ca_stove" then return end

entity.food = ents.Create("ca_food")

if entity:GetModel() != nil then entity.food:SetModel(entity:GetModel()) end
if entity:GetSkin() != nil then entity.food:SetSkin(entity:GetSkin()) end

entity.food:SetPos(entity:GetPos())
if entity:OBBMaxs().x > 17 && entity:OBBMaxs().y > 26 then entity.food:SetAngles(entity:GetAngles()) end

entity:Remove()
entity.food:Spawn()
elseif entity.cookhealth == nil then return
elseif entity.cooking == nil then
entity.cooking = true
entity:Ignite(4294967296)
end
end

function ENT:EndTouch(entity)
if entity:GetClass() != "ca_food" then return end

if entity.cooking != nil then
entity.cooking = nil
entity:Extinguish()
end
end
