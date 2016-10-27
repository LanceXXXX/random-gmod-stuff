function ragdolize_c2s(ply,cmd,args)
net.Start("ragdolize_toggle")
net.SendToServer()
end

concommand.Add("ragdolize",ragdolize_c2s)