cmake_minimum_required(VERSION 3.15)

project(libobs C CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
endif()

set(ARCH x64)
set(PLATFORM windows)

set(DEPEND_DIR "${CMAKE_SOURCE_DIR}/depend/win64")
set(DEPEND_INCLUDE_DIR "${DEPEND_DIR}/include")
set(DEPEND_BIN_DIR "${DEPEND_DIR}/bin")
set(DEPEND_LIB_DIR "${DEPEND_DIR}/bin")

set(OBS_PLUGIN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/obs-plugins")
set(OBS_PLUGIN_DATA_DIR "${CMAKE_BINARY_DIR}/data/obs-plugins")
set(OBS_OUTPUT_DIR "${CMAKE_BINARY_DIR}/output")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${OBS_OUTPUT_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${OBS_OUTPUT_DIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

if(MSVC)
    add_compile_options(/W3 /MP /Zc:__cplusplus)
    add_compile_definitions(_WIN32 WIN32 _WINDOWS NOMINMAX UNICODE _UNICODE
        $<$<CONFIG:Debug>:DEBUG _DEBUG>
        $<$<CONFIG:Release>:NDEBUG>
    )
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /SAFESEH:NO")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SAFESEH:NO")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /Zi")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /DEBUG")
endif()

include_directories(SYSTEM
    ${DEPEND_INCLUDE_DIR}
    ${CMAKE_SOURCE_DIR}/3dparty/win_pthreads
    ${CMAKE_SOURCE_DIR}/3dparty/jansson
    ${CMAKE_SOURCE_DIR}/3dparty/mbedtls/include
)

link_directories(${DEPEND_LIB_DIR})

macro(obs_copy_dlls target)
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${DEPEND_BIN_DIR} $<TARGET_FILE_DIR:${target}>
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/data $<TARGET_FILE_DIR:${target}>/data
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${OBS_PLUGIN_OUTPUT_DIR}/$<CONFIG> $<TARGET_FILE_DIR:${target}>/obs-plugins

        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${OBS_PLUGIN_DATA_DIR}/win-capture/$<CONFIG> $<TARGET_FILE_DIR:${target}>/data/obs-plugins/win-capture
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${OBS_PLUGIN_DATA_DIR}/obs-ffmpeg/$<CONFIG> $<TARGET_FILE_DIR:${target}>/data/obs-plugins/obs-ffmpeg
        COMMENT "Copying runtime dependencies and resources..."
    )
endmacro()

add_subdirectory(3dparty/jansson)
add_subdirectory(3dparty/mbedtls)
add_subdirectory(3dparty/win_pthreads)
add_subdirectory(3dparty/DuiLib)

add_subdirectory(core)
add_subdirectory(core/render/d3d11)
add_subdirectory(core/render/opengl)

add_subdirectory(plugins)

add_subdirectory(ui)

message(STATUS "==================================================")
message(STATUS "libobs build configuration:")
message(STATUS "  Architecture: ${ARCH}")
message(STATUS "  Platform:     ${PLATFORM}")
message(STATUS "  Build type:   ${CMAKE_BUILD_TYPE}")
message(STATUS "  Depend dir:   ${DEPEND_DIR}")
message(STATUS "  Output dir:   ${OBS_OUTPUT_DIR}")
message(STATUS "==================================================")
