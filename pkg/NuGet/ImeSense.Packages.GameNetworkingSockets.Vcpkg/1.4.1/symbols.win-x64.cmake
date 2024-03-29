if($<CONFIG> STREQUAL "Debug")
    set(GAME_NETWORKING_SOCKETS_CONFIG "Debug")
elseif($<CONFIG> STREQUAL "Release" OR $<CONFIG> STREQUAL "MinSizeRel" OR $<CONFIG> STREQUAL "RelWithDebInfo")
    set(GAME_NETWORKING_SOCKETS_CONFIG "Release")
endif()

set(GAME_NETWORKING_SOCKETS_ROOT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../..")
set(GAME_NETWORKING_SOCKETS_RUNTIME_ID "win-x64")
set(GAME_NETWORKING_SOCKETS_RUNTIME_PATH "${GAME_NETWORKING_SOCKETS_ROOT_PATH}/runtimes/${GAME_NETWORKING_SOCKETS_RUNTIME_ID}/native/$(GAME_NETWORKING_SOCKETS_CONFIG)/")

add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/GameNetworkingSockets.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
)
add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/legacy.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
)
add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libcrypto-3.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
)
add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libssl-3.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
)

if(GAME_NETWORKING_SOCKETS_CONFIG STREQUAL "Debug")
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotobuf-lited.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotobufd.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotocd.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
elseif(GAME_NETWORKING_SOCKETS_CONFIG STREQUAL "Release")
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotobuf-lite.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotobuf.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
    add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${GAME_NETWORKING_SOCKETS_RUNTIME_PATH}/libprotoc.pdb ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/
    )
endif()
