# $Id: FindFFTW3.cmake 13758 2009-08-13 13:48:33Z loose $
#
# Copyright (C) 2008-2009
# ASTRON (Netherlands Foundation for Research in Astronomy)
# P.O.Box 2, 7990 AA Dwingeloo, The Netherlands, seg@astron.nl
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# Try to find FFTW3.
#
# Usage: find_package(FFTW3 [COMPONENTS [double|single|long-double] [threads]])
# This will define:
#  
#  FFTW3_FOUND        - system has FFTW3
#  FFTW3_INCLUDE_DIR  - the FFTW3 include directory (cached)
#  FFTW3_INCLUDE_DIRS - the FFTW3 include directories
#                       (identical to FFTW3_INCLUDE_DIR)
#  FFTW3_LIBRARY      - the FFTW3 library (cached)
#  FFTW3_LIBRARIES    - the FFTW3 libraries
#                       (identical to FFTW3_LIBRARY)

set(_usage_msg
  "Usage: find_package(FFTW3 [COMPONENTS [double|single|long-double]"
  "[threads]])")

# -----------------------------------------------------------------------------
# Get the optional component _fftw3_${_kind}. Sensible values for _fftw3_${_kind}
# are (at the moment) precision, or parallelization.
# The variable _values will contain the list of valid components for
# _fftw3_${_kind}; the first element of _values is used as default value, in case
# no matching component could be found.
# The output will be stored in the variable _fftw3_${_kind}.
#
# It is an error if, between multiple calls of FindFFTW3(), the currently
# specified component value is different from the cached one.
#
# Usage: get_fftw3_component(<category> <default-value> [value] ...)
# -----------------------------------------------------------------------------
macro(get_fftw3_component _kind _default_value)
  set(_values ${ARGN})
  set(_fftw3_${_kind})
  foreach(_val ${_values})
    list(FIND FFTW3_FIND_COMPONENTS ${_val} _idx)
    if(_idx GREATER -1)
      if(NOT _fftw3_${_kind})
        set(_fftw3_${_kind} ${_val})
      else(NOT _fftw3_${_kind})
        message(FATAL_ERROR
          "FindFFTW3: more than one `_fftw3_${_kind}' component was specified.\n"
          "${_usage_msg}")
      endif(NOT _fftw3_${_kind})
    endif(_idx GREATER -1)
  endforeach(_val ${_values})
  if(NOT _fftw3_${_kind})
    set(_fftw3_${_kind} "${_default_value}")
  endif(NOT _fftw3_${_kind})
  string(TOUPPER "FFTW3_${_kind}" _cached_value)
  if(DEFINED ${_cached_value})
    if(NOT "${_fftw3_${_kind}}" STREQUAL "${${_cached_value}}")
      message(FATAL_ERROR
        "FindFFTW3: previous call used ${_kind} `${${_cached_value}}', "
        "which is different from `${_fftw3_${_kind}}'. This is not supported!")
    endif(NOT "${_fftw3_${_kind}}" STREQUAL "${${_cached_value}}")
  endif(DEFINED ${_cached_value})
endmacro(get_fftw3_component _kind)

# -----------------------------------------------------------------------------
# get_fftw3_precision() 
#
# Return the precision `component' (single|double|long-double) in _precision.
# Set the _precision_tag depending on the specified precision.
# -----------------------------------------------------------------------------
macro(get_fftw3_precision)
  get_fftw3_component(precision double single long-double)
  if(_precision MATCHES single)
    set(_precision_tag f)
  elseif(_precision MATCHES long-double)
    set(_precision_tag l)
  else()
    set(_precision_tag)
  endif(_precision MATCHES single)
endmacro(get_fftw3_precision)

# -----------------------------------------------------------------------------
# get_fftw3_parallelization()
#
# Return the parallelization `component' (off|threads) in _parallelization.
# -----------------------------------------------------------------------------
macro(get_fftw3_parallelization)
  get_fftw3_component(parallelization off threads)
endmacro(get_fftw3_parallelization)

# =============================================================================

# Get the precision `component' (single|double|long-double)
get_fftw3_precision()

# Get the parallelization `component' (off|threads)
get_fftw3_parallelization()

# Set the default header and library file names.
set(_libraries fftw3${_precision_tag})
set(_headerfile fftw3.h)

# Parallelization using threads also requires fftw3_threads library
if(_fftw3_parallelization)
  set(_libraries fftw3${_precision_tag}_${_fftw3_parallelization} ${_libraries})
endif(_fftw3_parallelization)

# Keep a list of variable names that we need to pass on to
# find_package_handle_standard_args().
set(_check_list)

# Search for all required libraries.
foreach(_lib ${_libraries})
  string(TOUPPER ${_lib} _LIB)
  find_library(${_LIB}_LIBRARY ${_lib})
  mark_as_advanced(${_LIB}_LIBRARY)
  list(APPEND FFTW3_LIBRARIES ${${_LIB}_LIBRARY})
  list(APPEND _check_list ${_LIB}_LIBRARY)
endforeach(_lib ${_libraries})

# Search for the header file.
find_path(FFTW3_INCLUDE_DIR fftw3.h)
mark_as_advanced(FFTW3_INCLUDE_DIR)
list(APPEND _check_list FFTW3_INCLUDE_DIR)

# Handle the QUIETLY and REQUIRED arguments and set FFTW_FOUND to TRUE if
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFTW3 DEFAULT_MSG ${_check_list})

# If everything was found, put the following variables in the cache. We need
# them to check if a second call to FindFFTW has conflicting options.
if(FFTW3_FOUND)
  set(FFTW3_PRECISION ${_fftw3_precision} CACHE INTERNAL
    "FFTW precision")
  set(FFTW3_PARALLELIZATION ${_fftw3_parallelization} CACHE INTERNAL
    "FFTW parallelization")
endif(FFTW3_FOUND)
