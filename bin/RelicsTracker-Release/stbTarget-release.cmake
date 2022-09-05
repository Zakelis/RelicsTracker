
set(stb_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(stb_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(stb_INCLUDES_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(stb_RES_DIRS_RELEASE )
set(stb_DEFINITIONS_RELEASE "-DSTB_TEXTEDIT_KEYTYPE=unsigned")
set(stb_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(stb_COMPILE_DEFINITIONS_RELEASE "STB_TEXTEDIT_KEYTYPE=unsigned")
set(stb_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(stb_COMPILE_OPTIONS_C_RELEASE "")
set(stb_COMPILE_OPTIONS_CXX_RELEASE "")
set(stb_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(stb_LIBRARIES_RELEASE "") # Will be filled later
set(stb_LIBS_RELEASE "") # Same as stb_LIBRARIES
set(stb_SYSTEM_LIBS_RELEASE )
set(stb_FRAMEWORK_DIRS_RELEASE )
set(stb_FRAMEWORKS_RELEASE )
set(stb_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(stb_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(stb_FRAMEWORKS_FOUND_RELEASE "${stb_FRAMEWORKS_RELEASE}" "${stb_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(stb_INCLUDE_DIRS_RELEASE
                 stb_INCLUDE_DIR_RELEASE
                 stb_INCLUDES_RELEASE
                 stb_DEFINITIONS_RELEASE
                 stb_LINKER_FLAGS_RELEASE_LIST
                 stb_COMPILE_DEFINITIONS_RELEASE
                 stb_COMPILE_OPTIONS_RELEASE_LIST
                 stb_LIBRARIES_RELEASE
                 stb_LIBS_RELEASE
                 stb_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to stb_LIBS and stb_LIBRARY_LIST
set(stb_LIBRARY_LIST_RELEASE )
set(stb_LIB_DIRS_RELEASE )

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_stb_DEPENDENCIES_RELEASE "${stb_FRAMEWORKS_FOUND_RELEASE} ${stb_SYSTEM_LIBS_RELEASE} ")

conan_package_library_targets("${stb_LIBRARY_LIST_RELEASE}"  # libraries
                              "${stb_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_stb_DEPENDENCIES_RELEASE}"  # deps
                              stb_LIBRARIES_RELEASE            # out_libraries
                              stb_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "stb")                                      # package_name

set(stb_LIBS_RELEASE ${stb_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${stb_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND stb_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND stb_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${stb_SYSTEM_LIBS_RELEASE})
    list(APPEND stb_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND stb_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(stb_LIBRARIES_TARGETS_RELEASE "${stb_LIBRARIES_TARGETS_RELEASE};")
set(stb_LIBRARIES_RELEASE "${stb_LIBRARIES_RELEASE};")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_PREFIX_PATH})
