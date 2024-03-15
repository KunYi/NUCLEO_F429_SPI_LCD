cmake_minimum_required(VERSION 3.16)

# Path to toolchain file. This one has to be before 'project()' below
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/cmake/arm-none-eabi-gcc.cmake)

enable_language(C ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

project(F429_LCD)
set(EXECUTABLE ${PROJECT_NAME}.elf)
set(LINKER_FILE ${CMAKE_SOURCE_DIR}/STM32F429ZITX_FLASH.ld)

add_compile_options(
  -mcpu=cortex-m4
  -mthumb
  -mfpu=fpv4-sp-d16
  -mfloat-abi=hard

  -fdata-sections
  -ffunction-sections

  -DUSE_HAL_DRIVER
  -DSTM32F429xx
  -DSTM32F429_439xx
  -Wall
  -O0
  -ggdb
)

set(STM32F4_HAL_DIR "HALLIB/STM32F4xx_HAL_Driver")
FILE(GLOB STM32F4_HAL_SRC "${STM32F4_HAL_DIR}/Src/*.c")
set(BSP_DIR "HARDWARE")
FILE(GLOB BSP_SRC "${BSP_DIR}/*/*.c")
set(SYS_DIR "SYSTEM")
FILE(GLOB SYS_SRC "${SYS_DIR}/*/*.c")
set(USER_DIR "USER")
FILE(GLOB USER_SRC "${USER_DIR}/*.c")
set(CORE_DIR "CORE")
FILE(GLOB CORE_SRC "${CORE_DIR}/*_gcc.s")


set(SRC_FILES
   ${STM32F4_HAL_SRC}
   ${BSP_SRC}
   ${SYS_SRC}
   ${USER_SRC}
   ${CORE_SRC}
)

# Build the executable based on the source files
add_executable(${EXECUTABLE} ${SRC_FILES})

# List of includ directories
target_include_directories(${EXECUTABLE} PRIVATE
   CORE
   HALLIB/STM32F4xx_HAL_Driver/Inc
   HARDWARE/24CXX
   HARDWARE/IIC
   HARDWARE/KEY
   HARDWARE/LCD
   HARDWARE/LED
   HARDWARE/SPI
   HARDWARE/TOUCH
   SYSTEM/delay
   SYSTEM/sys
   USER
)

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
  -T${LINKER_FILE}
  -mcpu=cortex-m4
  -mthumb
  -mfpu=fpv4-sp-d16
  -mfloat-abi=hard
  -specs=nano.specs
  -specs=nosys.specs
  -lm
  -lc
  -fno-math-errno
  -Wl,-Map=${PROJECT_NAME}.map,--cref
  -Wl,--gc-sections
  -Xlinker -print-memory-usage -Xlinker
)

# Optional: Print executable size as part of the post build process
add_custom_command(TARGET ${EXECUTABLE}
  POST_BUILD
  COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE})

# Optional: Create hex, bin and S-Record files after the build
add_custom_command(TARGET ${EXECUTABLE}
  POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
  COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin)
