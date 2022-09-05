

if(NOT TARGET Ogg::ogg)
    add_library(Ogg::ogg INTERFACE IMPORTED)
endif()

if(NOT TARGET Ogg::Ogg)
    add_library(Ogg::Ogg INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/OggTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()

if(Ogg_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${Ogg_FIND_COMPONENTS})
        list(FIND Ogg_COMPONENTS_RELEASE "Ogg::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'Ogg'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'Ogg'")
        endif()
    endforeach()
endif()