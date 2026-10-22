project(obs_opengl C)

file(GLOB obs_opengl_SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/glad/src/*.c"
)

file(GLOB obs_opengl_HEADERS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/glad/include/**/*.h"
)

list(REMOVE_ITEM obs_opengl_SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/gl-x11.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/glad/src/glad_glx.c"
)

add_library(obs_opengl SHARED ${obs_opengl_SOURCES} ${obs_opengl_HEADERS})

target_compile_definitions(obs_opengl PRIVATE LIBOBS_EXPORTS GLAD_GLAPI_EXPORT_BUILD)

target_include_directories(obs_opengl
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/glad/include
        ${CMAKE_SOURCE_DIR}/core
)

target_link_libraries(obs_opengl
    PRIVATE
        libobs
        opengl32
)

set_target_properties(obs_opengl PROPERTIES
    OUTPUT_NAME obs_opengl
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY ${OBS_OUTPUT_DIR}
    RUNTIME_OUTPUT_DIRECTORY ${OBS_OUTPUT_DIR}
)
