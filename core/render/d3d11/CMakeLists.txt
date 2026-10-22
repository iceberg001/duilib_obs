project(obs_d3d11 CXX)

set(obs_d3d11_SOURCES
    d3d11-indexbuffer.cpp
    d3d11-samplerstate.cpp
    d3d11-shader.cpp
    d3d11-shaderprocessor.cpp
    d3d11-stagesurf.cpp
    d3d11-subsystem.cpp
    d3d11-texture2d.cpp
    d3d11-vertexbuffer.cpp
    d3d11-duplicator.cpp
    d3d11-rebuild.cpp
    d3d11-zstencilbuffer.cpp
)

set(obs_d3d11_HEADERS
    d3d11-shaderprocessor.hpp
    d3d11-subsystem.hpp
)

add_library(obs_d3d11 SHARED ${obs_d3d11_SOURCES} ${obs_d3d11_HEADERS})

target_compile_definitions(obs_d3d11 PRIVATE LIBOBS_EXPORTS GLAD_GLAPI_EXPORT_BUILD)

target_include_directories(obs_d3d11 PRIVATE ${CMAKE_SOURCE_DIR}/core)

target_link_libraries(obs_d3d11
    PRIVATE
        libobs
        d3d11
        dxgi
)

set_target_properties(obs_d3d11 PROPERTIES
    OUTPUT_NAME obs_d3d11
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY ${OBS_OUTPUT_DIR}
    RUNTIME_OUTPUT_DIRECTORY ${OBS_OUTPUT_DIR}
)
