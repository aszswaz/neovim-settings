cmake_minimum_required(VERSION 3.22.2)
project()

message(STATUS "cmake binary directory: ${CMAKE_BINARY_DIR}")

# Compile commands are output to "compile_commands.json", so that tools such as "ccls" can provide assistance.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# Set gcc compile options.
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -Wall -g3 -ggdb")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} -Wall -g3 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} -O3 -Wall")

set(UNIT_TEST ${PROJECT_NAME}_test)

set(
    SRC_FILES
)
set (
    UNIT_SRC
    ${SRC_FILES}
)

add_executable(
        ${PROJECT_NAME}
        src/main.cpp
        ${SRC_FILES}
)
add_executable(
        ${UNIT_TEST}
        unit/main.cpp
        ${UNIT_SRC}
)
