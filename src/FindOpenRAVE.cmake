# Try to find OpenRAVE
# Once done this will define
#
# OpenRAVE_FOUND - if Coin3d is found
# OpenRAVE_CXXFLAGS - extra flags
# OpenRAVE_INCLUDE_DIRS - include directories
# OpenRAVE_LINK_DIRS - link directories
# OpenRAVE_LIBRARY_RELEASE - the relase version
# OpenRAVE_LIBRARY_DEBUG - the debug version
# OpenRAVE_LIBRARY - a default library, with priority debug.

# use openrave-config
MESSAGE( "CMAKE_SOURCE_DIR: " ${CMAKE_SOURCE_DIR} )
find_program(OpenRAVE_CONFIG_EXECUTABLE NAMES openrave-config DOC "openrave-config executable")
mark_as_advanced(OpenRAVE_CONFIG_EXECUTABLE)

if(OpenRAVE_CONFIG_EXECUTABLE)
  set(OpenRAVE_FOUND 1)

  execute_process(
    COMMAND ${OpenRAVE_CONFIG_EXECUTABLE} --cflags
    OUTPUT_VARIABLE _openraveconfig_cflags
    RESULT_VARIABLE _openraveconfig_failed)
  string(REGEX REPLACE "[\r\n]" " " _openraveconfig_cflags "${_openraveconfig_cflags}")
  
  execute_process(
    COMMAND ${OpenRAVE_CONFIG_EXECUTABLE} --libs
    OUTPUT_VARIABLE _openraveconfig_ldflags
    RESULT_VARIABLE _openraveconfig_failed)
  string(REGEX REPLACE "[\r\n]" " " _openraveconfig_ldflags "${_openraveconfig_ldflags}")

  execute_process(
    COMMAND ${OpenRAVE_CONFIG_EXECUTABLE} --cflags-only-I
    OUTPUT_VARIABLE _openraveconfig_includedirs
    RESULT_VARIABLE _openraveconfig_failed)
  string(REGEX REPLACE "[\r\n]" " " _openraveconfig_includedirs "${_openraveconfig_includedirs}")
  string(REGEX MATCHALL "(^| )-I([./+-_\\a-zA-Z]*)" _openraveconfig_includedirs "${_openraveconfig_includedirs}")
  string(REGEX REPLACE "(^| )-I" "" _openraveconfig_includedirs "${_openraveconfig_includedirs}")
  separate_arguments(_openraveconfig_includedirs)

  execute_process(
    COMMAND ${OpenRAVE_CONFIG_EXECUTABLE} --libs-only-L
    OUTPUT_VARIABLE _openraveconfig_ldflags
    RESULT_VARIABLE _openraveconfig_failed)
  string(REGEX REPLACE "[\r\n]" " " _openraveconfig_ldflags "${_openraveconfig_ldflags}")
  string(REGEX MATCHALL "(^| )-L([./+-_\\a-zA-Z]*)" _openraveconfig_ldirs "${_openraveconfig_ldflags}")
  string(REGEX REPLACE "(^| )-L" "" _openraveconfig_ldirs "${_openraveconfig_ldirs}")
  separate_arguments(_openraveconfig_ldirs)

  execute_process(
    COMMAND ${OpenRAVE_CONFIG_EXECUTABLE} --libs-only-l
    OUTPUT_VARIABLE _openraveconfig_libs
    RESULT_VARIABLE _openraveconfig_failed)
  string(REGEX REPLACE "[\r\n]" " " _openraveconfig_libs "${_openraveconfig_libs}")
  string(REGEX MATCHALL "(^| )-l([./+-_\\a-zA-Z]*)" _openraveconfig_libs "${_openraveconfig_libs}")
  string(REGEX REPLACE "(^| )-l" "" _openraveconfig_libs "${_openraveconfig_libs}")  

  set( OpenRAVE_CXXFLAGS "${_openraveconfig_cflags}" )
  set( OpenRAVE_LINK_FLAGS "${_openraveconfig_ldflags}" )
  set( OpenRAVE_INCLUDE_DIRS ${_openraveconfig_includedirs})
  set( OpenRAVE_LINK_DIRS ${_openraveconfig_ldirs})
  set( OpenRAVE_LIBRARY ${_openraveconfig_libs})
  set( OpenRAVE_LIBRARY_RELEASE ${OpenRAVE_LIBRARY})
  set( OpenRAVE_LIBRARY_DEBUG ${OpenRAVE_LIBRARY})
else(OpenRAVE_CONFIG_EXECUTABLE)
  # openrave include files in local directory
  if( MSVC )
    message("Inside MSVC")
    set(OpenRAVE_FOUND 1)
    set( OpenRAVE_CXXFLAGS "")
    set( OpenRAVE_LINK_FLAGS "")
    set( OpenRAVE_INCLUDE_DIRS "C:/workspace/openrave/inc;C:/openrave/include")
    set( OpenRAVE_LINK_DIRS "C:/workspace/openrave/libs;C:/openrave/lib" )
    set( OpenRAVE_LIBRARY openrave)
    set( OpenRAVE_LIBRARY_RELEASE "openrave")
    set( OpenRAVE_LIBRARY_DEBUG "openrave")
  else( MSVC )
    set(OpenRAVE_FOUND 0)
  endif( MSVC )  
endif(OpenRAVE_CONFIG_EXECUTABLE)

MARK_AS_ADVANCED(
    OpenRAVE_FOUND
    OpenRAVE_CXXFLAGS
    OpenRAVE_LINK_FLAGS
    OpenRAVE_INCLUDE_DIRS
    OpenRAVE_LINK_DIRS
    OpenRAVE_LIBRARY
    OpenRAVE_LIBRARY_RELEASE
    OpenRAVE_LIBRARY_DEBUG
)
