########## MACROS ###########################################################################
#############################################################################################


macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS FRAMEWORKS_DIRS)
    if(APPLE)
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAMES ${_FRAMEWORK} PATHS ${FRAMEWORKS_DIRS} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${FRAMEWORKS_DIRS}")
            endif()
        endforeach()
    endif()
endmacro()


function(conan_package_library_targets libraries package_libdir deps out_libraries out_libraries_target build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAMES ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            list(APPEND _out_libraries ${CONAN_FOUND_LIBRARY})
            if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
                # Create a micro-target for each lib/a found
                string(REGEX REPLACE "[^A-Za-z0-9.+_-]" "_" _LIBRARY_NAME ${_LIBRARY_NAME})
                set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
                if(NOT TARGET ${_LIB_NAME})
                    # Create a micro-target for each lib/a found
                    add_library(${_LIB_NAME} UNKNOWN IMPORTED)
                    set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
                    set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
                else()
                    conan_message(STATUS "Skipping already existing target: ${_LIB_NAME}")
                endif()
                list(APPEND _out_libraries_target ${_LIB_NAME})
            endif()
            conan_message(STATUS "Found: ${CONAN_FOUND_LIBRARY}")
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            list(APPEND _out_libraries_target ${_LIBRARY_NAME})
            list(APPEND _out_libraries ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
        # Add all dependencies to all targets
        string(REPLACE " " ";" deps_list "${deps}")
        foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
            set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
        endforeach()
    endif()

    set(${out_libraries} ${_out_libraries} PARENT_SCOPE)
    set(${out_libraries_target} ${_out_libraries_target} PARENT_SCOPE)
endfunction()


########### VARIABLES #######################################################################
#############################################################################################


set(SFML_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_RES_DIRS_RELEASE )
set(SFML_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(SFML_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(SFML_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(SFML_LIBRARIES_RELEASE "") # Will be filled later
set(SFML_LIBS_RELEASE "") # Same as SFML_LIBRARIES
set(SFML_SYSTEM_LIBS_RELEASE gdi32 winmm ws2_32)
set(SFML_FRAMEWORK_DIRS_RELEASE )
set(SFML_FRAMEWORKS_RELEASE )
set(SFML_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(SFML_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")

conan_find_apple_frameworks(SFML_FRAMEWORKS_FOUND_RELEASE "${SFML_FRAMEWORKS_RELEASE}" "${SFML_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(SFML_INCLUDE_DIRS_RELEASE
                 SFML_INCLUDE_DIR_RELEASE
                 SFML_INCLUDES_RELEASE
                 SFML_DEFINITIONS_RELEASE
                 SFML_LINKER_FLAGS_RELEASE_LIST
                 SFML_COMPILE_DEFINITIONS_RELEASE
                 SFML_COMPILE_OPTIONS_RELEASE_LIST
                 SFML_LIBRARIES_RELEASE
                 SFML_LIBS_RELEASE
                 SFML_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to SFML_LIBS and SFML_LIBRARY_LIST
set(SFML_LIBRARY_LIST_RELEASE sfml-main sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(SFML_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_SFML_DEPENDENCIES_RELEASE "${SFML_FRAMEWORKS_FOUND_RELEASE} ${SFML_SYSTEM_LIBS_RELEASE} Freetype::Freetype;stb::stb;opengl::opengl;FLAC::FLAC;OpenAL::OpenAL;Vorbis::Vorbis")

conan_package_library_targets("${SFML_LIBRARY_LIST_RELEASE}"  # libraries
                              "${SFML_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_SFML_DEPENDENCIES_RELEASE}"  # deps
                              SFML_LIBRARIES_RELEASE            # out_libraries
                              SFML_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "SFML")                                      # package_name

set(SFML_LIBS_RELEASE ${SFML_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${SFML_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND SFML_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND SFML_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${SFML_SYSTEM_LIBS_RELEASE})
    list(APPEND SFML_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND SFML_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(SFML_LIBRARIES_TARGETS_RELEASE "${SFML_LIBRARIES_TARGETS_RELEASE};Freetype::Freetype;stb::stb;opengl::opengl;FLAC::FLAC;OpenAL::OpenAL;Vorbis::Vorbis")
set(SFML_LIBRARIES_RELEASE "${SFML_LIBRARIES_RELEASE};Freetype::Freetype;stb::stb;opengl::opengl;FLAC::FLAC;OpenAL::OpenAL;Vorbis::Vorbis")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/" ${CMAKE_PREFIX_PATH})

set(SFML_COMPONENTS_RELEASE SFML::main SFML::graphics SFML::window SFML::network SFML::audio SFML::system)

########### COMPONENT system VARIABLES #############################################

set(SFML_system_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_system_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_system_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_system_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_system_RES_DIRS_RELEASE )
set(SFML_system_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_system_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_system_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_system_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_system_LIBS_RELEASE sfml-system-s)
set(SFML_system_SYSTEM_LIBS_RELEASE winmm)
set(SFML_system_FRAMEWORK_DIRS_RELEASE )
set(SFML_system_FRAMEWORKS_RELEASE )
set(SFML_system_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_system_DEPENDENCIES_RELEASE )
set(SFML_system_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT system FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_system_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_system_FRAMEWORKS_FOUND_RELEASE "${SFML_system_FRAMEWORKS_RELEASE}" "${SFML_system_FRAMEWORK_DIRS_RELEASE}")

set(SFML_system_LIB_TARGETS_RELEASE "")
set(SFML_system_NOT_USED_RELEASE "")
set(SFML_system_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_system_FRAMEWORKS_FOUND_RELEASE} ${SFML_system_SYSTEM_LIBS_RELEASE} ${SFML_system_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_system_LIBS_RELEASE}"
                              "${SFML_system_LIB_DIRS_RELEASE}"
                              "${SFML_system_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_system_NOT_USED_RELEASE
                              SFML_system_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_system")

set(SFML_system_LINK_LIBS_RELEASE ${SFML_system_LIB_TARGETS_RELEASE} ${SFML_system_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT audio VARIABLES #############################################

set(SFML_audio_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_audio_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_audio_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_audio_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_audio_RES_DIRS_RELEASE )
set(SFML_audio_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_audio_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_audio_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_audio_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_audio_LIBS_RELEASE sfml-audio-s)
set(SFML_audio_SYSTEM_LIBS_RELEASE )
set(SFML_audio_FRAMEWORK_DIRS_RELEASE )
set(SFML_audio_FRAMEWORKS_RELEASE )
set(SFML_audio_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_audio_DEPENDENCIES_RELEASE SFML::system FLAC::FLAC OpenAL::OpenAL Vorbis::Vorbis)
set(SFML_audio_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT audio FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_audio_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_audio_FRAMEWORKS_FOUND_RELEASE "${SFML_audio_FRAMEWORKS_RELEASE}" "${SFML_audio_FRAMEWORK_DIRS_RELEASE}")

set(SFML_audio_LIB_TARGETS_RELEASE "")
set(SFML_audio_NOT_USED_RELEASE "")
set(SFML_audio_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_audio_FRAMEWORKS_FOUND_RELEASE} ${SFML_audio_SYSTEM_LIBS_RELEASE} ${SFML_audio_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_audio_LIBS_RELEASE}"
                              "${SFML_audio_LIB_DIRS_RELEASE}"
                              "${SFML_audio_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_audio_NOT_USED_RELEASE
                              SFML_audio_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_audio")

set(SFML_audio_LINK_LIBS_RELEASE ${SFML_audio_LIB_TARGETS_RELEASE} ${SFML_audio_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT network VARIABLES #############################################

set(SFML_network_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_network_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_network_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_network_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_network_RES_DIRS_RELEASE )
set(SFML_network_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_network_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_network_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_network_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_network_LIBS_RELEASE sfml-network-s)
set(SFML_network_SYSTEM_LIBS_RELEASE ws2_32)
set(SFML_network_FRAMEWORK_DIRS_RELEASE )
set(SFML_network_FRAMEWORKS_RELEASE )
set(SFML_network_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_network_DEPENDENCIES_RELEASE SFML::system)
set(SFML_network_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT network FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_network_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_network_FRAMEWORKS_FOUND_RELEASE "${SFML_network_FRAMEWORKS_RELEASE}" "${SFML_network_FRAMEWORK_DIRS_RELEASE}")

set(SFML_network_LIB_TARGETS_RELEASE "")
set(SFML_network_NOT_USED_RELEASE "")
set(SFML_network_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_network_FRAMEWORKS_FOUND_RELEASE} ${SFML_network_SYSTEM_LIBS_RELEASE} ${SFML_network_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_network_LIBS_RELEASE}"
                              "${SFML_network_LIB_DIRS_RELEASE}"
                              "${SFML_network_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_network_NOT_USED_RELEASE
                              SFML_network_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_network")

set(SFML_network_LINK_LIBS_RELEASE ${SFML_network_LIB_TARGETS_RELEASE} ${SFML_network_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT window VARIABLES #############################################

set(SFML_window_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_window_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_window_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_window_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_window_RES_DIRS_RELEASE )
set(SFML_window_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_window_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_window_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_window_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_window_LIBS_RELEASE sfml-window-s)
set(SFML_window_SYSTEM_LIBS_RELEASE gdi32 winmm)
set(SFML_window_FRAMEWORK_DIRS_RELEASE )
set(SFML_window_FRAMEWORKS_RELEASE )
set(SFML_window_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_window_DEPENDENCIES_RELEASE SFML::system opengl::opengl)
set(SFML_window_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT window FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_window_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_window_FRAMEWORKS_FOUND_RELEASE "${SFML_window_FRAMEWORKS_RELEASE}" "${SFML_window_FRAMEWORK_DIRS_RELEASE}")

set(SFML_window_LIB_TARGETS_RELEASE "")
set(SFML_window_NOT_USED_RELEASE "")
set(SFML_window_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_window_FRAMEWORKS_FOUND_RELEASE} ${SFML_window_SYSTEM_LIBS_RELEASE} ${SFML_window_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_window_LIBS_RELEASE}"
                              "${SFML_window_LIB_DIRS_RELEASE}"
                              "${SFML_window_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_window_NOT_USED_RELEASE
                              SFML_window_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_window")

set(SFML_window_LINK_LIBS_RELEASE ${SFML_window_LIB_TARGETS_RELEASE} ${SFML_window_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT graphics VARIABLES #############################################

set(SFML_graphics_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_graphics_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_graphics_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_graphics_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_graphics_RES_DIRS_RELEASE )
set(SFML_graphics_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_graphics_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_graphics_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_graphics_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_graphics_LIBS_RELEASE sfml-graphics-s)
set(SFML_graphics_SYSTEM_LIBS_RELEASE )
set(SFML_graphics_FRAMEWORK_DIRS_RELEASE )
set(SFML_graphics_FRAMEWORKS_RELEASE )
set(SFML_graphics_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_graphics_DEPENDENCIES_RELEASE SFML::window Freetype::Freetype stb::stb)
set(SFML_graphics_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT graphics FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_graphics_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_graphics_FRAMEWORKS_FOUND_RELEASE "${SFML_graphics_FRAMEWORKS_RELEASE}" "${SFML_graphics_FRAMEWORK_DIRS_RELEASE}")

set(SFML_graphics_LIB_TARGETS_RELEASE "")
set(SFML_graphics_NOT_USED_RELEASE "")
set(SFML_graphics_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_graphics_FRAMEWORKS_FOUND_RELEASE} ${SFML_graphics_SYSTEM_LIBS_RELEASE} ${SFML_graphics_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_graphics_LIBS_RELEASE}"
                              "${SFML_graphics_LIB_DIRS_RELEASE}"
                              "${SFML_graphics_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_graphics_NOT_USED_RELEASE
                              SFML_graphics_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_graphics")

set(SFML_graphics_LINK_LIBS_RELEASE ${SFML_graphics_LIB_TARGETS_RELEASE} ${SFML_graphics_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT main VARIABLES #############################################

set(SFML_main_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_main_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_main_INCLUDES_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(SFML_main_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(SFML_main_RES_DIRS_RELEASE )
set(SFML_main_DEFINITIONS_RELEASE "-DSFML_STATIC")
set(SFML_main_COMPILE_DEFINITIONS_RELEASE "SFML_STATIC")
set(SFML_main_COMPILE_OPTIONS_C_RELEASE "")
set(SFML_main_COMPILE_OPTIONS_CXX_RELEASE "")
set(SFML_main_LIBS_RELEASE sfml-main)
set(SFML_main_SYSTEM_LIBS_RELEASE )
set(SFML_main_FRAMEWORK_DIRS_RELEASE )
set(SFML_main_FRAMEWORKS_RELEASE )
set(SFML_main_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib/cmake/conan-official-sfml-targets.cmake")
set(SFML_main_DEPENDENCIES_RELEASE )
set(SFML_main_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT main FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(SFML_main_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(SFML_main_FRAMEWORKS_FOUND_RELEASE "${SFML_main_FRAMEWORKS_RELEASE}" "${SFML_main_FRAMEWORK_DIRS_RELEASE}")

set(SFML_main_LIB_TARGETS_RELEASE "")
set(SFML_main_NOT_USED_RELEASE "")
set(SFML_main_LIBS_FRAMEWORKS_DEPS_RELEASE ${SFML_main_FRAMEWORKS_FOUND_RELEASE} ${SFML_main_SYSTEM_LIBS_RELEASE} ${SFML_main_DEPENDENCIES_RELEASE})
conan_package_library_targets("${SFML_main_LIBS_RELEASE}"
                              "${SFML_main_LIB_DIRS_RELEASE}"
                              "${SFML_main_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              SFML_main_NOT_USED_RELEASE
                              SFML_main_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "SFML_main")

set(SFML_main_LINK_LIBS_RELEASE ${SFML_main_LIB_TARGETS_RELEASE} ${SFML_main_LIBS_FRAMEWORKS_DEPS_RELEASE})