//# Get revision info; generated by CMake/makeversion

#ifndef LOFAR_COMMON_PACKAGE__VERSION_H
#define LOFAR_COMMON_PACKAGE__VERSION_H

#include <Common/Version.h>

// Class to get the version (revision) of the package and the packages it uses.
namespace LOFAR {
  class CommonVersion
  {
  public:
    // Get the info for this package.
    static Version getInfo();

    // Get the version number of the package (as given in repository).
    static std::string getVersion();
    // Get the svn version number of the package according to CMakeLists.txt.
    static std::string getConfVersion();
    // Get the global revision number of the package.
    static std::string getRevision();
    // Get the local revision number of the package.
    static std::string getPackageRevision();
    // Get the number of files differing from repository.
    // Usually this is blank, but it can tell the nr of changed files.
    static std::string getNrChangedFiles();
    // Get the date/time the package was built (in fact, configured).
    static std::string getBuildTime();
    // Get the name of the user who built the package.
    static std::string getBuildUser();
    // Get the machine the package was built on.
    static std::string getBuildMachine();

    // Append the vector with the vinfo of this package and used packages.
    static void fillInfo (int level,
			  std::vector<Version::PkgInfo>& vec);
  };
}

#endif
