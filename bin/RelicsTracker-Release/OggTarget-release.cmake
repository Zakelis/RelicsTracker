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


set(Ogg_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_INCLUDES_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_RES_DIRS_RELEASE )
set(Ogg_DEFINITIONS_RELEASE )
set(Ogg_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(Ogg_COMPILE_DEFINITIONS_RELEASE )
set(Ogg_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(Ogg_COMPILE_OPTIONS_C_RELEASE "")
set(Ogg_COMPILE_OPTIONS_CXX_RELEASE "")
set(Ogg_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(Ogg_LIBRARIES_RELEASE "") # Will be filled later
set(Ogg_LIBS_RELEASE "") # Same as Ogg_LIBRARIES
set(Ogg_SYSTEM_LIBS_RELEASE )
set(Ogg_FRAMEWORK_DIRS_RELEASE )
set(Ogg_FRAMEWORKS_RELEASE )
set(Ogg_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(Ogg_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(Ogg_FRAMEWORKS_FOUND_RELEASE "${Ogg_FRAMEWORKS_RELEASE}" "${Ogg_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(Ogg_INCLUDE_DIRS_RELEASE
                 Ogg_INCLUDE_DIR_RELEASE
                 Ogg_INCLUDES_RELEASE
                 Ogg_DEFINITIONS_RELEASE
                 Ogg_LINKER_FLAGS_RELEASE_LIST
                 Ogg_COMPILE_DEFINITIONS_RELEASE
                 Ogg_COMPILE_OPTIONS_RELEASE_LIST
                 Ogg_LIBRARIES_RELEASE
                 Ogg_LIBS_RELEASE
                 Ogg_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to Ogg_LIBS and Ogg_LIBRARY_LIST
set(Ogg_LIBRARY_LIST_RELEASE ogg)
set(Ogg_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_Ogg_DEPENDENCIES_RELEASE "${Ogg_FRAMEWORKS_FOUND_RELEASE} ${Ogg_SYSTEM_LIBS_RELEASE} ")

conan_package_library_targets("${Ogg_LIBRARY_LIST_RELEASE}"  # libraries
                              "${Ogg_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_Ogg_DEPENDENCIES_RELEASE}"  # deps
                              Ogg_LIBRARIES_RELEASE            # out_libraries
                              Ogg_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "Ogg")                                      # package_name

set(Ogg_LIBS_RELEASE ${Ogg_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${Ogg_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND Ogg_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND Ogg_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${Ogg_SYSTEM_LIBS_RELEASE})
    list(APPEND Ogg_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND Ogg_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(Ogg_LIBRARIES_TARGETS_RELEASE "${Ogg_LIBRARIES_TARGETS_RELEASE};")
set(Ogg_LIBRARIES_RELEASE "${Ogg_LIBRARIES_RELEASE};")

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH})

set(Ogg_COMPONENTS_RELEASE Ogg::ogg)

########### COMPONENT ogg VARIABLES #############################################

set(Ogg_ogg_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_ogg_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_ogg_INCLUDES_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(Ogg_ogg_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(Ogg_ogg_RES_DIRS_RELEASE )
set(Ogg_ogg_DEFINITIONS_RELEASE )
set(Ogg_ogg_COMPILE_DEFINITIONS_RELEASE )
set(Ogg_ogg_COMPILE_OPTIONS_C_RELEASE "")
set(Ogg_ogg_COMPILE_OPTIONS_CXX_RELEASE "")
set(Ogg_ogg_LIBS_RELEASE ogg)
set(Ogg_ogg_SYSTEM_LIBS_RELEASE )
set(Ogg_ogg_FRAMEWORK_DIRS_RELEASE )
set(Ogg_ogg_FRAMEWORKS_RELEASE )
set(Ogg_ogg_BUILD_MODULES_PATHS_RELEASE )
set(Ogg_ogg_DEPENDENCIES_RELEASE )
set(Ogg_ogg_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT ogg FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Ogg_ogg_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Ogg_ogg_FRAMEWORKS_FOUND_RELEASE "${Ogg_ogg_FRAMEWORKS_RELEASE}" "${Ogg_ogg_FRAMEWORK_DIRS_RELEASE}")

set(Ogg_ogg_LIB_TARGETS_RELEASE "")
set(Ogg_ogg_NOT_USED_RELEASE "")
set(Ogg_ogg_LIBS_FRAMEWORKS_DEPS_RELEASE ${Ogg_ogg_FRAMEWORKS_FOUND_RELEASE} ${Ogg_ogg_SYSTEM_LIBS_RELEASE} ${Ogg_ogg_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Ogg_ogg_LIBS_RELEASE}"
                              "${Ogg_ogg_LIB_DIRS_RELEASE}"
                              "${Ogg_ogg_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Ogg_ogg_NOT_USED_RELEASE
                              Ogg_ogg_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Ogg_ogg")

set(Ogg_ogg_LINK_LIBS_RELEASE ${Ogg_ogg_LIB_TARGETS_RELEASE} ${Ogg_ogg_LIBS_FRAMEWORKS_DEPS_RELEASE})