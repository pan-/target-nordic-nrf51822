# Copyright (C) 2014-2015 ARM Limited. All rights reserved.

if(TARGET_NORDIC_NRF51822_GCC_TOOLCHAIN_INCLUDED)
    return()
endif()
set(TARGET_NORDIC_NRF51822_GCC_TOOLCHAIN_INCLUDED 1)

# legacy definitions for building mbed 2.0 modules with a retrofitted build
# system:
set(MBED_LEGACY_TARGET_DEFINITIONS "NORDIC" "NRF51822_MKIT" "MCU_NRF51822" "MCU_NORDIC_16K")
# provide compatibility definitions for compiling with this target: these are
# definitions that legacy code assumes will be defined. 
add_definitions("-DNRF51 -DTARGET_NORDIC -DTARGET_M0 -D__MBED__=1 -DMCU_NORDIC_16K -DTARGET_NRF51822 -DTARGET_MCU_NORDIC_16K")

# append non-generic flags, and set NRF51822-specific link script

set(_CPU_COMPILATION_OPTIONS "-mcpu=cortex-m0 -mthumb -D__thumb2__")

set(CMAKE_C_FLAGS_INIT             "${CMAKE_C_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_ASM_FLAGS_INIT           "${CMAKE_ASM_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_CXX_FLAGS_INIT           "${CMAKE_CXX_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "${CMAKE_MODULE_LINKER_FLAGS_INIT} -mcpu=cortex-m0 -mthumb")
set(CMAKE_EXE_LINKER_FLAGS_INIT    "${CMAKE_EXE_LINKER_FLAGS_INIT} -mcpu=cortex-m0 -mthumb -T${CMAKE_CURRENT_LIST_DIR}/../ld/NRF51822.ld -fno-rtti -fno-threadsafe-statics --specs=nano.specs")

# post-process elf files into .bin files:
# TODO: merge hex files here
set(YOTTA_POSTPROCESS_COMMAND "arm-none-eabi-objcopy -O ihex YOTTA_CURRENT_EXE_NAME YOTTA_CURRENT_EXE_NAME.hex && srec_cat /home/rgrover/play/mbed-src/libraries/mbed/targets/hal/TARGET_NORDIC/TARGET_MCU_NRF51822/Lib/s130_nrf51822_1_0_0/s130_nrf51_1.0.0_softdevice.hex -intel YOTTA_CURRENT_EXE_NAME.hex -intel -o combined.hex -intel")
