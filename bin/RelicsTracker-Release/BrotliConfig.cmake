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

include(${CMAKE_CURRENT_LIST_DIR}/BrotliTargets.cmake)

########## FIND PACKAGE DEPENDENCY ##########################################################
#############################################################################################

include(CMakeFindDependencyMacro)

########## TARGETS PROPERTIES ###############################################################
#############################################################################################

########## COMPONENT brotlicommon TARGET PROPERTIES ######################################

set_property(TARGET Brotli::brotlicommon PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Brotli_brotlicommon_LINK_LIBS_DEBUG}
                ${Brotli_brotlicommon_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlicommon_LINK_LIBS_RELEASE}
                ${Brotli_brotlicommon_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlicommon_LINK_LIBS_RELWITHDEBINFO}
                ${Brotli_brotlicommon_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlicommon_LINK_LIBS_MINSIZEREL}
                ${Brotli_brotlicommon_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Brotli::brotlicommon PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Brotli_brotlicommon_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlicommon_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlicommon_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlicommon_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlicommon PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Brotli_brotlicommon_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlicommon_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlicommon_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlicommon_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlicommon PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_C_DEBUG}
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_C_RELEASE}
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Brotli_brotlicommon_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Brotli_brotlicommon_TARGET_PROPERTIES TRUE)

########## COMPONENT brotlienc TARGET PROPERTIES ######################################

set_property(TARGET Brotli::brotlienc PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Brotli_brotlienc_LINK_LIBS_DEBUG}
                ${Brotli_brotlienc_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlienc_LINK_LIBS_RELEASE}
                ${Brotli_brotlienc_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlienc_LINK_LIBS_RELWITHDEBINFO}
                ${Brotli_brotlienc_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlienc_LINK_LIBS_MINSIZEREL}
                ${Brotli_brotlienc_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Brotli::brotlienc PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Brotli_brotlienc_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlienc_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlienc_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlienc_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlienc PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Brotli_brotlienc_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlienc_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlienc_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlienc_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlienc PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Brotli_brotlienc_COMPILE_OPTIONS_C_DEBUG}
                 ${Brotli_brotlienc_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Brotli_brotlienc_COMPILE_OPTIONS_C_RELEASE}
                 ${Brotli_brotlienc_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Brotli_brotlienc_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Brotli_brotlienc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Brotli_brotlienc_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Brotli_brotlienc_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Brotli_brotlienc_TARGET_PROPERTIES TRUE)

########## COMPONENT brotlidec TARGET PROPERTIES ######################################

set_property(TARGET Brotli::brotlidec PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Brotli_brotlidec_LINK_LIBS_DEBUG}
                ${Brotli_brotlidec_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlidec_LINK_LIBS_RELEASE}
                ${Brotli_brotlidec_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlidec_LINK_LIBS_RELWITHDEBINFO}
                ${Brotli_brotlidec_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlidec_LINK_LIBS_MINSIZEREL}
                ${Brotli_brotlidec_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Brotli::brotlidec PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Brotli_brotlidec_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlidec_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlidec_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlidec_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlidec PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Brotli_brotlidec_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Brotli_brotlidec_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Brotli_brotlidec_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Brotli_brotlidec_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Brotli::brotlidec PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Brotli_brotlidec_COMPILE_OPTIONS_C_DEBUG}
                 ${Brotli_brotlidec_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Brotli_brotlidec_COMPILE_OPTIONS_C_RELEASE}
                 ${Brotli_brotlidec_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Brotli_brotlidec_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Brotli_brotlidec_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Brotli_brotlidec_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Brotli_brotlidec_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Brotli_brotlidec_TARGET_PROPERTIES TRUE)

########## GLOBAL TARGET PROPERTIES #########################################################

if(NOT Brotli_Brotli_TARGET_PROPERTIES)
    set_property(TARGET Brotli::Brotli APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${Brotli_COMPONENTS_DEBUG}>
                 $<$<CONFIG:Release>:${Brotli_COMPONENTS_RELEASE}>
                 $<$<CONFIG:RelWithDebInfo>:${Brotli_COMPONENTS_RELWITHDEBINFO}>
                 $<$<CONFIG:MinSizeRel>:${Brotli_COMPONENTS_MINSIZEREL}>)
endif()

########## BUILD MODULES ####################################################################
#############################################################################################

########## COMPONENT brotlicommon BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Brotli_brotlicommon_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlicommon_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlicommon_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlicommon_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT brotlienc BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Brotli_brotlienc_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlienc_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlienc_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlienc_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT brotlidec BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Brotli_brotlidec_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlidec_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlidec_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Brotli_brotlidec_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()