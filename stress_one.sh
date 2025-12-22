#!/home/mario/git/4.4BSD-Lite2/usr/src/bin/sh

# Stress test script for 4.4BSD ash

echo "Starting stress tests..."

# 1. Loop and Variable Expansion
echo "Testing loops and variables..."
for i in 1 2 3 4 5 6 7 8 9 10; do
    for j in 1 2 3 4 5; do
        X="var_${i}_${j}"
        eval "$X=value_$i$j"
    done
done

# 2. Arithmetic Expansion
echo "Testing arithmetic..."
count=0
while [ $count -lt 100 ]; do
    count=$((count + 1))
    Y=$((count * 2 / 1 + 10 - 5))
done

# 3. Subshells and Pipes
echo "Testing subshells and pipes..."
(echo "hello" | cat | cat | cat | sed 's/h/H/') > /dev/null

# 4. Builtins and Redirection
echo "Testing builtins and redirections..."
echo "test" > test_leak.tmp
read line < test_leak.tmp
rm test_leak.tmp

# 5. Functions
echo "Testing functions..."
func_test() {
    local lvar="local"
    echo $1 $lvar
}
for i in 1 2 3 4 5; do
    func_test "arg$i" > /dev/null
done

# 6. Command Substitution
echo "Testing command substitution..."
A=$(echo "subshell output")
B=`echo "backtick output"`

# 7. Large Data handling (small scale for test)
echo "Testing large strings..."
LONG="initial"
for i in 1 2 3 4 5 6 7; do
    LONG="${LONG}${LONG}"
done
echo ${#LONG} > /dev/null

echo "Stress tests completed."
