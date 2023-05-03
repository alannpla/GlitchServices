util.keep_running()
util.require_natives(1651208000)
if not SCRIPT_SILENT_START and players.get_name(players.user()) ~= "UNKNOWN" then

  util.toast("Hola, " .. players.get_name(players.user()) .. "! \nBienvenido!")

end
---------------AUTO ACTUALIZACION
function checkVersion()
  local user = "alannpla"
  local repo = "Pomelo"
  local branch = "main"

  local url = string.format("https://api.github.com/repos/%s/%s/contents/version.txt?ref=%s", user, repo, branch)

  local headers = {
    ["Accept"] = "application/vnd.github.v3+json"
  }

  local response = PerformHttpRequest(url, function(statusCode, responseText, headers)
    if statusCode == 200 then
      local responseJson = json.decode(responseText)
      local remoteVersion = base64.decode(responseJson.content)
      if remoteVersion ~= version then
        print("Hay una nueva versión disponible:", remoteVersion)
      end
    else
      print("Error al obtener la versión:", statusCode, responseText)
    end
  end, "GET", nil, headers)
end



--[[


--IMAGEN BIENVENIDA

P_DIR = filesystem.store_dir() .. "Pomelo\\"
FolderDirs = {
  Img = P_DIR .. "Image\\",
}


function SHOW_IMG(img_name, max_passed_time) -- Credit goes to LanceScript Reloaded
  if filesystem.exists(FolderDirs.Img .. img_name) then
      local ImgAlpha = 0
      local IncreasedImgAlpha = 0.01
      util.create_tick_handler(function()
          ImgAlpha = ImgAlpha + IncreasedImgAlpha
          if ImgAlpha > 1 then
              ImgAlpha = 1
          elseif ImgAlpha < 0 then 
              ImgAlpha = 0
              return false
          end
      end)

      local Img = directx.create_texture(FolderDirs.Img .. img_name)
      local StartedTime = os.clock()
      util.create_tick_handler(function()
          directx.draw_texture(Img, 0.07, 0.07, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, ImgAlpha)
          local PassedTime = os.clock() - StartedTime
          if PassedTime > max_passed_time then
              IncreasedImgAlpha = -0.01
          end
          if ImgAlpha == 0 then
              return false
          end
      end)
  end
end
if SCRIPT_MANUAL_START and not SCRIPT_SILENT_START then
  SHOW_IMG("Pomelo Banner.png", 3)
end
]]---



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

    menu.text_input(myFolder, "Mensaje", {"spammessage"}, "Podes modificar el texto, ejemplo: Pomelo Script", function(txt)

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

----------------------DIVIDER

menu.divider(menu.my_root(), "Test", {}, end)
--[[
local recovery = menu.list(menu.my_root(), "Recovery", {}, "ALERTA! Todas las opciones de esta carpeta se consideran riesgosas. No nos hacemos responsables. Estas advertido.")
-----------TEST
-----------TEST
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




