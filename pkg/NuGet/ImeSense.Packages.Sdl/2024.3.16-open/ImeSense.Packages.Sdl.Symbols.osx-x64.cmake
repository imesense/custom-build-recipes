if($<CONFIG> STREQUAL "Debug")
    set(SDL_CONFIG "Debug")
elseif($<CONFIG> STREQUAL "Release" OR $<CONFIG> STREQUAL "MinSizeRel" OR $<CONFIG> STREQUAL "RelWithDebInfo")
    set(SDL_CONFIG "Release")
endif()

set(SDL_ROOT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../..")
set(SDL_RUNTIME_ID "osx-x64")
set(SDL_RUNTIME_PATH "${SDL_ROOT_PATH}/runtimes/${SDL_RUNTIME_ID}/native/$(SDL_CONFIG)/")

add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${SDL_RUNTIME_PATH}/libSDL3.1.0.0.dylib.dSYM ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libSDL3.1.0.0.dylib.dSYM
)
