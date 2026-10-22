project(ObsClient CXX)

file(GLOB api_SOURCES "${CMAKE_SOURCE_DIR}/api/*.cpp")
file(GLOB api_HEADERS "${CMAKE_SOURCE_DIR}/api/*.h")

file(GLOB controls_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/controls/*.cpp")
file(GLOB controls_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/controls/*.h")

file(GLOB ui_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file(GLOB ui_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/*.h")

list(REMOVE_ITEM ui_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/StdAfx.cpp")

add_executable(ObsClient WIN32
    ${api_SOURCES}
    ${api_HEADERS}
    ${controls_SOURCES}
    ${controls_HEADERS}
    ${ui_SOURCES}
    ${ui_HEADERS}
    rc/client.rc
)

target_compile_definitions(ObsClient PRIVATE
    _WINDOWS
    $<$<CONFIG:Debug>:DEBUG _DEBUG>
    $<$<CONFIG:Release>:NDEBUG>
)

target_include_directories(ObsClient PRIVATE
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_SOURCE_DIR}/3dparty/DuiLib
    ${CMAKE_SOURCE_DIR}/api
)

target_link_libraries(ObsClient PRIVATE
    libobs
    duilib
)

set_target_properties(ObsClient PROPERTIES
    OUTPUT_NAME ObsClient
    RUNTIME_OUTPUT_DIRECTORY ${OBS_OUTPUT_DIR}
    VS_DEBUGGER_WORKING_DIRECTORY "${OBS_OUTPUT_DIR}/$<CONFIG>"
    VS_DEBUGGER_COMMAND_ARGUMENTS ""
)

obs_copy_dlls(ObsClient)
