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


set(Boost_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_RES_DIRS_RELEASE )
set(Boost_DEFINITIONS_RELEASE "-DBOOST_STACKTRACE_USE_NOOP"
			"-DBOOST_STACKTRACE_USE_WINDBG"
			"-DBOOST_STACKTRACE_USE_WINDBG_CACHED"
			"-DBOOST_ALL_NO_LIB")
set(Boost_LINKER_FLAGS_RELEASE_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(Boost_COMPILE_DEFINITIONS_RELEASE "BOOST_STACKTRACE_USE_NOOP"
			"BOOST_STACKTRACE_USE_WINDBG"
			"BOOST_STACKTRACE_USE_WINDBG_CACHED"
			"BOOST_ALL_NO_LIB")
set(Boost_COMPILE_OPTIONS_RELEASE_LIST "" "")
set(Boost_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_LIBRARIES_TARGETS_RELEASE "") # Will be filled later, if CMake 3
set(Boost_LIBRARIES_RELEASE "") # Will be filled later
set(Boost_LIBS_RELEASE "") # Same as Boost_LIBRARIES
set(Boost_SYSTEM_LIBS_RELEASE ole32 dbgeng bcrypt)
set(Boost_FRAMEWORK_DIRS_RELEASE )
set(Boost_FRAMEWORKS_RELEASE )
set(Boost_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
set(Boost_BUILD_MODULES_PATHS_RELEASE )

conan_find_apple_frameworks(Boost_FRAMEWORKS_FOUND_RELEASE "${Boost_FRAMEWORKS_RELEASE}" "${Boost_FRAMEWORK_DIRS_RELEASE}")

mark_as_advanced(Boost_INCLUDE_DIRS_RELEASE
                 Boost_INCLUDE_DIR_RELEASE
                 Boost_INCLUDES_RELEASE
                 Boost_DEFINITIONS_RELEASE
                 Boost_LINKER_FLAGS_RELEASE_LIST
                 Boost_COMPILE_DEFINITIONS_RELEASE
                 Boost_COMPILE_OPTIONS_RELEASE_LIST
                 Boost_LIBRARIES_RELEASE
                 Boost_LIBS_RELEASE
                 Boost_LIBRARIES_TARGETS_RELEASE)

# Find the real .lib/.a and add them to Boost_LIBS and Boost_LIBRARY_LIST
set(Boost_LIBRARY_LIST_RELEASE libboost_contract libboost_coroutine libboost_fiber_numa libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_json libboost_locale libboost_log_setup libboost_log libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_atomic libboost_wserialization libboost_serialization)
set(Boost_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_Boost_DEPENDENCIES_RELEASE "${Boost_FRAMEWORKS_FOUND_RELEASE} ${Boost_SYSTEM_LIBS_RELEASE} BZip2::BZip2;ZLIB::ZLIB")

conan_package_library_targets("${Boost_LIBRARY_LIST_RELEASE}"  # libraries
                              "${Boost_LIB_DIRS_RELEASE}"      # package_libdir
                              "${_Boost_DEPENDENCIES_RELEASE}"  # deps
                              Boost_LIBRARIES_RELEASE            # out_libraries
                              Boost_LIBRARIES_TARGETS_RELEASE    # out_libraries_targets
                              "_RELEASE"                          # build_type
                              "Boost")                                      # package_name

set(Boost_LIBS_RELEASE ${Boost_LIBRARIES_RELEASE})

foreach(_FRAMEWORK ${Boost_FRAMEWORKS_FOUND_RELEASE})
    list(APPEND Boost_LIBRARIES_TARGETS_RELEASE ${_FRAMEWORK})
    list(APPEND Boost_LIBRARIES_RELEASE ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${Boost_SYSTEM_LIBS_RELEASE})
    list(APPEND Boost_LIBRARIES_TARGETS_RELEASE ${_SYSTEM_LIB})
    list(APPEND Boost_LIBRARIES_RELEASE ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(Boost_LIBRARIES_TARGETS_RELEASE "${Boost_LIBRARIES_TARGETS_RELEASE};BZip2::BZip2;ZLIB::ZLIB")
set(Boost_LIBRARIES_RELEASE "${Boost_LIBRARIES_RELEASE};BZip2::BZip2;ZLIB::ZLIB")

set(CMAKE_MODULE_PATH "C:/.conan/10a1cc/1/" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "C:/.conan/10a1cc/1/" ${CMAKE_PREFIX_PATH})

set(Boost_COMPONENTS_RELEASE Boost::boost Boost::contract Boost::coroutine Boost::fiber_numa Boost::fiber Boost::context Boost::graph Boost::iostreams Boost::json Boost::locale Boost::log_setup Boost::log Boost::math_c99 Boost::math_c99f Boost::math_c99l Boost::math_tr1 Boost::math_tr1f Boost::math_tr1l Boost::math Boost::nowide Boost::program_options Boost::random Boost::regex Boost::stacktrace_noop Boost::stacktrace_windbg Boost::stacktrace_windbg_cached Boost::stacktrace Boost::timer Boost::type_erasure Boost::thread Boost::chrono Boost::container Boost::date_time Boost::unit_test_framework Boost::prg_exec_monitor Boost::test_exec_monitor Boost::test Boost::exception Boost::wave Boost::filesystem Boost::atomic Boost::system Boost::wserialization Boost::serialization Boost::_libboost Boost::headers Boost::diagnostic_definitions Boost::disable_autolinking Boost::dynamic_linking)

########### COMPONENT dynamic_linking VARIABLES #############################################

set(Boost_dynamic_linking_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_dynamic_linking_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_dynamic_linking_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_dynamic_linking_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_dynamic_linking_RES_DIRS_RELEASE )
set(Boost_dynamic_linking_DEFINITIONS_RELEASE )
set(Boost_dynamic_linking_COMPILE_DEFINITIONS_RELEASE )
set(Boost_dynamic_linking_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_dynamic_linking_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_dynamic_linking_LIBS_RELEASE )
set(Boost_dynamic_linking_SYSTEM_LIBS_RELEASE )
set(Boost_dynamic_linking_FRAMEWORK_DIRS_RELEASE )
set(Boost_dynamic_linking_FRAMEWORKS_RELEASE )
set(Boost_dynamic_linking_BUILD_MODULES_PATHS_RELEASE )
set(Boost_dynamic_linking_DEPENDENCIES_RELEASE )
set(Boost_dynamic_linking_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT dynamic_linking FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_dynamic_linking_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_dynamic_linking_FRAMEWORKS_FOUND_RELEASE "${Boost_dynamic_linking_FRAMEWORKS_RELEASE}" "${Boost_dynamic_linking_FRAMEWORK_DIRS_RELEASE}")

set(Boost_dynamic_linking_LIB_TARGETS_RELEASE "")
set(Boost_dynamic_linking_NOT_USED_RELEASE "")
set(Boost_dynamic_linking_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_dynamic_linking_FRAMEWORKS_FOUND_RELEASE} ${Boost_dynamic_linking_SYSTEM_LIBS_RELEASE} ${Boost_dynamic_linking_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_dynamic_linking_LIBS_RELEASE}"
                              "${Boost_dynamic_linking_LIB_DIRS_RELEASE}"
                              "${Boost_dynamic_linking_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_dynamic_linking_NOT_USED_RELEASE
                              Boost_dynamic_linking_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_dynamic_linking")

set(Boost_dynamic_linking_LINK_LIBS_RELEASE ${Boost_dynamic_linking_LIB_TARGETS_RELEASE} ${Boost_dynamic_linking_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT disable_autolinking VARIABLES #############################################

set(Boost_disable_autolinking_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_disable_autolinking_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_disable_autolinking_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_disable_autolinking_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_disable_autolinking_RES_DIRS_RELEASE )
set(Boost_disable_autolinking_DEFINITIONS_RELEASE "-DBOOST_ALL_NO_LIB")
set(Boost_disable_autolinking_COMPILE_DEFINITIONS_RELEASE "BOOST_ALL_NO_LIB")
set(Boost_disable_autolinking_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_disable_autolinking_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_disable_autolinking_LIBS_RELEASE )
set(Boost_disable_autolinking_SYSTEM_LIBS_RELEASE )
set(Boost_disable_autolinking_FRAMEWORK_DIRS_RELEASE )
set(Boost_disable_autolinking_FRAMEWORKS_RELEASE )
set(Boost_disable_autolinking_BUILD_MODULES_PATHS_RELEASE )
set(Boost_disable_autolinking_DEPENDENCIES_RELEASE )
set(Boost_disable_autolinking_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT disable_autolinking FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_disable_autolinking_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_disable_autolinking_FRAMEWORKS_FOUND_RELEASE "${Boost_disable_autolinking_FRAMEWORKS_RELEASE}" "${Boost_disable_autolinking_FRAMEWORK_DIRS_RELEASE}")

set(Boost_disable_autolinking_LIB_TARGETS_RELEASE "")
set(Boost_disable_autolinking_NOT_USED_RELEASE "")
set(Boost_disable_autolinking_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_disable_autolinking_FRAMEWORKS_FOUND_RELEASE} ${Boost_disable_autolinking_SYSTEM_LIBS_RELEASE} ${Boost_disable_autolinking_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_disable_autolinking_LIBS_RELEASE}"
                              "${Boost_disable_autolinking_LIB_DIRS_RELEASE}"
                              "${Boost_disable_autolinking_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_disable_autolinking_NOT_USED_RELEASE
                              Boost_disable_autolinking_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_disable_autolinking")

set(Boost_disable_autolinking_LINK_LIBS_RELEASE ${Boost_disable_autolinking_LIB_TARGETS_RELEASE} ${Boost_disable_autolinking_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT diagnostic_definitions VARIABLES #############################################

set(Boost_diagnostic_definitions_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_diagnostic_definitions_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_diagnostic_definitions_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_diagnostic_definitions_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_diagnostic_definitions_RES_DIRS_RELEASE )
set(Boost_diagnostic_definitions_DEFINITIONS_RELEASE )
set(Boost_diagnostic_definitions_COMPILE_DEFINITIONS_RELEASE )
set(Boost_diagnostic_definitions_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_diagnostic_definitions_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_diagnostic_definitions_LIBS_RELEASE )
set(Boost_diagnostic_definitions_SYSTEM_LIBS_RELEASE )
set(Boost_diagnostic_definitions_FRAMEWORK_DIRS_RELEASE )
set(Boost_diagnostic_definitions_FRAMEWORKS_RELEASE )
set(Boost_diagnostic_definitions_BUILD_MODULES_PATHS_RELEASE )
set(Boost_diagnostic_definitions_DEPENDENCIES_RELEASE )
set(Boost_diagnostic_definitions_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT diagnostic_definitions FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_diagnostic_definitions_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_diagnostic_definitions_FRAMEWORKS_FOUND_RELEASE "${Boost_diagnostic_definitions_FRAMEWORKS_RELEASE}" "${Boost_diagnostic_definitions_FRAMEWORK_DIRS_RELEASE}")

set(Boost_diagnostic_definitions_LIB_TARGETS_RELEASE "")
set(Boost_diagnostic_definitions_NOT_USED_RELEASE "")
set(Boost_diagnostic_definitions_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_diagnostic_definitions_FRAMEWORKS_FOUND_RELEASE} ${Boost_diagnostic_definitions_SYSTEM_LIBS_RELEASE} ${Boost_diagnostic_definitions_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_diagnostic_definitions_LIBS_RELEASE}"
                              "${Boost_diagnostic_definitions_LIB_DIRS_RELEASE}"
                              "${Boost_diagnostic_definitions_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_diagnostic_definitions_NOT_USED_RELEASE
                              Boost_diagnostic_definitions_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_diagnostic_definitions")

set(Boost_diagnostic_definitions_LINK_LIBS_RELEASE ${Boost_diagnostic_definitions_LIB_TARGETS_RELEASE} ${Boost_diagnostic_definitions_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT headers VARIABLES #############################################

set(Boost_headers_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_headers_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_headers_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_headers_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_headers_RES_DIRS_RELEASE )
set(Boost_headers_DEFINITIONS_RELEASE )
set(Boost_headers_COMPILE_DEFINITIONS_RELEASE )
set(Boost_headers_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_headers_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_headers_LIBS_RELEASE )
set(Boost_headers_SYSTEM_LIBS_RELEASE )
set(Boost_headers_FRAMEWORK_DIRS_RELEASE )
set(Boost_headers_FRAMEWORKS_RELEASE )
set(Boost_headers_BUILD_MODULES_PATHS_RELEASE )
set(Boost_headers_DEPENDENCIES_RELEASE Boost::diagnostic_definitions Boost::disable_autolinking Boost::dynamic_linking)
set(Boost_headers_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT headers FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_headers_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_headers_FRAMEWORKS_FOUND_RELEASE "${Boost_headers_FRAMEWORKS_RELEASE}" "${Boost_headers_FRAMEWORK_DIRS_RELEASE}")

set(Boost_headers_LIB_TARGETS_RELEASE "")
set(Boost_headers_NOT_USED_RELEASE "")
set(Boost_headers_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_headers_FRAMEWORKS_FOUND_RELEASE} ${Boost_headers_SYSTEM_LIBS_RELEASE} ${Boost_headers_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_headers_LIBS_RELEASE}"
                              "${Boost_headers_LIB_DIRS_RELEASE}"
                              "${Boost_headers_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_headers_NOT_USED_RELEASE
                              Boost_headers_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_headers")

set(Boost_headers_LINK_LIBS_RELEASE ${Boost_headers_LIB_TARGETS_RELEASE} ${Boost_headers_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT _libboost VARIABLES #############################################

set(Boost__libboost_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost__libboost_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost__libboost_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost__libboost_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost__libboost_RES_DIRS_RELEASE )
set(Boost__libboost_DEFINITIONS_RELEASE )
set(Boost__libboost_COMPILE_DEFINITIONS_RELEASE )
set(Boost__libboost_COMPILE_OPTIONS_C_RELEASE "")
set(Boost__libboost_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost__libboost_LIBS_RELEASE )
set(Boost__libboost_SYSTEM_LIBS_RELEASE bcrypt)
set(Boost__libboost_FRAMEWORK_DIRS_RELEASE )
set(Boost__libboost_FRAMEWORKS_RELEASE )
set(Boost__libboost_BUILD_MODULES_PATHS_RELEASE )
set(Boost__libboost_DEPENDENCIES_RELEASE Boost::headers)
set(Boost__libboost_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT _libboost FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost__libboost_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost__libboost_FRAMEWORKS_FOUND_RELEASE "${Boost__libboost_FRAMEWORKS_RELEASE}" "${Boost__libboost_FRAMEWORK_DIRS_RELEASE}")

set(Boost__libboost_LIB_TARGETS_RELEASE "")
set(Boost__libboost_NOT_USED_RELEASE "")
set(Boost__libboost_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost__libboost_FRAMEWORKS_FOUND_RELEASE} ${Boost__libboost_SYSTEM_LIBS_RELEASE} ${Boost__libboost_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost__libboost_LIBS_RELEASE}"
                              "${Boost__libboost_LIB_DIRS_RELEASE}"
                              "${Boost__libboost_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost__libboost_NOT_USED_RELEASE
                              Boost__libboost_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost__libboost")

set(Boost__libboost_LINK_LIBS_RELEASE ${Boost__libboost_LIB_TARGETS_RELEASE} ${Boost__libboost_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT serialization VARIABLES #############################################

set(Boost_serialization_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_serialization_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_serialization_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_serialization_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_serialization_RES_DIRS_RELEASE )
set(Boost_serialization_DEFINITIONS_RELEASE )
set(Boost_serialization_COMPILE_DEFINITIONS_RELEASE )
set(Boost_serialization_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_serialization_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_serialization_LIBS_RELEASE libboost_serialization)
set(Boost_serialization_SYSTEM_LIBS_RELEASE )
set(Boost_serialization_FRAMEWORK_DIRS_RELEASE )
set(Boost_serialization_FRAMEWORKS_RELEASE )
set(Boost_serialization_BUILD_MODULES_PATHS_RELEASE )
set(Boost_serialization_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_serialization_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT serialization FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_serialization_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_serialization_FRAMEWORKS_FOUND_RELEASE "${Boost_serialization_FRAMEWORKS_RELEASE}" "${Boost_serialization_FRAMEWORK_DIRS_RELEASE}")

set(Boost_serialization_LIB_TARGETS_RELEASE "")
set(Boost_serialization_NOT_USED_RELEASE "")
set(Boost_serialization_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_serialization_FRAMEWORKS_FOUND_RELEASE} ${Boost_serialization_SYSTEM_LIBS_RELEASE} ${Boost_serialization_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_serialization_LIBS_RELEASE}"
                              "${Boost_serialization_LIB_DIRS_RELEASE}"
                              "${Boost_serialization_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_serialization_NOT_USED_RELEASE
                              Boost_serialization_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_serialization")

set(Boost_serialization_LINK_LIBS_RELEASE ${Boost_serialization_LIB_TARGETS_RELEASE} ${Boost_serialization_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT wserialization VARIABLES #############################################

set(Boost_wserialization_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wserialization_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wserialization_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wserialization_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_wserialization_RES_DIRS_RELEASE )
set(Boost_wserialization_DEFINITIONS_RELEASE )
set(Boost_wserialization_COMPILE_DEFINITIONS_RELEASE )
set(Boost_wserialization_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_wserialization_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_wserialization_LIBS_RELEASE libboost_wserialization)
set(Boost_wserialization_SYSTEM_LIBS_RELEASE )
set(Boost_wserialization_FRAMEWORK_DIRS_RELEASE )
set(Boost_wserialization_FRAMEWORKS_RELEASE )
set(Boost_wserialization_BUILD_MODULES_PATHS_RELEASE )
set(Boost_wserialization_DEPENDENCIES_RELEASE Boost::serialization Boost::_libboost)
set(Boost_wserialization_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT wserialization FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_wserialization_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_wserialization_FRAMEWORKS_FOUND_RELEASE "${Boost_wserialization_FRAMEWORKS_RELEASE}" "${Boost_wserialization_FRAMEWORK_DIRS_RELEASE}")

set(Boost_wserialization_LIB_TARGETS_RELEASE "")
set(Boost_wserialization_NOT_USED_RELEASE "")
set(Boost_wserialization_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_wserialization_FRAMEWORKS_FOUND_RELEASE} ${Boost_wserialization_SYSTEM_LIBS_RELEASE} ${Boost_wserialization_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_wserialization_LIBS_RELEASE}"
                              "${Boost_wserialization_LIB_DIRS_RELEASE}"
                              "${Boost_wserialization_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_wserialization_NOT_USED_RELEASE
                              Boost_wserialization_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_wserialization")

set(Boost_wserialization_LINK_LIBS_RELEASE ${Boost_wserialization_LIB_TARGETS_RELEASE} ${Boost_wserialization_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT system VARIABLES #############################################

set(Boost_system_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_system_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_system_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_system_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_system_RES_DIRS_RELEASE )
set(Boost_system_DEFINITIONS_RELEASE )
set(Boost_system_COMPILE_DEFINITIONS_RELEASE )
set(Boost_system_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_system_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_system_LIBS_RELEASE )
set(Boost_system_SYSTEM_LIBS_RELEASE )
set(Boost_system_FRAMEWORK_DIRS_RELEASE )
set(Boost_system_FRAMEWORKS_RELEASE )
set(Boost_system_BUILD_MODULES_PATHS_RELEASE )
set(Boost_system_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_system_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT system FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_system_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_system_FRAMEWORKS_FOUND_RELEASE "${Boost_system_FRAMEWORKS_RELEASE}" "${Boost_system_FRAMEWORK_DIRS_RELEASE}")

set(Boost_system_LIB_TARGETS_RELEASE "")
set(Boost_system_NOT_USED_RELEASE "")
set(Boost_system_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_system_FRAMEWORKS_FOUND_RELEASE} ${Boost_system_SYSTEM_LIBS_RELEASE} ${Boost_system_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_system_LIBS_RELEASE}"
                              "${Boost_system_LIB_DIRS_RELEASE}"
                              "${Boost_system_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_system_NOT_USED_RELEASE
                              Boost_system_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_system")

set(Boost_system_LINK_LIBS_RELEASE ${Boost_system_LIB_TARGETS_RELEASE} ${Boost_system_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT atomic VARIABLES #############################################

set(Boost_atomic_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_atomic_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_atomic_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_atomic_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_atomic_RES_DIRS_RELEASE )
set(Boost_atomic_DEFINITIONS_RELEASE )
set(Boost_atomic_COMPILE_DEFINITIONS_RELEASE )
set(Boost_atomic_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_atomic_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_atomic_LIBS_RELEASE libboost_atomic)
set(Boost_atomic_SYSTEM_LIBS_RELEASE )
set(Boost_atomic_FRAMEWORK_DIRS_RELEASE )
set(Boost_atomic_FRAMEWORKS_RELEASE )
set(Boost_atomic_BUILD_MODULES_PATHS_RELEASE )
set(Boost_atomic_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_atomic_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT atomic FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_atomic_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_atomic_FRAMEWORKS_FOUND_RELEASE "${Boost_atomic_FRAMEWORKS_RELEASE}" "${Boost_atomic_FRAMEWORK_DIRS_RELEASE}")

set(Boost_atomic_LIB_TARGETS_RELEASE "")
set(Boost_atomic_NOT_USED_RELEASE "")
set(Boost_atomic_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_atomic_FRAMEWORKS_FOUND_RELEASE} ${Boost_atomic_SYSTEM_LIBS_RELEASE} ${Boost_atomic_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_atomic_LIBS_RELEASE}"
                              "${Boost_atomic_LIB_DIRS_RELEASE}"
                              "${Boost_atomic_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_atomic_NOT_USED_RELEASE
                              Boost_atomic_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_atomic")

set(Boost_atomic_LINK_LIBS_RELEASE ${Boost_atomic_LIB_TARGETS_RELEASE} ${Boost_atomic_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT filesystem VARIABLES #############################################

set(Boost_filesystem_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_filesystem_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_filesystem_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_filesystem_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_filesystem_RES_DIRS_RELEASE )
set(Boost_filesystem_DEFINITIONS_RELEASE )
set(Boost_filesystem_COMPILE_DEFINITIONS_RELEASE )
set(Boost_filesystem_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_filesystem_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_filesystem_LIBS_RELEASE libboost_filesystem)
set(Boost_filesystem_SYSTEM_LIBS_RELEASE )
set(Boost_filesystem_FRAMEWORK_DIRS_RELEASE )
set(Boost_filesystem_FRAMEWORKS_RELEASE )
set(Boost_filesystem_BUILD_MODULES_PATHS_RELEASE )
set(Boost_filesystem_DEPENDENCIES_RELEASE Boost::atomic Boost::system Boost::_libboost)
set(Boost_filesystem_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT filesystem FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_filesystem_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_filesystem_FRAMEWORKS_FOUND_RELEASE "${Boost_filesystem_FRAMEWORKS_RELEASE}" "${Boost_filesystem_FRAMEWORK_DIRS_RELEASE}")

set(Boost_filesystem_LIB_TARGETS_RELEASE "")
set(Boost_filesystem_NOT_USED_RELEASE "")
set(Boost_filesystem_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_filesystem_FRAMEWORKS_FOUND_RELEASE} ${Boost_filesystem_SYSTEM_LIBS_RELEASE} ${Boost_filesystem_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_filesystem_LIBS_RELEASE}"
                              "${Boost_filesystem_LIB_DIRS_RELEASE}"
                              "${Boost_filesystem_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_filesystem_NOT_USED_RELEASE
                              Boost_filesystem_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_filesystem")

set(Boost_filesystem_LINK_LIBS_RELEASE ${Boost_filesystem_LIB_TARGETS_RELEASE} ${Boost_filesystem_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT wave VARIABLES #############################################

set(Boost_wave_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wave_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wave_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_wave_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_wave_RES_DIRS_RELEASE )
set(Boost_wave_DEFINITIONS_RELEASE )
set(Boost_wave_COMPILE_DEFINITIONS_RELEASE )
set(Boost_wave_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_wave_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_wave_LIBS_RELEASE libboost_wave)
set(Boost_wave_SYSTEM_LIBS_RELEASE )
set(Boost_wave_FRAMEWORK_DIRS_RELEASE )
set(Boost_wave_FRAMEWORKS_RELEASE )
set(Boost_wave_BUILD_MODULES_PATHS_RELEASE )
set(Boost_wave_DEPENDENCIES_RELEASE Boost::filesystem Boost::serialization Boost::_libboost)
set(Boost_wave_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT wave FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_wave_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_wave_FRAMEWORKS_FOUND_RELEASE "${Boost_wave_FRAMEWORKS_RELEASE}" "${Boost_wave_FRAMEWORK_DIRS_RELEASE}")

set(Boost_wave_LIB_TARGETS_RELEASE "")
set(Boost_wave_NOT_USED_RELEASE "")
set(Boost_wave_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_wave_FRAMEWORKS_FOUND_RELEASE} ${Boost_wave_SYSTEM_LIBS_RELEASE} ${Boost_wave_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_wave_LIBS_RELEASE}"
                              "${Boost_wave_LIB_DIRS_RELEASE}"
                              "${Boost_wave_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_wave_NOT_USED_RELEASE
                              Boost_wave_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_wave")

set(Boost_wave_LINK_LIBS_RELEASE ${Boost_wave_LIB_TARGETS_RELEASE} ${Boost_wave_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT exception VARIABLES #############################################

set(Boost_exception_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_exception_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_exception_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_exception_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_exception_RES_DIRS_RELEASE )
set(Boost_exception_DEFINITIONS_RELEASE )
set(Boost_exception_COMPILE_DEFINITIONS_RELEASE )
set(Boost_exception_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_exception_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_exception_LIBS_RELEASE libboost_exception)
set(Boost_exception_SYSTEM_LIBS_RELEASE )
set(Boost_exception_FRAMEWORK_DIRS_RELEASE )
set(Boost_exception_FRAMEWORKS_RELEASE )
set(Boost_exception_BUILD_MODULES_PATHS_RELEASE )
set(Boost_exception_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_exception_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT exception FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_exception_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_exception_FRAMEWORKS_FOUND_RELEASE "${Boost_exception_FRAMEWORKS_RELEASE}" "${Boost_exception_FRAMEWORK_DIRS_RELEASE}")

set(Boost_exception_LIB_TARGETS_RELEASE "")
set(Boost_exception_NOT_USED_RELEASE "")
set(Boost_exception_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_exception_FRAMEWORKS_FOUND_RELEASE} ${Boost_exception_SYSTEM_LIBS_RELEASE} ${Boost_exception_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_exception_LIBS_RELEASE}"
                              "${Boost_exception_LIB_DIRS_RELEASE}"
                              "${Boost_exception_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_exception_NOT_USED_RELEASE
                              Boost_exception_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_exception")

set(Boost_exception_LINK_LIBS_RELEASE ${Boost_exception_LIB_TARGETS_RELEASE} ${Boost_exception_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT test VARIABLES #############################################

set(Boost_test_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_test_RES_DIRS_RELEASE )
set(Boost_test_DEFINITIONS_RELEASE )
set(Boost_test_COMPILE_DEFINITIONS_RELEASE )
set(Boost_test_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_test_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_test_LIBS_RELEASE )
set(Boost_test_SYSTEM_LIBS_RELEASE )
set(Boost_test_FRAMEWORK_DIRS_RELEASE )
set(Boost_test_FRAMEWORKS_RELEASE )
set(Boost_test_BUILD_MODULES_PATHS_RELEASE )
set(Boost_test_DEPENDENCIES_RELEASE Boost::exception Boost::_libboost)
set(Boost_test_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT test FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_test_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_test_FRAMEWORKS_FOUND_RELEASE "${Boost_test_FRAMEWORKS_RELEASE}" "${Boost_test_FRAMEWORK_DIRS_RELEASE}")

set(Boost_test_LIB_TARGETS_RELEASE "")
set(Boost_test_NOT_USED_RELEASE "")
set(Boost_test_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_test_FRAMEWORKS_FOUND_RELEASE} ${Boost_test_SYSTEM_LIBS_RELEASE} ${Boost_test_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_test_LIBS_RELEASE}"
                              "${Boost_test_LIB_DIRS_RELEASE}"
                              "${Boost_test_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_test_NOT_USED_RELEASE
                              Boost_test_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_test")

set(Boost_test_LINK_LIBS_RELEASE ${Boost_test_LIB_TARGETS_RELEASE} ${Boost_test_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT test_exec_monitor VARIABLES #############################################

set(Boost_test_exec_monitor_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_exec_monitor_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_exec_monitor_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_test_exec_monitor_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_test_exec_monitor_RES_DIRS_RELEASE )
set(Boost_test_exec_monitor_DEFINITIONS_RELEASE )
set(Boost_test_exec_monitor_COMPILE_DEFINITIONS_RELEASE )
set(Boost_test_exec_monitor_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_test_exec_monitor_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_test_exec_monitor_LIBS_RELEASE libboost_test_exec_monitor)
set(Boost_test_exec_monitor_SYSTEM_LIBS_RELEASE )
set(Boost_test_exec_monitor_FRAMEWORK_DIRS_RELEASE )
set(Boost_test_exec_monitor_FRAMEWORKS_RELEASE )
set(Boost_test_exec_monitor_BUILD_MODULES_PATHS_RELEASE )
set(Boost_test_exec_monitor_DEPENDENCIES_RELEASE Boost::test Boost::_libboost)
set(Boost_test_exec_monitor_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT test_exec_monitor FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_test_exec_monitor_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_test_exec_monitor_FRAMEWORKS_FOUND_RELEASE "${Boost_test_exec_monitor_FRAMEWORKS_RELEASE}" "${Boost_test_exec_monitor_FRAMEWORK_DIRS_RELEASE}")

set(Boost_test_exec_monitor_LIB_TARGETS_RELEASE "")
set(Boost_test_exec_monitor_NOT_USED_RELEASE "")
set(Boost_test_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_test_exec_monitor_FRAMEWORKS_FOUND_RELEASE} ${Boost_test_exec_monitor_SYSTEM_LIBS_RELEASE} ${Boost_test_exec_monitor_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_test_exec_monitor_LIBS_RELEASE}"
                              "${Boost_test_exec_monitor_LIB_DIRS_RELEASE}"
                              "${Boost_test_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_test_exec_monitor_NOT_USED_RELEASE
                              Boost_test_exec_monitor_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_test_exec_monitor")

set(Boost_test_exec_monitor_LINK_LIBS_RELEASE ${Boost_test_exec_monitor_LIB_TARGETS_RELEASE} ${Boost_test_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT prg_exec_monitor VARIABLES #############################################

set(Boost_prg_exec_monitor_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_prg_exec_monitor_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_prg_exec_monitor_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_prg_exec_monitor_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_prg_exec_monitor_RES_DIRS_RELEASE )
set(Boost_prg_exec_monitor_DEFINITIONS_RELEASE )
set(Boost_prg_exec_monitor_COMPILE_DEFINITIONS_RELEASE )
set(Boost_prg_exec_monitor_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_prg_exec_monitor_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_prg_exec_monitor_LIBS_RELEASE libboost_prg_exec_monitor)
set(Boost_prg_exec_monitor_SYSTEM_LIBS_RELEASE )
set(Boost_prg_exec_monitor_FRAMEWORK_DIRS_RELEASE )
set(Boost_prg_exec_monitor_FRAMEWORKS_RELEASE )
set(Boost_prg_exec_monitor_BUILD_MODULES_PATHS_RELEASE )
set(Boost_prg_exec_monitor_DEPENDENCIES_RELEASE Boost::test Boost::_libboost)
set(Boost_prg_exec_monitor_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT prg_exec_monitor FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_prg_exec_monitor_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_prg_exec_monitor_FRAMEWORKS_FOUND_RELEASE "${Boost_prg_exec_monitor_FRAMEWORKS_RELEASE}" "${Boost_prg_exec_monitor_FRAMEWORK_DIRS_RELEASE}")

set(Boost_prg_exec_monitor_LIB_TARGETS_RELEASE "")
set(Boost_prg_exec_monitor_NOT_USED_RELEASE "")
set(Boost_prg_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_prg_exec_monitor_FRAMEWORKS_FOUND_RELEASE} ${Boost_prg_exec_monitor_SYSTEM_LIBS_RELEASE} ${Boost_prg_exec_monitor_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_prg_exec_monitor_LIBS_RELEASE}"
                              "${Boost_prg_exec_monitor_LIB_DIRS_RELEASE}"
                              "${Boost_prg_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_prg_exec_monitor_NOT_USED_RELEASE
                              Boost_prg_exec_monitor_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_prg_exec_monitor")

set(Boost_prg_exec_monitor_LINK_LIBS_RELEASE ${Boost_prg_exec_monitor_LIB_TARGETS_RELEASE} ${Boost_prg_exec_monitor_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT unit_test_framework VARIABLES #############################################

set(Boost_unit_test_framework_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_unit_test_framework_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_unit_test_framework_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_unit_test_framework_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_unit_test_framework_RES_DIRS_RELEASE )
set(Boost_unit_test_framework_DEFINITIONS_RELEASE )
set(Boost_unit_test_framework_COMPILE_DEFINITIONS_RELEASE )
set(Boost_unit_test_framework_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_unit_test_framework_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_unit_test_framework_LIBS_RELEASE libboost_unit_test_framework)
set(Boost_unit_test_framework_SYSTEM_LIBS_RELEASE )
set(Boost_unit_test_framework_FRAMEWORK_DIRS_RELEASE )
set(Boost_unit_test_framework_FRAMEWORKS_RELEASE )
set(Boost_unit_test_framework_BUILD_MODULES_PATHS_RELEASE )
set(Boost_unit_test_framework_DEPENDENCIES_RELEASE Boost::prg_exec_monitor Boost::test Boost::test_exec_monitor Boost::_libboost)
set(Boost_unit_test_framework_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT unit_test_framework FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_unit_test_framework_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_unit_test_framework_FRAMEWORKS_FOUND_RELEASE "${Boost_unit_test_framework_FRAMEWORKS_RELEASE}" "${Boost_unit_test_framework_FRAMEWORK_DIRS_RELEASE}")

set(Boost_unit_test_framework_LIB_TARGETS_RELEASE "")
set(Boost_unit_test_framework_NOT_USED_RELEASE "")
set(Boost_unit_test_framework_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_unit_test_framework_FRAMEWORKS_FOUND_RELEASE} ${Boost_unit_test_framework_SYSTEM_LIBS_RELEASE} ${Boost_unit_test_framework_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_unit_test_framework_LIBS_RELEASE}"
                              "${Boost_unit_test_framework_LIB_DIRS_RELEASE}"
                              "${Boost_unit_test_framework_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_unit_test_framework_NOT_USED_RELEASE
                              Boost_unit_test_framework_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_unit_test_framework")

set(Boost_unit_test_framework_LINK_LIBS_RELEASE ${Boost_unit_test_framework_LIB_TARGETS_RELEASE} ${Boost_unit_test_framework_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT date_time VARIABLES #############################################

set(Boost_date_time_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_date_time_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_date_time_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_date_time_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_date_time_RES_DIRS_RELEASE )
set(Boost_date_time_DEFINITIONS_RELEASE )
set(Boost_date_time_COMPILE_DEFINITIONS_RELEASE )
set(Boost_date_time_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_date_time_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_date_time_LIBS_RELEASE libboost_date_time)
set(Boost_date_time_SYSTEM_LIBS_RELEASE )
set(Boost_date_time_FRAMEWORK_DIRS_RELEASE )
set(Boost_date_time_FRAMEWORKS_RELEASE )
set(Boost_date_time_BUILD_MODULES_PATHS_RELEASE )
set(Boost_date_time_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_date_time_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT date_time FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_date_time_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_date_time_FRAMEWORKS_FOUND_RELEASE "${Boost_date_time_FRAMEWORKS_RELEASE}" "${Boost_date_time_FRAMEWORK_DIRS_RELEASE}")

set(Boost_date_time_LIB_TARGETS_RELEASE "")
set(Boost_date_time_NOT_USED_RELEASE "")
set(Boost_date_time_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_date_time_FRAMEWORKS_FOUND_RELEASE} ${Boost_date_time_SYSTEM_LIBS_RELEASE} ${Boost_date_time_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_date_time_LIBS_RELEASE}"
                              "${Boost_date_time_LIB_DIRS_RELEASE}"
                              "${Boost_date_time_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_date_time_NOT_USED_RELEASE
                              Boost_date_time_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_date_time")

set(Boost_date_time_LINK_LIBS_RELEASE ${Boost_date_time_LIB_TARGETS_RELEASE} ${Boost_date_time_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT container VARIABLES #############################################

set(Boost_container_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_container_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_container_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_container_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_container_RES_DIRS_RELEASE )
set(Boost_container_DEFINITIONS_RELEASE )
set(Boost_container_COMPILE_DEFINITIONS_RELEASE )
set(Boost_container_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_container_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_container_LIBS_RELEASE libboost_container)
set(Boost_container_SYSTEM_LIBS_RELEASE )
set(Boost_container_FRAMEWORK_DIRS_RELEASE )
set(Boost_container_FRAMEWORKS_RELEASE )
set(Boost_container_BUILD_MODULES_PATHS_RELEASE )
set(Boost_container_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_container_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT container FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_container_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_container_FRAMEWORKS_FOUND_RELEASE "${Boost_container_FRAMEWORKS_RELEASE}" "${Boost_container_FRAMEWORK_DIRS_RELEASE}")

set(Boost_container_LIB_TARGETS_RELEASE "")
set(Boost_container_NOT_USED_RELEASE "")
set(Boost_container_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_container_FRAMEWORKS_FOUND_RELEASE} ${Boost_container_SYSTEM_LIBS_RELEASE} ${Boost_container_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_container_LIBS_RELEASE}"
                              "${Boost_container_LIB_DIRS_RELEASE}"
                              "${Boost_container_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_container_NOT_USED_RELEASE
                              Boost_container_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_container")

set(Boost_container_LINK_LIBS_RELEASE ${Boost_container_LIB_TARGETS_RELEASE} ${Boost_container_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT chrono VARIABLES #############################################

set(Boost_chrono_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_chrono_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_chrono_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_chrono_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_chrono_RES_DIRS_RELEASE )
set(Boost_chrono_DEFINITIONS_RELEASE )
set(Boost_chrono_COMPILE_DEFINITIONS_RELEASE )
set(Boost_chrono_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_chrono_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_chrono_LIBS_RELEASE libboost_chrono)
set(Boost_chrono_SYSTEM_LIBS_RELEASE )
set(Boost_chrono_FRAMEWORK_DIRS_RELEASE )
set(Boost_chrono_FRAMEWORKS_RELEASE )
set(Boost_chrono_BUILD_MODULES_PATHS_RELEASE )
set(Boost_chrono_DEPENDENCIES_RELEASE Boost::system Boost::_libboost)
set(Boost_chrono_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT chrono FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_chrono_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_chrono_FRAMEWORKS_FOUND_RELEASE "${Boost_chrono_FRAMEWORKS_RELEASE}" "${Boost_chrono_FRAMEWORK_DIRS_RELEASE}")

set(Boost_chrono_LIB_TARGETS_RELEASE "")
set(Boost_chrono_NOT_USED_RELEASE "")
set(Boost_chrono_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_chrono_FRAMEWORKS_FOUND_RELEASE} ${Boost_chrono_SYSTEM_LIBS_RELEASE} ${Boost_chrono_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_chrono_LIBS_RELEASE}"
                              "${Boost_chrono_LIB_DIRS_RELEASE}"
                              "${Boost_chrono_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_chrono_NOT_USED_RELEASE
                              Boost_chrono_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_chrono")

set(Boost_chrono_LINK_LIBS_RELEASE ${Boost_chrono_LIB_TARGETS_RELEASE} ${Boost_chrono_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT thread VARIABLES #############################################

set(Boost_thread_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_thread_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_thread_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_thread_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_thread_RES_DIRS_RELEASE )
set(Boost_thread_DEFINITIONS_RELEASE )
set(Boost_thread_COMPILE_DEFINITIONS_RELEASE )
set(Boost_thread_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_thread_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_thread_LIBS_RELEASE libboost_thread)
set(Boost_thread_SYSTEM_LIBS_RELEASE )
set(Boost_thread_FRAMEWORK_DIRS_RELEASE )
set(Boost_thread_FRAMEWORKS_RELEASE )
set(Boost_thread_BUILD_MODULES_PATHS_RELEASE )
set(Boost_thread_DEPENDENCIES_RELEASE Boost::atomic Boost::chrono Boost::container Boost::date_time Boost::exception Boost::system Boost::_libboost)
set(Boost_thread_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT thread FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_thread_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_thread_FRAMEWORKS_FOUND_RELEASE "${Boost_thread_FRAMEWORKS_RELEASE}" "${Boost_thread_FRAMEWORK_DIRS_RELEASE}")

set(Boost_thread_LIB_TARGETS_RELEASE "")
set(Boost_thread_NOT_USED_RELEASE "")
set(Boost_thread_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_thread_FRAMEWORKS_FOUND_RELEASE} ${Boost_thread_SYSTEM_LIBS_RELEASE} ${Boost_thread_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_thread_LIBS_RELEASE}"
                              "${Boost_thread_LIB_DIRS_RELEASE}"
                              "${Boost_thread_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_thread_NOT_USED_RELEASE
                              Boost_thread_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_thread")

set(Boost_thread_LINK_LIBS_RELEASE ${Boost_thread_LIB_TARGETS_RELEASE} ${Boost_thread_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT type_erasure VARIABLES #############################################

set(Boost_type_erasure_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_type_erasure_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_type_erasure_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_type_erasure_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_type_erasure_RES_DIRS_RELEASE )
set(Boost_type_erasure_DEFINITIONS_RELEASE )
set(Boost_type_erasure_COMPILE_DEFINITIONS_RELEASE )
set(Boost_type_erasure_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_type_erasure_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_type_erasure_LIBS_RELEASE libboost_type_erasure)
set(Boost_type_erasure_SYSTEM_LIBS_RELEASE )
set(Boost_type_erasure_FRAMEWORK_DIRS_RELEASE )
set(Boost_type_erasure_FRAMEWORKS_RELEASE )
set(Boost_type_erasure_BUILD_MODULES_PATHS_RELEASE )
set(Boost_type_erasure_DEPENDENCIES_RELEASE Boost::thread Boost::_libboost)
set(Boost_type_erasure_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT type_erasure FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_type_erasure_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_type_erasure_FRAMEWORKS_FOUND_RELEASE "${Boost_type_erasure_FRAMEWORKS_RELEASE}" "${Boost_type_erasure_FRAMEWORK_DIRS_RELEASE}")

set(Boost_type_erasure_LIB_TARGETS_RELEASE "")
set(Boost_type_erasure_NOT_USED_RELEASE "")
set(Boost_type_erasure_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_type_erasure_FRAMEWORKS_FOUND_RELEASE} ${Boost_type_erasure_SYSTEM_LIBS_RELEASE} ${Boost_type_erasure_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_type_erasure_LIBS_RELEASE}"
                              "${Boost_type_erasure_LIB_DIRS_RELEASE}"
                              "${Boost_type_erasure_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_type_erasure_NOT_USED_RELEASE
                              Boost_type_erasure_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_type_erasure")

set(Boost_type_erasure_LINK_LIBS_RELEASE ${Boost_type_erasure_LIB_TARGETS_RELEASE} ${Boost_type_erasure_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT timer VARIABLES #############################################

set(Boost_timer_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_timer_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_timer_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_timer_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_timer_RES_DIRS_RELEASE )
set(Boost_timer_DEFINITIONS_RELEASE )
set(Boost_timer_COMPILE_DEFINITIONS_RELEASE )
set(Boost_timer_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_timer_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_timer_LIBS_RELEASE libboost_timer)
set(Boost_timer_SYSTEM_LIBS_RELEASE )
set(Boost_timer_FRAMEWORK_DIRS_RELEASE )
set(Boost_timer_FRAMEWORKS_RELEASE )
set(Boost_timer_BUILD_MODULES_PATHS_RELEASE )
set(Boost_timer_DEPENDENCIES_RELEASE Boost::chrono Boost::system Boost::_libboost)
set(Boost_timer_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT timer FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_timer_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_timer_FRAMEWORKS_FOUND_RELEASE "${Boost_timer_FRAMEWORKS_RELEASE}" "${Boost_timer_FRAMEWORK_DIRS_RELEASE}")

set(Boost_timer_LIB_TARGETS_RELEASE "")
set(Boost_timer_NOT_USED_RELEASE "")
set(Boost_timer_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_timer_FRAMEWORKS_FOUND_RELEASE} ${Boost_timer_SYSTEM_LIBS_RELEASE} ${Boost_timer_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_timer_LIBS_RELEASE}"
                              "${Boost_timer_LIB_DIRS_RELEASE}"
                              "${Boost_timer_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_timer_NOT_USED_RELEASE
                              Boost_timer_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_timer")

set(Boost_timer_LINK_LIBS_RELEASE ${Boost_timer_LIB_TARGETS_RELEASE} ${Boost_timer_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT stacktrace VARIABLES #############################################

set(Boost_stacktrace_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_stacktrace_RES_DIRS_RELEASE )
set(Boost_stacktrace_DEFINITIONS_RELEASE )
set(Boost_stacktrace_COMPILE_DEFINITIONS_RELEASE )
set(Boost_stacktrace_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_stacktrace_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_stacktrace_LIBS_RELEASE )
set(Boost_stacktrace_SYSTEM_LIBS_RELEASE )
set(Boost_stacktrace_FRAMEWORK_DIRS_RELEASE )
set(Boost_stacktrace_FRAMEWORKS_RELEASE )
set(Boost_stacktrace_BUILD_MODULES_PATHS_RELEASE )
set(Boost_stacktrace_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_stacktrace_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT stacktrace FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_stacktrace_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_stacktrace_FRAMEWORKS_FOUND_RELEASE "${Boost_stacktrace_FRAMEWORKS_RELEASE}" "${Boost_stacktrace_FRAMEWORK_DIRS_RELEASE}")

set(Boost_stacktrace_LIB_TARGETS_RELEASE "")
set(Boost_stacktrace_NOT_USED_RELEASE "")
set(Boost_stacktrace_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_stacktrace_FRAMEWORKS_FOUND_RELEASE} ${Boost_stacktrace_SYSTEM_LIBS_RELEASE} ${Boost_stacktrace_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_stacktrace_LIBS_RELEASE}"
                              "${Boost_stacktrace_LIB_DIRS_RELEASE}"
                              "${Boost_stacktrace_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_stacktrace_NOT_USED_RELEASE
                              Boost_stacktrace_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_stacktrace")

set(Boost_stacktrace_LINK_LIBS_RELEASE ${Boost_stacktrace_LIB_TARGETS_RELEASE} ${Boost_stacktrace_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT stacktrace_windbg_cached VARIABLES #############################################

set(Boost_stacktrace_windbg_cached_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_cached_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_cached_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_cached_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_stacktrace_windbg_cached_RES_DIRS_RELEASE )
set(Boost_stacktrace_windbg_cached_DEFINITIONS_RELEASE "-DBOOST_STACKTRACE_USE_WINDBG_CACHED")
set(Boost_stacktrace_windbg_cached_COMPILE_DEFINITIONS_RELEASE "BOOST_STACKTRACE_USE_WINDBG_CACHED")
set(Boost_stacktrace_windbg_cached_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_stacktrace_windbg_cached_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_stacktrace_windbg_cached_LIBS_RELEASE libboost_stacktrace_windbg_cached)
set(Boost_stacktrace_windbg_cached_SYSTEM_LIBS_RELEASE ole32 dbgeng)
set(Boost_stacktrace_windbg_cached_FRAMEWORK_DIRS_RELEASE )
set(Boost_stacktrace_windbg_cached_FRAMEWORKS_RELEASE )
set(Boost_stacktrace_windbg_cached_BUILD_MODULES_PATHS_RELEASE )
set(Boost_stacktrace_windbg_cached_DEPENDENCIES_RELEASE Boost::stacktrace Boost::_libboost)
set(Boost_stacktrace_windbg_cached_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT stacktrace_windbg_cached FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_stacktrace_windbg_cached_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_stacktrace_windbg_cached_FRAMEWORKS_FOUND_RELEASE "${Boost_stacktrace_windbg_cached_FRAMEWORKS_RELEASE}" "${Boost_stacktrace_windbg_cached_FRAMEWORK_DIRS_RELEASE}")

set(Boost_stacktrace_windbg_cached_LIB_TARGETS_RELEASE "")
set(Boost_stacktrace_windbg_cached_NOT_USED_RELEASE "")
set(Boost_stacktrace_windbg_cached_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_stacktrace_windbg_cached_FRAMEWORKS_FOUND_RELEASE} ${Boost_stacktrace_windbg_cached_SYSTEM_LIBS_RELEASE} ${Boost_stacktrace_windbg_cached_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_stacktrace_windbg_cached_LIBS_RELEASE}"
                              "${Boost_stacktrace_windbg_cached_LIB_DIRS_RELEASE}"
                              "${Boost_stacktrace_windbg_cached_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_stacktrace_windbg_cached_NOT_USED_RELEASE
                              Boost_stacktrace_windbg_cached_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_stacktrace_windbg_cached")

set(Boost_stacktrace_windbg_cached_LINK_LIBS_RELEASE ${Boost_stacktrace_windbg_cached_LIB_TARGETS_RELEASE} ${Boost_stacktrace_windbg_cached_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT stacktrace_windbg VARIABLES #############################################

set(Boost_stacktrace_windbg_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_windbg_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_stacktrace_windbg_RES_DIRS_RELEASE )
set(Boost_stacktrace_windbg_DEFINITIONS_RELEASE "-DBOOST_STACKTRACE_USE_WINDBG")
set(Boost_stacktrace_windbg_COMPILE_DEFINITIONS_RELEASE "BOOST_STACKTRACE_USE_WINDBG")
set(Boost_stacktrace_windbg_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_stacktrace_windbg_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_stacktrace_windbg_LIBS_RELEASE libboost_stacktrace_windbg)
set(Boost_stacktrace_windbg_SYSTEM_LIBS_RELEASE ole32 dbgeng)
set(Boost_stacktrace_windbg_FRAMEWORK_DIRS_RELEASE )
set(Boost_stacktrace_windbg_FRAMEWORKS_RELEASE )
set(Boost_stacktrace_windbg_BUILD_MODULES_PATHS_RELEASE )
set(Boost_stacktrace_windbg_DEPENDENCIES_RELEASE Boost::stacktrace Boost::_libboost)
set(Boost_stacktrace_windbg_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT stacktrace_windbg FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_stacktrace_windbg_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_stacktrace_windbg_FRAMEWORKS_FOUND_RELEASE "${Boost_stacktrace_windbg_FRAMEWORKS_RELEASE}" "${Boost_stacktrace_windbg_FRAMEWORK_DIRS_RELEASE}")

set(Boost_stacktrace_windbg_LIB_TARGETS_RELEASE "")
set(Boost_stacktrace_windbg_NOT_USED_RELEASE "")
set(Boost_stacktrace_windbg_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_stacktrace_windbg_FRAMEWORKS_FOUND_RELEASE} ${Boost_stacktrace_windbg_SYSTEM_LIBS_RELEASE} ${Boost_stacktrace_windbg_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_stacktrace_windbg_LIBS_RELEASE}"
                              "${Boost_stacktrace_windbg_LIB_DIRS_RELEASE}"
                              "${Boost_stacktrace_windbg_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_stacktrace_windbg_NOT_USED_RELEASE
                              Boost_stacktrace_windbg_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_stacktrace_windbg")

set(Boost_stacktrace_windbg_LINK_LIBS_RELEASE ${Boost_stacktrace_windbg_LIB_TARGETS_RELEASE} ${Boost_stacktrace_windbg_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT stacktrace_noop VARIABLES #############################################

set(Boost_stacktrace_noop_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_noop_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_noop_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_stacktrace_noop_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_stacktrace_noop_RES_DIRS_RELEASE )
set(Boost_stacktrace_noop_DEFINITIONS_RELEASE "-DBOOST_STACKTRACE_USE_NOOP")
set(Boost_stacktrace_noop_COMPILE_DEFINITIONS_RELEASE "BOOST_STACKTRACE_USE_NOOP")
set(Boost_stacktrace_noop_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_stacktrace_noop_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_stacktrace_noop_LIBS_RELEASE libboost_stacktrace_noop)
set(Boost_stacktrace_noop_SYSTEM_LIBS_RELEASE )
set(Boost_stacktrace_noop_FRAMEWORK_DIRS_RELEASE )
set(Boost_stacktrace_noop_FRAMEWORKS_RELEASE )
set(Boost_stacktrace_noop_BUILD_MODULES_PATHS_RELEASE )
set(Boost_stacktrace_noop_DEPENDENCIES_RELEASE Boost::stacktrace Boost::_libboost)
set(Boost_stacktrace_noop_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT stacktrace_noop FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_stacktrace_noop_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_stacktrace_noop_FRAMEWORKS_FOUND_RELEASE "${Boost_stacktrace_noop_FRAMEWORKS_RELEASE}" "${Boost_stacktrace_noop_FRAMEWORK_DIRS_RELEASE}")

set(Boost_stacktrace_noop_LIB_TARGETS_RELEASE "")
set(Boost_stacktrace_noop_NOT_USED_RELEASE "")
set(Boost_stacktrace_noop_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_stacktrace_noop_FRAMEWORKS_FOUND_RELEASE} ${Boost_stacktrace_noop_SYSTEM_LIBS_RELEASE} ${Boost_stacktrace_noop_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_stacktrace_noop_LIBS_RELEASE}"
                              "${Boost_stacktrace_noop_LIB_DIRS_RELEASE}"
                              "${Boost_stacktrace_noop_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_stacktrace_noop_NOT_USED_RELEASE
                              Boost_stacktrace_noop_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_stacktrace_noop")

set(Boost_stacktrace_noop_LINK_LIBS_RELEASE ${Boost_stacktrace_noop_LIB_TARGETS_RELEASE} ${Boost_stacktrace_noop_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT regex VARIABLES #############################################

set(Boost_regex_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_regex_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_regex_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_regex_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_regex_RES_DIRS_RELEASE )
set(Boost_regex_DEFINITIONS_RELEASE )
set(Boost_regex_COMPILE_DEFINITIONS_RELEASE )
set(Boost_regex_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_regex_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_regex_LIBS_RELEASE libboost_regex)
set(Boost_regex_SYSTEM_LIBS_RELEASE )
set(Boost_regex_FRAMEWORK_DIRS_RELEASE )
set(Boost_regex_FRAMEWORKS_RELEASE )
set(Boost_regex_BUILD_MODULES_PATHS_RELEASE )
set(Boost_regex_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_regex_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT regex FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_regex_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_regex_FRAMEWORKS_FOUND_RELEASE "${Boost_regex_FRAMEWORKS_RELEASE}" "${Boost_regex_FRAMEWORK_DIRS_RELEASE}")

set(Boost_regex_LIB_TARGETS_RELEASE "")
set(Boost_regex_NOT_USED_RELEASE "")
set(Boost_regex_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_regex_FRAMEWORKS_FOUND_RELEASE} ${Boost_regex_SYSTEM_LIBS_RELEASE} ${Boost_regex_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_regex_LIBS_RELEASE}"
                              "${Boost_regex_LIB_DIRS_RELEASE}"
                              "${Boost_regex_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_regex_NOT_USED_RELEASE
                              Boost_regex_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_regex")

set(Boost_regex_LINK_LIBS_RELEASE ${Boost_regex_LIB_TARGETS_RELEASE} ${Boost_regex_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT random VARIABLES #############################################

set(Boost_random_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_random_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_random_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_random_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_random_RES_DIRS_RELEASE )
set(Boost_random_DEFINITIONS_RELEASE )
set(Boost_random_COMPILE_DEFINITIONS_RELEASE )
set(Boost_random_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_random_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_random_LIBS_RELEASE libboost_random)
set(Boost_random_SYSTEM_LIBS_RELEASE )
set(Boost_random_FRAMEWORK_DIRS_RELEASE )
set(Boost_random_FRAMEWORKS_RELEASE )
set(Boost_random_BUILD_MODULES_PATHS_RELEASE )
set(Boost_random_DEPENDENCIES_RELEASE Boost::system Boost::_libboost)
set(Boost_random_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT random FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_random_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_random_FRAMEWORKS_FOUND_RELEASE "${Boost_random_FRAMEWORKS_RELEASE}" "${Boost_random_FRAMEWORK_DIRS_RELEASE}")

set(Boost_random_LIB_TARGETS_RELEASE "")
set(Boost_random_NOT_USED_RELEASE "")
set(Boost_random_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_random_FRAMEWORKS_FOUND_RELEASE} ${Boost_random_SYSTEM_LIBS_RELEASE} ${Boost_random_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_random_LIBS_RELEASE}"
                              "${Boost_random_LIB_DIRS_RELEASE}"
                              "${Boost_random_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_random_NOT_USED_RELEASE
                              Boost_random_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_random")

set(Boost_random_LINK_LIBS_RELEASE ${Boost_random_LIB_TARGETS_RELEASE} ${Boost_random_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT program_options VARIABLES #############################################

set(Boost_program_options_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_program_options_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_program_options_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_program_options_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_program_options_RES_DIRS_RELEASE )
set(Boost_program_options_DEFINITIONS_RELEASE )
set(Boost_program_options_COMPILE_DEFINITIONS_RELEASE )
set(Boost_program_options_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_program_options_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_program_options_LIBS_RELEASE libboost_program_options)
set(Boost_program_options_SYSTEM_LIBS_RELEASE )
set(Boost_program_options_FRAMEWORK_DIRS_RELEASE )
set(Boost_program_options_FRAMEWORKS_RELEASE )
set(Boost_program_options_BUILD_MODULES_PATHS_RELEASE )
set(Boost_program_options_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_program_options_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT program_options FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_program_options_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_program_options_FRAMEWORKS_FOUND_RELEASE "${Boost_program_options_FRAMEWORKS_RELEASE}" "${Boost_program_options_FRAMEWORK_DIRS_RELEASE}")

set(Boost_program_options_LIB_TARGETS_RELEASE "")
set(Boost_program_options_NOT_USED_RELEASE "")
set(Boost_program_options_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_program_options_FRAMEWORKS_FOUND_RELEASE} ${Boost_program_options_SYSTEM_LIBS_RELEASE} ${Boost_program_options_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_program_options_LIBS_RELEASE}"
                              "${Boost_program_options_LIB_DIRS_RELEASE}"
                              "${Boost_program_options_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_program_options_NOT_USED_RELEASE
                              Boost_program_options_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_program_options")

set(Boost_program_options_LINK_LIBS_RELEASE ${Boost_program_options_LIB_TARGETS_RELEASE} ${Boost_program_options_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT nowide VARIABLES #############################################

set(Boost_nowide_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_nowide_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_nowide_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_nowide_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_nowide_RES_DIRS_RELEASE )
set(Boost_nowide_DEFINITIONS_RELEASE )
set(Boost_nowide_COMPILE_DEFINITIONS_RELEASE )
set(Boost_nowide_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_nowide_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_nowide_LIBS_RELEASE libboost_nowide)
set(Boost_nowide_SYSTEM_LIBS_RELEASE )
set(Boost_nowide_FRAMEWORK_DIRS_RELEASE )
set(Boost_nowide_FRAMEWORKS_RELEASE )
set(Boost_nowide_BUILD_MODULES_PATHS_RELEASE )
set(Boost_nowide_DEPENDENCIES_RELEASE Boost::filesystem Boost::_libboost)
set(Boost_nowide_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT nowide FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_nowide_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_nowide_FRAMEWORKS_FOUND_RELEASE "${Boost_nowide_FRAMEWORKS_RELEASE}" "${Boost_nowide_FRAMEWORK_DIRS_RELEASE}")

set(Boost_nowide_LIB_TARGETS_RELEASE "")
set(Boost_nowide_NOT_USED_RELEASE "")
set(Boost_nowide_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_nowide_FRAMEWORKS_FOUND_RELEASE} ${Boost_nowide_SYSTEM_LIBS_RELEASE} ${Boost_nowide_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_nowide_LIBS_RELEASE}"
                              "${Boost_nowide_LIB_DIRS_RELEASE}"
                              "${Boost_nowide_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_nowide_NOT_USED_RELEASE
                              Boost_nowide_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_nowide")

set(Boost_nowide_LINK_LIBS_RELEASE ${Boost_nowide_LIB_TARGETS_RELEASE} ${Boost_nowide_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math VARIABLES #############################################

set(Boost_math_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_RES_DIRS_RELEASE )
set(Boost_math_DEFINITIONS_RELEASE )
set(Boost_math_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_LIBS_RELEASE )
set(Boost_math_SYSTEM_LIBS_RELEASE )
set(Boost_math_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_FRAMEWORKS_RELEASE )
set(Boost_math_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_math_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_FRAMEWORKS_FOUND_RELEASE "${Boost_math_FRAMEWORKS_RELEASE}" "${Boost_math_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_LIB_TARGETS_RELEASE "")
set(Boost_math_NOT_USED_RELEASE "")
set(Boost_math_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_SYSTEM_LIBS_RELEASE} ${Boost_math_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_LIBS_RELEASE}"
                              "${Boost_math_LIB_DIRS_RELEASE}"
                              "${Boost_math_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_NOT_USED_RELEASE
                              Boost_math_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math")

set(Boost_math_LINK_LIBS_RELEASE ${Boost_math_LIB_TARGETS_RELEASE} ${Boost_math_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_tr1l VARIABLES #############################################

set(Boost_math_tr1l_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1l_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1l_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1l_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_tr1l_RES_DIRS_RELEASE )
set(Boost_math_tr1l_DEFINITIONS_RELEASE )
set(Boost_math_tr1l_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_tr1l_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_tr1l_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_tr1l_LIBS_RELEASE libboost_math_tr1l)
set(Boost_math_tr1l_SYSTEM_LIBS_RELEASE )
set(Boost_math_tr1l_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_tr1l_FRAMEWORKS_RELEASE )
set(Boost_math_tr1l_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_tr1l_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_tr1l_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_tr1l FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_tr1l_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_tr1l_FRAMEWORKS_FOUND_RELEASE "${Boost_math_tr1l_FRAMEWORKS_RELEASE}" "${Boost_math_tr1l_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_tr1l_LIB_TARGETS_RELEASE "")
set(Boost_math_tr1l_NOT_USED_RELEASE "")
set(Boost_math_tr1l_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_tr1l_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_tr1l_SYSTEM_LIBS_RELEASE} ${Boost_math_tr1l_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_tr1l_LIBS_RELEASE}"
                              "${Boost_math_tr1l_LIB_DIRS_RELEASE}"
                              "${Boost_math_tr1l_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_tr1l_NOT_USED_RELEASE
                              Boost_math_tr1l_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_tr1l")

set(Boost_math_tr1l_LINK_LIBS_RELEASE ${Boost_math_tr1l_LIB_TARGETS_RELEASE} ${Boost_math_tr1l_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_tr1f VARIABLES #############################################

set(Boost_math_tr1f_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1f_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1f_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1f_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_tr1f_RES_DIRS_RELEASE )
set(Boost_math_tr1f_DEFINITIONS_RELEASE )
set(Boost_math_tr1f_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_tr1f_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_tr1f_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_tr1f_LIBS_RELEASE libboost_math_tr1f)
set(Boost_math_tr1f_SYSTEM_LIBS_RELEASE )
set(Boost_math_tr1f_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_tr1f_FRAMEWORKS_RELEASE )
set(Boost_math_tr1f_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_tr1f_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_tr1f_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_tr1f FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_tr1f_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_tr1f_FRAMEWORKS_FOUND_RELEASE "${Boost_math_tr1f_FRAMEWORKS_RELEASE}" "${Boost_math_tr1f_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_tr1f_LIB_TARGETS_RELEASE "")
set(Boost_math_tr1f_NOT_USED_RELEASE "")
set(Boost_math_tr1f_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_tr1f_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_tr1f_SYSTEM_LIBS_RELEASE} ${Boost_math_tr1f_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_tr1f_LIBS_RELEASE}"
                              "${Boost_math_tr1f_LIB_DIRS_RELEASE}"
                              "${Boost_math_tr1f_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_tr1f_NOT_USED_RELEASE
                              Boost_math_tr1f_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_tr1f")

set(Boost_math_tr1f_LINK_LIBS_RELEASE ${Boost_math_tr1f_LIB_TARGETS_RELEASE} ${Boost_math_tr1f_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_tr1 VARIABLES #############################################

set(Boost_math_tr1_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_tr1_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_tr1_RES_DIRS_RELEASE )
set(Boost_math_tr1_DEFINITIONS_RELEASE )
set(Boost_math_tr1_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_tr1_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_tr1_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_tr1_LIBS_RELEASE libboost_math_tr1)
set(Boost_math_tr1_SYSTEM_LIBS_RELEASE )
set(Boost_math_tr1_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_tr1_FRAMEWORKS_RELEASE )
set(Boost_math_tr1_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_tr1_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_tr1_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_tr1 FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_tr1_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_tr1_FRAMEWORKS_FOUND_RELEASE "${Boost_math_tr1_FRAMEWORKS_RELEASE}" "${Boost_math_tr1_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_tr1_LIB_TARGETS_RELEASE "")
set(Boost_math_tr1_NOT_USED_RELEASE "")
set(Boost_math_tr1_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_tr1_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_tr1_SYSTEM_LIBS_RELEASE} ${Boost_math_tr1_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_tr1_LIBS_RELEASE}"
                              "${Boost_math_tr1_LIB_DIRS_RELEASE}"
                              "${Boost_math_tr1_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_tr1_NOT_USED_RELEASE
                              Boost_math_tr1_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_tr1")

set(Boost_math_tr1_LINK_LIBS_RELEASE ${Boost_math_tr1_LIB_TARGETS_RELEASE} ${Boost_math_tr1_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_c99l VARIABLES #############################################

set(Boost_math_c99l_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99l_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99l_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99l_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_c99l_RES_DIRS_RELEASE )
set(Boost_math_c99l_DEFINITIONS_RELEASE )
set(Boost_math_c99l_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_c99l_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_c99l_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_c99l_LIBS_RELEASE libboost_math_c99l)
set(Boost_math_c99l_SYSTEM_LIBS_RELEASE )
set(Boost_math_c99l_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_c99l_FRAMEWORKS_RELEASE )
set(Boost_math_c99l_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_c99l_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_c99l_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_c99l FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_c99l_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_c99l_FRAMEWORKS_FOUND_RELEASE "${Boost_math_c99l_FRAMEWORKS_RELEASE}" "${Boost_math_c99l_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_c99l_LIB_TARGETS_RELEASE "")
set(Boost_math_c99l_NOT_USED_RELEASE "")
set(Boost_math_c99l_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_c99l_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_c99l_SYSTEM_LIBS_RELEASE} ${Boost_math_c99l_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_c99l_LIBS_RELEASE}"
                              "${Boost_math_c99l_LIB_DIRS_RELEASE}"
                              "${Boost_math_c99l_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_c99l_NOT_USED_RELEASE
                              Boost_math_c99l_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_c99l")

set(Boost_math_c99l_LINK_LIBS_RELEASE ${Boost_math_c99l_LIB_TARGETS_RELEASE} ${Boost_math_c99l_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_c99f VARIABLES #############################################

set(Boost_math_c99f_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99f_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99f_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99f_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_c99f_RES_DIRS_RELEASE )
set(Boost_math_c99f_DEFINITIONS_RELEASE )
set(Boost_math_c99f_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_c99f_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_c99f_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_c99f_LIBS_RELEASE libboost_math_c99f)
set(Boost_math_c99f_SYSTEM_LIBS_RELEASE )
set(Boost_math_c99f_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_c99f_FRAMEWORKS_RELEASE )
set(Boost_math_c99f_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_c99f_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_c99f_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_c99f FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_c99f_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_c99f_FRAMEWORKS_FOUND_RELEASE "${Boost_math_c99f_FRAMEWORKS_RELEASE}" "${Boost_math_c99f_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_c99f_LIB_TARGETS_RELEASE "")
set(Boost_math_c99f_NOT_USED_RELEASE "")
set(Boost_math_c99f_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_c99f_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_c99f_SYSTEM_LIBS_RELEASE} ${Boost_math_c99f_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_c99f_LIBS_RELEASE}"
                              "${Boost_math_c99f_LIB_DIRS_RELEASE}"
                              "${Boost_math_c99f_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_c99f_NOT_USED_RELEASE
                              Boost_math_c99f_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_c99f")

set(Boost_math_c99f_LINK_LIBS_RELEASE ${Boost_math_c99f_LIB_TARGETS_RELEASE} ${Boost_math_c99f_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT math_c99 VARIABLES #############################################

set(Boost_math_c99_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_math_c99_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_math_c99_RES_DIRS_RELEASE )
set(Boost_math_c99_DEFINITIONS_RELEASE )
set(Boost_math_c99_COMPILE_DEFINITIONS_RELEASE )
set(Boost_math_c99_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_math_c99_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_math_c99_LIBS_RELEASE libboost_math_c99)
set(Boost_math_c99_SYSTEM_LIBS_RELEASE )
set(Boost_math_c99_FRAMEWORK_DIRS_RELEASE )
set(Boost_math_c99_FRAMEWORKS_RELEASE )
set(Boost_math_c99_BUILD_MODULES_PATHS_RELEASE )
set(Boost_math_c99_DEPENDENCIES_RELEASE Boost::math Boost::_libboost)
set(Boost_math_c99_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT math_c99 FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_math_c99_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_math_c99_FRAMEWORKS_FOUND_RELEASE "${Boost_math_c99_FRAMEWORKS_RELEASE}" "${Boost_math_c99_FRAMEWORK_DIRS_RELEASE}")

set(Boost_math_c99_LIB_TARGETS_RELEASE "")
set(Boost_math_c99_NOT_USED_RELEASE "")
set(Boost_math_c99_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_math_c99_FRAMEWORKS_FOUND_RELEASE} ${Boost_math_c99_SYSTEM_LIBS_RELEASE} ${Boost_math_c99_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_math_c99_LIBS_RELEASE}"
                              "${Boost_math_c99_LIB_DIRS_RELEASE}"
                              "${Boost_math_c99_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_math_c99_NOT_USED_RELEASE
                              Boost_math_c99_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_math_c99")

set(Boost_math_c99_LINK_LIBS_RELEASE ${Boost_math_c99_LIB_TARGETS_RELEASE} ${Boost_math_c99_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT log VARIABLES #############################################

set(Boost_log_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_log_RES_DIRS_RELEASE )
set(Boost_log_DEFINITIONS_RELEASE )
set(Boost_log_COMPILE_DEFINITIONS_RELEASE )
set(Boost_log_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_log_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_log_LIBS_RELEASE libboost_log)
set(Boost_log_SYSTEM_LIBS_RELEASE )
set(Boost_log_FRAMEWORK_DIRS_RELEASE )
set(Boost_log_FRAMEWORKS_RELEASE )
set(Boost_log_BUILD_MODULES_PATHS_RELEASE )
set(Boost_log_DEPENDENCIES_RELEASE Boost::atomic Boost::container Boost::date_time Boost::exception Boost::filesystem Boost::random Boost::regex Boost::system Boost::thread Boost::_libboost)
set(Boost_log_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT log FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_log_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_log_FRAMEWORKS_FOUND_RELEASE "${Boost_log_FRAMEWORKS_RELEASE}" "${Boost_log_FRAMEWORK_DIRS_RELEASE}")

set(Boost_log_LIB_TARGETS_RELEASE "")
set(Boost_log_NOT_USED_RELEASE "")
set(Boost_log_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_log_FRAMEWORKS_FOUND_RELEASE} ${Boost_log_SYSTEM_LIBS_RELEASE} ${Boost_log_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_log_LIBS_RELEASE}"
                              "${Boost_log_LIB_DIRS_RELEASE}"
                              "${Boost_log_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_log_NOT_USED_RELEASE
                              Boost_log_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_log")

set(Boost_log_LINK_LIBS_RELEASE ${Boost_log_LIB_TARGETS_RELEASE} ${Boost_log_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT log_setup VARIABLES #############################################

set(Boost_log_setup_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_setup_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_setup_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_log_setup_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_log_setup_RES_DIRS_RELEASE )
set(Boost_log_setup_DEFINITIONS_RELEASE )
set(Boost_log_setup_COMPILE_DEFINITIONS_RELEASE )
set(Boost_log_setup_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_log_setup_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_log_setup_LIBS_RELEASE libboost_log_setup)
set(Boost_log_setup_SYSTEM_LIBS_RELEASE )
set(Boost_log_setup_FRAMEWORK_DIRS_RELEASE )
set(Boost_log_setup_FRAMEWORKS_RELEASE )
set(Boost_log_setup_BUILD_MODULES_PATHS_RELEASE )
set(Boost_log_setup_DEPENDENCIES_RELEASE Boost::log Boost::_libboost)
set(Boost_log_setup_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT log_setup FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_log_setup_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_log_setup_FRAMEWORKS_FOUND_RELEASE "${Boost_log_setup_FRAMEWORKS_RELEASE}" "${Boost_log_setup_FRAMEWORK_DIRS_RELEASE}")

set(Boost_log_setup_LIB_TARGETS_RELEASE "")
set(Boost_log_setup_NOT_USED_RELEASE "")
set(Boost_log_setup_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_log_setup_FRAMEWORKS_FOUND_RELEASE} ${Boost_log_setup_SYSTEM_LIBS_RELEASE} ${Boost_log_setup_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_log_setup_LIBS_RELEASE}"
                              "${Boost_log_setup_LIB_DIRS_RELEASE}"
                              "${Boost_log_setup_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_log_setup_NOT_USED_RELEASE
                              Boost_log_setup_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_log_setup")

set(Boost_log_setup_LINK_LIBS_RELEASE ${Boost_log_setup_LIB_TARGETS_RELEASE} ${Boost_log_setup_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT locale VARIABLES #############################################

set(Boost_locale_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_locale_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_locale_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_locale_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_locale_RES_DIRS_RELEASE )
set(Boost_locale_DEFINITIONS_RELEASE )
set(Boost_locale_COMPILE_DEFINITIONS_RELEASE )
set(Boost_locale_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_locale_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_locale_LIBS_RELEASE libboost_locale)
set(Boost_locale_SYSTEM_LIBS_RELEASE )
set(Boost_locale_FRAMEWORK_DIRS_RELEASE )
set(Boost_locale_FRAMEWORKS_RELEASE )
set(Boost_locale_BUILD_MODULES_PATHS_RELEASE )
set(Boost_locale_DEPENDENCIES_RELEASE Boost::thread Boost::_libboost)
set(Boost_locale_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT locale FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_locale_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_locale_FRAMEWORKS_FOUND_RELEASE "${Boost_locale_FRAMEWORKS_RELEASE}" "${Boost_locale_FRAMEWORK_DIRS_RELEASE}")

set(Boost_locale_LIB_TARGETS_RELEASE "")
set(Boost_locale_NOT_USED_RELEASE "")
set(Boost_locale_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_locale_FRAMEWORKS_FOUND_RELEASE} ${Boost_locale_SYSTEM_LIBS_RELEASE} ${Boost_locale_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_locale_LIBS_RELEASE}"
                              "${Boost_locale_LIB_DIRS_RELEASE}"
                              "${Boost_locale_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_locale_NOT_USED_RELEASE
                              Boost_locale_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_locale")

set(Boost_locale_LINK_LIBS_RELEASE ${Boost_locale_LIB_TARGETS_RELEASE} ${Boost_locale_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT json VARIABLES #############################################

set(Boost_json_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_json_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_json_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_json_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_json_RES_DIRS_RELEASE )
set(Boost_json_DEFINITIONS_RELEASE )
set(Boost_json_COMPILE_DEFINITIONS_RELEASE )
set(Boost_json_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_json_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_json_LIBS_RELEASE libboost_json)
set(Boost_json_SYSTEM_LIBS_RELEASE )
set(Boost_json_FRAMEWORK_DIRS_RELEASE )
set(Boost_json_FRAMEWORKS_RELEASE )
set(Boost_json_BUILD_MODULES_PATHS_RELEASE )
set(Boost_json_DEPENDENCIES_RELEASE Boost::container Boost::exception Boost::system Boost::_libboost)
set(Boost_json_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT json FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_json_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_json_FRAMEWORKS_FOUND_RELEASE "${Boost_json_FRAMEWORKS_RELEASE}" "${Boost_json_FRAMEWORK_DIRS_RELEASE}")

set(Boost_json_LIB_TARGETS_RELEASE "")
set(Boost_json_NOT_USED_RELEASE "")
set(Boost_json_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_json_FRAMEWORKS_FOUND_RELEASE} ${Boost_json_SYSTEM_LIBS_RELEASE} ${Boost_json_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_json_LIBS_RELEASE}"
                              "${Boost_json_LIB_DIRS_RELEASE}"
                              "${Boost_json_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_json_NOT_USED_RELEASE
                              Boost_json_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_json")

set(Boost_json_LINK_LIBS_RELEASE ${Boost_json_LIB_TARGETS_RELEASE} ${Boost_json_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT iostreams VARIABLES #############################################

set(Boost_iostreams_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_iostreams_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_iostreams_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_iostreams_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_iostreams_RES_DIRS_RELEASE )
set(Boost_iostreams_DEFINITIONS_RELEASE )
set(Boost_iostreams_COMPILE_DEFINITIONS_RELEASE )
set(Boost_iostreams_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_iostreams_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_iostreams_LIBS_RELEASE libboost_iostreams)
set(Boost_iostreams_SYSTEM_LIBS_RELEASE )
set(Boost_iostreams_FRAMEWORK_DIRS_RELEASE )
set(Boost_iostreams_FRAMEWORKS_RELEASE )
set(Boost_iostreams_BUILD_MODULES_PATHS_RELEASE )
set(Boost_iostreams_DEPENDENCIES_RELEASE Boost::random Boost::regex Boost::_libboost BZip2::BZip2 ZLIB::ZLIB)
set(Boost_iostreams_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT iostreams FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_iostreams_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_iostreams_FRAMEWORKS_FOUND_RELEASE "${Boost_iostreams_FRAMEWORKS_RELEASE}" "${Boost_iostreams_FRAMEWORK_DIRS_RELEASE}")

set(Boost_iostreams_LIB_TARGETS_RELEASE "")
set(Boost_iostreams_NOT_USED_RELEASE "")
set(Boost_iostreams_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_iostreams_FRAMEWORKS_FOUND_RELEASE} ${Boost_iostreams_SYSTEM_LIBS_RELEASE} ${Boost_iostreams_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_iostreams_LIBS_RELEASE}"
                              "${Boost_iostreams_LIB_DIRS_RELEASE}"
                              "${Boost_iostreams_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_iostreams_NOT_USED_RELEASE
                              Boost_iostreams_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_iostreams")

set(Boost_iostreams_LINK_LIBS_RELEASE ${Boost_iostreams_LIB_TARGETS_RELEASE} ${Boost_iostreams_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT graph VARIABLES #############################################

set(Boost_graph_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_graph_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_graph_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_graph_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_graph_RES_DIRS_RELEASE )
set(Boost_graph_DEFINITIONS_RELEASE )
set(Boost_graph_COMPILE_DEFINITIONS_RELEASE )
set(Boost_graph_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_graph_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_graph_LIBS_RELEASE libboost_graph)
set(Boost_graph_SYSTEM_LIBS_RELEASE )
set(Boost_graph_FRAMEWORK_DIRS_RELEASE )
set(Boost_graph_FRAMEWORKS_RELEASE )
set(Boost_graph_BUILD_MODULES_PATHS_RELEASE )
set(Boost_graph_DEPENDENCIES_RELEASE Boost::math Boost::random Boost::regex Boost::serialization Boost::_libboost)
set(Boost_graph_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT graph FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_graph_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_graph_FRAMEWORKS_FOUND_RELEASE "${Boost_graph_FRAMEWORKS_RELEASE}" "${Boost_graph_FRAMEWORK_DIRS_RELEASE}")

set(Boost_graph_LIB_TARGETS_RELEASE "")
set(Boost_graph_NOT_USED_RELEASE "")
set(Boost_graph_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_graph_FRAMEWORKS_FOUND_RELEASE} ${Boost_graph_SYSTEM_LIBS_RELEASE} ${Boost_graph_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_graph_LIBS_RELEASE}"
                              "${Boost_graph_LIB_DIRS_RELEASE}"
                              "${Boost_graph_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_graph_NOT_USED_RELEASE
                              Boost_graph_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_graph")

set(Boost_graph_LINK_LIBS_RELEASE ${Boost_graph_LIB_TARGETS_RELEASE} ${Boost_graph_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT context VARIABLES #############################################

set(Boost_context_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_context_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_context_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_context_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_context_RES_DIRS_RELEASE )
set(Boost_context_DEFINITIONS_RELEASE )
set(Boost_context_COMPILE_DEFINITIONS_RELEASE )
set(Boost_context_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_context_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_context_LIBS_RELEASE libboost_context)
set(Boost_context_SYSTEM_LIBS_RELEASE )
set(Boost_context_FRAMEWORK_DIRS_RELEASE )
set(Boost_context_FRAMEWORKS_RELEASE )
set(Boost_context_BUILD_MODULES_PATHS_RELEASE )
set(Boost_context_DEPENDENCIES_RELEASE Boost::_libboost)
set(Boost_context_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT context FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_context_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_context_FRAMEWORKS_FOUND_RELEASE "${Boost_context_FRAMEWORKS_RELEASE}" "${Boost_context_FRAMEWORK_DIRS_RELEASE}")

set(Boost_context_LIB_TARGETS_RELEASE "")
set(Boost_context_NOT_USED_RELEASE "")
set(Boost_context_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_context_FRAMEWORKS_FOUND_RELEASE} ${Boost_context_SYSTEM_LIBS_RELEASE} ${Boost_context_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_context_LIBS_RELEASE}"
                              "${Boost_context_LIB_DIRS_RELEASE}"
                              "${Boost_context_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_context_NOT_USED_RELEASE
                              Boost_context_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_context")

set(Boost_context_LINK_LIBS_RELEASE ${Boost_context_LIB_TARGETS_RELEASE} ${Boost_context_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT fiber VARIABLES #############################################

set(Boost_fiber_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_fiber_RES_DIRS_RELEASE )
set(Boost_fiber_DEFINITIONS_RELEASE )
set(Boost_fiber_COMPILE_DEFINITIONS_RELEASE )
set(Boost_fiber_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_fiber_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_fiber_LIBS_RELEASE libboost_fiber)
set(Boost_fiber_SYSTEM_LIBS_RELEASE )
set(Boost_fiber_FRAMEWORK_DIRS_RELEASE )
set(Boost_fiber_FRAMEWORKS_RELEASE )
set(Boost_fiber_BUILD_MODULES_PATHS_RELEASE )
set(Boost_fiber_DEPENDENCIES_RELEASE Boost::context Boost::filesystem Boost::_libboost)
set(Boost_fiber_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT fiber FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_fiber_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_fiber_FRAMEWORKS_FOUND_RELEASE "${Boost_fiber_FRAMEWORKS_RELEASE}" "${Boost_fiber_FRAMEWORK_DIRS_RELEASE}")

set(Boost_fiber_LIB_TARGETS_RELEASE "")
set(Boost_fiber_NOT_USED_RELEASE "")
set(Boost_fiber_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_fiber_FRAMEWORKS_FOUND_RELEASE} ${Boost_fiber_SYSTEM_LIBS_RELEASE} ${Boost_fiber_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_fiber_LIBS_RELEASE}"
                              "${Boost_fiber_LIB_DIRS_RELEASE}"
                              "${Boost_fiber_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_fiber_NOT_USED_RELEASE
                              Boost_fiber_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_fiber")

set(Boost_fiber_LINK_LIBS_RELEASE ${Boost_fiber_LIB_TARGETS_RELEASE} ${Boost_fiber_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT fiber_numa VARIABLES #############################################

set(Boost_fiber_numa_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_numa_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_numa_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_fiber_numa_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_fiber_numa_RES_DIRS_RELEASE )
set(Boost_fiber_numa_DEFINITIONS_RELEASE )
set(Boost_fiber_numa_COMPILE_DEFINITIONS_RELEASE )
set(Boost_fiber_numa_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_fiber_numa_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_fiber_numa_LIBS_RELEASE libboost_fiber_numa)
set(Boost_fiber_numa_SYSTEM_LIBS_RELEASE )
set(Boost_fiber_numa_FRAMEWORK_DIRS_RELEASE )
set(Boost_fiber_numa_FRAMEWORKS_RELEASE )
set(Boost_fiber_numa_BUILD_MODULES_PATHS_RELEASE )
set(Boost_fiber_numa_DEPENDENCIES_RELEASE Boost::fiber Boost::_libboost)
set(Boost_fiber_numa_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT fiber_numa FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_fiber_numa_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_fiber_numa_FRAMEWORKS_FOUND_RELEASE "${Boost_fiber_numa_FRAMEWORKS_RELEASE}" "${Boost_fiber_numa_FRAMEWORK_DIRS_RELEASE}")

set(Boost_fiber_numa_LIB_TARGETS_RELEASE "")
set(Boost_fiber_numa_NOT_USED_RELEASE "")
set(Boost_fiber_numa_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_fiber_numa_FRAMEWORKS_FOUND_RELEASE} ${Boost_fiber_numa_SYSTEM_LIBS_RELEASE} ${Boost_fiber_numa_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_fiber_numa_LIBS_RELEASE}"
                              "${Boost_fiber_numa_LIB_DIRS_RELEASE}"
                              "${Boost_fiber_numa_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_fiber_numa_NOT_USED_RELEASE
                              Boost_fiber_numa_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_fiber_numa")

set(Boost_fiber_numa_LINK_LIBS_RELEASE ${Boost_fiber_numa_LIB_TARGETS_RELEASE} ${Boost_fiber_numa_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT coroutine VARIABLES #############################################

set(Boost_coroutine_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_coroutine_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_coroutine_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_coroutine_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_coroutine_RES_DIRS_RELEASE )
set(Boost_coroutine_DEFINITIONS_RELEASE )
set(Boost_coroutine_COMPILE_DEFINITIONS_RELEASE )
set(Boost_coroutine_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_coroutine_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_coroutine_LIBS_RELEASE libboost_coroutine)
set(Boost_coroutine_SYSTEM_LIBS_RELEASE )
set(Boost_coroutine_FRAMEWORK_DIRS_RELEASE )
set(Boost_coroutine_FRAMEWORKS_RELEASE )
set(Boost_coroutine_BUILD_MODULES_PATHS_RELEASE )
set(Boost_coroutine_DEPENDENCIES_RELEASE Boost::context Boost::exception Boost::system Boost::_libboost)
set(Boost_coroutine_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT coroutine FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_coroutine_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_coroutine_FRAMEWORKS_FOUND_RELEASE "${Boost_coroutine_FRAMEWORKS_RELEASE}" "${Boost_coroutine_FRAMEWORK_DIRS_RELEASE}")

set(Boost_coroutine_LIB_TARGETS_RELEASE "")
set(Boost_coroutine_NOT_USED_RELEASE "")
set(Boost_coroutine_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_coroutine_FRAMEWORKS_FOUND_RELEASE} ${Boost_coroutine_SYSTEM_LIBS_RELEASE} ${Boost_coroutine_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_coroutine_LIBS_RELEASE}"
                              "${Boost_coroutine_LIB_DIRS_RELEASE}"
                              "${Boost_coroutine_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_coroutine_NOT_USED_RELEASE
                              Boost_coroutine_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_coroutine")

set(Boost_coroutine_LINK_LIBS_RELEASE ${Boost_coroutine_LIB_TARGETS_RELEASE} ${Boost_coroutine_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT contract VARIABLES #############################################

set(Boost_contract_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_contract_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_contract_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_contract_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_contract_RES_DIRS_RELEASE )
set(Boost_contract_DEFINITIONS_RELEASE )
set(Boost_contract_COMPILE_DEFINITIONS_RELEASE )
set(Boost_contract_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_contract_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_contract_LIBS_RELEASE libboost_contract)
set(Boost_contract_SYSTEM_LIBS_RELEASE )
set(Boost_contract_FRAMEWORK_DIRS_RELEASE )
set(Boost_contract_FRAMEWORKS_RELEASE )
set(Boost_contract_BUILD_MODULES_PATHS_RELEASE )
set(Boost_contract_DEPENDENCIES_RELEASE Boost::exception Boost::thread Boost::_libboost)
set(Boost_contract_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT contract FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_contract_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_contract_FRAMEWORKS_FOUND_RELEASE "${Boost_contract_FRAMEWORKS_RELEASE}" "${Boost_contract_FRAMEWORK_DIRS_RELEASE}")

set(Boost_contract_LIB_TARGETS_RELEASE "")
set(Boost_contract_NOT_USED_RELEASE "")
set(Boost_contract_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_contract_FRAMEWORKS_FOUND_RELEASE} ${Boost_contract_SYSTEM_LIBS_RELEASE} ${Boost_contract_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_contract_LIBS_RELEASE}"
                              "${Boost_contract_LIB_DIRS_RELEASE}"
                              "${Boost_contract_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_contract_NOT_USED_RELEASE
                              Boost_contract_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_contract")

set(Boost_contract_LINK_LIBS_RELEASE ${Boost_contract_LIB_TARGETS_RELEASE} ${Boost_contract_LIBS_FRAMEWORKS_DEPS_RELEASE})

########### COMPONENT boost VARIABLES #############################################

set(Boost_boost_INCLUDE_DIRS_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_boost_INCLUDE_DIR_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_boost_INCLUDES_RELEASE "C:/.conan/10a1cc/1/include")
set(Boost_boost_LIB_DIRS_RELEASE "C:/.conan/10a1cc/1/lib")
set(Boost_boost_RES_DIRS_RELEASE )
set(Boost_boost_DEFINITIONS_RELEASE )
set(Boost_boost_COMPILE_DEFINITIONS_RELEASE )
set(Boost_boost_COMPILE_OPTIONS_C_RELEASE "")
set(Boost_boost_COMPILE_OPTIONS_CXX_RELEASE "")
set(Boost_boost_LIBS_RELEASE )
set(Boost_boost_SYSTEM_LIBS_RELEASE )
set(Boost_boost_FRAMEWORK_DIRS_RELEASE )
set(Boost_boost_FRAMEWORKS_RELEASE )
set(Boost_boost_BUILD_MODULES_PATHS_RELEASE )
set(Boost_boost_DEPENDENCIES_RELEASE Boost::headers)
set(Boost_boost_LINKER_FLAGS_LIST_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>
)

########## COMPONENT boost FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(Boost_boost_FRAMEWORKS_FOUND_RELEASE "")
conan_find_apple_frameworks(Boost_boost_FRAMEWORKS_FOUND_RELEASE "${Boost_boost_FRAMEWORKS_RELEASE}" "${Boost_boost_FRAMEWORK_DIRS_RELEASE}")

set(Boost_boost_LIB_TARGETS_RELEASE "")
set(Boost_boost_NOT_USED_RELEASE "")
set(Boost_boost_LIBS_FRAMEWORKS_DEPS_RELEASE ${Boost_boost_FRAMEWORKS_FOUND_RELEASE} ${Boost_boost_SYSTEM_LIBS_RELEASE} ${Boost_boost_DEPENDENCIES_RELEASE})
conan_package_library_targets("${Boost_boost_LIBS_RELEASE}"
                              "${Boost_boost_LIB_DIRS_RELEASE}"
                              "${Boost_boost_LIBS_FRAMEWORKS_DEPS_RELEASE}"
                              Boost_boost_NOT_USED_RELEASE
                              Boost_boost_LIB_TARGETS_RELEASE
                              "RELEASE"
                              "Boost_boost")

set(Boost_boost_LINK_LIBS_RELEASE ${Boost_boost_LIB_TARGETS_RELEASE} ${Boost_boost_LIBS_FRAMEWORKS_DEPS_RELEASE})