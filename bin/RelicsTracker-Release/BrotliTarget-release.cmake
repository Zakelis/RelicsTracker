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


set(Brotli_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include;C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_INCLUDES_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_RES_DIRS_RELEASE )
set(Brotli_DEFINITIONS_RELEASE )
set(Brotli_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(Brotli_COMPILE_DEFINITIONS_RELEASE )
set(Brotli_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(Brotli_COMPILE_OPTIONS_C_RELEASE "")
set(Brotli_COMPILE_OPTIONS_CXX_RELEASE "")
set(Brotli_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(Brotli_LIBRARIES_RELEASE "") # Will be filled later
set(Brotli_LIBS_RELEASE "") # Same as Brotli_LIBRARIES
set(Brotli_SYSTEM_LIBS_RELEASE )
set(Brotli_FRAMEWORK_DIRS_RELEASE )
set(Brotli_FRAMEWORKS_RELEASE )
set(Brotli_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(Brotli_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(Brotli_FRAMEWORKS_FOUND_RELEASE "${Brotli_FRAMEWORKS_RELEASE}" "${Brotli_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(Brotli_INCLUDE_DIRS_RELEASE
                 Brotli_INCLUDE_DIR_RELEASE
                 Brotli_INCLUDES_RELEASE
                 Brotli_DEFINITIONS_RELEASE
                 Brotli_LINKER_FLAGS_RELEASE_LIST
                 Brotli_COMPILE_DEFINITIONS_RELEASE
                 Brotli_COMPILE_OPTIONS_RELEASE_LIST
                 Brotli_LIBRARIES_RELEASE
                 Brotli_LIBS_RELEASE
                 Brotli_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to Brotli_LIBS and Brotli_LIBRARY_LIST
set(Brotli_LIBRARY_LIST_RELEASE brotlidec-static brotlienc-static brotlicommon-static)
set(Brotli_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_Brotli_DEPENDENCIES_RELEASE "${Brotli_FRAMEWORKS_FOUND_RELEASE} ${Brotli_SYSTEM_LIBS_RELEASE} ")

conan_package_library_targets("${Brotli_LIBRARY_LIST_RELEASE}"  # libraries
                              "${Brotli_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_Brotli_DEPENDENCIES_RELEASE}"  # deps
                              Brotli_LIBRARIES_RELEASE            # out_libraries
                              Brotli_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "Brotli")                                      # package_name

set(Brotli_LIBS_RELEASE ${Brotli_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${Brotli_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND Brotli_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND Brotli_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${Brotli_SYSTEM_LIBS_RELEASE})
    list(APPEND Brotli_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND Brotli_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(Brotli_LIBRARIES_TARGETS_RELEASE "${Brotli_LIBRARIES_TARGETS_RELEASE};")
set(Brotli_LIBRARIES_RELEASE "${Brotli_LIBRARIES_RELEASE};")

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH})

set(Brotli_COMPONENTS_RELEASE Brotli::brotlidec Brotli::brotlienc Brotli::brotlicommon)

########### COMPONENT brotlicommon VARIABLES #############################################

set(Brotli_brotlicommon_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlicommon_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include;C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlicommon_INCLUDES_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlicommon_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib")
set(Brotli_brotlicommon_RES_DIRS_RELEASE )
set(Brotli_brotlicommon_DEFINITIONS_RELEASE )
set(Brotli_brotlicommon_COMPILE_DEFINITIONS_RELEASE )
set(Brotli_brotlicommon_COMPILE_OPTIONS_C_RELEASE "")
set(Brotli_brotlicommon_COMPILE_OPTIONS_CXX_RELEASE "")
set(Brotli_brotlicommon_LIBS_RELEASE brotlicommon-static)
set(Brotli_brotlicommon_SYSTEM_LIBS_RELEASE )
set(Brotli_brotlicommon_FRAMEWORK_DIRS_RELEASE )
set(Brotli_brotlicommon_FRAMEWORKS_RELEASE )
set(Brotli_brotlicommon_BUILD_MODULES_PATHS_RELEASE )
set(Brotli_brotlicommon_DEPENDENCIES_RELEASE )
set(Brotli_brotlicommon_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT brotlicommon FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Brotli_brotlicommon_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Brotli_brotlicommon_FRAMEWORKS_FOUND_RELEASE "${Brotli_brotlicommon_FRAMEWORKS_RELEASE}" "${Brotli_brotlicommon_FRAMEWORK_DIRS_RELEASE}")

set(Brotli_brotlicommon_LIB_TARGETS_RELEASE "")
set(Brotli_brotlicommon_NOT_USED_RELEASE "")
set(Brotli_brotlicommon_LIBS_FRAMEWORKS_DEPS_RELEASE ${Brotli_brotlicommon_FRAMEWORKS_FOUND_RELEASE} ${Brotli_brotlicommon_SYSTEM_LIBS_RELEASE} ${Brotli_brotlicommon_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Brotli_brotlicommon_LIBS_RELEASE}"
                              "${Brotli_brotlicommon_LIB_DIRS_RELEASE}"
                              "${Brotli_brotlicommon_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Brotli_brotlicommon_NOT_USED_RELEASE
                              Brotli_brotlicommon_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Brotli_brotlicommon")

set(Brotli_brotlicommon_LINK_LIBS_RELEASE ${Brotli_brotlicommon_LIB_TARGETS_RELEASE} ${Brotli_brotlicommon_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT brotlienc VARIABLES #############################################

set(Brotli_brotlienc_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlienc_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include;C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlienc_INCLUDES_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlienc_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib")
set(Brotli_brotlienc_RES_DIRS_RELEASE )
set(Brotli_brotlienc_DEFINITIONS_RELEASE )
set(Brotli_brotlienc_COMPILE_DEFINITIONS_RELEASE )
set(Brotli_brotlienc_COMPILE_OPTIONS_C_RELEASE "")
set(Brotli_brotlienc_COMPILE_OPTIONS_CXX_RELEASE "")
set(Brotli_brotlienc_LIBS_RELEASE brotlienc-static)
set(Brotli_brotlienc_SYSTEM_LIBS_RELEASE )
set(Brotli_brotlienc_FRAMEWORK_DIRS_RELEASE )
set(Brotli_brotlienc_FRAMEWORKS_RELEASE )
set(Brotli_brotlienc_BUILD_MODULES_PATHS_RELEASE )
set(Brotli_brotlienc_DEPENDENCIES_RELEASE Brotli::brotlicommon)
set(Brotli_brotlienc_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT brotlienc FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Brotli_brotlienc_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Brotli_brotlienc_FRAMEWORKS_FOUND_RELEASE "${Brotli_brotlienc_FRAMEWORKS_RELEASE}" "${Brotli_brotlienc_FRAMEWORK_DIRS_RELEASE}")

set(Brotli_brotlienc_LIB_TARGETS_RELEASE "")
set(Brotli_brotlienc_NOT_USED_RELEASE "")
set(Brotli_brotlienc_LIBS_FRAMEWORKS_DEPS_RELEASE ${Brotli_brotlienc_FRAMEWORKS_FOUND_RELEASE} ${Brotli_brotlienc_SYSTEM_LIBS_RELEASE} ${Brotli_brotlienc_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Brotli_brotlienc_LIBS_RELEASE}"
                              "${Brotli_brotlienc_LIB_DIRS_RELEASE}"
                              "${Brotli_brotlienc_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Brotli_brotlienc_NOT_USED_RELEASE
                              Brotli_brotlienc_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Brotli_brotlienc")

set(Brotli_brotlienc_LINK_LIBS_RELEASE ${Brotli_brotlienc_LIB_TARGETS_RELEASE} ${Brotli_brotlienc_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT brotlidec VARIABLES #############################################

set(Brotli_brotlidec_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlidec_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include;C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlidec_INCLUDES_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(Brotli_brotlidec_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib")
set(Brotli_brotlidec_RES_DIRS_RELEASE )
set(Brotli_brotlidec_DEFINITIONS_RELEASE )
set(Brotli_brotlidec_COMPILE_DEFINITIONS_RELEASE )
set(Brotli_brotlidec_COMPILE_OPTIONS_C_RELEASE "")
set(Brotli_brotlidec_COMPILE_OPTIONS_CXX_RELEASE "")
set(Brotli_brotlidec_LIBS_RELEASE brotlidec-static)
set(Brotli_brotlidec_SYSTEM_LIBS_RELEASE )
set(Brotli_brotlidec_FRAMEWORK_DIRS_RELEASE )
set(Brotli_brotlidec_FRAMEWORKS_RELEASE )
set(Brotli_brotlidec_BUILD_MODULES_PATHS_RELEASE )
set(Brotli_brotlidec_DEPENDENCIES_RELEASE Brotli::brotlicommon)
set(Brotli_brotlidec_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT brotlidec FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Brotli_brotlidec_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Brotli_brotlidec_FRAMEWORKS_FOUND_RELEASE "${Brotli_brotlidec_FRAMEWORKS_RELEASE}" "${Brotli_brotlidec_FRAMEWORK_DIRS_RELEASE}")

set(Brotli_brotlidec_LIB_TARGETS_RELEASE "")
set(Brotli_brotlidec_NOT_USED_RELEASE "")
set(Brotli_brotlidec_LIBS_FRAMEWORKS_DEPS_RELEASE ${Brotli_brotlidec_FRAMEWORKS_FOUND_RELEASE} ${Brotli_brotlidec_SYSTEM_LIBS_RELEASE} ${Brotli_brotlidec_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Brotli_brotlidec_LIBS_RELEASE}"
                              "${Brotli_brotlidec_LIB_DIRS_RELEASE}"
                              "${Brotli_brotlidec_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Brotli_brotlidec_NOT_USED_RELEASE
                              Brotli_brotlidec_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Brotli_brotlidec")

set(Brotli_brotlidec_LINK_LIBS_RELEASE ${Brotli_brotlidec_LIB_TARGETS_RELEASE} ${Brotli_brotlidec_LIBS_FRAMEWORKS_DEPS_RELEASE})