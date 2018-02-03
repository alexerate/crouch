local players = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	players[player_name] = {
		just_crouched = false,
		nametag = player_name,
		obj = minetest.get_player_by_name(player_name)
	}
end)

minetest.register_on_leaveplayer(function(player)
	player_name = player:get_player_name()
	players[player_name] = nil
end)

minetest.register_globalstep(function(dtime)
	for player_name,player in pairs(players) do
		if player~=nil then
			if player.obj:get_player_control()["sneak"] == true then
				if player.just_crouched then break end
				player.obj:set_eye_offset({x=0,y=-5,z=0},{x=0,y=0,z=0})
				--player.obj:set_properties({nametag=" "}) -- cause refresh of player model and cause animation to restart when flooding the MAJ key
				player.just_crouched = true
			else
				if not player.just_crouched then break end
				player.obj:set_eye_offset({x=0,y=0,z=0},{x=0,y=5,z=0})
				--player.obj:set_properties({nametag=player_name})
				player.just_crouched = false
			end
		end
	end
end)
