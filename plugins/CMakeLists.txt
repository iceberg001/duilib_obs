option(ENABLE_VLC "Enable vlc-video plugin" OFF)
option(ENABLE_LIBFDK "Enable obs-libfdk plugin" OFF)
option(ENABLE_QSV11 "Enable obs-qsv11 plugin" OFF)
option(ENABLE_WIN_MF "Enable win-mf plugin" ON)
option(ENABLE_WIN_DSHOW "Enable win-dshow plugin" ON)

macro(setup_plugin target)
    set_target_properties(${target} PROPERTIES
        PREFIX ""
        LIBRARY_OUTPUT_DIRECTORY ${OBS_PLUGIN_OUTPUT_DIR}
        RUNTIME_OUTPUT_DIRECTORY ${OBS_PLUGIN_OUTPUT_DIR}
    )
endmacro()

# image-source
add_library(image-source SHARED
    image-source/image-source.c
    image-source/obs-slideshow.c
    image-source/color-source.c
)
target_include_directories(image-source PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(image-source PRIVATE libobs w32-pthreads)
setup_plugin(image-source)

# obs-ffmpeg
add_library(obs-ffmpeg SHARED
    obs-ffmpeg/obs-ffmpeg.c
    obs-ffmpeg/obs-ffmpeg-audio-encoders.c
    obs-ffmpeg/obs-ffmpeg-nvenc.c
    obs-ffmpeg/obs-ffmpeg-output.c
    obs-ffmpeg/obs-ffmpeg-mux.c
    obs-ffmpeg/obs-ffmpeg-source.c
    obs-ffmpeg/media-playback/decode.c
    obs-ffmpeg/media-playback/media.c
)
target_include_directories(obs-ffmpeg PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/obs-ffmpeg
    ${CMAKE_CURRENT_SOURCE_DIR}/obs-ffmpeg/media-playback
)
target_link_libraries(obs-ffmpeg PRIVATE
    libobs w32-pthreads
    avcodec avformat avutil avdevice swresample swscale
)
setup_plugin(obs-ffmpeg)

# ffmpeg-mux64
add_executable(ffmpeg-mux64
    obs-ffmpeg/ffmpeg-mux/ffmpeg-mux.c
)
target_include_directories(ffmpeg-mux64 PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(ffmpeg-mux64 PRIVATE
    libobs w32-pthreads
    avcodec avformat avutil avdevice swresample swscale
)
set_target_properties(ffmpeg-mux64 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OBS_PLUGIN_DATA_DIR}/obs-ffmpeg
)

# obs-filters
add_library(obs-filters SHARED
    obs-filters/obs-filters.c
    obs-filters/async-delay-filter.c
    obs-filters/chroma-key-filter.c
    obs-filters/color-correction-filter.c
    obs-filters/color-grade-filter.c
    obs-filters/color-key-filter.c
    obs-filters/compressor-filter.c
    obs-filters/crop-filter.c
    obs-filters/gain-filter.c
    obs-filters/gpu-delay.c
    obs-filters/mask-filter.c
    obs-filters/noise-gate-filter.c
    obs-filters/noise-suppress-filter.c
    obs-filters/scale-filter.c
    obs-filters/scroll-filter.c
    obs-filters/sharpness-filter.c
)
target_include_directories(obs-filters PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(obs-filters PRIVATE libobs w32-pthreads speexdsp)
setup_plugin(obs-filters)

# obs-outputs
add_library(obs-outputs SHARED
    obs-outputs/obs-outputs.c
    obs-outputs/null-output.c
    obs-outputs/rtmp-stream.c
    obs-outputs/rtmp-windows.c
    obs-outputs/flv-output.c
    obs-outputs/flv-mux.c
    obs-outputs/net-if.c
    obs-outputs/librtmp/amf.c
    obs-outputs/librtmp/cencode.c
    obs-outputs/librtmp/hashswf.c
    obs-outputs/librtmp/log.c
    obs-outputs/librtmp/md5.c
    obs-outputs/librtmp/parseurl.c
    obs-outputs/librtmp/rtmp.c
    obs-outputs/ftl-stream.c
    obs-outputs/ftl-sdk/libftl/hmac/hmac.c
    obs-outputs/ftl-sdk/libftl/hmac/sha2.c
    obs-outputs/ftl-sdk/libftl/ftl-sdk.c
    obs-outputs/ftl-sdk/libftl/handshake.c
    obs-outputs/ftl-sdk/libftl/ingest.c
    obs-outputs/ftl-sdk/libftl/ftl_helpers.c
    obs-outputs/ftl-sdk/libftl/media.c
    obs-outputs/ftl-sdk/libftl/gettimeofday/gettimeofday.c
    obs-outputs/ftl-sdk/libftl/logging.c
    obs-outputs/ftl-sdk/libftl/win32/socket.c
    obs-outputs/ftl-sdk/libftl/win32/threads.c
)
target_compile_definitions(obs-outputs PRIVATE USE_MBEDTLS FTL_STATIC_COMPILE)
target_include_directories(obs-outputs PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/obs-outputs/ftl-sdk/libftl
    ${CMAKE_CURRENT_SOURCE_DIR}/obs-outputs/ftl-sdk/libftl/win32
)
target_link_libraries(obs-outputs PRIVATE
    libobs w32-pthreads jansson mbedtls
    libcurl zlib Crypt32 Iphlpapi winmm ws2_32
)
setup_plugin(obs-outputs)

# obs-text
add_library(obs-text SHARED
    obs-text/gdiplus/obs-text.cpp
)
target_compile_definitions(obs-text PRIVATE UNICODE _UNICODE)
target_include_directories(obs-text PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(obs-text PRIVATE libobs gdiplus)
setup_plugin(obs-text)

# obs-transitions
add_library(obs-transitions SHARED
    obs-transitions/obs-transitions.c
    obs-transitions/transition-cut.c
    obs-transitions/transition-fade.c
    obs-transitions/transition-fade-to-color.c
    obs-transitions/transition-slide.c
    obs-transitions/transition-swipe.c
    obs-transitions/transition-stinger.c
    obs-transitions/transition-luma-wipe.c
)
target_include_directories(obs-transitions PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(obs-transitions PRIVATE libobs)
setup_plugin(obs-transitions)

# obs-x264
add_library(obs-x264 SHARED
    obs-x264/obs-x264.c
    obs-x264/obs-x264-plugin-main.c
)
target_include_directories(obs-x264 PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(obs-x264 PRIVATE libobs x264)
setup_plugin(obs-x264)

# rtmp-services
add_library(rtmp-services SHARED
    rtmp-services/rtmp-services-main.c
    rtmp-services/rtmp-common.c
    rtmp-services/rtmp-custom.c
)
target_include_directories(rtmp-services PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_SOURCE_DIR}/3dparty/jansson
)
target_link_libraries(rtmp-services PRIVATE libobs jansson)
setup_plugin(rtmp-services)

# win-capture (plugin)
add_library(win-capture SHARED
    win-capture/plugin-main.c
    win-capture/window-capture.c
    win-capture/monitor-capture.c
    win-capture/cursor-capture.c
    win-capture/dc-capture.c
    win-capture/duplicator-monitor-capture.c
    win-capture/game-capture.c
    win-capture/app-helpers.c
    win-capture/load-graphics-offsets.c
    win-capture/window-helpers.c
    win-capture/funchook.c
    win-capture/obfuscate.c
    win-capture/inject-library.c
    win-capture/ipc-util/pipe-windows.c
)
target_include_directories(win-capture PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/win-capture
)
target_link_libraries(win-capture PRIVATE libobs psapi d3d9 dxgi d3d11)
setup_plugin(win-capture)

# get-graphics-offsets64
add_executable(get-graphics-offsets64
    win-capture/get-graphics-offsets/get-graphics-offsets.c
    win-capture/get-graphics-offsets/d3d8-offsets.cpp
    win-capture/get-graphics-offsets/d3d9-offsets.cpp
    win-capture/get-graphics-offsets/ddraw-offsets.cpp
    win-capture/get-graphics-offsets/dxgi-offsets.cpp
    win-capture/ipc-util/pipe-windows.c
)
target_include_directories(get-graphics-offsets64 PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/win-capture
)
target_link_libraries(get-graphics-offsets64 PRIVATE libobs d3d9 dxgi d3d11)
set_target_properties(get-graphics-offsets64 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OBS_PLUGIN_DATA_DIR}/win-capture
)

# graphics-hook64
add_library(graphics-hook64 SHARED
    win-capture/graphics-hook/graphics-hook.c
    win-capture/graphics-hook/d3d8-capture.cpp
    win-capture/graphics-hook/d3d9-capture.cpp
    win-capture/graphics-hook/d3d10-capture.cpp
    win-capture/graphics-hook/d3d11-capture.cpp
    win-capture/graphics-hook/d3d12-capture.cpp
    win-capture/graphics-hook/dxgi-capture.cpp
    win-capture/graphics-hook/gl-capture.c
    win-capture/obfuscate.c
    win-capture/funchook.c
    win-capture/ipc-util/pipe-windows.c
)
target_include_directories(graphics-hook64 PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/win-capture
)
target_link_libraries(graphics-hook64 PRIVATE libobs d3d9 dxgi d3d11 psapi)
set_target_properties(graphics-hook64 PROPERTIES
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY ${OBS_PLUGIN_DATA_DIR}/win-capture
    RUNTIME_OUTPUT_DIRECTORY ${OBS_PLUGIN_DATA_DIR}/win-capture
)

# inject-helper64
add_executable(inject-helper64
    win-capture/inject-helper/inject-helper.c
    win-capture/inject-library.c
    win-capture/obfuscate.c
)
target_include_directories(inject-helper64 PRIVATE
    ${CMAKE_SOURCE_DIR}/core
    ${CMAKE_CURRENT_SOURCE_DIR}/win-capture
)
target_link_libraries(inject-helper64 PRIVATE libobs)
set_target_properties(inject-helper64 PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${OBS_PLUGIN_DATA_DIR}/win-capture
)

# win-wasapi
add_library(win-wasapi SHARED
    win-wasapi/plugin-main.cpp
    win-wasapi/win-wasapi.cpp
    win-wasapi/enum-wasapi.cpp
)
target_include_directories(win-wasapi PRIVATE ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(win-wasapi PRIVATE
    libobs d3d9 dxva2 uuid mfplat mfuuid mf wmcodecdspuuid
)
setup_plugin(win-wasapi)

if(ENABLE_LIBFDK)
    add_library(obs-libfdk SHARED
        obs-libfdk/obs-libfdk.c
    )
    target_include_directories(obs-libfdk PRIVATE
        ${CMAKE_SOURCE_DIR}/core
        ${DEPEND_INCLUDE_DIR}
    )
    target_link_libraries(obs-libfdk PRIVATE libobs w32-pthreads fdk-aac_dll)
    setup_plugin(obs-libfdk)
endif()

if(ENABLE_QSV11)
    add_library(obs-qsv11 SHARED
        obs-qsv11/obs-qsv11-plugin-main.c
        obs-qsv11/obs-qsv11.c
        obs-qsv11/QSV_Encoder.cpp
        obs-qsv11/QSV_Encoder_Internal.cpp
        obs-qsv11/common_utils.cpp
        obs-qsv11/common_utils_windows.cpp
        obs-qsv11/common_directx11.cpp
        obs-qsv11/common_directx9.cpp
        obs-qsv11/device_directx9.cpp
    )
    target_compile_definitions(obs-qsv11 PRIVATE DX11_D3D)
    target_include_directories(obs-qsv11 PRIVATE
        ${CMAKE_SOURCE_DIR}/core
        ${CMAKE_CURRENT_SOURCE_DIR}/obs-qsv11
        ${CMAKE_CURRENT_SOURCE_DIR}/obs-qsv11/libmfx/include
        ${CMAKE_CURRENT_SOURCE_DIR}/obs-qsv11/libmfx/include/msdk/include
    )
    target_link_libraries(obs-qsv11 PRIVATE
        libobs w32-pthreads d3d11 dxgi D3d9 Dxva2
    )
    setup_plugin(obs-qsv11)
endif()

if(ENABLE_WIN_DSHOW)
    file(GLOB win_dshow_sources "${CMAKE_CURRENT_SOURCE_DIR}/win-dshow/libdshowcapture/source/*.cpp")
    add_library(win-dshow SHARED
        win-dshow/win-dshow.cpp
        win-dshow/win-dshow-encoder.cpp
        win-dshow/dshow-plugin.cpp
        win-dshow/ffmpeg-decode.c
        ${win_dshow_sources}
    )
    target_compile_definitions(win-dshow PRIVATE UNICODE _UNICODE)
    target_include_directories(win-dshow PRIVATE
        ${CMAKE_SOURCE_DIR}/core
        ${CMAKE_CURRENT_SOURCE_DIR}/win-dshow/libdshowcapture
    )
    target_link_libraries(win-dshow PRIVATE
        libobs
        strmiids ksuser wmcodecdspuuid
        avcodec avformat avutil avdevice swresample swscale
    )
    setup_plugin(win-dshow)
endif()

if(ENABLE_WIN_MF)
    add_library(win-mf SHARED
        win-mf/mf-plugin.cpp
        win-mf/mf-common.cpp
        win-mf/mf-aac.cpp
        win-mf/mf-h264.cpp
        win-mf/mf-aac-encoder.cpp
        win-mf/mf-h264-encoder.cpp
        win-mf/mf-encoder-descriptor.cpp
    )
    target_compile_definitions(win-mf PRIVATE UNICODE _UNICODE)
    target_include_directories(win-mf PRIVATE ${CMAKE_SOURCE_DIR}/core)
    target_link_libraries(win-mf PRIVATE
        libobs d3d9 dxva2 uuid mfplat mfuuid mf wmcodecdspuuid
    )
    setup_plugin(win-mf)
endif()

if(ENABLE_VLC)
    add_library(vlc-video SHARED
        vlc-video/vlc-video-plugin.c
        vlc-video/vlc-video-source.c
    )
    target_include_directories(vlc-video PRIVATE
        ${CMAKE_SOURCE_DIR}/core
        ${CMAKE_CURRENT_SOURCE_DIR}/vlc-video/vlc
    )
    target_link_libraries(vlc-video PRIVATE libobs w32-pthreads)
    setup_plugin(vlc-video)
endif()
