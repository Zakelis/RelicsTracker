
set(PNG_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/include")
set(PNG_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/include")
set(PNG_INCLUDES_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/include")
set(PNG_RES_DIRS_RELEASE )
set(PNG_DEFINITIONS_RELEASE )
set(PNG_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(PNG_COMPILE_DEFINITIONS_RELEASE )
set(PNG_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(PNG_COMPILE_OPTIONS_C_RELEASE "")
set(PNG_COMPILE_OPTIONS_CXX_RELEASE "")
set(PNG_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(PNG_LIBRARIES_RELEASE "") # Will be filled later
set(PNG_LIBS_RELEASE "") # Same as PNG_LIBRARIES
set(PNG_SYSTEM_LIBS_RELEASE )
set(PNG_FRAMEWORK_DIRS_RELEASE )
set(PNG_FRAMEWORKS_RELEASE )
set(PNG_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(PNG_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(PNG_FRAMEWORKS_FOUND_RELEASE "${PNG_FRAMEWORKS_RELEASE}" "${PNG_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(PNG_INCLUDE_DIRS_RELEASE
                 PNG_INCLUDE_DIR_RELEASE
                 PNG_INCLUDES_RELEASE
                 PNG_DEFINITIONS_RELEASE
                 PNG_LINKER_FLAGS_RELEASE_LIST
                 PNG_COMPILE_DEFINITIONS_RELEASE
                 PNG_COMPILE_OPTIONS_RELEASE_LIST
                 PNG_LIBRARIES_RELEASE
                 PNG_LIBS_RELEASE
                 PNG_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to PNG_LIBS and PNG_LIBRARY_LIST
set(PNG_LIBRARY_LIST_RELEASE libpng16)
set(PNG_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_PNG_DEPENDENCIES_RELEASE "${PNG_FRAMEWORKS_FOUND_RELEASE} ${PNG_SYSTEM_LIBS_RELEASE} ZLIB::ZLIB")

conan_package_library_targets("${PNG_LIBRARY_LIST_RELEASE}"  # libraries
                              "${PNG_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_PNG_DEPENDENCIES_RELEASE}"  # deps
                              PNG_LIBRARIES_RELEASE            # out_libraries
                              PNG_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "PNG")                                      # package_name

set(PNG_LIBS_RELEASE ${PNG_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${PNG_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND PNG_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND PNG_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${PNG_SYSTEM_LIBS_RELEASE})
    list(APPEND PNG_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND PNG_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(PNG_LIBRARIES_TARGETS_RELEASE "${PNG_LIBRARIES_TARGETS_RELEASE};ZLIB::ZLIB")
set(PNG_LIBRARIES_RELEASE "${PNG_LIBRARIES_RELEASE};ZLIB::ZLIB")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/" ${CMAKE_PREFIX_PATH})
