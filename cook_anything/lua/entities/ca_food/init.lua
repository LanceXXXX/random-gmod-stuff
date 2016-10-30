AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
self:PhysicsInit(SOLID_VPHYSICS)
self:SetMoveType(MOVETYPE_VPHYSICS)
self:SetSolid(SOLID_VPHYSICS)

local phys = self:GetPhysicsObject()

if phys:IsValid() then
phys:Wake()
end
self.size = self:OBBMaxs().z * 4
self.cookhealth = self.size
self:SetColor(Color(170,170,170,255))
end

function ENT:Think()
if self.cooking == nil then return end
if self.cookhealth > 0 then
self.cookhealth = self.cookhealth - 1
else
self.cookhealth = nil
self.cooking = nil
self:Extinguish()
self:SetColor(Color(85,85,85,255))
end
end

function ENT:Use(activator,caller)
if !IsValid(caller) || !caller:IsPlayer() then return end
if !caller:KeyPressed(IN_USE) then return end

if self:IsPlayerHolding() then
caller:DropObject()
return
else
if self.cookhealth != nil then
caller:PickupObject(self)
return
end
end

caller:SetHealth(caller:Health() + self.size)
self:Remove()

caller:EmitSound("sounds/ca_eat.ogg")
end
