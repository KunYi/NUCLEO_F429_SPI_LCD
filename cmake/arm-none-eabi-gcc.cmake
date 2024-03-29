# the file from
# https://github.com/ErichStyger/mcuoneclipse/blob/master/Examples/VisualStudioCode/FRDM-K22F/FRDM-K22F_Simple/arm-none-eabi-gcc.cmake
# ref. https://mcuoneclipse.com/2021/05/04/visual-studio-code-for-c-c-with-arm-cortex-m-part-2/

#
# For using Ninja:
# cmake -DCMAKE_MAKE_PROGRAM=ninja.exe -DCMAKE_TOOLCHAIN_FILE="arm-none-eabi-gcc.cmake" -G "Ninja" ..
# followed by
# 'ninja' or 'cmake --build .' to build it

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if (CMAKE_HOST_LINUX)
  set(ARM_TOOLCHAIN_DIR "/usr/bin")
elseif (CMAKE_HOST_WIN32)
  set(ARM_TOOLCHAIN_DIR "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.10/bin")
endif (CMAKE_HOST_LINUX)

set(BINUTILS_PATH ${ARM_TOOLCHAIN_DIR})
set(TOOLCHAIN_PREFIX ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

if (CMAKE_HOST_LINUX)
  set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc CACHE INTERNAL "GNU C compiler")
  set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++ CACHE INTERNAL "GNU C++ compiler")
  set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
  set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")
  set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER} CACHE INTERNAL "GNU Assembler")
elseif (CMAKE_HOST_WIN32)
  set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc.exe CACHE INTERNAL "GNU C compiler")
  set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++.exe CACHE INTERNAL "GNU C++ compiler")
  set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy.exe CACHE INTERNAL "objcopy tool")
  set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size.exe CACHE INTERNAL "size tool")
  set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER} CACHE INTERNAL "GNU Assembler")
endif (CMAKE_HOST_LINUX)

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
