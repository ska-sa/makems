#  $Id: LofarCTest.cmake 13474 2009-06-24 14:33:14Z loose $
#
#  Copyright (C) 2008-2009
#  ASTRON (Netherlands Foundation for Research in Astronomy)
#  P.O.Box 2, 7990 AA Dwingeloo, The Netherlands, seg@astron.nl
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## --------------------------------------------------------------------------
## "Auto-tools variable" needed for backward compatibility
## --------------------------------------------------------------------------
set(srcdir "${CMAKE_CURRENT_SOURCE_DIR}")

## --------------------------------------------------------------------------
## Add current source directory to compiler's include path
## --------------------------------------------------------------------------
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

## ----------------------------------------------------------------------------
## Configure the LOFAR CTest wrapper script in the current binary directory
## ----------------------------------------------------------------------------
configure_file(${LOFAR_ROOT}/autoconf_share/runctest.sh.in
               ${CMAKE_CURRENT_BINARY_DIR}/runctest.sh)
