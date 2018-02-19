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

-- minetest.register_chatcommand("spawn", {
--         params = "",
--         description = "Teleport to the spawn point",
--         func = function(name, param)
--                 local player = minetest.get_player_by_name(name)
--                 if not player then
--                         return false, "Player not found"
--                 end
--                 if spawn_spawnpos then
--                         player:setpos(spawn_spawnpos)
--                         return true, "Teleporting to spawn..."
--                 else
--                         return false, "The spawn point is not set!"
--                 end
--         end,
-- })

-- minetest.register_chatcommand("origin", {
--         params = "",
--         privs = {teleport = true},
--         description = "Teleport to (0,0,0)",
--         func = function(name, param)
--                 local player = minetest.get_player_by_name(name)
--                 if not player then
--                         return false, "Player not found"
--                 end
--                 player:setpos({x=0, y=0, z=0})
--                 return true, "Teleporting to origin..."
--         end,
-- })


minetest.register_on_newplayer(function(player)
        player:setpos({x=0, y=-1, z=0})
        end
)
