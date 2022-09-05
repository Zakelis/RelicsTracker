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


set(Vorbis_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_RES_DIRS_RELEASE )
set(Vorbis_DEFINITIONS_RELEASE )
set(Vorbis_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(Vorbis_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(Vorbis_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(Vorbis_LIBRARIES_RELEASE "") # Will be filled later
set(Vorbis_LIBS_RELEASE "") # Same as Vorbis_LIBRARIES
set(Vorbis_SYSTEM_LIBS_RELEASE )
set(Vorbis_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_FRAMEWORKS_RELEASE )
set(Vorbis_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(Vorbis_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(Vorbis_FRAMEWORKS_FOUND_RELEASE "${Vorbis_FRAMEWORKS_RELEASE}" "${Vorbis_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(Vorbis_INCLUDE_DIRS_RELEASE
                 Vorbis_INCLUDE_DIR_RELEASE
                 Vorbis_INCLUDES_RELEASE
                 Vorbis_DEFINITIONS_RELEASE
                 Vorbis_LINKER_FLAGS_RELEASE_LIST
                 Vorbis_COMPILE_DEFINITIONS_RELEASE
                 Vorbis_COMPILE_OPTIONS_RELEASE_LIST
                 Vorbis_LIBRARIES_RELEASE
                 Vorbis_LIBS_RELEASE
                 Vorbis_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to Vorbis_LIBS and Vorbis_LIBRARY_LIST
set(Vorbis_LIBRARY_LIST_RELEASE vorbisenc vorbisfile vorbis)
set(Vorbis_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_Vorbis_DEPENDENCIES_RELEASE "${Vorbis_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_SYSTEM_LIBS_RELEASE} Ogg::Ogg")

conan_package_library_targets("${Vorbis_LIBRARY_LIST_RELEASE}"  # libraries
                              "${Vorbis_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_Vorbis_DEPENDENCIES_RELEASE}"  # deps
                              Vorbis_LIBRARIES_RELEASE            # out_libraries
                              Vorbis_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "Vorbis")                                      # package_name

set(Vorbis_LIBS_RELEASE ${Vorbis_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${Vorbis_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND Vorbis_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND Vorbis_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${Vorbis_SYSTEM_LIBS_RELEASE})
    list(APPEND Vorbis_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND Vorbis_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(Vorbis_LIBRARIES_TARGETS_RELEASE "${Vorbis_LIBRARIES_TARGETS_RELEASE};Ogg::Ogg")
set(Vorbis_LIBRARIES_RELEASE "${Vorbis_LIBRARIES_RELEASE};Ogg::Ogg")

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH})

set(Vorbis_COMPONENTS_RELEASE Vorbis::Enc Vorbis::vorbisenc Vorbis::File Vorbis::vorbisfile Vorbis::vorbis)

########### COMPONENT vorbis VARIABLES #############################################

set(Vorbis_vorbis_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbis_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbis_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbis_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(Vorbis_vorbis_RES_DIRS_RELEASE )
set(Vorbis_vorbis_DEFINITIONS_RELEASE )
set(Vorbis_vorbis_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_vorbis_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_vorbis_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_vorbis_LIBS_RELEASE vorbis)
set(Vorbis_vorbis_SYSTEM_LIBS_RELEASE )
set(Vorbis_vorbis_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_vorbis_FRAMEWORKS_RELEASE )
set(Vorbis_vorbis_BUILD_MODULES_PATHS_RELEASE )
set(Vorbis_vorbis_DEPENDENCIES_RELEASE Ogg::Ogg)
set(Vorbis_vorbis_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT vorbis FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Vorbis_vorbis_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Vorbis_vorbis_FRAMEWORKS_FOUND_RELEASE "${Vorbis_vorbis_FRAMEWORKS_RELEASE}" "${Vorbis_vorbis_FRAMEWORK_DIRS_RELEASE}")

set(Vorbis_vorbis_LIB_TARGETS_RELEASE "")
set(Vorbis_vorbis_NOT_USED_RELEASE "")
set(Vorbis_vorbis_LIBS_FRAMEWORKS_DEPS_RELEASE ${Vorbis_vorbis_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_vorbis_SYSTEM_LIBS_RELEASE} ${Vorbis_vorbis_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Vorbis_vorbis_LIBS_RELEASE}"
                              "${Vorbis_vorbis_LIB_DIRS_RELEASE}"
                              "${Vorbis_vorbis_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Vorbis_vorbis_NOT_USED_RELEASE
                              Vorbis_vorbis_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Vorbis_vorbis")

set(Vorbis_vorbis_LINK_LIBS_RELEASE ${Vorbis_vorbis_LIB_TARGETS_RELEASE} ${Vorbis_vorbis_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT vorbisfile VARIABLES #############################################

set(Vorbis_vorbisfile_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisfile_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisfile_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisfile_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(Vorbis_vorbisfile_RES_DIRS_RELEASE )
set(Vorbis_vorbisfile_DEFINITIONS_RELEASE )
set(Vorbis_vorbisfile_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_vorbisfile_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_vorbisfile_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_vorbisfile_LIBS_RELEASE vorbisfile)
set(Vorbis_vorbisfile_SYSTEM_LIBS_RELEASE )
set(Vorbis_vorbisfile_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_vorbisfile_FRAMEWORKS_RELEASE )
set(Vorbis_vorbisfile_BUILD_MODULES_PATHS_RELEASE )
set(Vorbis_vorbisfile_DEPENDENCIES_RELEASE Vorbis::vorbis)
set(Vorbis_vorbisfile_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT vorbisfile FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Vorbis_vorbisfile_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Vorbis_vorbisfile_FRAMEWORKS_FOUND_RELEASE "${Vorbis_vorbisfile_FRAMEWORKS_RELEASE}" "${Vorbis_vorbisfile_FRAMEWORK_DIRS_RELEASE}")

set(Vorbis_vorbisfile_LIB_TARGETS_RELEASE "")
set(Vorbis_vorbisfile_NOT_USED_RELEASE "")
set(Vorbis_vorbisfile_LIBS_FRAMEWORKS_DEPS_RELEASE ${Vorbis_vorbisfile_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_vorbisfile_SYSTEM_LIBS_RELEASE} ${Vorbis_vorbisfile_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Vorbis_vorbisfile_LIBS_RELEASE}"
                              "${Vorbis_vorbisfile_LIB_DIRS_RELEASE}"
                              "${Vorbis_vorbisfile_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Vorbis_vorbisfile_NOT_USED_RELEASE
                              Vorbis_vorbisfile_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Vorbis_vorbisfile")

set(Vorbis_vorbisfile_LINK_LIBS_RELEASE ${Vorbis_vorbisfile_LIB_TARGETS_RELEASE} ${Vorbis_vorbisfile_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT File VARIABLES #############################################

set(Vorbis_File_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_File_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_File_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_File_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(Vorbis_File_RES_DIRS_RELEASE )
set(Vorbis_File_DEFINITIONS_RELEASE )
set(Vorbis_File_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_File_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_File_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_File_LIBS_RELEASE )
set(Vorbis_File_SYSTEM_LIBS_RELEASE )
set(Vorbis_File_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_File_FRAMEWORKS_RELEASE )
set(Vorbis_File_BUILD_MODULES_PATHS_RELEASE )
set(Vorbis_File_DEPENDENCIES_RELEASE Vorbis::vorbisfile)
set(Vorbis_File_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT File FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Vorbis_File_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Vorbis_File_FRAMEWORKS_FOUND_RELEASE "${Vorbis_File_FRAMEWORKS_RELEASE}" "${Vorbis_File_FRAMEWORK_DIRS_RELEASE}")

set(Vorbis_File_LIB_TARGETS_RELEASE "")
set(Vorbis_File_NOT_USED_RELEASE "")
set(Vorbis_File_LIBS_FRAMEWORKS_DEPS_RELEASE ${Vorbis_File_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_File_SYSTEM_LIBS_RELEASE} ${Vorbis_File_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Vorbis_File_LIBS_RELEASE}"
                              "${Vorbis_File_LIB_DIRS_RELEASE}"
                              "${Vorbis_File_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Vorbis_File_NOT_USED_RELEASE
                              Vorbis_File_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Vorbis_File")

set(Vorbis_File_LINK_LIBS_RELEASE ${Vorbis_File_LIB_TARGETS_RELEASE} ${Vorbis_File_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT vorbisenc VARIABLES #############################################

set(Vorbis_vorbisenc_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisenc_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisenc_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_vorbisenc_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(Vorbis_vorbisenc_RES_DIRS_RELEASE )
set(Vorbis_vorbisenc_DEFINITIONS_RELEASE )
set(Vorbis_vorbisenc_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_vorbisenc_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_vorbisenc_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_vorbisenc_LIBS_RELEASE vorbisenc)
set(Vorbis_vorbisenc_SYSTEM_LIBS_RELEASE )
set(Vorbis_vorbisenc_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_vorbisenc_FRAMEWORKS_RELEASE )
set(Vorbis_vorbisenc_BUILD_MODULES_PATHS_RELEASE )
set(Vorbis_vorbisenc_DEPENDENCIES_RELEASE Vorbis::vorbis)
set(Vorbis_vorbisenc_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT vorbisenc FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Vorbis_vorbisenc_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Vorbis_vorbisenc_FRAMEWORKS_FOUND_RELEASE "${Vorbis_vorbisenc_FRAMEWORKS_RELEASE}" "${Vorbis_vorbisenc_FRAMEWORK_DIRS_RELEASE}")

set(Vorbis_vorbisenc_LIB_TARGETS_RELEASE "")
set(Vorbis_vorbisenc_NOT_USED_RELEASE "")
set(Vorbis_vorbisenc_LIBS_FRAMEWORKS_DEPS_RELEASE ${Vorbis_vorbisenc_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_vorbisenc_SYSTEM_LIBS_RELEASE} ${Vorbis_vorbisenc_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Vorbis_vorbisenc_LIBS_RELEASE}"
                              "${Vorbis_vorbisenc_LIB_DIRS_RELEASE}"
                              "${Vorbis_vorbisenc_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Vorbis_vorbisenc_NOT_USED_RELEASE
                              Vorbis_vorbisenc_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Vorbis_vorbisenc")

set(Vorbis_vorbisenc_LINK_LIBS_RELEASE ${Vorbis_vorbisenc_LIB_TARGETS_RELEASE} ${Vorbis_vorbisenc_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT Enc VARIABLES #############################################

set(Vorbis_Enc_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_Enc_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_Enc_INCLUDES_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(Vorbis_Enc_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(Vorbis_Enc_RES_DIRS_RELEASE )
set(Vorbis_Enc_DEFINITIONS_RELEASE )
set(Vorbis_Enc_COMPILE_DEFINITIONS_RELEASE )
set(Vorbis_Enc_COMPILE_OPTIONS_C_RELEASE "")
set(Vorbis_Enc_COMPILE_OPTIONS_CXX_RELEASE "")
set(Vorbis_Enc_LIBS_RELEASE )
set(Vorbis_Enc_SYSTEM_LIBS_RELEASE )
set(Vorbis_Enc_FRAMEWORK_DIRS_RELEASE )
set(Vorbis_Enc_FRAMEWORKS_RELEASE )
set(Vorbis_Enc_BUILD_MODULES_PATHS_RELEASE )
set(Vorbis_Enc_DEPENDENCIES_RELEASE Vorbis::vorbisenc)
set(Vorbis_Enc_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT Enc FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Vorbis_Enc_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Vorbis_Enc_FRAMEWORKS_FOUND_RELEASE "${Vorbis_Enc_FRAMEWORKS_RELEASE}" "${Vorbis_Enc_FRAMEWORK_DIRS_RELEASE}")

set(Vorbis_Enc_LIB_TARGETS_RELEASE "")
set(Vorbis_Enc_NOT_USED_RELEASE "")
set(Vorbis_Enc_LIBS_FRAMEWORKS_DEPS_RELEASE ${Vorbis_Enc_FRAMEWORKS_FOUND_RELEASE} ${Vorbis_Enc_SYSTEM_LIBS_RELEASE} ${Vorbis_Enc_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Vorbis_Enc_LIBS_RELEASE}"
                              "${Vorbis_Enc_LIB_DIRS_RELEASE}"
                              "${Vorbis_Enc_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Vorbis_Enc_NOT_USED_RELEASE
                              Vorbis_Enc_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Vorbis_Enc")

set(Vorbis_Enc_LINK_LIBS_RELEASE ${Vorbis_Enc_LIB_TARGETS_RELEASE} ${Vorbis_Enc_LIBS_FRAMEWORKS_DEPS_RELEASE})