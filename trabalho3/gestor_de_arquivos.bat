@echo off
::Etapa 1
::Processo de criação de pastas Documentos, Log e Backup
mkdir c:\gestor_de_arquivos
cd c:\gestor_de_arquivos
mkdir c:\gestor_de_arquivos\Documentos
mkdir c:\gestor_de_arquivos\Logs
mkdir c:\gestor_de_arquivos\Backups
set total_de_pastas=5
set total_de_arquivos=6
set relatorio_final=c:\gestor_de_arquivos
pause

::Etapa 2
::Processo de criação dos arquivos TXT, CSV E IN
echo Aqui é o relatorio com arquivo.txt >> c:\gestor_de_arquivos\Documentos\relatorio.txt
echo Aqui é os dados com arquivo.csv >> c:\gestor_de_arquivos\Documentos\dados.csv
echo Aqui é a config com arquivo.in >> c:\gestor_de_arquivos\Documentos\config.in
pause

::Etapa 3
::Processo de resgistro de Log
title Registro de Operações
cls
set "log=C:\gestor_de_arquivos\Logs\logderegistro.txt"
set "operacao=Verificando o Sistema"
echo Executando %operacao%...
timeout /t 2 >nul
set /a errorlevel=0
if %errorlevel%==0 goto sucesso
goto falha

::Etapa 4
::caso de sucesso
:sucesso
set "status=SUCESSO"
goto registrar

::Etapa 5
::caso de falha
:falha
set "status=FALHA (código %errorlevel%)"
goto registrar

::Etapa 6
::registrar
:registrar
if not exist "C:\gestor_de_arquivos\Logs" mkdir "C:\gestor_de_arquivos\Logs"
echo [%date% - %time%] Operação: %operacao% - Resultado: %status% >> "%log%"
echo -----------------------
echo Operação: %operacao%
echo Resultado: %status%
echo Log salvo em: %log%
echo ------------------------
pause
exit /b

::Etapa 7
::Processo de Backup
title Backup
cls
set "origem=C:\gestor_de_arquivos\Documentos"
set "destino=C:\gestor_de_arquivos\Backups"
echo -----------------------
echo Iniciaando Backup com Robocopy...
echo -----------------------
robocopy "%origem%" "%destino%" /E /COPYALL /R:2 /W:2 /LOG:"%destino%\log_backup.txt"
echo ------------------------
echo  Backup concluído!
echo  Verifique o log em "%destino%\log_backup.txt"
echo -------------------------
pause

::Etapa 8
::Relatório Final
echo --- Relatório Final ----
(
echo Executando....
echo --------
echo Total de arquivos: %total_de_arquivos%
echo Total de pastas: %total_de_pastas%
echo Data e Hora: %date% %time%
%relatorio_final%
)
echo [%date% %time%] Operando.... Gerando Relatório Final === sucesso >> %destino% 
echo Salvando relatorio: %relatorio_final%

echo.
echo concluído
echo Verificandoo log em %destino%
pause
exit /b