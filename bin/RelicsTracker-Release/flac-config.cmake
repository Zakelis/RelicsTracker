########## MACROS ###########################################################################
#############################################################################################

function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


# Requires CMake > 3.0
if(${CMAKE_VERSION} VERSION_LESS "3.0")
    message(FATAL_ERROR "The 'cmake_find_package_multi' generator only works with CMake > 3.0")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/flacTargets.cmake)

########## FIND PACKAGE DEPENDENCY ##########################################################
#############################################################################################

include(CMakeFindDependencyMacro)

if(NOT Ogg_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(Ogg REQUIRED NO_MODULE)
    else()
        find_dependency(Ogg REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency Ogg already found")
endif()

########## TARGETS PROPERTIES ###############################################################
#############################################################################################

########## COMPONENT FLAC TARGET PROPERTIES ######################################

set_property(TARGET FLAC::FLAC PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${FLAC_FLAC_LINK_LIBS_DEBUG}
                ${FLAC_FLAC_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC_LINK_LIBS_RELEASE}
                ${FLAC_FLAC_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC_LINK_LIBS_RELWITHDEBINFO}
                ${FLAC_FLAC_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC_LINK_LIBS_MINSIZEREL}
                ${FLAC_FLAC_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${FLAC_FLAC_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${FLAC_FLAC_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${FLAC_FLAC_COMPILE_OPTIONS_C_DEBUG}
                 ${FLAC_FLAC_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${FLAC_FLAC_COMPILE_OPTIONS_C_RELEASE}
                 ${FLAC_FLAC_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${FLAC_FLAC_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${FLAC_FLAC_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${FLAC_FLAC_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${FLAC_FLAC_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(FLAC_FLAC_TARGET_PROPERTIES TRUE)

########## COMPONENT FLAC++ TARGET PROPERTIES ######################################

set_property(TARGET FLAC::FLAC++ PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${FLAC_FLAC++_LINK_LIBS_DEBUG}
                ${FLAC_FLAC++_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC++_LINK_LIBS_RELEASE}
                ${FLAC_FLAC++_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC++_LINK_LIBS_RELWITHDEBINFO}
                ${FLAC_FLAC++_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC++_LINK_LIBS_MINSIZEREL}
                ${FLAC_FLAC++_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC++ PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${FLAC_FLAC++_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC++_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC++_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC++_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC++ PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${FLAC_FLAC++_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${FLAC_FLAC++_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${FLAC_FLAC++_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${FLAC_FLAC++_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET FLAC::FLAC++ PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${FLAC_FLAC++_COMPILE_OPTIONS_C_DEBUG}
                 ${FLAC_FLAC++_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${FLAC_FLAC++_COMPILE_OPTIONS_C_RELEASE}
                 ${FLAC_FLAC++_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${FLAC_FLAC++_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${FLAC_FLAC++_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${FLAC_FLAC++_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${FLAC_FLAC++_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(FLAC_FLAC++_TARGET_PROPERTIES TRUE)

########## GLOBAL TARGET PROPERTIES #########################################################

if(NOT FLAC_FLAC_TARGET_PROPERTIES)
    set_property(TARGET FLAC::FLAC APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${FLAC_COMPONENTS_DEBUG}>
                 $<$<CONFIG:Release>:${FLAC_COMPONENTS_RELEASE}>
                 $<$<CONFIG:RelWithDebInfo>:${FLAC_COMPONENTS_RELWITHDEBINFO}>
                 $<$<CONFIG:MinSizeRel>:${FLAC_COMPONENTS_MINSIZEREL}>)
endif()

########## BUILD MODULES ####################################################################
#############################################################################################

########## COMPONENT FLAC BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT FLAC++ BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC++_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC++_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC++_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${FLAC_FLAC++_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()