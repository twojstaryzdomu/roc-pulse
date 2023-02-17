include(ExternalProject)

set(PULSEAUDIO_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/pulsebuild")

# This command runs "meson setup" to generate pulse/version.h
# We don't actually build PulseAudio
# We don't bother whether we're cross-compiling or not,
# because the generated header is the same in both cases.
ExternalProject_Add(pulsebuild
  SOURCE_DIR "${PULSEAUDIO_BUILD_DIR}"
  BINARY_DIR "${PULSEAUDIO_BUILD_DIR}"
  INSTALL_DIR ""
  DOWNLOAD_COMMAND ""
  PATCH_COMMAND ""
  CONFIGURE_COMMAND
    # Use fake .pc files to suppress dependency search.
    ${CMAKE_COMMAND} -E env "PKG_CONFIG_PATH=${PROJECT_SOURCE_DIR}/cmake/pkgconfig"
      meson setup "${PULSEAUDIO_BUILD_DIR}" "${PULSEAUDIO_DIR}"
        -Ddaemon=false
        -Ddoxygen=false
        -Dman=false
        -Dtests=false
        -Ddatabase=simple
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  TEST_COMMAND ""
  LOG_DOWNLOAD ON
  LOG_PATCH ${USE_LOGFILES}
  LOG_CONFIGURE ${USE_LOGFILES}
  LOG_BUILD ${USE_LOGFILES}
  LOG_INSTALL ${USE_LOGFILES}
  LOG_TEST ${USE_LOGFILES}
  )

include_directories(SYSTEM
  "${PULSEAUDIO_BUILD_DIR}/src"
  )
