
if(NOT TARGET stb::stb)
    add_library(stb::stb INTERFACE IMPORTED)
endif()

# Load the debug and release library finders
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
file(GLOB CONFIG_FILES "${_DIR}/stbTarget-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()
