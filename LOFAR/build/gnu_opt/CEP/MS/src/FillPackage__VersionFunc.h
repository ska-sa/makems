/* Generated by CMake for project MS */

namespace LOFAR {
  std::string MSVersion::getBuildTime()
  { return std::string(__DATE__) + " " + std::string(__TIME__); }
  std::string MSVersion::getBuildUser()
  { return "oms"; }
  std::string MSVersion::getBuildMachine()
  { return "jakob"; }
  void MSVersion::fillInfo
    (int level, std::vector<Version::PkgInfo>& vec)
  {
    // Add info of this package if needed.
    vec.push_back (Version::PkgInfo(level, &getInfo));
    // Add info of packages being used.
    CommonVersion::fillInfo (level+1, vec);
  }
}