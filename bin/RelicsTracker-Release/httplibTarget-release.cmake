
set(httplib_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include;C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_INCLUDES_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_RES_DIRS_RELEASE )
set(httplib_DEFINITIONS_RELEASE )
set(httplib_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(httplib_COMPILE_DEFINITIONS_RELEASE )
set(httplib_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(httplib_COMPILE_OPTIONS_C_RELEASE "")
set(httplib_COMPILE_OPTIONS_CXX_RELEASE "")
set(httplib_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(httplib_LIBRARIES_RELEASE "") # Will be filled later
set(httplib_LIBS_RELEASE "") # Same as httplib_LIBRARIES
set(httplib_SYSTEM_LIBS_RELEASE crypt32 cryptui ws2_32)
set(httplib_FRAMEWORK_DIRS_RELEASE )
set(httplib_FRAMEWORKS_RELEASE )
set(httplib_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(httplib_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(httplib_FRAMEWORKS_FOUND_RELEASE "${httplib_FRAMEWORKS_RELEASE}" "${httplib_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(httplib_INCLUDE_DIRS_RELEASE
                 httplib_INCLUDE_DIR_RELEASE
                 httplib_INCLUDES_RELEASE
                 httplib_DEFINITIONS_RELEASE
                 httplib_LINKER_FLAGS_RELEASE_LIST
                 httplib_COMPILE_DEFINITIONS_RELEASE
                 httplib_COMPILE_OPTIONS_RELEASE_LIST
                 httplib_LIBRARIES_RELEASE
                 httplib_LIBS_RELEASE
                 httplib_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to httplib_LIBS and httplib_LIBRARY_LIST
set(httplib_LIBRARY_LIST_RELEASE )
set(httplib_LIB_DIRS_RELEASE )

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_httplib_DEPENDENCIES_RELEASE "${httplib_FRAMEWORKS_FOUND_RELEASE} ${httplib_SYSTEM_LIBS_RELEASE} ")

conan_package_library_targets("${httplib_LIBRARY_LIST_RELEASE}"  # libraries
                              "${httplib_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_httplib_DEPENDENCIES_RELEASE}"  # deps
                              httplib_LIBRARIES_RELEASE            # out_libraries
                              httplib_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "httplib")                                      # package_name

set(httplib_LIBS_RELEASE ${httplib_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${httplib_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND httplib_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND httplib_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${httplib_SYSTEM_LIBS_RELEASE})
    list(APPEND httplib_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND httplib_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(httplib_LIBRARIES_TARGETS_RELEASE "${httplib_LIBRARIES_TARGETS_RELEASE};")
set(httplib_LIBRARIES_RELEASE "${httplib_LIBRARIES_RELEASE};")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_PREFIX_PATH})
