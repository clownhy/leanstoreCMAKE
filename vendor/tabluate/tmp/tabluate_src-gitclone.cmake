
if(NOT "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitinfo.txt" IS_NEWER_THAN "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout "https://github.com/p-ranav/tabulate.git" "tabluate_src"
    WORKING_DIRECTORY "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/p-ranav/tabulate.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout 718d827cf05c2e9bba17e926cac2d7ab2356621c --
  WORKING_DIRECTORY "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '718d827cf05c2e9bba17e926cac2d7ab2356621c'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitinfo.txt"
    "/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/yuhao/Codes/leanstore/build/vendor/tabluate/src/tabluate_src-stamp/tabluate_src-gitclone-lastrun.txt'")
endif()

