CMAKE_MINIMUM_REQUIRED (VERSION 3.6)
PROJECT (Fortran-FCGI)

ENABLE_LANGUAGE (Fortran)

IF (CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
  SET (CMAKE_Fortran_FLAGS "-Wall")
ENDIF ()

FIND_LIBRARY (LIBFASTCGI fcgi)

ADD_EXECUTABLE (fortran-fcgi
  src/3rd/flibs/src/cgi/cgi_protocol.f90
  src/3rd/flibs/src/cgi/fcgi_protocol.f90
  src/main.f90
)

TARGET_INCLUDE_DIRECTORIES (fortran-fcgi
  PRIVATE src/3rd/flibs/src/datastructures
)

TARGET_LINK_LIBRARIES (fortran-fcgi
  ${LIBFASTCGI}
)
