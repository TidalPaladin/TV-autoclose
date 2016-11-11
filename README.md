# TV-autoclose

This simple script written in bash is designed to clean up the many windows that can appear when using Teamviewer on the Raspberry Pi.

Specifically, the following windows are modified:

  * Change password and free trial prompts are automatically closed
  * Teamviewer logo window is forced to the bottom of the desktop stack. This window cannot be closed or removed from the screen, as it
   will cause the Teamviewer connection to freeze.
   
## Requirements

Closing of windows is achieved with xdotool, and adjusting window position in stack is achieved with wmctrl. These packages can be installed with
`sudo apt-get install wmctrl xdotool`
