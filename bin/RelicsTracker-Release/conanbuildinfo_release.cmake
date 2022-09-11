
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
###  SFML
#################
set(CONAN_SFML_ROOT_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35")
set(CONAN_INCLUDE_DIRS_SFML_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include")
set(CONAN_LIB_DIRS_SFML_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib")
set(CONAN_BIN_DIRS_SFML_RELEASE )
set(CONAN_RES_DIRS_SFML_RELEASE )
set(CONAN_SRC_DIRS_SFML_RELEASE )
set(CONAN_BUILD_DIRS_SFML_RELEASE "C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/")
set(CONAN_FRAMEWORK_DIRS_SFML_RELEASE )
set(CONAN_LIBS_SFML_RELEASE sfml-main sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_PKG_LIBS_SFML_RELEASE sfml-main sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_SYSTEM_LIBS_SFML_RELEASE gdi32 winmm ws2_32)
set(CONAN_FRAMEWORKS_SFML_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_SFML_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_SFML_RELEASE "-DSFML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_SFML_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SFML_RELEASE "SFML_STATIC")

set(CONAN_C_FLAGS_SFML_RELEASE "")
set(CONAN_CXX_FLAGS_SFML_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_SFML_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SFML_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_SFML_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SFML_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SFML_RELEASE "${CONAN_FRAMEWORKS_SFML_RELEASE}" "_SFML" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_SFML_RELEASE ${CONAN_PKG_LIBS_SFML_RELEASE} ${CONAN_SYSTEM_LIBS_SFML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SFML_RELEASE})


#################
###  BOOST
#################
set(CONAN_BOOST_ROOT_RELEASE "C:/.conan/10a1cc/1")
set(CONAN_INCLUDE_DIRS_BOOST_RELEASE "C:/.conan/10a1cc/1/include")
set(CONAN_LIB_DIRS_BOOST_RELEASE "C:/.conan/10a1cc/1/lib")
set(CONAN_BIN_DIRS_BOOST_RELEASE )
set(CONAN_RES_DIRS_BOOST_RELEASE )
set(CONAN_SRC_DIRS_BOOST_RELEASE )
set(CONAN_BUILD_DIRS_BOOST_RELEASE "C:/.conan/10a1cc/1/")
set(CONAN_FRAMEWORK_DIRS_BOOST_RELEASE )
set(CONAN_LIBS_BOOST_RELEASE libboost_contract libboost_coroutine libboost_fiber_numa libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_json libboost_locale libboost_log_setup libboost_log libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_atomic libboost_wserialization libboost_serialization)
set(CONAN_PKG_LIBS_BOOST_RELEASE libboost_contract libboost_coroutine libboost_fiber_numa libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_json libboost_locale libboost_log_setup libboost_log libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_atomic libboost_wserialization libboost_serialization)
set(CONAN_SYSTEM_LIBS_BOOST_RELEASE ole32 dbgeng bcrypt)
set(CONAN_FRAMEWORKS_BOOST_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_BOOST_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_BOOST_RELEASE "-DBOOST_STACKTRACE_USE_NOOP"
			"-DBOOST_STACKTRACE_USE_WINDBG"
			"-DBOOST_STACKTRACE_USE_WINDBG_CACHED"
			"-DBOOST_ALL_NO_LIB")
set(CONAN_BUILD_MODULES_PATHS_BOOST_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BOOST_RELEASE "BOOST_STACKTRACE_USE_NOOP"
			"BOOST_STACKTRACE_USE_WINDBG"
			"BOOST_STACKTRACE_USE_WINDBG_CACHED"
			"BOOST_ALL_NO_LIB")

set(CONAN_C_FLAGS_BOOST_RELEASE "")
set(CONAN_CXX_FLAGS_BOOST_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_BOOST_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BOOST_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_BOOST_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BOOST_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BOOST_RELEASE "${CONAN_FRAMEWORKS_BOOST_RELEASE}" "_BOOST" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_BOOST_RELEASE ${CONAN_PKG_LIBS_BOOST_RELEASE} ${CONAN_SYSTEM_LIBS_BOOST_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BOOST_RELEASE})


#################
###  OPENGL
#################
set(CONAN_OPENGL_ROOT_RELEASE "C:/Users/stany/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_OPENGL_RELEASE )
set(CONAN_LIB_DIRS_OPENGL_RELEASE )
set(CONAN_BIN_DIRS_OPENGL_RELEASE )
set(CONAN_RES_DIRS_OPENGL_RELEASE )
set(CONAN_SRC_DIRS_OPENGL_RELEASE )
set(CONAN_BUILD_DIRS_OPENGL_RELEASE "C:/Users/stany/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_OPENGL_RELEASE )
set(CONAN_LIBS_OPENGL_RELEASE )
set(CONAN_PKG_LIBS_OPENGL_RELEASE )
set(CONAN_SYSTEM_LIBS_OPENGL_RELEASE opengl32)
set(CONAN_FRAMEWORKS_OPENGL_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_OPENGL_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_OPENGL_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENGL_RELEASE )

set(CONAN_C_FLAGS_OPENGL_RELEASE "")
set(CONAN_CXX_FLAGS_OPENGL_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENGL_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_OPENGL_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE "${CONAN_FRAMEWORKS_OPENGL_RELEASE}" "_OPENGL" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_OPENGL_RELEASE ${CONAN_PKG_LIBS_OPENGL_RELEASE} ${CONAN_SYSTEM_LIBS_OPENGL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE})


#################
###  FREETYPE
#################
set(CONAN_FREETYPE_ROOT_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16")
set(CONAN_INCLUDE_DIRS_FREETYPE_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2")
set(CONAN_LIB_DIRS_FREETYPE_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib")
set(CONAN_BIN_DIRS_FREETYPE_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/bin")
set(CONAN_RES_DIRS_FREETYPE_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/res")
set(CONAN_SRC_DIRS_FREETYPE_RELEASE )
set(CONAN_BUILD_DIRS_FREETYPE_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_FREETYPE_RELEASE )
set(CONAN_LIBS_FREETYPE_RELEASE freetype)
set(CONAN_PKG_LIBS_FREETYPE_RELEASE freetype)
set(CONAN_SYSTEM_LIBS_FREETYPE_RELEASE )
set(CONAN_FRAMEWORKS_FREETYPE_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_FREETYPE_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_FREETYPE_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FREETYPE_RELEASE )

set(CONAN_C_FLAGS_FREETYPE_RELEASE "")
set(CONAN_CXX_FLAGS_FREETYPE_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FREETYPE_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_FREETYPE_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE "${CONAN_FRAMEWORKS_FREETYPE_RELEASE}" "_FREETYPE" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_FREETYPE_RELEASE ${CONAN_PKG_LIBS_FREETYPE_RELEASE} ${CONAN_SYSTEM_LIBS_FREETYPE_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE})


#################
###  STB
#################
set(CONAN_STB_ROOT_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_STB_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_STB_RELEASE )
set(CONAN_BIN_DIRS_STB_RELEASE )
set(CONAN_RES_DIRS_STB_RELEASE )
set(CONAN_SRC_DIRS_STB_RELEASE )
set(CONAN_BUILD_DIRS_STB_RELEASE "C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_STB_RELEASE )
set(CONAN_LIBS_STB_RELEASE )
set(CONAN_PKG_LIBS_STB_RELEASE )
set(CONAN_SYSTEM_LIBS_STB_RELEASE )
set(CONAN_FRAMEWORKS_STB_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_STB_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_STB_RELEASE "-DSTB_TEXTEDIT_KEYTYPE=unsigned")
set(CONAN_BUILD_MODULES_PATHS_STB_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_STB_RELEASE "STB_TEXTEDIT_KEYTYPE=unsigned")

set(CONAN_C_FLAGS_STB_RELEASE "")
set(CONAN_CXX_FLAGS_STB_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_STB_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_STB_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_STB_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_STB_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_STB_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_STB_RELEASE "${CONAN_FRAMEWORKS_STB_RELEASE}" "_STB" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_STB_RELEASE ${CONAN_PKG_LIBS_STB_RELEASE} ${CONAN_SYSTEM_LIBS_STB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_STB_RELEASE})


#################
###  FLAC
#################
set(CONAN_FLAC_ROOT_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540")
set(CONAN_INCLUDE_DIRS_FLAC_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(CONAN_LIB_DIRS_FLAC_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(CONAN_BIN_DIRS_FLAC_RELEASE "C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/bin")
set(CONAN_RES_DIRS_FLAC_RELEASE )
set(CONAN_SRC_DIRS_FLAC_RELEASE )
set(CONAN_BUILD_DIRS_FLAC_RELEASE )
set(CONAN_FRAMEWORK_DIRS_FLAC_RELEASE )
set(CONAN_LIBS_FLAC_RELEASE FLAC++ FLAC)
set(CONAN_PKG_LIBS_FLAC_RELEASE FLAC++ FLAC)
set(CONAN_SYSTEM_LIBS_FLAC_RELEASE )
set(CONAN_FRAMEWORKS_FLAC_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_FLAC_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_FLAC_RELEASE "-DFLAC__NO_DLL")
set(CONAN_BUILD_MODULES_PATHS_FLAC_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FLAC_RELEASE "FLAC__NO_DLL")

set(CONAN_C_FLAGS_FLAC_RELEASE "")
set(CONAN_CXX_FLAGS_FLAC_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_FLAC_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FLAC_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_FLAC_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FLAC_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FLAC_RELEASE "${CONAN_FRAMEWORKS_FLAC_RELEASE}" "_FLAC" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_FLAC_RELEASE ${CONAN_PKG_LIBS_FLAC_RELEASE} ${CONAN_SYSTEM_LIBS_FLAC_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FLAC_RELEASE})


#################
###  OPENAL
#################
set(CONAN_OPENAL_ROOT_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_OPENAL_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/AL")
set(CONAN_LIB_DIRS_OPENAL_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_OPENAL_RELEASE )
set(CONAN_RES_DIRS_OPENAL_RELEASE )
set(CONAN_SRC_DIRS_OPENAL_RELEASE )
set(CONAN_BUILD_DIRS_OPENAL_RELEASE "C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_OPENAL_RELEASE )
set(CONAN_LIBS_OPENAL_RELEASE OpenAL32)
set(CONAN_PKG_LIBS_OPENAL_RELEASE OpenAL32)
set(CONAN_SYSTEM_LIBS_OPENAL_RELEASE winmm ole32 shell32 User32)
set(CONAN_FRAMEWORKS_OPENAL_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_OPENAL_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_OPENAL_RELEASE "-DAL_LIBTYPE_STATIC")
set(CONAN_BUILD_MODULES_PATHS_OPENAL_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENAL_RELEASE "AL_LIBTYPE_STATIC")

set(CONAN_C_FLAGS_OPENAL_RELEASE "")
set(CONAN_CXX_FLAGS_OPENAL_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENAL_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_OPENAL_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENAL_RELEASE "${CONAN_FRAMEWORKS_OPENAL_RELEASE}" "_OPENAL" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_OPENAL_RELEASE ${CONAN_PKG_LIBS_OPENAL_RELEASE} ${CONAN_SYSTEM_LIBS_OPENAL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENAL_RELEASE})


#################
###  VORBIS
#################
set(CONAN_VORBIS_ROOT_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540")
set(CONAN_INCLUDE_DIRS_VORBIS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include")
set(CONAN_LIB_DIRS_VORBIS_RELEASE "C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib")
set(CONAN_BIN_DIRS_VORBIS_RELEASE )
set(CONAN_RES_DIRS_VORBIS_RELEASE )
set(CONAN_SRC_DIRS_VORBIS_RELEASE )
set(CONAN_BUILD_DIRS_VORBIS_RELEASE )
set(CONAN_FRAMEWORK_DIRS_VORBIS_RELEASE )
set(CONAN_LIBS_VORBIS_RELEASE vorbisenc vorbisfile vorbis)
set(CONAN_PKG_LIBS_VORBIS_RELEASE vorbisenc vorbisfile vorbis)
set(CONAN_SYSTEM_LIBS_VORBIS_RELEASE )
set(CONAN_FRAMEWORKS_VORBIS_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_VORBIS_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_VORBIS_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_VORBIS_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VORBIS_RELEASE )

set(CONAN_C_FLAGS_VORBIS_RELEASE "")
set(CONAN_CXX_FLAGS_VORBIS_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VORBIS_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_VORBIS_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VORBIS_RELEASE "${CONAN_FRAMEWORKS_VORBIS_RELEASE}" "_VORBIS" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_VORBIS_RELEASE ${CONAN_PKG_LIBS_VORBIS_RELEASE} ${CONAN_SYSTEM_LIBS_VORBIS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VORBIS_RELEASE})


#################
###  LIBPNG
#################
set(CONAN_LIBPNG_ROOT_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859")
set(CONAN_INCLUDE_DIRS_LIBPNG_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/include")
set(CONAN_LIB_DIRS_LIBPNG_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/lib")
set(CONAN_BIN_DIRS_LIBPNG_RELEASE )
set(CONAN_RES_DIRS_LIBPNG_RELEASE )
set(CONAN_SRC_DIRS_LIBPNG_RELEASE )
set(CONAN_BUILD_DIRS_LIBPNG_RELEASE "C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/")
set(CONAN_FRAMEWORK_DIRS_LIBPNG_RELEASE )
set(CONAN_LIBS_LIBPNG_RELEASE libpng16)
set(CONAN_PKG_LIBS_LIBPNG_RELEASE libpng16)
set(CONAN_SYSTEM_LIBS_LIBPNG_RELEASE )
set(CONAN_FRAMEWORKS_LIBPNG_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_LIBPNG_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_LIBPNG_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBPNG_RELEASE )

set(CONAN_C_FLAGS_LIBPNG_RELEASE "")
set(CONAN_CXX_FLAGS_LIBPNG_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBPNG_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_LIBPNG_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE "${CONAN_FRAMEWORKS_LIBPNG_RELEASE}" "_LIBPNG" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_LIBPNG_RELEASE ${CONAN_PKG_LIBS_LIBPNG_RELEASE} ${CONAN_SYSTEM_LIBS_LIBPNG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE})


#################
###  BZIP2
#################
set(CONAN_BZIP2_ROOT_RELEASE "C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5")
set(CONAN_INCLUDE_DIRS_BZIP2_RELEASE "C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/include")
set(CONAN_LIB_DIRS_BZIP2_RELEASE "C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib")
set(CONAN_BIN_DIRS_BZIP2_RELEASE "C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/bin")
set(CONAN_RES_DIRS_BZIP2_RELEASE )
set(CONAN_SRC_DIRS_BZIP2_RELEASE )
set(CONAN_BUILD_DIRS_BZIP2_RELEASE "C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/")
set(CONAN_FRAMEWORK_DIRS_BZIP2_RELEASE )
set(CONAN_LIBS_BZIP2_RELEASE bz2)
set(CONAN_PKG_LIBS_BZIP2_RELEASE bz2)
set(CONAN_SYSTEM_LIBS_BZIP2_RELEASE )
set(CONAN_FRAMEWORKS_BZIP2_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_BZIP2_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_BZIP2_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BZIP2_RELEASE )

set(CONAN_C_FLAGS_BZIP2_RELEASE "")
set(CONAN_CXX_FLAGS_BZIP2_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BZIP2_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_BZIP2_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE "${CONAN_FRAMEWORKS_BZIP2_RELEASE}" "_BZIP2" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_BZIP2_RELEASE ${CONAN_PKG_LIBS_BZIP2_RELEASE} ${CONAN_SYSTEM_LIBS_BZIP2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE})


#################
###  BROTLI
#################
set(CONAN_BROTLI_ROOT_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f")
set(CONAN_INCLUDE_DIRS_BROTLI_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli")
set(CONAN_LIB_DIRS_BROTLI_RELEASE "C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib")
set(CONAN_BIN_DIRS_BROTLI_RELEASE )
set(CONAN_RES_DIRS_BROTLI_RELEASE )
set(CONAN_SRC_DIRS_BROTLI_RELEASE )
set(CONAN_BUILD_DIRS_BROTLI_RELEASE )
set(CONAN_FRAMEWORK_DIRS_BROTLI_RELEASE )
set(CONAN_LIBS_BROTLI_RELEASE brotlidec-static brotlienc-static brotlicommon-static)
set(CONAN_PKG_LIBS_BROTLI_RELEASE brotlidec-static brotlienc-static brotlicommon-static)
set(CONAN_SYSTEM_LIBS_BROTLI_RELEASE )
set(CONAN_FRAMEWORKS_BROTLI_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_BROTLI_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_BROTLI_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_BROTLI_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BROTLI_RELEASE )

set(CONAN_C_FLAGS_BROTLI_RELEASE "")
set(CONAN_CXX_FLAGS_BROTLI_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_BROTLI_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_BROTLI_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BROTLI_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_BROTLI_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BROTLI_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BROTLI_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BROTLI_RELEASE "${CONAN_FRAMEWORKS_BROTLI_RELEASE}" "_BROTLI" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_BROTLI_RELEASE ${CONAN_PKG_LIBS_BROTLI_RELEASE} ${CONAN_SYSTEM_LIBS_BROTLI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BROTLI_RELEASE})


#################
###  OGG
#################
set(CONAN_OGG_ROOT_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_OGG_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_OGG_RELEASE "C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_OGG_RELEASE )
set(CONAN_RES_DIRS_OGG_RELEASE )
set(CONAN_SRC_DIRS_OGG_RELEASE )
set(CONAN_BUILD_DIRS_OGG_RELEASE )
set(CONAN_FRAMEWORK_DIRS_OGG_RELEASE )
set(CONAN_LIBS_OGG_RELEASE ogg)
set(CONAN_PKG_LIBS_OGG_RELEASE ogg)
set(CONAN_SYSTEM_LIBS_OGG_RELEASE )
set(CONAN_FRAMEWORKS_OGG_RELEASE )
set(CONAN_FRAMEWORKS_FOUND_OGG_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_OGG_RELEASE )
set(CONAN_BUILD_MODULES_PATHS_OGG_RELEASE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OGG_RELEASE )

set(CONAN_C_FLAGS_OGG_RELEASE "")
set(CONAN_CXX_FLAGS_OGG_RELEASE "")
set(CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE "")
set(CONAN_EXE_LINKER_FLAGS_OGG_RELEASE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OGG_RELEASE_LIST "")
set(CONAN_CXX_FLAGS_OGG_RELEASE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OGG_RELEASE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OGG_RELEASE "${CONAN_FRAMEWORKS_OGG_RELEASE}" "_OGG" "_RELEASE")
# Append to aggregated values variable
set(CONAN_LIBS_OGG_RELEASE ${CONAN_PKG_LIBS_OGG_RELEASE} ${CONAN_SYSTEM_LIBS_OGG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OGG_RELEASE})


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

set(CONAN_DEPENDENCIES_RELEASE cpp-httplib openssl nlohmann_json sfml boost opengl freetype stb flac openal vorbis libpng bzip2 brotli ogg zlib)

set(CONAN_INCLUDE_DIRS_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/httplib"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/include"
			"C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/include"
			"C:/.conan/10a1cc/1/include"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2"
			"C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/AL"
			"C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/include"
			"C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/include"
			"C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/include/brotli"
			"C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include" ${CONAN_INCLUDE_DIRS_RELEASE})
set(CONAN_LIB_DIRS_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib"
			"C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/lib"
			"C:/.conan/10a1cc/1/lib"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib"
			"C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/stany/.conan/data/vorbis/1.3.7/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/lib"
			"C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/lib"
			"C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib"
			"C:/Users/stany/.conan/data/brotli/1.0.9/_/_/package/7e52046413f1e13a5fa19e3d410c5b50df627c3f/lib"
			"C:/Users/stany/.conan/data/ogg/1.3.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib" ${CONAN_LIB_DIRS_RELEASE})
set(CONAN_BIN_DIRS_RELEASE "C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/bin"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/bin"
			"C:/Users/stany/.conan/data/flac/1.3.3/_/_/package/becff00909fb3d957c6b4ca60fa64d4e6a32a540/bin"
			"C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/bin" ${CONAN_BIN_DIRS_RELEASE})
set(CONAN_RES_DIRS_RELEASE "C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/res" ${CONAN_RES_DIRS_RELEASE})
set(CONAN_FRAMEWORK_DIRS_RELEASE  ${CONAN_FRAMEWORK_DIRS_RELEASE})
set(CONAN_LIBS_RELEASE libssl libcrypto sfml-main sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s libboost_contract libboost_coroutine libboost_fiber_numa libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_json libboost_locale libboost_log_setup libboost_log libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_atomic libboost_wserialization libboost_serialization freetype FLAC++ FLAC OpenAL32 vorbisenc vorbisfile vorbis libpng16 bz2 brotlidec-static brotlienc-static brotlicommon-static ogg zlib ${CONAN_LIBS_RELEASE})
set(CONAN_PKG_LIBS_RELEASE libssl libcrypto sfml-main sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s libboost_contract libboost_coroutine libboost_fiber_numa libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_json libboost_locale libboost_log_setup libboost_log libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_atomic libboost_wserialization libboost_serialization freetype FLAC++ FLAC OpenAL32 vorbisenc vorbisfile vorbis libpng16 bz2 brotlidec-static brotlienc-static brotlicommon-static ogg zlib ${CONAN_PKG_LIBS_RELEASE})
set(CONAN_SYSTEM_LIBS_RELEASE cryptui crypt32 advapi32 user32 gdi32 ws2_32 dbgeng bcrypt opengl32 winmm ole32 shell32 User32 ${CONAN_SYSTEM_LIBS_RELEASE})
set(CONAN_FRAMEWORKS_RELEASE  ${CONAN_FRAMEWORKS_RELEASE})
set(CONAN_FRAMEWORKS_FOUND_RELEASE "")  # Will be filled later
set(CONAN_DEFINES_RELEASE "-DAL_LIBTYPE_STATIC"
			"-DFLAC__NO_DLL"
			"-DSTB_TEXTEDIT_KEYTYPE=unsigned"
			"-DBOOST_STACKTRACE_USE_NOOP"
			"-DBOOST_STACKTRACE_USE_WINDBG"
			"-DBOOST_STACKTRACE_USE_WINDBG_CACHED"
			"-DBOOST_ALL_NO_LIB"
			"-DSFML_STATIC" ${CONAN_DEFINES_RELEASE})
set(CONAN_BUILD_MODULES_PATHS_RELEASE  ${CONAN_BUILD_MODULES_PATHS_RELEASE})
set(CONAN_CMAKE_MODULE_PATH_RELEASE "C:/Users/stany/.conan/data/cpp-httplib/0.11.1/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/"
			"C:/Users/stany/.conan/data/openssl/3.0.5/_/_/package/1cf626f618fdd256dd79c53f4d6cebfc2eaa1df7/lib/cmake"
			"C:/Users/stany/.conan/data/nlohmann_json/3.11.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/sfml/2.5.1/_/_/package/d7765125768fb382b42764ce3d31b319f2682d35/"
			"C:/.conan/10a1cc/1/"
			"C:/Users/stany/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/stany/.conan/data/freetype/2.11.1/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake"
			"C:/Users/stany/.conan/data/stb/cci.20210910/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/stany/.conan/data/openal/1.21.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/stany/.conan/data/libpng/1.6.37/_/_/package/ce650d9f1f1c1c0839cf0694a55c1351ddbed859/"
			"C:/Users/stany/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/"
			"C:/Users/stany/.conan/data/zlib/1.2.12/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/" ${CONAN_CMAKE_MODULE_PATH_RELEASE})

set(CONAN_CXX_FLAGS_RELEASE " ${CONAN_CXX_FLAGS_RELEASE}")
set(CONAN_SHARED_LINKER_FLAGS_RELEASE " ${CONAN_SHARED_LINKER_FLAGS_RELEASE}")
set(CONAN_EXE_LINKER_FLAGS_RELEASE " ${CONAN_EXE_LINKER_FLAGS_RELEASE}")
set(CONAN_C_FLAGS_RELEASE " ${CONAN_C_FLAGS_RELEASE}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_RELEASE "${CONAN_FRAMEWORKS_RELEASE}" "" "_RELEASE")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS_RELEASE ${CONAN_LIBS_RELEASE} ${CONAN_SYSTEM_LIBS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_RELEASE})
