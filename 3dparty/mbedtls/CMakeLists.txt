project(mbedtls C)

file(GLOB mbedtls_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c")
file(GLOB mbedtls_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/include/mbedtls/*.h")

add_library(mbedtls STATIC ${mbedtls_SOURCES} ${mbedtls_HEADERS})

target_include_directories(mbedtls PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)