local spawn_spawnpos = minetest.setting_get_pos("static_spawnpoint")
local execution_pos = {x=-310,y=0,z=-40}

places = {}

places.register_place = function (name, pos, command)
   if not command then
      command = name
   end
   minetest.register_chatcommand(command, {
        params = "",
        description = "Teleport to "..name,
        func = function(nm, param)
                local player = minetest.get_player_by_name(nm)
                if not player then
                        return false, "Player not found"
                end
		if xban and xban.get_property(nm, "jailed") then
		   player:setpos(execution_pos)
		   return true, "Nice try! You can't escape!"
		end
		player:setpos(pos)
		return true, "Teleporting to "..name.."..."
        end,
   })
end


if spawn_spawnpos then
   places.register_place("Spawn", spawn_spawnpos, "spawn")
end
places.register_place("Origin", {x=0, y=0, z=0}, "origin")
places.register_place("South Forest", {x=285, y=9, z=-2047}, "sf")
places.register_place("Personhood", {x=1534, y=28, z=2972}, "ph")
places.register_place("Personhood West", {x=1133, y=14, z=3046}, "phw")
places.register_place("Trisiston", {x=-4262, y=21, z=-3123}, "tst")
places.register_place("Elders Valley", {x=-3815, y=10, z=-3150}, "ev")

local spawn_at_spawn = minetest.settings:get("places_spawn_spawn")
minetest.log("[places] spawn_at_spawn = " .. tostring(spawn_at_spawn))
if not (spawn_at_spawn == "true") then
	minetest.register_on_newplayer(function(player)
		player:setpos({x=0, y=-1, z=0})
	end)
end
