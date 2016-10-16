function parkcore_fall(ply,speed)
if ply.pc_kicked == false then return end
ply.pc_kicked = false
if speed < 1000 then
return 0
end
end

function parkcore_spawn(ply)
ply.pc_kicked = false
end

hook.Add("GetFallDamage","Parkcore Fall",parkcore_fall)
hook.Add("PlayerInitialSpawn","Parkcore Spawn",parkcore_spawn)