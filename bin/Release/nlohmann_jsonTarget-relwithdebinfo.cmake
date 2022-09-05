
set(nlohmann_json_INCLUDE_DIRS_RELWITHDEBINFO "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(nlohmann_json_INCLUDE_DIR_RELWITHDEBINFO "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(nlohmann_json_INCLUDES_RELWITHDEBINFO "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(nlohmann_json_RES_DIRS_RELWITHDEBINFO )
set(nlohmann_json_DEFINITIONS_RELWITHDEBINFO )
set(nlohmann_json_LINKER_FLAGS_RELWITHDEBINFO_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(nlohmann_json_COMPILE_DEFINITIONS_RELWITHDEBINFO )
set(nlohmann_json_COMPILE_OPTIONS_RELWITHDEBINFO_LIST "" "")
set(nlohmann_json_COMPILE_OPTIONS_C_RELWITHDEBINFO "")
set(nlohmann_json_COMPILE_OPTIONS_CXX_RELWITHDEBINFO "")
set(nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO "") # Will be filled later, if CMake 3
set(nlohmann_json_LIBRARIES_RELWITHDEBINFO "") # Will be filled later
set(nlohmann_json_LIBS_RELWITHDEBINFO "") # Same as nlohmann_json_LIBRARIES
set(nlohmann_json_SYSTEM_LIBS_RELWITHDEBINFO )
set(nlohmann_json_FRAMEWORK_DIRS_RELWITHDEBINFO )
set(nlohmann_json_FRAMEWORKS_RELWITHDEBINFO )
set(nlohmann_json_FRAMEWORKS_FOUND_RELWITHDEBINFO "") # Will be filled later
set(nlohmann_json_BUILD_MODULES_PATHS_RELWITHDEBINFO )

conan_find_apple_frameworks(nlohmann_json_FRAMEWORKS_FOUND_RELWITHDEBINFO "${nlohmann_json_FRAMEWORKS_RELWITHDEBINFO}" "${nlohmann_json_FRAMEWORK_DIRS_RELWITHDEBINFO}")

mark_as_advanced(nlohmann_json_INCLUDE_DIRS_RELWITHDEBINFO
                 nlohmann_json_INCLUDE_DIR_RELWITHDEBINFO
                 nlohmann_json_INCLUDES_RELWITHDEBINFO
                 nlohmann_json_DEFINITIONS_RELWITHDEBINFO
                 nlohmann_json_LINKER_FLAGS_RELWITHDEBINFO_LIST
                 nlohmann_json_COMPILE_DEFINITIONS_RELWITHDEBINFO
                 nlohmann_json_COMPILE_OPTIONS_RELWITHDEBINFO_LIST
                 nlohmann_json_LIBRARIES_RELWITHDEBINFO
                 nlohmann_json_LIBS_RELWITHDEBINFO
                 nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO)

# Find the real .lib/.a and add them to nlohmann_json_LIBS and nlohmann_json_LIBRARY_LIST
set(nlohmann_json_LIBRARY_LIST_RELWITHDEBINFO )
set(nlohmann_json_LIB_DIRS_RELWITHDEBINFO )

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_nlohmann_json_DEPENDENCIES_RELWITHDEBINFO "${nlohmann_json_FRAMEWORKS_FOUND_RELWITHDEBINFO} ${nlohmann_json_SYSTEM_LIBS_RELWITHDEBINFO} ")

conan_package_library_targets("${nlohmann_json_LIBRARY_LIST_RELWITHDEBINFO}"  # libraries
                              "${nlohmann_json_LIB_DIRS_RELWITHDEBINFO}"      # package_libdir
                              "${_nlohmann_json_DEPENDENCIES_RELWITHDEBINFO}"  # deps
                              nlohmann_json_LIBRARIES_RELWITHDEBINFO            # out_libraries
                              nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO    # out_libraries_targets
                              "_RELWITHDEBINFO"                          # build_type
                              "nlohmann_json")                                      # package_name

set(nlohmann_json_LIBS_RELWITHDEBINFO ${nlohmann_json_LIBRARIES_RELWITHDEBINFO})

foreach(_FRAMEWORK ${nlohmann_json_FRAMEWORKS_FOUND_RELWITHDEBINFO})
    list(APPEND nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO ${_FRAMEWORK})
    list(APPEND nlohmann_json_LIBRARIES_RELWITHDEBINFO ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${nlohmann_json_SYSTEM_LIBS_RELWITHDEBINFO})
    list(APPEND nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO ${_SYSTEM_LIB})
    list(APPEND nlohmann_json_LIBRARIES_RELWITHDEBINFO ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO "${nlohmann_json_LIBRARIES_TARGETS_RELWITHDEBINFO};")
set(nlohmann_json_LIBRARIES_RELWITHDEBINFO "${nlohmann_json_LIBRARIES_RELWITHDEBINFO};")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/" ${CMAKE_PREFIX_PATH})
