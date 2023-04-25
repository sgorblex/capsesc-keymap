# capsesc tty keymap
capsesc is a script which creates a tty keymap which switches the caps_lock and esc keys. This is very useful since the average user has way more keypresses for the esc key as opposed to the caps_lock key, which is more easily reachable in a tipical keyboard layout. For example, it is very useful for Vim users.

## USER STORIES

./capsesc.sh
Creates switched version of the current keymap and puts it in the current directory

./capsesc.sh keymap_name
Creates switched version of the specified keymap and puts it in the current directory

./capsesc.sh [keymap_name] -i|--install
Creates switched version of the current/specified keymap and installs it. Leaves the new keymap in a temporary file which path is printed.

## IDEAS
Work in X too
