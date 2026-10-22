project(duilib CXX)

file(GLOB Control_src "${CMAKE_CURRENT_SOURCE_DIR}/Control/*.cpp")
list(FILTER Control_src EXCLUDE REGEX "Control/UIMenu\\.cpp$")
file(GLOB Core_src "${CMAKE_CURRENT_SOURCE_DIR}/Core/*.cpp")
file(GLOB Layout_src "${CMAKE_CURRENT_SOURCE_DIR}/Layout/*.cpp")
file(GLOB Utils_src_cpp "${CMAKE_CURRENT_SOURCE_DIR}/Utils/*.cpp")
file(GLOB Utils_src_c "${CMAKE_CURRENT_SOURCE_DIR}/Utils/*.c")
file(GLOB Root_src "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

set(duilib_HEADERS
    UIlib.h
    StdAfx.h
)

add_library(duilib SHARED
    ${Control_src}
    ${Core_src}
    ${Layout_src}
    ${Utils_src_cpp}
    ${Utils_src_c}
    ${Root_src}
    ${duilib_HEADERS}
)

target_compile_definitions(duilib PRIVATE _WINDOWS UILIB_EXPORTS)

target_include_directories(duilib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Control>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Core>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Layout>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Utils>
)

target_link_libraries(duilib comctl32 gdi32 user32)

set_target_properties(duilib PROPERTIES OUTPUT_NAME duilib)
