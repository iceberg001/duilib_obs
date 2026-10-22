project(jansson C)

set(jansson_SOURCES
    dump.c
    error.c
    hashtable.c
    hashtable_seed.c
    load.c
    memory.c
    pack_unpack.c
    strbuffer.c
    strconv.c
    utf.c
    value.c
)

set(jansson_HEADERS
    jansson.h
    jansson_config.h
    hashtable.h
    jansson_private.h
    lookup3.h
    strbuffer.h
    utf.h
)

add_library(jansson STATIC ${jansson_SOURCES} ${jansson_HEADERS})

target_compile_definitions(jansson PRIVATE HAVE_STDINT_H)

target_include_directories(jansson PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)