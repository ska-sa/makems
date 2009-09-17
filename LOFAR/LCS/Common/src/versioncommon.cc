//# Print revision info; generated by CMake/makeversion

#include <Common/Package__Version.h>
#include <Common/Version.h>
#include <iostream>

using namespace LOFAR;

int main (int argc, const char* argv[])
{
  std::string type = "brief";
  if (argc > 1) {
    type = argv[1];
  }
  Version::show<CommonVersion> (std::cout, "Common", type);
  return 0;
}