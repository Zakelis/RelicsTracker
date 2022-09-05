

if(NOT TARGET Vorbis::vorbis)
    add_library(Vorbis::vorbis INTERFACE IMPORTED)
endif()

if(NOT TARGET Vorbis::vorbisfile)
    add_library(Vorbis::vorbisfile INTERFACE IMPORTED)
endif()

if(NOT TARGET Vorbis::File)
    add_library(Vorbis::File INTERFACE IMPORTED)
endif()

if(NOT TARGET Vorbis::vorbisenc)
    add_library(Vorbis::vorbisenc INTERFACE IMPORTED)
endif()

if(NOT TARGET Vorbis::Enc)
    add_library(Vorbis::Enc INTERFACE IMPORTED)
endif()

if(NOT TARGET Vorbis::Vorbis)
    add_library(Vorbis::Vorbis INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/VorbisTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()

if(Vorbis_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${Vorbis_FIND_COMPONENTS})
        list(FIND Vorbis_COMPONENTS_RELEASE "Vorbis::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'Vorbis'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'Vorbis'")
        endif()
    endforeach()
endif()