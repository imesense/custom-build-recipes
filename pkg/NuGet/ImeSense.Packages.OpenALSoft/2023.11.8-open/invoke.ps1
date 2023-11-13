$Source      = "https://github.com/kcat/openal-soft.git"
$Commit      = "d44112514d84614af6c16ec48d9450706da3b335"
$Destination = "dep/kcat/openal-soft/$Commit"

$Root   = "../../../.."
$Output = "out"

function Invoke-Get {
    if (!(Test-Path -Path "$Destination" -ErrorAction SilentlyContinue)) {
        git clone $Source $Destination
    }
}

function Invoke-Patch {
    Set-Location $Destination
    git reset --hard $Commit
    Set-Location $Root
}

function Invoke-Build {
    $installer = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    $path      = & $installer -latest -prerelease -property installationPath

    Push-Location "$path\Common7\Tools"
    cmd /c "VsDevCmd.bat&set" |
    ForEach-Object {
        if ($_ -Match "=") {
            $v = $_.Split("=", 2)
            Set-Item -Force -Path "ENV:\$($v[0])" -Value "$($v[1])"
        }
    }
    Pop-Location
    Write-Host "Visual Studio 2022 Command Prompt" -ForegroundColor Yellow

    cmake `
        -S $Destination `
        -B $Destination/build/Win32 `
        -G "Visual Studio 17 2022" `
        -A Win32 `
        -T host=x64 `
        -DALSOFT_REQUIRE_WINMM=ON `
        -DALSOFT_REQUIRE_DSOUND=ON `
        -DALSOFT_REQUIRE_WASAPI=ON
    cmake `
        -S $Destination `
        -B $Destination/build/x64 `
        -G "Visual Studio 17 2022" `
        -A x64 `
        -T host=x64 `
        -DALSOFT_REQUIRE_WINMM=ON `
        -DALSOFT_REQUIRE_DSOUND=ON `
        -DALSOFT_REQUIRE_WASAPI=ON

    cmake --build $Destination/build/Win32 --config Debug
    cmake --build $Destination/build/Win32 --config Release
    cmake --build $Destination/build/x64 --config Debug
    cmake --build $Destination/build/x64 --config Release
}

function Invoke-Pack {
    nuget pack $PSScriptRoot\ImeSense.Packages.OpenALSoft.nuspec -OutputDirectory $Output
}

function Invoke-Actions {
    Invoke-Get
    Invoke-Patch
    Invoke-Build
    Invoke-Pack
}
