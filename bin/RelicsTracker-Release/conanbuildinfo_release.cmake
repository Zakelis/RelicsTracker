
#################
###  CPP-HTTPLIB
#################
set(CONAN_CPP-HTTPLIB_ROOT_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_CPP-HTTPLIB_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib")
set(CONAN_LIB_DIRS_CPP-HTTPLIB_RELEASE )
set(CONAN_BIN_DIRS_CPP-HTTPLIB_RELEASE )
set(CONAN_RES_DIRS_CPP-HTTPLIB_RELEASE )
set(CONAN_SRC_DIRS_CPP-HTTPLIB_RELEASE )
set(CONAN_BUILD_DIRS_CPP-HTTPLIB_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_CPP-HTTPLIB_RELEASE )
set(CONAN_LIBS_CPP-HTTPLIB_RELEASE )
set(CONAN_PKG_LIBS_CPP-HTTPLIB_RELEASE )
set(CONAN_SYSTEM_LIBS_CPP-HTTPLIB_RELEASE crypt32 cryptui ws2_32)
set(CONAN_FRAMEWORKS_CPP-HTTPLIB_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_CPP-HTTPLIB_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_CPP-HTTPLIB_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_CPP-HTTPLIB_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_CPP-HTTPLIB_RELEASE )

set(CONAN_C_FLAGS_CPP-HTTPLIB_RELEASE "")
set(CONAN_CXX_FLAGS_CPP-HTTPLIB_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_CPP-HTTPLIB_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_CPP-HTTPLIB_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_CPP-HTTPLIB_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_CPP-HTTPLIB_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_CPP-HTTPLIB_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_CPP-HTTPLIB_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_CPP-HTTPLIB_RELEASE "${CONAN_FRAMEWORKS_CPP-HTTPLIB_RELEASE}" "_CPP-HTTPLIB" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_CPP-HTTPLIB_RELEASE ${CONAN_PKG_LIBS_CPP-HTTPLIB_RELEASE} ${CONAN_SYSTEM_LIBS_CPP-HTTPLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_CPP-HTTPLIB_RELEASE})


#################
###  OPENSSL
#################
set(CONAN_OPENSSL_ROOT_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7")
set(CONAN_INCLUDE_DIRS_OPENSSL_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/include")
set(CONAN_LIB_DIRS_OPENSSL_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib")
set(CONAN_BIN_DIRS_OPENSSL_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/bin")
set(CONAN_RES_DIRS_OPENSSL_RELEASE )
set(CONAN_SRC_DIRS_OPENSSL_RELEASE )
set(CONAN_BUILD_DIRS_OPENSSL_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_OPENSSL_RELEASE )
set(CONAN_LIBS_OPENSSL_RELEASE libssl libcrypto)
set(CONAN_PKG_LIBS_OPENSSL_RELEASE libssl libcrypto)
set(CONAN_SYSTEM_LIBS_OPENSSL_RELEASE crypt32 ws2_32 advapi32 user32 bcrypt)
set(CONAN_FRAMEWORKS_OPENSSL_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_OPENSSL_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_OPENSSL_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_OPENSSL_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENSSL_RELEASE )

set(CONAN_C_FLAGS_OPENSSL_RELEASE "")
set(CONAN_CXX_FLAGS_OPENSSL_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENSSL_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_OPENSSL_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENSSL_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENSSL_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENSSL_RELEASE "${CONAN_FRAMEWORKS_OPENSSL_RELEASE}" "_OPENSSL" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_OPENSSL_RELEASE ${CONAN_PKG_LIBS_OPENSSL_RELEASE} ${CONAN_SYSTEM_LIBS_OPENSSL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENSSL_RELEASE})


#################
###  NLOHMANN_JSON
#################
set(CONAN_NLOHMANN_JSON_ROOT_RELEASE "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_NLOHMANN_JSON_RELEASE "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_NLOHMANN_JSON_RELEASE )
set(CONAN_BIN_DIRS_NLOHMANN_JSON_RELEASE )
set(CONAN_RES_DIRS_NLOHMANN_JSON_RELEASE )
set(CONAN_SRC_DIRS_NLOHMANN_JSON_RELEASE )
set(CONAN_BUILD_DIRS_NLOHMANN_JSON_RELEASE "C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_NLOHMANN_JSON_RELEASE )
set(CONAN_LIBS_NLOHMANN_JSON_RELEASE )
set(CONAN_PKG_LIBS_NLOHMANN_JSON_RELEASE )
set(CONAN_SYSTEM_LIBS_NLOHMANN_JSON_RELEASE )
set(CONAN_FRAMEWORKS_NLOHMANN_JSON_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_NLOHMANN_JSON_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_NLOHMANN_JSON_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_NLOHMANN_JSON_RELEASE )

set(CONAN_C_FLAGS_NLOHMANN_JSON_RELEASE "")
set(CONAN_CXX_FLAGS_NLOHMANN_JSON_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_NLOHMANN_JSON_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_NLOHMANN_JSON_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_NLOHMANN_JSON_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_NLOHMANN_JSON_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_RELEASE "${CONAN_FRAMEWORKS_NLOHMANN_JSON_RELEASE}" "_NLOHMANN_JSON" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_NLOHMANN_JSON_RELEASE ${CONAN_PKG_LIBS_NLOHMANN_JSON_RELEASE} ${CONAN_SYSTEM_LIBS_NLOHMANN_JSON_RELEASE} ${CONAN_FRAMEWORKS_FOUND_NLOHMANN_JSON_RELEASE})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT_RELEASE "C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_ZLIB_RELEASE "C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_ZLIB_RELEASE "C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_ZLIB_RELEASE )
set(CONAN_RES_DIRS_ZLIB_RELEASE )
set(CONAN_SRC_DIRS_ZLIB_RELEASE )
set(CONAN_BUILD_DIRS_ZLIB_RELEASE "C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_ZLIB_RELEASE )
set(CONAN_LIBS_ZLIB_RELEASE zlib)
set(CONAN_PKG_LIBS_ZLIB_RELEASE zlib)
set(CONAN_SYSTEM_LIBS_ZLIB_RELEASE )
set(CONAN_FRAMEWORKS_ZLIB_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_ZLIB_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_ZLIB_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE )

set(CONAN_C_FLAGS_ZLIB_RELEASE "")
set(CONAN_CXX_FLAGS_ZLIB_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE "${CONAN_FRAMEWORKS_ZLIB_RELEASE}" "_ZLIB" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB_RELEASE ${CONAN_PKG_LIBS_ZLIB_RELEASE} ${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE})


### Definition of global aggregated variables ###

set(CONAN_DEPENDENCIES_RELEASE cpp-httplib openssl nlohmann_json zlib)

set(CONAN_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/include"
			"C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include" ${CONAN_INCLUDE_DIRS_RELEASE})
set(CONAN_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib" ${CONAN_LIB_DIRS_RELEASE})
set(CONAN_BIN_DIRS_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/bin" ${CONAN_BIN_DIRS_RELEASE})
set(CONAN_RES_DIRS_RELEASE  ${CONAN_RES_DIRS_RELEASE})
set(CONAN_FRAMEWORK_DIRS_RELEASE  ${CONAN_FRAMEWORK_DIRS_RELEASE})
set(CONAN_LIBS_RELEASE libssl libcrypto zlib ${CONAN_LIBS_RELEASE})
set(CONAN_PKG_LIBS_RELEASE libssl libcrypto zlib ${CONAN_PKG_LIBS_RELEASE})
set(CONAN_SYSTEM_LIBS_RELEASE cryptui crypt32 ws2_32 advapi32 user32 bcrypt ${CONAN_SYSTEM_LIBS_RELEASE})
set(CONAN_FRAMEWORKS_RELEASE  ${CONAN_FRAMEWORKS_RELEASE})
set(CONAN_FRAMEWORKS_FOUND_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_RELEASE  ${CONAN_DEFINES_RELEASE})
set(CONAN_BUILD_MODULES_PATHS_RELEASE  ${CONAN_BUILD_MODULES_PATHS_RELEASE})
set(CONAN_CMAKE_MODULE_PATH_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib/cmake"
			"C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/" ${CONAN_CMAKE_MODULE_PATH_RELEASE})

set(CONAN_CXX_FLAGS_RELEASE " ${CONAN_CXX_FLAGS_RELEASE}")
set(CONAN_SHARED_LINKER_FLAGS_RELEASE " ${CONAN_SHARED_LINKER_FLAGS_RELEASE}")
set(CONAN_EXE_LINKER_FLAGS_RELEASE " ${CONAN_EXE_LINKER_FLAGS_RELEASE}")
set(CONAN_C_FLAGS_RELEASE " ${CONAN_C_FLAGS_RELEASE}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_RELEASE "${CONAN_FRAMEWORKS_RELEASE}" "" "_RELEASE")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS_RELEASE ${CONAN_LIBS_RELEASE} ${CONAN_SYSTEM_LIBS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_RELEASE})
