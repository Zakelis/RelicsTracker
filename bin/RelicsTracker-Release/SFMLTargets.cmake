

if(NOT TARGET SFML::system)
    add_library(SFML::system INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::audio)
    add_library(SFML::audio INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::network)
    add_library(SFML::network INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::window)
    add_library(SFML::window INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::graphics)
    add_library(SFML::graphics INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::main)
    add_library(SFML::main INTERFACE IMPORTED)
endif()

if(NOT TARGET SFML::SFML)
    add_library(SFML::SFML INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/SFMLTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()

if(SFML_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${SFML_FIND_COMPONENTS})
        list(FIND SFML_COMPONENTS_RELEASE "SFML::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'SFML'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'SFML'")
        endif()
    endforeach()
endif()