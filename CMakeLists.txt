# CMakeLists.txt

cmake_minimum_required (VERSION 3.8)
project (RelicsTracker)

#Boost
if (WIN32)
    macro(get_WIN32_WINNT version)
        if (CMAKE_SYSTEM_VERSION)
            set(ver ${CMAKE_SYSTEM_VERSION})
            string(REGEX MATCH "^([0-9]+).([0-9])" ver ${ver})
            string(REGEX MATCH "^([0-9]+)" verMajor ${ver})
            # Check for Windows 10, b/c we'll need to convert to hex 'A'.
            if ("${verMajor}" MATCHES "10")
                set(verMajor "A")
                string(REGEX REPLACE "^([0-9]+)" ${verMajor} ver ${ver})
            endif ()
            # Remove all remaining '.' characters.
            string(REPLACE "." "" ver ${ver})
            # Prepend each digit with a zero.
            string(REGEX REPLACE "([0-9A-Z])" "0\\1" ver ${ver})
            set(${version} "0x${ver}")
        endif ()
    endmacro()

    get_WIN32_WINNT(ver)
    add_definitions(-D_WIN32_WINNT=${ver})
endif ()

# Download automatically, you can also just copy the conan.cmake file
if (NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
    file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.16.1/conan.cmake"
            "${CMAKE_BINARY_DIR}/conan.cmake"
            TLS_VERIFY ON)
endif ()

include(${CMAKE_BINARY_DIR}/conan.cmake)
conan_cmake_run(
        CONANFILE
        conanfile.txt
        BASIC_SETUP
        CMAKE_TARGETS
        BUILD missing
)

# Headers QOL
include_directories(include)

# Sources
add_executable(RelicsTracker
        src/main.cpp
        src/ComputationHandler.cpp
        src/Object.cpp
        src/RequestHandler.cpp
        include/ComputationHandler.h
        include/Object.h
        include/RequestHandler.h
)

include(${CMAKE_BINARY_DIR}/conan_paths.cmake)

find_package(OpenSSL COMPONENTS Crypto SSL QUIET)
find_package(httplib REQUIRED)
find_package(ZLIB REQUIRED)
find_package(nlohmann_json REQUIRED)

target_link_libraries(RelicsTracker ZLIB::ZLIB OpenSSL::SSL OpenSSL::Crypto httplib::httplib nlohmann_json::nlohmann_json)