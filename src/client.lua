local lessLethalWeapon = GetHashKey(config.weapon)
local fallDownTime = config.secondsInGround

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local armed, weaponHash = GetCurrentPedWeapon(ped)
		if armed and weaponHash == lessLethalWeapon then
			idle = 0
			SetWeaponDamageModifierThisFrame(weaponHash, 0.1)
		end
		Citizen.Wait(idle)
	end
end)

AddEventHandler('gameEventTriggered', function (name, args)
	local ped = PlayerPedId()
	if name == "CEventNetworkEntityDamage" and args[1] == ped then
		if args[7] == lessLethalWeapon then
			CancelEvent()
			
			local seconds = fallDownTime
			while seconds > 0 do
				SetPedToRagdollWithFall(ped,1500,1500,0,GetEntityForwardVector(args[2]),10.0,0.0,0.0,0.0,0.0,0.0,0.0)
				seconds = seconds - 1
				Citizen.Wait(1000)
			end
		end
	end
end)