@echo off
for %%G in (.) do set CURRENT_FOLDER=%%~nxG

echo Compiling shaders...
make shaders >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo Shader compilation failed!
	make shaders
	pause
	exit /b 1
)

echo Compiling %CURRENT_FOLDER%...
"C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" Sample.vcxproj /p:Configuration=Debug /p:Platform=x64 /v:minimal >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo Project compilation failed!
	"C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" Sample.vcxproj /p:Configuration=Debug /p:Platform=x64 /v:minimal
	pause
	exit /b 1
)

echo Running %CURRENT_FOLDER%...
"x64\Debug\Sample.exe"
pause
