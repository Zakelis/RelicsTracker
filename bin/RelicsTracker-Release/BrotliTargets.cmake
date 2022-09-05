

if(NOT TARGET Brotli::brotlicommon)
    add_library(Brotli::brotlicommon INTERFACE IMPORTED)
endif()

if(NOT TARGET Brotli::brotlienc)
    add_library(Brotli::brotlienc INTERFACE IMPORTED)
endif()

if(NOT TARGET Brotli::brotlidec)
    add_library(Brotli::brotlidec INTERFACE IMPORTED)
endif()

if(NOT TARGET Brotli::Brotli)
    add_library(Brotli::Brotli INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/BrotliTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()

if(Brotli_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${Brotli_FIND_COMPONENTS})
        list(FIND Brotli_COMPONENTS_RELEASE "Brotli::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'Brotli'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'Brotli'")
        endif()
    endforeach()
endif()