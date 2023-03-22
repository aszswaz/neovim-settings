cmake_minimum_required(VERSION 3.22.2)
project()

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()
set(CMAKE_BINARY_DIR "${PROJECT_SOURCE_DIR}/build")
# 生成 compile_commands.json 文件，一些用具会用它来进行语法辅助，比如 ccls
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
execute_process(COMMAND "ln" "-svf" "${CMAKE_BINARY_DIR}/compile_commands.json" "compile_commands.json")
# 设置 GCC 编译选项
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -Wall -g3 -ggdb")
set(CMAKE_C_FLAGS_DEBUG "$ENV{CFLAGS} -Wall -g3 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS_RELEASE "$ENV{CFLAGS} -O3 -Wall")
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 17)

# 扫描源文件
file(GLOB_RECURSE C_FILES ./src/main/*.c)
file(GLOB_RECURSE CPP_FILES ./src/main/*.cpp)
file(GLOB_RECURSE HPP_FILES ./src/main/*.hpp)
file(GLOB_RECURSE C_TEST_FILES ./src/test/*.c)
file(GLOB_RECURSE CPP_TEST_FILES ./src/test/*.cpp)
file(GLOB_RECURSE HPP_TEST_FILES ./src/test/*.hpp)
set(SRC_FILES ${C_FILES} ${CPP_FILES} ${HPP_FILES})
set(UNIT_SRC ${C_TEST_FILES} ${CPP_TEST_FILES} ${HPP_TEST_FILES})

# 单元测试
set(UNIT_TEST ${PROJECT_NAME}_test)

add_executable(${PROJECT_NAME} ${SRC_FILES})
add_executable(${UNIT_TEST} ${UNIT_SRC})
