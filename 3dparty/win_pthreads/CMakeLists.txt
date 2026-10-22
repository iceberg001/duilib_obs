project(w32-pthreads C)

set(w32-pthreads_SOURCES pthread.c)

set(w32-pthreads_HEADERS
    implement.h
    pthread.h
    sched.h
    semaphore.h
)

add_library(w32-pthreads SHARED ${w32-pthreads_SOURCES} ${w32-pthreads_HEADERS})

target_compile_definitions(w32-pthreads PRIVATE __CLEANUP_C PTW32_BUILD)

target_include_directories(w32-pthreads PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

set_target_properties(w32-pthreads PROPERTIES
    OUTPUT_NAME pthreadVC2
    PREFIX ""
)
