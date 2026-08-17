:: MultiTool 1.3
:: 15/08/2026
:: Ferramenta baseada no projeto de ENG0800
:: Desenvolvedor Eng. Marco Aurélio Machado

@echo off
chcp 65001 > nul
title MultiTool

:: Tela cheia
powershell -windowstyle maximized -command ""

:: Menu
:M
CLS
COLOR 0A

echo.  
echo.  
echo     ==================================================
echo         PROGRAMA PARA CONFIGURAÇÃO E PERFORMANCE
echo     ==================================================
echo.    
echo.   ...................................................
echo.   
echo.   [A] CRIAR PONTO DE RESTAURAÇÃO DO SISTEMA OPERACIONAL
echo.   [B] CORRIGIR IMAGEM DE IMPLANTAÇÃO (PROCESSO EXTENSO)
echo.   [C] VERIFICAR E CORRIGIR ARQUIVOS DE SISTEMA - WINDOWS
echo.   [D] ATIVAR AS CONFIGURAÇÕES DE ALTO DESEMPENHO
echo.   [E] ATIVAR A CENTRAL DE NOTIFICAÇÕES DO WINDOWS
echo.   [F] EXECUTAR ATIVADOR DE CHAVE PARA WINDOWS E OFFICE
echo.   [G] ABRIR ASSISTENTE DE RESTAURAÇÃO DO SISTEMA
echo.   [H] VERIFICAR STATUS DO BitLocker
echo.   [I] DESLIGAR BitLocker
echo.   [J] INSTALAR TODOS OS DRIVERS
echo.   [K] LIMPAR ARQUIVOS TEMPORÁRIOS
echo.
echo.   [Z] SAIR DO PROGRAMA

echo.   ...................................................
echo.   SELECIONE A OPÇÃO [D] PARA ACELERAR O WINDOWS
echo.   SELECIONE A OPÇÃO [G] PARA REVERTER AS ALTERAÇÕES
echo. 
echo.   Desenvolvido por ENG0800
echo.   Versão Marco Notebooks 1.3 15/08/2026
echo.  
echo.  

set /p opcao=" Digite a opção desejada > "

:: Converte para maiúsculas
for %%i in (A B C D E F G H I J K Z) do if /i "%opcao%"=="%%i" goto %%i

:: Se chegou aqui, opção inválida
echo.
echo Opção inválida! Pressione qualquer tecla para tentar novamente...
pause > nul
goto M

:: CRIAR PONTO DE RESTAURAÇÃO DO SISTEMA OPERACIONAL
:A
COLOR 0A

reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'PONTO_DE_RESTAURAÇÃO_ENGENHARIA0800' >nul 2>&1
echo           PONTO DE RESTAURACAO CRIADO COM SUCESSO!
PAUSE
GOTO M

:: CORRIGIR IMAGEM DE IMPLANTAÇÃO
:B
COLOR 0A

DISM /ONLINE /CLEANUP-IMAGE /RESTOREHEALTH
PAUSE
GOTO M

:: VERIFICAR E CORRIGIR ARQUIVOS DE SISTEMA - WINDOWS
:C
COLOR 0A

SFC /SCANNOW

echo INTEGRIDADE DO SISTEMA VERIFICADA!
PAUSE
GOTO M

:: ATIVAR A CENTRAL DE NOTIFICAÇÕES DO WINDOWS
:E
COLOR 0A
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 0 /f
echo CENTRAL DE NOTIFICACOES ATIVADA !
PAUSE
GOTO M

:: EXECUTAR ATIVADOR DE CHAVE PARA WINDOWS E OFFICE
:F
COLOR 0A
powershell.exe -ExecutionPolicy Bypass -File "%~dp0chave.ps1"
PAUSE
GOTO M

:: ABRIR ASSISTENTE DE RESTAURAÇÃO DO SISTEMA
:G
rstrui.exe
COLOR 0A
PAUSE
GOTO M

:: VERIFICAR STATUS DO BitLocker
:H
manage-bde.exe -status
COLOR 0A
PAUSE
GOTO M

:: DESLIGAR BitLocker
:I
echo Digite a unidade com BitLocker "exemplo c:"
set /p unidade=
manage-bde.exe %unidade% -off
COLOR 0A
PAUSE
GOTO M

:: INSTALAR TODOS OS DRIVERS
:J
driverquery /v
COLOR 0A
echo.
echo.
echo Drivers instalados com sucesso.
PAUSE
GOTO M

:: LIMPAR ARQUIVOS TEMPORÁRIOS
:K
:: Limpa Temp do Windows
del /s /f /q "%systemroot%\Temp\*.*"
rd /s /q "%systemroot%\Temp"
mkdir "%systemroot%\Temp"
:: Limpa Temp do perfil do usuário
del /s /f /q "%localappdata%\Temp\*.*"
rd /s /q "%localappdata%\Temp"
mkdir "%localappdata%\Temp"
COLOR 0A
CLS
echo.
echo.
echo Limpeza de arquivos temporários efetuado com sucesso!
echo.
echo.
PAUSE
GOTO M

:: ATIVAR AS CONFIGURAÇÕES DE ALTO DESEMPENHO
:D
POWERCFG /H /TYPE REDUCED
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\EXPLORER\ADVANCED" /V DESKTOPLIVEPREVIEWHOVERTIME /T REG_DWORD /D 0 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\SERVICES\DIAGTRACK" /V START /T REG_DWORD /D 4 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\DSH" /V ALLOWNEWSANDINTERESTS /T REG_DWORD /D 0 /F
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\CONTENTDELIVERYMANAGER" /V SUBSCRIBEDCONTENT-338387ENABLED /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\EDGE" /V STARTUPBOOSTENABLED /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\EDGE" /V BACKGROUNDMODEENABLED /T REG_DWORD /D 0 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL\SESSION MANAGER\ENVIRONMENT" /V DEVMGR_SHOW_NONPRESENT_DEVICES /T REG_SZ /D 1 /F
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\CONTENTDELIVERYMANAGER" /V SUBSCRIBEDCONTENT-310093ENABLED /T REG_DWORD /D 0 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL\LSA" /V AUDITBASEOBJECTS /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\POLICIES\SYSTEM" /V VALIDATEADMINCODESIGNATURES /T REG_DWORD /D 1 /F
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\WINLOGON" /V RESTARTAPPS /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\WINDOWS\USERPROFILES" /V DISABLEUSERHIVEUNLOAD /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\WINDOWS\NETWORKCONNECTIVITYSTATUSINDICATOR" /V NOACTIVEPROBE /T REG_DWORD /D 0 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL\FILESYSTEM" /V NTFSDISABLELASTACCESSUPDATE /T REG_DWORD /D 1 /F
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\POLICIES\SYSTEM" /V ASYNCSCRIPTTIMEOUT /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\MICROSOFT\WINDOWS\WINDOWS ERROR REPORTING" /V DISABLED /T REG_DWORD /D 1 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL\CRASHCONTROL" /V CRASHDUMPENABLED /T REG_DWORD /D 0 /F
REG ADD "HKLM\SOFTWARE\POLICIES\MICROSOFT\WINDOWS\SYSTEM" /V DISABLESTATUSMESSAGES /T REG_DWORD /D 1 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL\BOOTCONTROL" /V BOOTLOG /T REG_DWORD /D 0 /F
REG ADD "HKLM\SYSTEM\CURRENTCONTROLSET\CONTROL" /V SERVICESPIPETIMEOUT /T REG_DWORD /D 5000 /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 2 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 80 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting" /v "DontShowUI" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPFastOpen" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Notepad" /v "fWrap" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f
REG ADD "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f
REG ADD "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 2000 /f
REG ADD "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d 2000 /f
REG ADD "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 2000 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d 86400 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 3 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBoottrace" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 128 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d 2 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d "32" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingCombining" /t REG_DWORD /d "1" /f
REG ADD "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDLL" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d 67108864 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 5000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f
REG ADD "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "1" /f
REG ADD "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement" /v "AllowGameDVR" /t REG_DWORD /d "1" /f
REG ADD "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "1" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REG ADD "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_DWORD /d "1" /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d "1" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LastActiveClick" /t REG_DWORD /d "1" /f
REG ADD "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f
REG ADD "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f
REG ADD "HKCU\Control Panel\Desktop" /v "PaintDesktopVersion" /t REG_DWORD /d "0" /f
REG ADD "HKCU\Software\Classes\ID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Classes\ID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "EnablePeriodicBackup" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableCdp" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC" /v "Icon" /d WmiPrvSE.exe /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC" /v "MUIVerb" /d "Executar SFC" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC" /v "SubCommands" /d "" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC\shell\001menu" /v "HasLUAShield" /d "" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC\shell\001menu" /v "MUIVerb" /d "Corrigir erros no Windows" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\SFC\shell\001menu\command"  /d "PowerShell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/s,/k, sfc /scannow' -Verb runAs\"" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\KillNRTasks" /v "icon" /d "taskmgr.exe,-30651" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\KillNRTasks" /v "MUIverb" /d "Eliminar Travamento" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\KillNRTasks" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\KillNRTasks\command"  /d "CMD.exe /C taskkill.exe /f /fi \"status eq Not Responding\" & Pause" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador" /v "icon" /d "DiagCpl.dll,-1" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador" /v "MUIverb" /d "Corrigir problemas" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador" /v "SubCommands" /d "" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\03entry" /v "Icon" /d "DiagCpl.dll,-500" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\03entry" /v "MUIVerb" /d "Programas Travando" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\03entry" /v "CommandFlags" /t REG_DWORD /d 32 /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\03entry\command"  /d "explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\applications" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\04entry" /v "icon" /d "DiagCpl.dll,-501" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\04entry" /v "MUIverb" /d "Problemas com Hardware ou Audio" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\04entry\command"  /d "explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\05entry" /v "icon" /d "DiagCpl.dll,-503" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\05entry" /v "MUIVerb" /d "Problemas com rede ou internet" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\05entry\command"  /d "explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\06entry" /v "icon" /d "DiagCpl.dll,-509" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\06entry" /v "MUIVerb" /d "Erros de Sistema e Seguranca" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\06entry\command"  /d "explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\07entry" /v "MUIVerb" /d "Todas as categorias" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\07entry" /v "CommandFlags" /t REG_DWORD /d 32 /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Solucionador\shell\07entry\command"  /d "explorer shell:::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\listAllPage" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Reiniciar Explorer" /v "icon" /d "explorer.exe" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Reiniciar Explorer" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Reiniciar Explorer" /v "MUIVerb" /d "Reiniciar Explorer" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Reiniciar Explorer\command" /d "cmd.exe /c taskkill /f /im explorer.exe  & start explorer.exe" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Executar Dism" /v "icon" /d "WmiPrvSE.exe" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Executar Dism" /v "MUIVerb" /d "Restaurar Imagem do Sistema" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Executar Dism" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Executar Dism" /v "HasLUAShield" /d "" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\shell\Executar Dism\command"  /d "PowerShell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/s,/k, Dism /Online /Cleanup-Image /RestoreHealth' -Verb runAs\"" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\shell\PontoRestauracao" /v "Icon" /d "SystemPropertiesProtection.exe" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\shell\PontoRestauracao" /v "MUIVerb" /d "Criar Ponto de Restauracao" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\shell\PontoRestauracao" /v "Position" /d "Top" /f
REG ADD "HKEY_CLASSES_ROOT\DesktopBackground\shell\PontoRestauracao\command" /d "PowerShell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/s,/c, PowerShell Checkpoint-Computer -Description \"Manual\" -RestorePointType \"MODIFY_SETTINGS\"' -Verb runAs\"" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f
CLS
echo.
echo.
echo OTIMIZADO COM SUCESSO!
echo.
echo.
PAUSE
GOTO M

:: SAIR DO PROGRAMA
:Z
EXIT