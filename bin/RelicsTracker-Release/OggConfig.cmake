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

include(${CMAKE_CURRENT_LIST_DIR}/OggTargets.cmake)

########## FIND PACKAGE DEPENDENCY ##########################################################
#############################################################################################

include(CMakeFindDependencyMacro)

########## TARGETS PROPERTIES ###############################################################
#############################################################################################

########## COMPONENT ogg TARGET PROPERTIES ######################################

set_property(TARGET Ogg::ogg PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Ogg_ogg_LINK_LIBS_DEBUG}
                ${Ogg_ogg_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Ogg_ogg_LINK_LIBS_RELEASE}
                ${Ogg_ogg_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Ogg_ogg_LINK_LIBS_RELWITHDEBINFO}
                ${Ogg_ogg_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Ogg_ogg_LINK_LIBS_MINSIZEREL}
                ${Ogg_ogg_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Ogg::ogg PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Ogg_ogg_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Ogg_ogg_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Ogg_ogg_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Ogg_ogg_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Ogg::ogg PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Ogg_ogg_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Ogg_ogg_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Ogg_ogg_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Ogg_ogg_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Ogg::ogg PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Ogg_ogg_COMPILE_OPTIONS_C_DEBUG}
                 ${Ogg_ogg_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Ogg_ogg_COMPILE_OPTIONS_C_RELEASE}
                 ${Ogg_ogg_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Ogg_ogg_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Ogg_ogg_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Ogg_ogg_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Ogg_ogg_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Ogg_ogg_TARGET_PROPERTIES TRUE)

########## GLOBAL TARGET PROPERTIES #########################################################

if(NOT Ogg_Ogg_TARGET_PROPERTIES)
    set_property(TARGET Ogg::Ogg APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${Ogg_COMPONENTS_DEBUG}>
                 $<$<CONFIG:Release>:${Ogg_COMPONENTS_RELEASE}>
                 $<$<CONFIG:RelWithDebInfo>:${Ogg_COMPONENTS_RELWITHDEBINFO}>
                 $<$<CONFIG:MinSizeRel>:${Ogg_COMPONENTS_MINSIZEREL}>)
endif()

########## BUILD MODULES ####################################################################
#############################################################################################

########## COMPONENT ogg BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Ogg_ogg_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Ogg_ogg_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Ogg_ogg_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Ogg_ogg_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()