util.keep_running()
util.require_natives(1651208000)

---------------AUTO ACTUALIZACION

local response = false
local localVer = 0.56
local localKs = false



util.toast("Espere unos segundos...")

async_http.init("raw.githubusercontent.com", "/alannpla/GlitchServices/main/version.lua", function(output)
    currentVer = tonumber(output)
    response = true
    if localVer ~= currentVer then
        util.toast("Hay una actualizacion disponible, reinicia para actualizarlo.")
        menu.action(menu.my_root(), "Actualizar Lua", {}, "", function()
            async_http.init('raw.githubusercontent.com','/alannpla/GlitchServices/main/GlitchServices.lua',function(a)
                local err = select(2,load(a))
                if err then
                    util.toast("Hubo un fallo porfavor procede a la actualizacion manual con github.")
                    
                return end
                local f = io.open(filesystem.scripts_dir()..SCRIPT_RELPATH, "wb")
                f:write(a)
                f:close()
                util.toast("Script actualizado. \nVersion actual " .. localVer .. ". \nBienvenido " .. players.get_name(players.user()))
                util.restart_script()
            end)
            async_http.dispatch()
        end)
    end
end, function() response = true end)
async_http.dispatch()
repeat 
    util.yield()
until response

menu.divider(menu.my_root(), "Version: " .. localVer, {}, end)
---------------LOCALIZACIONES

function teleportToAirport()
  local x = -1335
  local y = -3044
  util.teleport_2d(x, y)
  util.toast("Fuiste teletansportado al aeropuerto.")
end
function teleportToSantosCustoms()
  local x = -376
  local y = -128
  util.teleport_2d(x, y)
  util.toast("Fuiste teletansportado a Los Santos Customs.")
end
function teleportToRandomLocation()
  local randomX = math.random(-2000, 2000)
  local randomY = math.random(-2000, 2000)
  util.teleport_2d(randomX, randomY)
  util.toast("Fuiste teletansportado a un lugar aleatorio.")
end
function teleportToBinco()
  local x = -813
  local y = -1085
  util.teleport_2d(x, y)
  util.toast("Fuiste teletansportado a Binco.")
end

local teleportMenu = menu.list(menu.my_root(), "Localizaciones", {""}, "")

menu.action(teleportMenu, "Lugar aleatorio", {"tpr"}, "Teletransportarse a un lugar aleatorio.", teleportToRandomLocation)
menu.action(teleportMenu, "Aeropuerto", {}, "", teleportToAirport)
menu.action(teleportMenu, "Los Santos Customs", {""}, "", teleportToSantosCustoms)
menu.action(teleportMenu, "Binco", {"tpbinco"}, "", teleportToBinco)

--[[

]]---

-------------ONLINE PLAYERS

local playersReference
menu.action(menu.my_root(), "Online Players", {}, "", function()
	playersReference = playersReference or menu.ref_by_path("Players")
	menu.trigger_command(playersReference, "")
end)

---------------------- CHAT

local myFolder = menu.list(menu.my_root(), "Chat", {}, "Usar consola de comandos para enviar mensajes. Te permite usar ´CTRL + V´")

-- Crear el botón dentro de la carpeta
menu.action(myFolder, "Enviar mensaje en el chat", {}, "Enviar mensaje", function(click_type)
    menu.show_command_box_click_based(click_type, "say ")
end, function(message)
  	chat.send_message(message, false, true, true)
end, "say [message]")

menu.action(myFolder, "Enviar mensaje en el chat de equipo", {}, "Enviar mensajeen el chat de equipo", function(click_type)
  menu.show_command_box_click_based(click_type, "sayteam ")
end, function(message)
  chat.send_message(message, false, true, true)
end, "sayteam [message]")


---spammer
local myFolder = menu.list(myFolder, "Spammer", {}, "Podras espamear mensajes en el chat. (no recomandable)")

local mode = 1
    local message = "No molestes con god mode!"
    local delay = 10
    local max = 100
    menu.text_input(myFolder, "Mensaje", {"spammessage"}, "Podes modificar el texto, ejemplo: GlitchServices Script", function(txt)

      message = txt

  end, message)

    menu.slider(myFolder, "Velocidad de Spam", {},  "Tiempo de spam", 0, max, delay, 2, function (v)

      delay = v

  end)

  local options = {

		"Normal spam",

		"Todos spamean"

	}

    menu.slider_text(myFolder, "Modo", {}, "", options, function(op)

        mode = op

        util.toast(op)

    end)

  menu.toggle_loop(myFolder, "Activar Chat Spammer", {}, "Te permite spamear en el chat [On/Off]", function()

    local delay = (max - delay) * 10



    if mode == 1 then

        -- chat.send_message has some sort of rate limit for some reason

        for k,v in pairs(players.list(true, true, true)) do

            chat.send_targeted_message(v, players.user(), message, false)

        end

        util.yield(delay)

    elseif mode == 2 then

        for k1,v1 in pairs(players.list(true, true, true)) do

            for k2,v2 in pairs(players.list(true, true, true)) do

                chat.send_targeted_message(v2, v1, message, false)

            end

            

            util.yield(delay)

        end

    end

end)

----------------------HERRAMIENTAS

local herramientas = menu.list(menu.my_root(), "Herramientas", {}, "")

--Error transaccion

function GET_INT_LOCAL(script, script_local)
  if memory.script_local(script, script_local) ~= 0 then
      local ReadLocal = memory.read_int(memory.script_local(script, script_local))
      if ReadLocal ~= nil then
          return ReadLocal
      end
  end
end
function GET_INT_GLOBAL(global)
  return memory.read_int(memory.script_global(global))
end
function SET_INT_GLOBAL(global, value)
  memory.write_int(memory.script_global(global), value)
end
function IS_WORKING(is_add_new_line)
  local State = "" -- If global and local variables have been changed due to the GTAO update then
  if util.is_session_started() then -- Because unable to get local variable in story mode
      if GET_INT_LOCAL("", 3618) ~= util.joaat("") then 
          State = ("")
          if is_add_new_line then
              State = State .. "\n\n"
          end
      end
  end
  return State
end

menu.toggle_loop(herramientas, "Deshabilitar Error de transaccion", {}, "Esto se puede usar para eliminar errores de transacción.", function()
            if IS_WORKING(false) ~= "" then return end
            if not util.is_session_started() then return end

            if GET_INT_GLOBAL(4536679) == 4 or 20 then
                SET_INT_GLOBAL(4536673, 0) -- https://github.com/jonaaa20/RecoverySuite
            end
        end)

------------------MISC
local varios = menu.list(menu.my_root(), "Varios", {}, "")

--SCREENSHOT
menu.toggle(varios, "Modo Screenshot", {"screeshot"}, "Oculta hub.", function(on)
	if on then
		menu.trigger_commands("screenshot on")
	else
		menu.trigger_commands("screenshot off")
	end
end)

--RANDOM OUTFIT
menu.action(varios, "Random outfit", {"randomoutfit"}, "Aplica un outfit random.", function()
  menu.trigger_commands("randomoutfit")
  util.toast("Random outfit aplicado.")
end)

--RULETA RUSA
local randomizer = function(x)
  local r = math.random(1,6)
  return x[r]
end

array = {"1","2","3","4","5","6"}

menu.action(varios, "Jalar el gatillo", {}, "Juega la ruleta rusa con tu vida.", function()
  if randomizer(array) == "1" then
      util.toast("Sobreviviste :D")
  else
      util.log("Te suicidaste D:")
      menu.trigger_commands("ewo")
  end
end)

--SOCIAL MEDIA

local redesSociales = menu.list(menu.my_root(), "Redes Sociales", {}, "")
menu.hyperlink(redesSociales, "Mi Github", "https://github.com/alannpla", "")
menu.hyperlink(redesSociales, "Discord Server", "https://discord.gg/glitchservices", "")



----------------------DIVIDER

menu.divider(menu.my_root(), "Test", {}, end)

local recovery = menu.list(menu.my_root(), "Recovery", {}, "ALERTA! Todas las opciones de esta carpeta se consideran riesgosas. No nos hacemos responsables. Estas advertido.")






-------------
--[[
menu.action(menu.my_root(), "outfit", {""}, "Aplica un outfit", function()


  menu.trigger_commands("Head 0")
  menu.trigger_commands("Headvar 255")
  menu.trigger_commands("Mask 144")
  menu.trigger_commands("Maskvar 0")
  menu.trigger_commands("Hair 45")
  menu.trigger_commands("Hairvar 1")
  menu.trigger_commands("Top 282")
  menu.trigger_commands("Topvar 0")
  menu.trigger_commands("Gloves 110")
  menu.trigger_commands("Glovesvar 8")
  menu.trigger_commands("Top2 22")
  menu.trigger_commands("Top2var 0")
  menu.trigger_commands("Top3 54")
  menu.trigger_commands("Top3var 0")
  menu.trigger_commands("Parachute 82")
  menu.trigger_commands("Parachutevar 8")
  menu.trigger_commands("Pants 107")
  menu.trigger_commands("Pantsvar 3")
  menu.trigger_commands("Shoes 6")
  menu.trigger_commands("feetvar 1")
  menu.trigger_commands("Accessories 0")
  menu.trigger_commands("Accessoriesvar 0")
  menu.trigger_commands("Decals 0")
  menu.trigger_commands("Decalsvar 0")
  menu.trigger_commands("Hat -1")
  menu.trigger_commands("Hatvar -1")
  menu.trigger_commands("Glasses -1")
  menu.trigger_commands("Glassesvar -1")
  menu.trigger_commands("Ears -1")
  menu.trigger_commands("Earsvar -1")
  menu.trigger_commands("Watch -1")
  menu.trigger_commands("Watchvar -1")
  menu.trigger_commands("Bracelet -1")
  menu.trigger_commands("Braceletvar -1")


  util.toast("Outfit aplicado.")
end)
-------------------
--[[
local routif2 = function(x)
  local r = math.random(1,6)
  return x[r]
end

array = {"1","2","3","4","5","6"}

menu.action(menu.my_root(), "routfit2", {}, "Juega la ruleta rusa con tu vida.", function()
  if routif2(array) == "1" then
    menu.trigger_commands("Head 0")
    menu.trigger_commands("Headvar 255")
    menu.trigger_commands("Mask 144")
    menu.trigger_commands("Maskvar 0")
    menu.trigger_commands("Hair 45")
    menu.trigger_commands("Hairvar 1")
    menu.trigger_commands("Top 282")
    menu.trigger_commands("Topvar 0")
    menu.trigger_commands("Gloves 110")
    menu.trigger_commands("Glovesvar 8")
    menu.trigger_commands("Top2 22")
    menu.trigger_commands("Top2var 0")
    menu.trigger_commands("Top3 54")
    menu.trigger_commands("Top3var 0")
    menu.trigger_commands("Parachute 82")
    menu.trigger_commands("Parachutevar 8")
    menu.trigger_commands("Pants 107")
    menu.trigger_commands("Pantsvar 3")
    menu.trigger_commands("Shoes 6")
    menu.trigger_commands("feetvar 1")
    menu.trigger_commands("Accessories 0")
    menu.trigger_commands("Accessoriesvar 0")
    menu.trigger_commands("Decals 0")
    menu.trigger_commands("Decalsvar 0")
    menu.trigger_commands("Hat -1")
    menu.trigger_commands("Hatvar -1")
    menu.trigger_commands("Glasses -1")
    menu.trigger_commands("Glassesvar -1")
    menu.trigger_commands("Ears -1")
    menu.trigger_commands("Earsvar -1")
    menu.trigger_commands("Watch -1")
    menu.trigger_commands("Watchvar -1")
    menu.trigger_commands("Bracelet -1")
    menu.trigger_commands("Braceletvar -1")

  elseif routif2(array) == "2" then
    menu.trigger_commands("Head 0")
    menu.trigger_commands("Headvar 0")
    menu.trigger_commands("Mask 173")
    menu.trigger_commands("Maskvar 0")
    menu.trigger_commands("Hair 50")
    menu.trigger_commands("Hairvar 29")
    menu.trigger_commands("Top 53")
    menu.trigger_commands("Topvar 1")
    menu.trigger_commands("Gloves 77")
    menu.trigger_commands("Glovesvar 0")
    menu.trigger_commands("Top2 15")
    menu.trigger_commands("Top2var 0")
    menu.trigger_commands("Top3 1")
    menu.trigger_commands("Top3var 0")
    menu.trigger_commands("Parachute 0")
    menu.trigger_commands("Parachutevar 0")
    menu.trigger_commands("Pants 59")
    menu.trigger_commands("Pantsvar 6")
    menu.trigger_commands("Shoes 8")
    menu.trigger_commands("feetvar 0")
    menu.trigger_commands("Accessories 0")
    menu.trigger_commands("Accessoriesvar 0")
    menu.trigger_commands("Decals 0")
    menu.trigger_commands("Decalsvar 0")
    menu.trigger_commands("Hat 59")
    menu.trigger_commands("Hatvar 6")
    menu.trigger_commands("Glasses -1")
    menu.trigger_commands("Glassesvar -1")
    menu.trigger_commands("Ears -1")
    menu.trigger_commands("Earsvar -1")
    menu.trigger_commands("Watch -1")
    menu.trigger_commands("Watchvar -1")
    menu.trigger_commands("Bracelet -1")
    menu.trigger_commands("Braceletvar -1")
  end
end)

----------TEST
-----------TEST
-----------TEST
-----------TEST
-----------TEST
--[[

-813.92426, -1085.2758, 10.983818




---carpeta----

local myList = menu.list(menu.my_root(), "My List!", {}, "")

menu.action(myList, "Button inside list!", {}, "boton test", function()
  util.toast("Hi!") --the util.toast() function makes a notification of a string that you pass it.

end)

local myList = menu.list(menu.my_root(), "Mi Lista!", {}, "")

menu.action(myList, "boton", {}, "boton test", function()
  util.toast("Hi!") --the util.toast() function makes a notification of a string that you pass it.

end)





----- boton tp

menu.action(menu.my_root(), "tp ", {}, "tp to: 0, 100, 100", function()
  local ourPlayer = PLAYER.GET_PLAYER_PED(players.user())


  ENTITY.SET_ENTITY_COORDS(ourPlayer, -1282, -2185, 13, false, false, false, false)

  util.toast("fuiste tepeado :)")
end)

----boton activable

menu.toggle(menu.my_root(), "activable", {}, "activar o desactivar", function(on)
  util.toast("activado")
end)

local activable = false

function toggleGodMode()
    local player = util.get_player()
    if activable then
        util.set_entity_god_mode(player, false)
        util.toast("desactivado")
        activable = false
    else
        util.set_entity_god_mode(player, true)
        util.toast("activado")
        activable = true
    end
end

menu.toggle(menu.my_root(), "activable", {"activado", "Desactivado"}, "activar o desactivar", function(on)
    if on then
        toggleGodMode()
    else
        toggleGodMode()
    end
end)

--------------------

-- Función para establecer el nivel de búsqueda
function set_wanted_level(level)
  -- Obtener el jugador
  local player = PLAYER.PLAYER_PED_ID()

  -- Establecer el nivel de búsqueda
  if level > 0 then
      PLAYER.SET_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID(), level, false)
      PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(PLAYER.PLAYER_ID(), false)
      PLAYER.SET_WANTED_LEVEL_MULTIPLIER(1.0)
  else
      PLAYER.CLEAR_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID())
      PLAYER.SET_WANTED_LEVEL_MULTIPLIER(0.0)
  end

  -- Mostrar un mensaje en pantalla con el nivel actual de búsqueda
  local message = "Nivel de búsqueda: " .. tostring(level)
  util.toast(message)
end

-- Función para aumentar el nivel de búsqueda
function increase_wanted_level()
  -- Obtener el nivel actual de búsqueda
  local level = PLAYER.GET_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID())

  -- Aumentar el nivel de búsqueda
  if level < 5 then
      level = level + 1
      set_wanted_level(level)
  end
end

-- Función para disminuir el nivel de búsqueda
function decrease_wanted_level()
  -- Obtener el nivel actual de búsqueda
  local level = PLAYER.GET_PLAYER_WANTED_LEVEL(PLAYER.PLAYER_ID())

  -- Disminuir el nivel de búsqueda
  if level > 0 then
      level = level - 1
      set_wanted_level(level)
  end
end

-- Crear el menú

menu.action(menu.my_root(), "Aumentar nivel de búsqueda", {}, "Aumentar el nivel de búsqueda en una estrella", increase_wanted_level)
menu.action(menu.my_root(), "Disminuir nivel de búsqueda", {}, "Disminuir el nivel de búsqueda en una estrella", decrease_wanted_level)

----
menu.click_slider(menu.my_root(), "slider", {""}, "", 0, 5, 0, 0, function()
	util.toast("fuiste tepeado :)")
end)


-------------------

]]---
util.on_stop(function ()
  VEHICLE.SET_VEHICLE_GRAVITY(veh, true)
  ENTITY.SET_ENTITY_COLLISION(veh, true, true);
end)



