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

include(${CMAKE_CURRENT_LIST_DIR}/SFMLTargets.cmake)

########## FIND PACKAGE DEPENDENCY ##########################################################
#############################################################################################

include(CMakeFindDependencyMacro)

if(NOT freetype_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(freetype REQUIRED NO_MODULE)
    else()
        find_dependency(freetype REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency freetype already found")
endif()

if(NOT stb_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(stb REQUIRED NO_MODULE)
    else()
        find_dependency(stb REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency stb already found")
endif()

if(NOT opengl_system_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(opengl_system REQUIRED NO_MODULE)
    else()
        find_dependency(opengl_system REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency opengl_system already found")
endif()

if(NOT flac_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(flac REQUIRED NO_MODULE)
    else()
        find_dependency(flac REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency flac already found")
endif()

if(NOT OpenAL_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(OpenAL REQUIRED NO_MODULE)
    else()
        find_dependency(OpenAL REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency OpenAL already found")
endif()

if(NOT Vorbis_FOUND)
    if(${CMAKE_VERSION} VERSION_LESS "3.9.0")
        find_package(Vorbis REQUIRED NO_MODULE)
    else()
        find_dependency(Vorbis REQUIRED NO_MODULE)
    endif()
else()
    message(STATUS "Dependency Vorbis already found")
endif()

########## TARGETS PROPERTIES ###############################################################
#############################################################################################

########## COMPONENT system TARGET PROPERTIES ######################################

set_property(TARGET SFML::system PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_system_LINK_LIBS_DEBUG}
                ${SFML_system_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_system_LINK_LIBS_RELEASE}
                ${SFML_system_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_system_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_system_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_system_LINK_LIBS_MINSIZEREL}
                ${SFML_system_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::system PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_system_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_system_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_system_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_system_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::system PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_system_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_system_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_system_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_system_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::system PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_system_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_system_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_system_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_system_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_system_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_system_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_system_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_system_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_system_TARGET_PROPERTIES TRUE)

########## COMPONENT audio TARGET PROPERTIES ######################################

set_property(TARGET SFML::audio PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_audio_LINK_LIBS_DEBUG}
                ${SFML_audio_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_audio_LINK_LIBS_RELEASE}
                ${SFML_audio_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_audio_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_audio_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_audio_LINK_LIBS_MINSIZEREL}
                ${SFML_audio_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::audio PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_audio_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_audio_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_audio_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_audio_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::audio PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_audio_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_audio_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_audio_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_audio_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::audio PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_audio_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_audio_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_audio_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_audio_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_audio_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_audio_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_audio_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_audio_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_audio_TARGET_PROPERTIES TRUE)

########## COMPONENT network TARGET PROPERTIES ######################################

set_property(TARGET SFML::network PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_network_LINK_LIBS_DEBUG}
                ${SFML_network_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_network_LINK_LIBS_RELEASE}
                ${SFML_network_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_network_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_network_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_network_LINK_LIBS_MINSIZEREL}
                ${SFML_network_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::network PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_network_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_network_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_network_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_network_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::network PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_network_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_network_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_network_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_network_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::network PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_network_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_network_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_network_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_network_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_network_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_network_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_network_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_network_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_network_TARGET_PROPERTIES TRUE)

########## COMPONENT window TARGET PROPERTIES ######################################

set_property(TARGET SFML::window PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_window_LINK_LIBS_DEBUG}
                ${SFML_window_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_window_LINK_LIBS_RELEASE}
                ${SFML_window_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_window_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_window_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_window_LINK_LIBS_MINSIZEREL}
                ${SFML_window_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::window PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_window_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_window_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_window_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_window_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::window PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_window_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_window_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_window_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_window_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::window PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_window_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_window_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_window_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_window_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_window_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_window_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_window_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_window_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_window_TARGET_PROPERTIES TRUE)

########## COMPONENT graphics TARGET PROPERTIES ######################################

set_property(TARGET SFML::graphics PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_graphics_LINK_LIBS_DEBUG}
                ${SFML_graphics_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_graphics_LINK_LIBS_RELEASE}
                ${SFML_graphics_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_graphics_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_graphics_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_graphics_LINK_LIBS_MINSIZEREL}
                ${SFML_graphics_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::graphics PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_graphics_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_graphics_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_graphics_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_graphics_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::graphics PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_graphics_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_graphics_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_graphics_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_graphics_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::graphics PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_graphics_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_graphics_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_graphics_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_graphics_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_graphics_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_graphics_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_graphics_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_graphics_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_graphics_TARGET_PROPERTIES TRUE)

########## COMPONENT main TARGET PROPERTIES ######################################

set_property(TARGET SFML::main PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${SFML_main_LINK_LIBS_DEBUG}
                ${SFML_main_LINKER_FLAGS_LIST_DEBUG}>
             $<$<CONFIG:Release>:${SFML_main_LINK_LIBS_RELEASE}
                ${SFML_main_LINKER_FLAGS_LIST_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_main_LINK_LIBS_RELWITHDEBINFO}
                ${SFML_main_LINKER_FLAGS_LIST_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_main_LINK_LIBS_MINSIZEREL}
                ${SFML_main_LINKER_FLAGS_LIST_MINSIZEREL}>)
set_property(TARGET SFML::main PROPERTY INTERFACE_INCLUDE_DIRECTORIES
             $<$<CONFIG:Debug>:${SFML_main_INCLUDE_DIRS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_main_INCLUDE_DIRS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_main_INCLUDE_DIRS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_main_INCLUDE_DIRS_MINSIZEREL}>)
set_property(TARGET SFML::main PROPERTY INTERFACE_COMPILE_DEFINITIONS
             $<$<CONFIG:Debug>:${SFML_main_COMPILE_DEFINITIONS_DEBUG}>
             $<$<CONFIG:Release>:${SFML_main_COMPILE_DEFINITIONS_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:${SFML_main_COMPILE_DEFINITIONS_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:${SFML_main_COMPILE_DEFINITIONS_MINSIZEREL}>)
set_property(TARGET SFML::main PROPERTY INTERFACE_COMPILE_OPTIONS
             $<$<CONFIG:Debug>:
                 ${SFML_main_COMPILE_OPTIONS_C_DEBUG}
                 ${SFML_main_COMPILE_OPTIONS_CXX_DEBUG}>
             $<$<CONFIG:Release>:
                 ${SFML_main_COMPILE_OPTIONS_C_RELEASE}
                 ${SFML_main_COMPILE_OPTIONS_CXX_RELEASE}>
             $<$<CONFIG:RelWithDebInfo>:
                 ${SFML_main_COMPILE_OPTIONS_C_RELWITHDEBINFO}
                 ${SFML_main_COMPILE_OPTIONS_CXX_RELWITHDEBINFO}>
             $<$<CONFIG:MinSizeRel>:
                 ${SFML_main_COMPILE_OPTIONS_C_MINSIZEREL}
                 ${SFML_main_COMPILE_OPTIONS_CXX_MINSIZEREL}>)
set(SFML_main_TARGET_PROPERTIES TRUE)

########## GLOBAL TARGET PROPERTIES #########################################################

if(NOT SFML_SFML_TARGET_PROPERTIES)
    set_property(TARGET SFML::SFML APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${SFML_COMPONENTS_DEBUG}>
                 $<$<CONFIG:Release>:${SFML_COMPONENTS_RELEASE}>
                 $<$<CONFIG:RelWithDebInfo>:${SFML_COMPONENTS_RELWITHDEBINFO}>
                 $<$<CONFIG:MinSizeRel>:${SFML_COMPONENTS_MINSIZEREL}>)
endif()

########## BUILD MODULES ####################################################################
#############################################################################################

########## COMPONENT system BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_system_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_system_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_system_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_system_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT audio BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_audio_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_audio_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_audio_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_audio_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT network BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_network_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_network_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_network_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_network_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT window BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_window_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_window_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_window_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_window_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT graphics BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_graphics_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_graphics_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_graphics_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_graphics_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()

########## COMPONENT main BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${SFML_main_BUILD_MODULES_PATHS_DEBUG})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_main_BUILD_MODULES_PATHS_RELEASE})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_main_BUILD_MODULES_PATHS_RELWITHDEBINFO})
    include(${_BUILD_MODULE_PATH})
endforeach()

foreach(_BUILD_MODULE_PATH ${SFML_main_BUILD_MODULES_PATHS_MINSIZEREL})
    include(${_BUILD_MODULE_PATH})
endforeach()