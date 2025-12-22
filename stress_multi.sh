#!/home/mario/git/4.4BSD-Lite2/usr/src/bin/sh

# Expanded stress test for memory growth analysis

ITERATIONS=500
echo "Starting expanded stress tests ($ITERATIONS iterations)..."

i=0
while [ $i -lt $ITERATIONS ]; do
    # 1. Variable churn
    X="var_$i"
    eval "$X=value_$i"
    unset $X
    
    # 2. Arithmetic churn
    Y=$((i * 10 / 2 + 5))
    
    # 3. Subshell churn
    (echo $i) > /dev/null
    
    # 4. Command sub churn
    A=$(echo $i)
    
    i=$((i + 1))
done

echo "Expanded stress tests completed."
