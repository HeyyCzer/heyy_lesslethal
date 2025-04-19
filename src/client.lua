local lessLethalWeapon = GetHashKey(config.weapon)
local fallDownTime = config.secondsInGround

CreateThread(function()
	SetWeaponDamageModifier(weaponHash, 0.1)
end)

AddEventHandler('gameEventTriggered', function (name, args)
	if name ~= "CEventNetworkEntityDamage" then return end
	
	local ped = PlayerPedId()

	local victim, weapon = args[1], args[7]
	if victim ~= ped or weapon ~= lessLethalWeapon then return end

	CancelEvent()
	
	local ragdoll = true
	while ragdoll do
		SetPedToRagdollWithFall(ped,1500,1500,0,GetEntityForwardVector(args[2]),10.0,0.0,0.0,0.0,0.0,0.0,0.0)
		Wait(0)
	end

	SetTimeout(fallDownTime * 1000, function()
		ragdoll = nil
	end)
end)