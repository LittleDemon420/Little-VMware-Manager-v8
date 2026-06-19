@echo off
setlocal EnableDelayedExpansion

:: ==========================================================
:: LITTLE VMWARE MANAGER PROFESSIONAL v6.5.0 Pro Edition
:: Windows 10 / 11 - Kali Linux Custom Skin Style
:: ==========================================================

chcp 65001 >nul
title Little VMware Manager Professional v6.5.0 Pro Edition
:: Aumentamos a 45 líneas para dar margen arriba y abajo
mode con cols=102 lines=45

:: ==========================================================
:: COLORES ANSI (Estilo Kali Linux Terminal)
:: ==========================================================
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

set "ROSA=%ESC%[95m"
set "CYAN=%ESC%[96m"
set "VERDE=%ESC%[92m"
set "AMARILLO=%ESC%[93m"
set "BLANCO=%ESC%[97m"
set "ROJO=%ESC%[91m"
set "AZUL=%ESC%[94m"
set "GRIS=%ESC%[90m"
set "RESET=%ESC%[0m"

:: ==========================================================
:: COMPROBACIÓN ADMINISTRADOR
:: ==========================================================
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    cls
    echo.
    echo %ROJO%=====================================================%RESET%
    echo      %AMARILLO%ERROR: EJECUTA EL SCRIPT COMO ADMINISTRADOR%RESET%
    echo %ROJO%=====================================================%RESET%
    echo.
    pause
    exit
)

:: ==========================================================
:: DETECCIÓN DE RUTAS VMWARE
:: ==========================================================
set "RUTA_VMWARE="
set "RUTA_NETCFG="

if exist "C:\Program Files\VMware\VMware Workstation\vmware.exe" (
    set "RUTA_VMWARE=C:\Program Files\VMware\VMware Workstation\vmware.exe"
    set "RUTA_NETCFG=C:\Program Files\VMware\VMware Workstation\vmnetcfg.exe"
)
if exist "C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe" (
    set "RUTA_VMWARE=C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe"
    set "RUTA_NETCFG=C:\Program Files (x86)\VMware\VMware Workstation\vmnetcfg.exe"
)

if not defined RUTA_VMWARE (
    cls
    echo.
    echo %ROJO%[!] VMware Workstation no fue encontrado en el sistema.%RESET%
    echo.
    pause
    exit
)

:: ==========================================================
:: BUCLE PRINCIPAL DEL MENÚ
:: ==========================================================
:MENU
call :REFRESH
@cls
:: --- MARGEN DE SEGURIDAD PARA EVITAR QUE SE CORTE EL TÍTULO ---
echo.
echo.
echo    %ROSA%██╗     ██╗████████╗████████╗██╗     ███████╗%RESET%
echo    %ROSA%██║     ██║╚══██╔══╝╚══██╔══╝██║     ██╔════╝%RESET%
echo    %ROSA%██║     ██║   ██║      ██║   ██║     █████╗  %RESET%
echo    %ROSA%██║     ██║   ██║      ██║   ██║     ██╔══╝  %RESET%
echo    %ROSA%███████╗██║   ██║      ██║   ███████╗███████╗%RESET%
echo    %ROSA%╚══════╝╚═╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝%RESET%
echo.
echo    %CYAN%██╗   ██╗███╗   ███╗██╗    ██╗ █████╗ ██████╗ ███████╗%RESET%
echo    %CYAN%██║   ██║████╗ ████║██║    ██║██╔══██╗██╔══██╗██╔════╝%RESET%
echo    %CYAN%██║   ██║██╔████╔██║██║ █╗ ██║███████║██████╔╝█████╗  %RESET%
echo    %CYAN%╚██╗ ██╔╝██║╚██╔╝██║██║███╗██║██╔══██║██╔══██╗██╔══╝  %RESET%
echo    %CYAN% ╚████╔╝ ██║ ╚═╝ ██║╚███╔███╔╝██║  ██║██║  ██║███████╗%RESET%
echo    %CYAN%  ╚═══╝  ╚═╝     ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝%RESET%
echo.
echo    %VERDE%███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗ %RESET%
echo    %VERDE%████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗%RESET%
echo    %VERDE%██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝%RESET%
echo    %VERDE%██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗%RESET%
echo    %VERDE%██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║%RESET%
echo    %VERDE%╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝%RESET%
echo.

:: --- BANNER SUPERIOR DE INFORMACIÓN DE RED ---
echo %CYAN%======================================================================================================%RESET%
echo  KERNEL: 10.0+win ^| USER: %VERDE%!USERNAME!%RESET% ^| IP: %AMARILLO%!IP!%RESET% ^| OS: !OSNAME! ^| STATUS: !ESTADO!
echo %CYAN%======================================================================================================%RESET%
echo.
echo  🚀 PANEL DE CONTROL: LITTLE VMWARE MANAGER
echo %GRIS% ──────────────────────────────────────────────────────────────────────────────────────────────────%RESET%

:: --- COLUMNAS DEL PANEL DE CONTROL MANTENIENDO TU DISEÑO ---
echo   [%CYAN%01%RESET%] %VERDE%Iniciar VMware Services%RESET%    %GRIS%»%RESET% net start        ^│ [%CYAN%10%RESET%] %BLANCO%Reiniciar Red VMware%RESET%      %GRIS%»%RESET% restart net
echo   [%CYAN%02%RESET%] %ROJO%Detener VMware Services%RESET%    %GRIS%»%RESET% net stop         ^│ [%CYAN%11%RESET%] %BLANCO%Adaptadores VMware%RESET%        %GRIS%»%RESET% ipconfig vmn
echo   [%CYAN%03%RESET%] %AMARILLO%Reiniciar Servicios%RESET%        %GRIS%»%RESET% restart services ^│ [%CYAN%12%RESET%] %BLANCO%Ver Procesos VMware%RESET%       %GRIS%»%RESET% tasklist vm
echo   [%CYAN%04%RESET%] %ROSA%Kill Switch VMware%RESET%         %GRIS%»%RESET% taskkill /f      ^│ [%CYAN%13%RESET%] %BLANCO%Informacion Sistema%RESET%       %GRIS%»%RESET% systeminfo
echo   [%CYAN%05%RESET%] %BLANCO%Estado Detallado%RESET%           %GRIS%»%RESET% sc query status  ^│ [%CYAN%14%RESET%] %BLANCO%CMD Administrador%RESET%         %GRIS%»%RESET% launch cmd
echo   [%CYAN%06%RESET%] %BLANCO%Abrir VMware%RESET%               %GRIS%»%RESET% vmworkstation.exe^│ [%CYAN%15%RESET%] %BLANCO%PowerShell Admin%RESET%          %GRIS%»%RESET% launch ps
echo   [%CYAN%07%RESET%] %BLANCO%Abrir Services.msc%RESET%         %GRIS%»%RESET% services.msc     ^│ [%CYAN%16%RESET%] %BLANCO%Abrir Admin. Tareas%RESET%       %GRIS%»%RESET% taskmgr
echo   [%CYAN%08%RESET%] %BLANCO%Virtual Network Editor%RESET%     %GRIS%»%RESET% vmnetcfg.exe     ^│ [%CYAN%17%RESET%] %ROJO%CONFIG: Siempre Apagado%RESET%   %GRIS%»%RESET% Modo Manual
echo   [%CYAN%09%RESET%] %BLANCO%Abrir Carpeta VMware%RESET%       %GRIS%»%RESET% explorer         ^│ [%CYAN%18%RESET%] %VERDE%CONFIG: Siempre Encendido%RESET% %GRIS%»%RESET% Modo Auto
echo %GRIS% ──────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo   [%CYAN%19%RESET%] %ROSA%Ver Credenciales / Info Desarrollador%RESET%          %GRIS%»%RESET% info autor
echo.
echo                               [%ROJO%00%RESET%] %ROJO%FINALIZAR Y SALIR%RESET% %GRIS%»%RESET% exit
echo %GRIS% ──────────────────────────────────────────────────────────────────────────────────────────────────%RESET%
echo.
set /p "opcion=Selecciona una opción [00-19]: "

if "%opcion%"=="01" goto INICIAR
if "%opcion%"=="1" goto INICIAR
if "%opcion%"=="02" goto DETENER
if "%opcion%"=="2" goto DETENER
if "%opcion%"=="03" goto REINICIAR
if "%opcion%"=="3" goto REINICIAR
if "%opcion%"=="04" goto KILLSWITCH
if "%opcion%"=="4" goto KILLSWITCH
if "%opcion%"=="05" goto ESTADO
if "%opcion%"=="5" goto ESTADO
if "%opcion%"=="06" goto ABRIRVMWARE
if "%opcion%"=="6" goto ABRIRVMWARE
if "%opcion%"=="07" goto SERVICIOS
if "%opcion%"=="7" goto SERVICIOS
if "%opcion%"=="08" goto NETEDITOR
if "%opcion%"=="8" goto NETEDITOR
if "%opcion%"=="09" goto CARPETA
if "%opcion%"=="9" goto CARPETA
if "%opcion%"=="10" goto RED
if "%opcion%"=="11" goto ADAPTADORES
if "%opcion%"=="12" goto PROCESOS
if "%opcion%"=="13" goto SISTEMA
if "%opcion%"=="14" goto CMDADMIN
if "%opcion%"=="15" goto PSADMIN
if "%opcion%"=="16" goto TASKMANAGER
if "%opcion%"=="17" goto MODOMANUAL
if "%opcion%"=="18" goto MODOAUTO
if "%opcion%"=="19" goto CREDENCIALES
if "%opcion%"=="00" goto SALIR
if "%opcion%"=="0" goto SALIR

goto MENU

:: ==========================================================
:: NÚCLEO DE FUNCIONES MANTENIDAS Y NUEVAS
:: ==========================================================

:INICIAR
echo. & echo %VERDE%[+] Iniciando Servicios de VMware...%RESET%
call :STARTSERVICE VMUSBArbService
call :STARTSERVICE VMnetDHCP
call :STARTSERVICE "VMware NAT Service"
call :STARTSERVICE VMauthdService
call :STARTSERVICE VMnetBridge
call :STARTSERVICE VMwareHostd
start "" "%RUTA_VMWARE%"
goto MENU

:DETENER
echo. & echo %ROJO%[-] Deteniendo Servicios de VMware...%RESET%
call :STOPSERVICE VMwareHostd
call :STOPSERVICE VMauthdService
call :STOPSERVICE "VMware NAT Service"
call :STOPSERVICE VMnetDHCP
call :STOPSERVICE VMUSBArbService
call :STOPSERVICE VMnetBridge
goto MENU

:REINICIAR
echo. & echo %AMARILLO%[*] Reiniciando todos los servicios...%RESET%
call :STOPSERVICE VMwareHostd
call :STOPSERVICE VMauthdService
call :STOPSERVICE "VMware NAT Service"
call :STOPSERVICE VMnetDHCP
call :STOPSERVICE VMUSBArbService
call :STOPSERVICE VMnetBridge
timeout /t 2 >nul
call :STARTSERVICE VMUSBArbService
call :STARTSERVICE VMnetDHCP
call :STARTSERVICE "VMware NAT Service"
call :STARTSERVICE VMauthdService
call :STARTSERVICE VMnetBridge
call :STARTSERVICE VMwareHostd
goto MENU

:KILLSWITCH
echo. & echo %ROJO%[!] Forzando el cierre de procesos de VMware...%RESET%
taskkill /f /im vmware.exe >nul 2>&1
taskkill /f /im vmware-vmx.exe >nul 2>&1
taskkill /f /im vmware-tray.exe >nul 2>&1
taskkill /f /im vmware-hostd.exe >nul 2>&1
goto DETENER

:ESTADO
cls
echo.
echo %CYAN%=== ESTADO DE LOS SERVICIOS ===%RESET%
sc query VMUSBArbService | findstr "SERVICE_NAME STATE"
sc query VMnetDHCP | findstr "SERVICE_NAME STATE"
sc query "VMware NAT Service" | findstr "SERVICE_NAME STATE"
sc query VMauthdService | findstr "SERVICE_NAME STATE"
sc query VMwareHostd | findstr "SERVICE_NAME STATE"
echo.
pause
goto MENU

:ABRIRVMWARE
start "" "%RUTA_VMWARE%"
goto MENU

:SERVICIOS
start services.msc
goto MENU

:NETEDITOR
if exist "%RUTA_NETCFG%" (
    start "" "%RUTA_NETCFG%"
) else (
    echo %ROJO%vmnetcfg.exe no encontrado.%RESET%
    pause
)
goto MENU

:CARPETA
explorer "%ProgramFiles%\VMware"
goto MENU

:RED
echo. & echo %AMARILLO%[*] Reiniciando adaptadores de red virtual...%RESET%
net stop VMnetDHCP >nul 2>&1
net stop "VMware NAT Service" >nul 2>&1
timeout /t 2 >nul
net start VMnetDHCP >nul 2>&1
net start "VMware NAT Service" >nul 2>&1
goto MENU

:ADAPTADORES
cls
echo.
ipconfig /all | findstr /i vmnet
echo.
pause
goto MENU

:PROCESOS
cls
echo.
tasklist | findstr /i vmware
echo.
pause
goto MENU

:SISTEMA
cls
systeminfo
pause
goto MENU

:CMDADMIN
start cmd
goto MENU

:PSADMIN
powershell -Command "Start-Process powershell -Verb RunAs"
goto MENU

:TASKMANAGER
start taskmgr
goto MENU

:MODOMANUAL
echo.
echo %ROJO%[*] Configurando servicios en modo MANUAL (Siempre apagados al encender)...%RESET%
sc config VMUSBArbService start= demand >nul 2>&1
sc config VMnetDHCP start= demand >nul 2>&1
sc config "VMware NAT Service" start= demand >nul 2>&1
sc config VMauthdService start= demand >nul 2>&1
sc config VMnetBridge start= demand >nul 2>&1
sc config VMwareHostd start= demand >nul 2>&1
echo %VERDE%[+] Hecho. Los servicios ya no arrancarán solos al reiniciar el PC.%RESET%
echo Deteniendo servicios actuales por seguridad...
goto DETENER

:MODOAUTO
echo.
echo %VERDE%[*] Configurando servicios en modo AUTOMÁTICO (Arrancan solos con Windows)...%RESET%
sc config VMUSBArbService start= auto >nul 2>&1
sc config VMnetDHCP start= auto >nul 2>&1
sc config "VMware NAT Service" start= auto >nul 2>&1
sc config VMauthdService start= auto >nul 2>&1
sc config VMnetBridge start= auto >nul 2>&1
sc config VMwareHostd start= auto >nul 2>&1
echo %VERDE%[+] Hecho. VMware volverá a iniciar automáticamente junto a Windows.%RESET%
echo.
pause
goto MENU

:: --- OPCIÓN: CREDENCIALES ---
:CREDENCIALES
cls
echo.
echo    %ROSA%██╗      ██╗   ██╗███╗   ███╗██╗    ██╗███╗   ███╗%RESET%
echo    %ROSA%██║      ██║   ██║████╗ ████║██║    ██║████╗ ████║%RESET%
echo    %ROSA%██║      ██║   ██║██╔████╔██║██║ █╗ ██║██╔████╔██║%RESET%
echo    %ROSA%██║      ╚██╗ ██╔╝██║╚██╔╝██║██║███╗██║██║╚██╔╝██║%RESET%
echo    %ROSA%███████╗  ╚████╔╝ ██║ ╚═╝ ██║╚███╔███╔╝██║ ╚═╝ ██║%RESET%
echo    %ROSA%╚══════╝   ╚═══╝  ╚═╝     ╚═╝ ╚══╝╚══╝ ╚═╝     ╚═╝%RESET%
echo.
echo   %CYAN%┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓%RESET%
echo   %CYAN%┃%RESET% %BLANCO%^>^> INFO DEL DESARROLLADOR%RESET%                                    %CYAN%┃%RESET%
echo   %CYAN%┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛%RESET%
echo.
echo   %BLANCO%AUTOR:     %ROSA%@Ismael.1509%RESET%
echo   %BLANCO%GitHub:    %ROSA%@LittleDemon420%RESET%
echo   %BLANCO%GitHub:    %ROSA%https://github.com/littledemon420%RESET%
echo   %BLANCO%VERSIÓN:   %VERDE%8.2.1 Premium Edition%RESET%
echo   %BLANCO%ACADEMIA:  %AMARILLO%IFPS Puenteuropa - SMR1%RESET%
echo   %BLANCO%AÑO:       %CYAN%2025/2026%RESET%
echo.
echo   %CYAN%Este script ha sido diseñado para mantenimiento y optimizacion de sistemas Windows.%RESET%
echo.
echo Presione una tecla para volver...
pause >nul
goto MENU

:STARTSERVICE
net start %~1 >nul 2>&1
exit /b

:STOPSERVICE
net stop %~1 >nul 2>&1
exit /b

:: --- FUNCIÓN SUBRUTINA DE REFRESCO ---
:REFRESH
sc query VMauthdService | find "RUNNING" >nul
if !errorlevel! EQU 0 (
    set "ESTADO=%VERDE%ACTIVO%RESET%"
) else (
    set "ESTADO=%ROJO%INACTIVO%RESET%"
)

set "OSNAME=Desconocido"
for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul') do (
    set "OSNAME=%%B"
)
set "OSNAME=%OSNAME:~0,23%"

set "IP=Desconocida"
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do (
    set "IP=%%i"
    goto IPOK
)
:IPOK
set "IP=%IP: =%"
exit /b

:SALIR
cls
echo.
echo %ROSA%Gracias por usar Little VMware Manager Professional.%RESET%
echo.
timeout /t 2 >nul
exit