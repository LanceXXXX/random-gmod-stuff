function parkcore_fall(ply,speed)
if ply.pc_kicked == nil then return end
ply.pc_kicked = nil
if speed < 1000 then
return 0
end
end

hook.Add("GetFallDamage","Parkcore Fall",parkcore_fall)
