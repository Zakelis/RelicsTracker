
set(OpenAL_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/AL")
set(OpenAL_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include;C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/AL")
set(OpenAL_INCLUDES_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/AL")
set(OpenAL_RES_DIRS_RELEASE )
set(OpenAL_DEFINITIONS_RELEASE "-DAL_LIBTYPE_STATIC")
set(OpenAL_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(OpenAL_COMPILE_DEFINITIONS_RELEASE "AL_LIBTYPE_STATIC")
set(OpenAL_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(OpenAL_COMPILE_OPTIONS_C_RELEASE "")
set(OpenAL_COMPILE_OPTIONS_CXX_RELEASE "")
set(OpenAL_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(OpenAL_LIBRARIES_RELEASE "") # Will be filled later
set(OpenAL_LIBS_RELEASE "") # Same as OpenAL_LIBRARIES
set(OpenAL_SYSTEM_LIBS_RELEASE winmm ole32 shell32 User32)
set(OpenAL_FRAMEWORK_DIRS_RELEASE )
set(OpenAL_FRAMEWORKS_RELEASE )
set(OpenAL_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(OpenAL_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(OpenAL_FRAMEWORKS_FOUND_RELEASE "${OpenAL_FRAMEWORKS_RELEASE}" "${OpenAL_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(OpenAL_INCLUDE_DIRS_RELEASE
                 OpenAL_INCLUDE_DIR_RELEASE
                 OpenAL_INCLUDES_RELEASE
                 OpenAL_DEFINITIONS_RELEASE
                 OpenAL_LINKER_FLAGS_RELEASE_LIST
                 OpenAL_COMPILE_DEFINITIONS_RELEASE
                 OpenAL_COMPILE_OPTIONS_RELEASE_LIST
                 OpenAL_LIBRARIES_RELEASE
                 OpenAL_LIBS_RELEASE
                 OpenAL_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to OpenAL_LIBS and OpenAL_LIBRARY_LIST
set(OpenAL_LIBRARY_LIST_RELEASE OpenAL32)
set(OpenAL_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_OpenAL_DEPENDENCIES_RELEASE "${OpenAL_FRAMEWORKS_FOUND_RELEASE} ${OpenAL_SYSTEM_LIBS_RELEASE} ")

conan_package_library_targets("${OpenAL_LIBRARY_LIST_RELEASE}"  # libraries
                              "${OpenAL_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_OpenAL_DEPENDENCIES_RELEASE}"  # deps
                              OpenAL_LIBRARIES_RELEASE            # out_libraries
                              OpenAL_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "OpenAL")                                      # package_name

set(OpenAL_LIBS_RELEASE ${OpenAL_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${OpenAL_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND OpenAL_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND OpenAL_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${OpenAL_SYSTEM_LIBS_RELEASE})
    list(APPEND OpenAL_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND OpenAL_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(OpenAL_LIBRARIES_TARGETS_RELEASE "${OpenAL_LIBRARIES_TARGETS_RELEASE};")
set(OpenAL_LIBRARIES_RELEASE "${OpenAL_LIBRARIES_RELEASE};")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/" ${CMAKE_PREFIX_PATH})
