cmake_minimum_required(VERSION 3.13)
project(pdc_mini_aevol)



set(CMAKE_CXX_STANDARD 14)

set(DO_TRACES ON CACHE BOOL "Whether to enable the Traces library")
set(USE_OMP ON CACHE BOOL "Whether to enable OpenMP parallelization")
set(USE_CUDA OFF CACHE BOOL "Whether to enable CUDA parallelization")

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

set(CPPFLAGS "-I/opt/homebrew/opt/libomp/include")
set(LDFLAGS "-L/opt/homebrew/opt/libomp/lib")

if ( DO_TRACES )
    add_definitions(-DTRACES)
    message( STATUS "Traces are activated" )
endif ( DO_TRACES )

if ( USE_OMP )
    if ( APPLE )
        if(CMAKE_C_COMPILER_ID MATCHES "Clang\$")
            set(OpenMP_C_FLAGS "-Xpreprocessor -fopenmp")
            set(OpenMP_C_LIB_NAMES "omp")
            set(OpenMP_omp_LIBRARY omp)
        endif()

        if(CMAKE_CXX_COMPILER_ID MATCHES "Clang\$")
            set(OpenMP_CXX_FLAGS "-Xpreprocessor -fopenmp")
            set(OpenMP_CXX_LIB_NAMES "omp")
            set(OpenMP_omp_LIBRARY omp)
        endif()
    else()
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fopenmp")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
    endif()

    find_package(OpenMP REQUIRED)
endif ( USE_OMP )

find_package(ZLIB REQUIRED)

add_library(mini_aevol
        src/Abstract_ExpManager.cpp
        src/ExpManager.cpp
        src/AeTime.cpp
        src/DnaMutator.cpp
        src/MutationEvent.cpp
        src/Organism.cpp
        src/Stats.cpp
        src/Dna.cpp)

target_link_libraries(mini_aevol PUBLIC ZLIB::ZLIB)

if ( OPENMP_FOUND )
    target_link_libraries(mini_aevol PUBLIC OpenMP::OpenMP_CXX)
    target_compile_definitions(mini_aevol PUBLIC USE_OMP)
endif ()

add_executable(mini_aevol_cpu src/main.cpp)
target_link_libraries(mini_aevol_cpu mini_aevol)