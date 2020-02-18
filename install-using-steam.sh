#!/bin/sh

set -e

killall devildaggers > /dev/zero || true
steam -applaunch 422970
sleep 4

exe=$(readlink /proc/"$(pidof devildaggers devildaggers.bin)"/exe)
ddir=$(dirname "$exe")

killall devildaggers
sleep 1

mv "$exe" "$exe.bin"

(
cat << EOF
break XOpenIM
run
delete
finish
p \$rax = 0
continue
EOF
) > "$ddir/fix.gdb"

(
cat << EOF
#!/bin/sh

exec gdb ./devildaggers.bin < ./fix.gdb
EOF
) > "$exe"
chmod +x "$exe"

echo Success!?
steam -applaunch 422970

