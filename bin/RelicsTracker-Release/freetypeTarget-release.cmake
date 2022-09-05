
set(Freetype_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2")
set(Freetype_INCLUDE_DIR_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include;C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2")
set(Freetype_INCLUDES_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2")
set(Freetype_RES_DIRS_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/res")
set(Freetype_DEFINITIONS_RELEASE )
set(Freetype_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(Freetype_COMPILE_DEFINITIONS_RELEASE )
set(Freetype_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(Freetype_COMPILE_OPTIONS_C_RELEASE "")
set(Freetype_COMPILE_OPTIONS_CXX_RELEASE "")
set(Freetype_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(Freetype_LIBRARIES_RELEASE "") # Will be filled later
set(Freetype_LIBS_RELEASE "") # Same as Freetype_LIBRARIES
set(Freetype_SYSTEM_LIBS_RELEASE )
set(Freetype_FRAMEWORK_DIRS_RELEASE )
set(Freetype_FRAMEWORKS_RELEASE )
set(Freetype_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(Freetype_BUILD_MODULES_PATHS_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake/conan-official-freetype-targets.cmake")

conan_find_apple_frameworks(Freetype_FRAMEWORKS_FOUND_RELEASE "${Freetype_FRAMEWORKS_RELEASE}" "${Freetype_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(Freetype_INCLUDE_DIRS_RELEASE
                 Freetype_INCLUDE_DIR_RELEASE
                 Freetype_INCLUDES_RELEASE
                 Freetype_DEFINITIONS_RELEASE
                 Freetype_LINKER_FLAGS_RELEASE_LIST
                 Freetype_COMPILE_DEFINITIONS_RELEASE
                 Freetype_COMPILE_OPTIONS_RELEASE_LIST
                 Freetype_LIBRARIES_RELEASE
                 Freetype_LIBS_RELEASE
                 Freetype_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to Freetype_LIBS and Freetype_LIBRARY_LIST
set(Freetype_LIBRARY_LIST_RELEASE freetype)
set(Freetype_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_Freetype_DEPENDENCIES_RELEASE "${Freetype_FRAMEWORKS_FOUND_RELEASE} ${Freetype_SYSTEM_LIBS_RELEASE} PNG::PNG;ZLIB::ZLIB;BZip2::BZip2;Brotli::Brotli")

conan_package_library_targets("${Freetype_LIBRARY_LIST_RELEASE}"  # libraries
                              "${Freetype_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_Freetype_DEPENDENCIES_RELEASE}"  # deps
                              Freetype_LIBRARIES_RELEASE            # out_libraries
                              Freetype_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "Freetype")                                      # package_name

set(Freetype_LIBS_RELEASE ${Freetype_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${Freetype_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND Freetype_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND Freetype_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${Freetype_SYSTEM_LIBS_RELEASE})
    list(APPEND Freetype_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND Freetype_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(Freetype_LIBRARIES_TARGETS_RELEASE "${Freetype_LIBRARIES_TARGETS_RELEASE};PNG::PNG;ZLIB::ZLIB;BZip2::BZip2;Brotli::Brotli")
set(Freetype_LIBRARIES_RELEASE "${Freetype_LIBRARIES_RELEASE};PNG::PNG;ZLIB::ZLIB;BZip2::BZip2;Brotli::Brotli")

set(CMAKE_MODULE_PATH "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake" ${CMAKE_PREFIX_PATH})
