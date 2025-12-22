#!/home/mario/git/4.4BSD-Lite2/usr/src/bin/sh

# Environment and Export stress test

echo "Starting environment stress tests..."

i=0
while [ $i -lt 100 ]; do
    VARNAME="EXT_VAR_$i"
    export $VARNAME="some_value_$i"
    # Overwrite it
    export $VARNAME="new_value_$i"
    # Unset it
    unset $VARNAME
    i=$((i + 1))
done

# Test many exports at once
export A=1 B=2 C=3 D=4 E=5 F=6 G=7 H=8 I=9 J=10
unset A B C D E F G H I J

echo "Environment stress tests completed."
