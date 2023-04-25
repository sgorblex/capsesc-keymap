# capsesc tty keymap
`capsesc.sh` is a script that creates a tty keymap which switches the <kbd>esc</kbd> and <kbd>caps_lock</kbd> keys.
This is very useful since the average user has way more keypresses for <kbd>esc</kbd> as opposed to <kbd>caps_lock</kbd>, which is more easily reachable in a tipical keyboard layout.
For example, it is very useful for Vim users.

Switching the <kbd>esc</kbd> and <kbd>caps_lock</kbd> keys in the graphical interface is quite easy, for example in X you might just run `setxkbdmap -option caps:swapescape`.
In the tty this is not so easy, since you need to create a custom keymap.
The script aims to do so automatically, by creating a keymap either over the current one or over a specified one.

## Usage
As in `capsesc.sh --help`:
```
capsesc.sh: create a tty keymap with the caps_lock and esc keys switched.

USAGE:
capsesc.sh [OPTIONS] [MAP_NAME]

If neither --load nor --install are specified, leaves the new keymap in the current directory.

OPTIONS:
-l, --load			Load keymap after creating it (requires root privileges)
-i, --install NEW_NAME		Install keymap in after creating it (requires root privileges)
				(puts it in /usr/share/kbd/keymaps/custom)
-h, --help			Show this help
```
