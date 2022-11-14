@echo off
setlocal EnableDelayedExpansion

set thisBatDirectory=%~dp0
set thisBatFileName=%~nx0

cd /d "%thisBatDirectory%"

echo Arquivos encontrados:
echo.

set /a counter=0
for %%a in (*) do (
    if NOT %%a==%thisBatFileName% (
        set /a counter+=1
        echo !counter!_%%a 
    )
)

if %counter%==0 (
    echo Nenhum arquivo encontrado.
    echo.
    pause
    goto :eof
)

echo.
set /p "choose=Escolha um arquivo pelo numero: "

set /a counter=0
for %%a in (*) do (
    if NOT %%a==%thisBatFileName% (
        set /a counter+=1
        if !counter!==%choose% (
            set fileName=%thisBatDirectory%%%a
            goto :breakFindFile
        )
    )
)

:breakFindFile

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SourceCodeControlProvider" /v "ProviderRegKey" /d "SOFTWARE\Microsoft\Team Foundation Server MSSCCI Provider" /f
start "" "%fileName%"

:eof

Rem matheus.oliveira