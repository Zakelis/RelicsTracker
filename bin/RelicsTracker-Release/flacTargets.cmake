

if(NOT TARGET FLAC::FLAC)
    add_library(FLAC::FLAC INTERFACE IMPORTED)
endif()

if(NOT TARGET FLAC::FLAC++)
    add_library(FLAC::FLAC++ INTERFACE IMPORTED)
endif()

if(NOT TARGET FLAC::FLAC)
    add_library(FLAC::FLAC INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/flacTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()

if(flac_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${flac_FIND_COMPONENTS})
        list(FIND FLAC_COMPONENTS_RELEASE "FLAC::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'FLAC'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'FLAC'")
        endif()
    endforeach()
endif()