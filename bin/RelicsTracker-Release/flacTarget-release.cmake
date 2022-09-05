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


set(FLAC_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_INCLUDES_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_RES_DIRS_RELEASE )
set(FLAC_DEFINITIONS_RELEASE "-DFLAC__NO_DLL")
set(FLAC_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(FLAC_COMPILE_DEFINITIONS_RELEASE "FLAC__NO_DLL")
set(FLAC_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(FLAC_COMPILE_OPTIONS_C_RELEASE "")
set(FLAC_COMPILE_OPTIONS_CXX_RELEASE "")
set(FLAC_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(FLAC_LIBRARIES_RELEASE "") # Will be filled later
set(FLAC_LIBS_RELEASE "") # Same as FLAC_LIBRARIES
set(FLAC_SYSTEM_LIBS_RELEASE )
set(FLAC_FRAMEWORK_DIRS_RELEASE )
set(FLAC_FRAMEWORKS_RELEASE )
set(FLAC_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(FLAC_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(FLAC_FRAMEWORKS_FOUND_RELEASE "${FLAC_FRAMEWORKS_RELEASE}" "${FLAC_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(FLAC_INCLUDE_DIRS_RELEASE
                 FLAC_INCLUDE_DIR_RELEASE
                 FLAC_INCLUDES_RELEASE
                 FLAC_DEFINITIONS_RELEASE
                 FLAC_LINKER_FLAGS_RELEASE_LIST
                 FLAC_COMPILE_DEFINITIONS_RELEASE
                 FLAC_COMPILE_OPTIONS_RELEASE_LIST
                 FLAC_LIBRARIES_RELEASE
                 FLAC_LIBS_RELEASE
                 FLAC_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to FLAC_LIBS and FLAC_LIBRARY_LIST
set(FLAC_LIBRARY_LIST_RELEASE FLAC++ FLAC)
set(FLAC_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_FLAC_DEPENDENCIES_RELEASE "${FLAC_FRAMEWORKS_FOUND_RELEASE} ${FLAC_SYSTEM_LIBS_RELEASE} Ogg::Ogg")

conan_package_library_targets("${FLAC_LIBRARY_LIST_RELEASE}"  # libraries
                              "${FLAC_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_FLAC_DEPENDENCIES_RELEASE}"  # deps
                              FLAC_LIBRARIES_RELEASE            # out_libraries
                              FLAC_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "FLAC")                                      # package_name

set(FLAC_LIBS_RELEASE ${FLAC_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${FLAC_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND FLAC_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND FLAC_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${FLAC_SYSTEM_LIBS_RELEASE})
    list(APPEND FLAC_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND FLAC_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(FLAC_LIBRARIES_TARGETS_RELEASE "${FLAC_LIBRARIES_TARGETS_RELEASE};Ogg::Ogg")
set(FLAC_LIBRARIES_RELEASE "${FLAC_LIBRARIES_RELEASE};Ogg::Ogg")

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH})

set(FLAC_COMPONENTS_RELEASE FLAC::FLAC++ FLAC::FLAC)

########### COMPONENT FLAC VARIABLES #############################################

set(FLAC_FLAC_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC_INCLUDES_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(FLAC_FLAC_RES_DIRS_RELEASE )
set(FLAC_FLAC_DEFINITIONS_RELEASE "-DFLAC__NO_DLL")
set(FLAC_FLAC_COMPILE_DEFINITIONS_RELEASE "FLAC__NO_DLL")
set(FLAC_FLAC_COMPILE_OPTIONS_C_RELEASE "")
set(FLAC_FLAC_COMPILE_OPTIONS_CXX_RELEASE "")
set(FLAC_FLAC_LIBS_RELEASE FLAC)
set(FLAC_FLAC_SYSTEM_LIBS_RELEASE )
set(FLAC_FLAC_FRAMEWORK_DIRS_RELEASE )
set(FLAC_FLAC_FRAMEWORKS_RELEASE )
set(FLAC_FLAC_BUILD_MODULES_PATHS_RELEASE )
set(FLAC_FLAC_DEPENDENCIES_RELEASE Ogg::Ogg)
set(FLAC_FLAC_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT FLAC FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(FLAC_FLAC_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(FLAC_FLAC_FRAMEWORKS_FOUND_RELEASE "${FLAC_FLAC_FRAMEWORKS_RELEASE}" "${FLAC_FLAC_FRAMEWORK_DIRS_RELEASE}")

set(FLAC_FLAC_LIB_TARGETS_RELEASE "")
set(FLAC_FLAC_NOT_USED_RELEASE "")
set(FLAC_FLAC_LIBS_FRAMEWORKS_DEPS_RELEASE ${FLAC_FLAC_FRAMEWORKS_FOUND_RELEASE} ${FLAC_FLAC_SYSTEM_LIBS_RELEASE} ${FLAC_FLAC_DEPENDENCIES_RELEASE})
conan_package_library_targets("${FLAC_FLAC_LIBS_RELEASE}"
                              "${FLAC_FLAC_LIB_DIRS_RELEASE}"
                              "${FLAC_FLAC_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              FLAC_FLAC_NOT_USED_RELEASE
                              FLAC_FLAC_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "FLAC_FLAC")

set(FLAC_FLAC_LINK_LIBS_RELEASE ${FLAC_FLAC_LIB_TARGETS_RELEASE} ${FLAC_FLAC_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT FLAC++ VARIABLES #############################################

set(FLAC_FLAC++_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC++_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC++_INCLUDES_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(FLAC_FLAC++_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(FLAC_FLAC++_RES_DIRS_RELEASE )
set(FLAC_FLAC++_DEFINITIONS_RELEASE )
set(FLAC_FLAC++_COMPILE_DEFINITIONS_RELEASE )
set(FLAC_FLAC++_COMPILE_OPTIONS_C_RELEASE "")
set(FLAC_FLAC++_COMPILE_OPTIONS_CXX_RELEASE "")
set(FLAC_FLAC++_LIBS_RELEASE FLAC++)
set(FLAC_FLAC++_SYSTEM_LIBS_RELEASE )
set(FLAC_FLAC++_FRAMEWORK_DIRS_RELEASE )
set(FLAC_FLAC++_FRAMEWORKS_RELEASE )
set(FLAC_FLAC++_BUILD_MODULES_PATHS_RELEASE )
set(FLAC_FLAC++_DEPENDENCIES_RELEASE FLAC::FLAC)
set(FLAC_FLAC++_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT FLAC++ FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(FLAC_FLAC++_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(FLAC_FLAC++_FRAMEWORKS_FOUND_RELEASE "${FLAC_FLAC++_FRAMEWORKS_RELEASE}" "${FLAC_FLAC++_FRAMEWORK_DIRS_RELEASE}")

set(FLAC_FLAC++_LIB_TARGETS_RELEASE "")
set(FLAC_FLAC++_NOT_USED_RELEASE "")
set(FLAC_FLAC++_LIBS_FRAMEWORKS_DEPS_RELEASE ${FLAC_FLAC++_FRAMEWORKS_FOUND_RELEASE} ${FLAC_FLAC++_SYSTEM_LIBS_RELEASE} ${FLAC_FLAC++_DEPENDENCIES_RELEASE})
conan_package_library_targets("${FLAC_FLAC++_LIBS_RELEASE}"
                              "${FLAC_FLAC++_LIB_DIRS_RELEASE}"
                              "${FLAC_FLAC++_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              FLAC_FLAC++_NOT_USED_RELEASE
                              FLAC_FLAC++_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "FLAC_FLAC++")

set(FLAC_FLAC++_LINK_LIBS_RELEASE ${FLAC_FLAC++_LIB_TARGETS_RELEASE} ${FLAC_FLAC++_LIBS_FRAMEWORKS_DEPS_RELEASE})