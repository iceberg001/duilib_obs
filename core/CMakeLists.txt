project(libobs C CXX)

set(libobs_PLATFORM_SOURCES
    obs-win-crash-handler.c
    obs-windows.c
    util/threading-windows.c
    util/pipe-windows.c
    util/platform-windows.c
)

set(libobs_PLATFORM_HEADERS
    util/threading-windows.h
    util/windows/win-registry.h
    util/windows/win-version.h
    util/windows/ComPtr.hpp
    util/windows/CoTaskMemPtr.hpp
    util/windows/HRError.hpp
    util/windows/WinHandle.hpp
)

set(libobs_audio_monitoring_SOURCES
    audio-monitoring/win32/wasapi-output.c
    audio-monitoring/win32/wasapi-enum-devices.c
)

set(libobs_audio_monitoring_HEADERS
    audio-monitoring/win32/wasapi-output.h
)

set(libobs_callback_SOURCES
    callback/calldata.c
    callback/decl.c
    callback/signal.c
    callback/proc.c
)
set(libobs_callback_HEADERS
    callback/calldata.h
    callback/decl.h
    callback/proc.h
    callback/signal.h
)

set(libobs_graphics_SOURCES
    graphics/graphics-ffmpeg.c
    graphics/quat.c
    graphics/effect-parser.c
    graphics/axisang.c
    graphics/vec4.c
    graphics/vec2.c
    graphics/libnsgif/libnsgif.c
    graphics/texture-render.c
    graphics/image-file.c
    graphics/bounds.c
    graphics/matrix3.c
    graphics/matrix4.c
    graphics/vec3.c
    graphics/graphics.c
    graphics/shader-parser.c
    graphics/plane.c
    graphics/effect.c
    graphics/math-extra.c
    graphics/graphics-imports.c
)
set(libobs_graphics_HEADERS
    graphics/plane.h
    graphics/quat.h
    graphics/input.h
    graphics/axisang.h
    graphics/shader-parser.h
    graphics/effect.h
    graphics/math-defs.h
    graphics/matrix4.h
    graphics/graphics.h
    graphics/graphics-internal.h
    graphics/libnsgif/libnsgif.h
    graphics/device-exports.h
    graphics/image-file.h
    graphics/vec2.h
    graphics/vec4.h
    graphics/matrix3.h
    graphics/vec3.h
    graphics/math-extra.h
    graphics/bounds.h
    graphics/effect-parser.h
)

set(libobs_mediaio_SOURCES
    media-io/video-io.c
    media-io/video-fourcc.c
    media-io/video-matrices.c
    media-io/audio-io.c
    media-io/video-frame.c
    media-io/format-conversion.c
    media-io/audio-resampler-ffmpeg.c
    media-io/video-scaler-ffmpeg.c
    media-io/media-remux.c
)
set(libobs_mediaio_HEADERS
    media-io/media-io-defs.h
    media-io/video-io.h
    media-io/audio-io.h
    media-io/audio-math.h
    media-io/video-frame.h
    media-io/format-conversion.h
    media-io/audio-resampler.h
    media-io/video-scaler.h
    media-io/media-remux.h
    media-io/frame-rate.h
)

set(libobs_util_SOURCES
    util/array-serializer.c
    util/file-serializer.c
    util/base.c
    util/platform.c
    util/cf-lexer.c
    util/bmem.c
    util/config-file.c
    util/lexer.c
    util/dstr.c
    util/utf8.c
    util/crc32.c
    util/text-lookup.c
    util/cf-parser.c
    util/profiler.c
)
set(libobs_util_HEADERS
    util/array-serializer.h
    util/file-serializer.h
    util/utf8.h
    util/crc32.h
    util/base.h
    util/text-lookup.h
    util/vc/vc_inttypes.h
    util/vc/vc_stdbool.h
    util/vc/vc_stdint.h
    util/bmem.h
    util/c99defs.h
    util/util_uint128.h
    util/cf-parser.h
    util/threading.h
    util/pipe.h
    util/cf-lexer.h
    util/darray.h
    util/circlebuf.h
    util/dstr.h
    util/serializer.h
    util/config-file.h
    util/lexer.h
    util/platform.h
    util/profiler.h
    util/profiler.hpp
)

set(libobs_libobs_SOURCES
    ${libobs_PLATFORM_SOURCES}
    obs-audio-controls.c
    obs-avc.c
    obs-encoder.c
    obs-service.c
    obs-source.c
    obs-source-deinterlace.c
    obs-source-transition.c
    obs-output.c
    obs-output-delay.c
    obs.c
    obs-properties.c
    obs-data.c
    obs-hotkey.c
    obs-hotkey-name-map.c
    obs-module.c
    obs-display.c
    obs-view.c
    obs-scene.c
    obs-audio.c
    obs-video.c
)
set(libobs_libobs_HEADERS
    ${libobs_PLATFORM_HEADERS}
    obs-audio-controls.h
    obs-defs.h
    obs-avc.h
    obs-encoder.h
    obs-service.h
    obs-internal.h
    obs.h
    obs-ui.h
    obs-properties.h
    obs-data.h
    obs-interaction.h
    obs-hotkey.h
    obs-hotkeys.h
    obs-module.h
    obs-scene.h
    obs-source.h
    obs-output.h
    obs-ffmpeg-compat.h
    obs.hpp
    obs-config.h
)

set(libobs_SOURCES
    ${libobs_callback_SOURCES}
    ${libobs_graphics_SOURCES}
    ${libobs_mediaio_SOURCES}
    ${libobs_util_SOURCES}
    ${libobs_libobs_SOURCES}
    ${libobs_audio_monitoring_SOURCES}
)

set(libobs_HEADERS
    ${libobs_callback_HEADERS}
    ${libobs_graphics_HEADERS}
    ${libobs_mediaio_HEADERS}
    ${libobs_util_HEADERS}
    ${libobs_libobs_HEADERS}
    ${libobs_audio_monitoring_HEADERS}
)

source_group("callback\\Source Files" FILES ${libobs_callback_SOURCES})
source_group("callback\\Header Files" FILES ${libobs_callback_HEADERS})
source_group("graphics\\Source Files" FILES ${libobs_graphics_SOURCES})
source_group("graphics\\Header Files" FILES ${libobs_graphics_HEADERS})
source_group("libobs\\Source Files" FILES ${libobs_libobs_SOURCES})
source_group("libobs\\Header Files" FILES ${libobs_libobs_HEADERS})
source_group("media-io\\Source Files" FILES ${libobs_mediaio_SOURCES})
source_group("media-io\\Header Files" FILES ${libobs_mediaio_HEADERS})
source_group("util\\Source Files" FILES ${libobs_util_SOURCES})
source_group("util\\Header Files" FILES ${libobs_util_HEADERS})
source_group("audio-monitoring\\Source Files" FILES ${libobs_audio_monitoring_SOURCES})
source_group("audio-monitoring\\Header Files" FILES ${libobs_audio_monitoring_HEADERS})

set(OBS_VERSION "22.0.3" CACHE STRING "OBS version" FORCE)
set(OBS_DATA_PATH "../../data" CACHE STRING "" FORCE)
set(OBS_INSTALL_PREFIX "" CACHE STRING "" FORCE)
set(OBS_PLUGIN_DESTINATION "obs-plugins" CACHE STRING "" FORCE)
set(OBS_RELATIVE_PREFIX "../../" CACHE STRING "" FORCE)
set(OBS_UNIX_STRUCTURE 0 CACHE STRING "" FORCE)
set(BUILD_CAPTIONS 0 CACHE STRING "" FORCE)
set(HAVE_DBUS 0 CACHE STRING "" FORCE)
set(HAVE_PULSEAUDIO 0 CACHE STRING "" FORCE)
set(USE_XINPUT 0 CACHE STRING "" FORCE)
set(LIBOBS_IMAGEMAGICK_DIR_STYLE 0 CACHE STRING "" FORCE)
set(OBS_RELEASE_CANDIDATE_MAJOR 0 CACHE STRING "" FORCE)
set(OBS_RELEASE_CANDIDATE_MINOR 0 CACHE STRING "" FORCE)
set(OBS_RELEASE_CANDIDATE_PATCH 0 CACHE STRING "" FORCE)
set(OBS_RELEASE_CANDIDATE 0 CACHE STRING "" FORCE)

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/obsconfig.h.in"
    "${CMAKE_BINARY_DIR}/config/obsconfig.h"
)

add_library(libobs SHARED ${libobs_SOURCES} ${libobs_HEADERS})

target_compile_definitions(libobs
    PRIVATE
        LIBOBS_EXPORTS
        NOMINMAX
        PTW32_STATIC_LIB
        HAVE_OBSCONFIG_H
)

target_include_directories(libobs
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/config>
)

target_link_libraries(libobs
    PRIVATE
        jansson
        w32-pthreads
        zlib
        avcodec
        avformat
        avutil
        swresample
        swscale
        Winmm
        Psapi
)

set_target_properties(libobs PROPERTIES
    OUTPUT_NAME obs
    PREFIX ""
)
