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

include(${CMAKE_CURRENT_LIST_DIR}/VorbisTargets.cmake)

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

########## COMPONENT vorbis TARGET PROPERTIES ######################################

set_property(TARGET Vorbis::vorbis PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Vorbis_vorbis_LINK_LIBS_DEBUG}
                ${Vorbis_vorbis_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbis_LINK_LIBS_RELEASE}
                ${Vorbis_vorbis_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbis_LINK_LIBS_RELWITHDEBINFO}
                ${Vorbis_vorbis_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbis_LINK_LIBS_MINSIZEREL}
                ${Vorbis_vorbis_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbis PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Vorbis_vorbis_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbis_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbis_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbis_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbis PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Vorbis_vorbis_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbis_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbis_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbis_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbis PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Vorbis_vorbis_COMPILE_OPTIONS_C_DEBUG}
                 ${Vorbis_vorbis_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Vorbis_vorbis_COMPILE_OPTIONS_C_RELEASE}
                 ${Vorbis_vorbis_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Vorbis_vorbis_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Vorbis_vorbis_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Vorbis_vorbis_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Vorbis_vorbis_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Vorbis_vorbis_TARGET_PROPERTIES TRUE)

########## COMPONENT vorbisfile TARGET PROPERTIES ######################################

set_property(TARGET Vorbis::vorbisfile PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Vorbis_vorbisfile_LINK_LIBS_DEBUG}
                ${Vorbis_vorbisfile_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisfile_LINK_LIBS_RELEASE}
                ${Vorbis_vorbisfile_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisfile_LINK_LIBS_RELWITHDEBINFO}
                ${Vorbis_vorbisfile_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisfile_LINK_LIBS_MINSIZEREL}
                ${Vorbis_vorbisfile_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisfile PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Vorbis_vorbisfile_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisfile_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisfile_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisfile_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisfile PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Vorbis_vorbisfile_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisfile_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisfile_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisfile_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisfile PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_C_DEBUG}
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_C_RELEASE}
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Vorbis_vorbisfile_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Vorbis_vorbisfile_TARGET_PROPERTIES TRUE)

########## COMPONENT File TARGET PROPERTIES ######################################

set_property(TARGET Vorbis::File PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Vorbis_File_LINK_LIBS_DEBUG}
                ${Vorbis_File_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_File_LINK_LIBS_RELEASE}
                ${Vorbis_File_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_File_LINK_LIBS_RELWITHDEBINFO}
                ${Vorbis_File_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_File_LINK_LIBS_MINSIZEREL}
                ${Vorbis_File_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Vorbis::File PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Vorbis_File_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_File_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_File_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_File_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Vorbis::File PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Vorbis_File_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_File_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_File_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_File_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Vorbis::File PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Vorbis_File_COMPILE_OPTIONS_C_DEBUG}
                 ${Vorbis_File_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Vorbis_File_COMPILE_OPTIONS_C_RELEASE}
                 ${Vorbis_File_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Vorbis_File_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Vorbis_File_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Vorbis_File_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Vorbis_File_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Vorbis_File_TARGET_PROPERTIES TRUE)

########## COMPONENT vorbisenc TARGET PROPERTIES ######################################

set_property(TARGET Vorbis::vorbisenc PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Vorbis_vorbisenc_LINK_LIBS_DEBUG}
                ${Vorbis_vorbisenc_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisenc_LINK_LIBS_RELEASE}
                ${Vorbis_vorbisenc_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisenc_LINK_LIBS_RELWITHDEBINFO}
                ${Vorbis_vorbisenc_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisenc_LINK_LIBS_MINSIZEREL}
                ${Vorbis_vorbisenc_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisenc PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Vorbis_vorbisenc_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisenc_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisenc_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisenc_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisenc PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Vorbis_vorbisenc_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_vorbisenc_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_vorbisenc_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_vorbisenc_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Vorbis::vorbisenc PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_C_DEBUG}
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_C_RELEASE}
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Vorbis_vorbisenc_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Vorbis_vorbisenc_TARGET_PROPERTIES TRUE)

########## COMPONENT Enc TARGET PROPERTIES ######################################

set_property(TARGET Vorbis::Enc PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${Vorbis_Enc_LINK_LIBS_DEBUG}
                ${Vorbis_Enc_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_Enc_LINK_LIBS_RELEASE}
                ${Vorbis_Enc_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_Enc_LINK_LIBS_RELWITHDEBINFO}
                ${Vorbis_Enc_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_Enc_LINK_LIBS_MINSIZEREL}
                ${Vorbis_Enc_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET Vorbis::Enc PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${Vorbis_Enc_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_Enc_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_Enc_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_Enc_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET Vorbis::Enc PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${Vorbis_Enc_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${Vorbis_Enc_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${Vorbis_Enc_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${Vorbis_Enc_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET Vorbis::Enc PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${Vorbis_Enc_COMPILE_OPTIONS_C_DEBUG}
                 ${Vorbis_Enc_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${Vorbis_Enc_COMPILE_OPTIONS_C_RELEASE}
                 ${Vorbis_Enc_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${Vorbis_Enc_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${Vorbis_Enc_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${Vorbis_Enc_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${Vorbis_Enc_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(Vorbis_Enc_TARGET_PROPERTIES TRUE)

########## GLOBAL TARGET PROPERTIES #########################################################

if(NOT Vorbis_Vorbis_TARGET_PROPERTIES)
    set_property(TARGET Vorbis::Vorbis APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${Vorbis_COMPONENTS_DEBUG}>
                 $<$<CONFIG:Release>:${Vorbis_COMPONENTS_RELEASE}>
                 $<$<CONFIG:RelWithDebInfo>:${Vorbis_COMPONENTS_RELWITHDEBINFO}>
                 $<$<CONFIG:MinSizeRel>:${Vorbis_COMPONENTS_MINSIZEREL}>)
endif()

########## BUILD MODULES ####################################################################
#############################################################################################

########## COMPONENT vorbis BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbis_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbis_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbis_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbis_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT vorbisfile BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisfile_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisfile_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisfile_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisfile_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT File BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Vorbis_File_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_File_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_File_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_File_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT vorbisenc BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisenc_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisenc_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisenc_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_vorbisenc_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT Enc BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${Vorbis_Enc_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_Enc_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_Enc_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${Vorbis_Enc_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()