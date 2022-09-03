
set(httplib_INCLUDE_DIRS_RELWITHDEBINFO "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_INCLUDE_DIR_RELWITHDEBINFO "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include;C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_INCLUDES_RELWITHDEBINFO "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(httplib_RES_DIRS_RELWITHDEBINFO )
set(httplib_DEFINITIONS_RELWITHDEBINFO )
set(httplib_LINKER_FLAGS_RELWITHDEBINFO_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(httplib_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(httplib_COMPILE_OPTIONS_RELWITHDEBINFO_LIST "" "")
set(httplib_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(httplib_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(httplib_LIBRARIES_TARGETS_RELWITHDEBINFO "") # Will be filled later, if CMake 3
set(httplib_LIBRARIES_RELWITHDEBINFO "") # Will be filled later
set(httplib_LIBS_RELWITHDEBINFO "") # Same as httplib_LIBRARIES
set(httplib_SYSTEM_LIBS_RELWITHDEBINFO crypt32 cryptui ws2_32)
set(httplib_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(httplib_FRAMEWORKS_RELWITHDEBINFO )
set(httplib_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
set(httplib_BUILD_MODULES_PATHS_RELWITHDEBINFO )

conan_find_apple_frameworks(httplib_FRAMEWORKS_FOUND_RELWITHDEBINFO "${httplib_FRAMEWORKS_RELWITHDEBINFO}" "${httplib_FRAMEWORK_DIRS_RELWITHDEBINFO}")

mark_as_advanced(httplib_INCLUDE_DIRS_RELWITHDEBINFO
                 httplib_INCLUDE_DIR_RELWITHDEBINFO
                 httplib_INCLUDES_RELWITHDEBINFO
                 httplib_DEFINITIONS_RELWITHDEBINFO
                 httplib_LINKER_FLAGS_RELWITHDEBINFO_LIST
                 httplib_COMPILE_DEFINITIONS_RELWITHDEBINFO
                 httplib_COMPILE_OPTIONS_RELWITHDEBINFO_LIST
                 httplib_LIBRARIES_RELWITHDEBINFO
                 httplib_LIBS_RELWITHDEBINFO
                 httplib_LIBRARIES_TARGETS_RELWITHDEBINFO)

# Find the real .lib/.a and add them to httplib_LIBS and httplib_LIBRARY_LIST
set(httplib_LIBRARY_LIST_RELWITHDEBINFO )
set(httplib_LIB_DIRS_RELWITHDEBINFO )

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_httplib_DEPENDENCIES_RELWITHDEBINFO "${httplib_FRAMEWORKS_FOUND_RELWITHDEBINFO} ${httplib_SYSTEM_LIBS_RELWITHDEBINFO} ")

conan_package_library_targets("${httplib_LIBRARY_LIST_RELWITHDEBINFO}"  # libraries
                              "${httplib_LIB_DIRS_RELWITHDEBINFO}"      # package_libdir
                              "${_httplib_DEPENDENCIES_RELWITHDEBINFO}"  # deps
                              httplib_LIBRARIES_RELWITHDEBINFO            # out_libraries
                              httplib_LIBRARIES_TARGETS_RELWITHDEBINFO    # out_libraries_targets
                              "_RELWITHDEBINFO"                          # build_type
                              "httplib")                                      # package_name

set(httplib_LIBS_RELWITHDEBINFO ${httplib_LIBRARIES_RELWITHDEBINFO})

foreach(_FRAMEWORK ${httplib_FRAMEWORKS_FOUND_RELWITHDEBINFO})
    list(APPEND httplib_LIBRARIES_TARGETS_RELWITHDEBINFO ${_FRAMEWORK})
    list(APPEND httplib_LIBRARIES_RELWITHDEBINFO ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${httplib_SYSTEM_LIBS_RELWITHDEBINFO})
    list(APPEND httplib_LIBRARIES_TARGETS_RELWITHDEBINFO ${_SYSTEM_LIB})
    list(APPEND httplib_LIBRARIES_RELWITHDEBINFO ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(httplib_LIBRARIES_TARGETS_RELWITHDEBINFO "${httplib_LIBRARIES_TARGETS_RELWITHDEBINFO};")
set(httplib_LIBRARIES_RELWITHDEBINFO "${httplib_LIBRARIES_RELWITHDEBINFO};")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_PREFIX_PATH})
