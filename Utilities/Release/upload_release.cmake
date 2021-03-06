set(PROJECT_PREFIX cmake-)
if(NOT VERSION)
 set(VERSION 2.8)
endif()
set(dir "v${VERSION}")
if("${VERSION}" MATCHES "master")
  set(dir "dev")
endif()
file(GLOB FILES ${CMAKE_CURRENT_SOURCE_DIR} "${PROJECT_PREFIX}*")
list(SORT FILES)
list(REVERSE FILES)
message("${FILES}")
set(UPLOAD_LOC
  "kitware@www.cmake.org:/projects/FTP/pub/cmake/${dir}")
set(count 0)
foreach(file ${FILES})
  if(NOT IS_DIRECTORY ${file})
    message("upload ${file} ${UPLOAD_LOC}")
    execute_process(COMMAND 
      scp ${file} ${UPLOAD_LOC}
      RESULT_VARIABLE result)  
    math(EXPR count "${count} + 1")
    if("${result}" GREATER 0)
      message(FATAL_ERROR "failed to upload file to ${UPLOAD_LOC}")
    endif()
  endif()
endforeach(file)
if(${count} EQUAL 0)
   message(FATAL_ERROR "Error no files uploaded.")
endif()
