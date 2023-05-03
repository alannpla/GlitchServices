@echo off
echo Descargando actualización...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/alannpla/Pomelo/blob/main/Pomelo.lua')"
echo Actualización completada.
