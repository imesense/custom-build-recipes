source="https://github.com/libsdl-org/SDL.git"
branch="release-2.28.5"
destination="dep/libsdl-org/SDL/$branch"

root="../../../.."
output="out"

invoke_get() {
    if [ ! -d "$destination" ]; then
        mkdir -p $destination
        git clone --branch $branch --depth 1 $source $destination
    fi
}

invoke_build() {
    cmake \
        -S $destination \
        -B $destination/build/arm64 \
        -G "Xcode" \
        -D CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT="dwarf-with-dsym"

    cmake \
        -S $destination \
        -B $destination/build/x86_64 \
        -G "Xcode" \
        -D CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT="dwarf-with-dsym" \
        -D CMAKE_OSX_ARCHITECTURES=x86_64

    cmake --build $destination/build/arm64 --config Debug
    cmake --build $destination/build/arm64 --config RelWithDebInfo
    cmake --build $destination/build/x86_64 --config Debug
    cmake --build $destination/build/x86_64 --config RelWithDebInfo
}

invoke_pack() {
    script_root=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    cd $script_root
    nuget pack ImeSense.Packages.Sdl.Runtimes.osx-arm64.nuspec -OutputDirectory $root/$output
    nuget pack ImeSense.Packages.Sdl.Runtimes.osx-x64.nuspec -OutputDirectory $root/$output
    nuget pack ImeSense.Packages.Sdl.Symbols.osx-arm64.nuspec -OutputDirectory $root/$output
    nuget pack ImeSense.Packages.Sdl.Symbols.osx-x64.nuspec -OutputDirectory $root/$output
}

invoke_actions() {
    invoke_get
    invoke_build
    invoke_pack
}

invoke_actions
