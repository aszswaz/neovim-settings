cmake_minimum_required(VERSION 3.22.2)
project()

message(STATUS "cmake binary directory: ${CMAKE_BINARY_DIR}")

# Compile commands are output to "compile_commands.json", so that tools such as "ccls" can provide assistance.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# 设置 GCC 编译选项
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -Wall -g3 -ggdb")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} -Wall -g3 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} -O3 -Wall")
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 17)

# 扫描源文件
file(GLOB_RECURSE C_FILES ./src/*.c)
file(GLOB_RECURSE CPP_FILES ./src/*.cpp)
file(GLOB_RECURSE HPP_FILES ./src/*.hpp)
file(GLOB_RECURSE C_TEST_FILES ./test/*.c)
file(GLOB_RECURSE CPP_TEST_FILES ./test/*.cpp)
file(GLOB_RECURSE HPP_TEST_FILES ./test/*.hpp)
set(SRC_FILES ${C_FILES} ${CPP_FILES} ${HPP_FILES})
set(UNIT_SRC ${C_TEST_FILES} ${CPP_TEST_FILES} ${HPP_TEST_FILES})

# 单元测试
set(UNIT_TEST ${PROJECT_NAME}_test)

add_executable(${PROJECT_NAME} ${SRC_FILES})
add_executable(${UNIT_TEST} ${UNIT_SRC})
