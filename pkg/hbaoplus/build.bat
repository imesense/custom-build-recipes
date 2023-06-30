:: Build library
call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
msbuild ..\..\dep\hbaoplus\build\platforms\vs2015\GFSDK_SSAO.sln ^
    -p:Configuration=Release ^
    -p:Platform=x86 ^
    -maxCpuCount ^
    -nologo
msbuild ..\..\dep\hbaoplus\build\platforms\vs2015\GFSDK_SSAO.sln ^
    -p:Configuration=Release ^
    -p:Platform=x64 ^
    -maxCpuCount ^
    -nologo
