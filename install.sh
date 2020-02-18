#!/bin/sh

# To install:
# 1. Go to your Steam library
# 2. Find Devil Daggers in the game list
# 3. Right click DD entry -> Properties -> Local Files
# 4. Click "BROWSE LOCAL FILES".
# 5. Save this file there, it should be named "install.sh".
# 6. You must mark install.sh as executable and run it. To do this...
#
# If you're using dolphin (KDE):
#   1. Right click install.sh -> Properties -> Permissions
#   2. Make sure "Is executable" is checked.
#   3. Click "OK"
#   4. Double click install.sh, and choose "run" if it asks to open or run.
#
# Otherwise, in a terminal opened in devil dagger's directory:
#   1. chmod +x ./install.sh && ./install.sh
#
# 8. You also need to have gdb installed. Search for it in your package manager; IDK the specifics of this.
# 9. Run devil daggers from steam.
# 10. Mash A and D simultaneously a bunch of times ingame to make sure the fix took.

# To uninstall/if something breaks:
# 1. Go to your Steam library
# 2. Find Devil Daggers in the game list
# 3. Right click DD entry -> Properties -> Local Files
# 4. Click "VERIFY INTEGRITY OF GAME FILES..."


if [ -x devildaggers.bin ]
then
    # Already installed; $0 should be devildaggers
    (
    cat << EOF
break XOpenIM
run
delete
finish
p \$rax = 0
continue
EOF
    ) | exec gdb ./devildaggers.bin
else
    # Not installed; $0 should be install.sh
    echo Installing self.
    mv devildaggers devildaggers.bin
    cp $0 devildaggers
    chmod +x $0
fi
