#!/usr/bin/env bash

echo "=================================================================="
echo " RVV Kernel Quick Sanity Check (Matrix Size: 512x512x512)"
echo "=================================================================="
printf "%-45s | %-10s | %s\n" "Kernel Directory" "Status" "GFLOPS"
echo "------------------------------------------------------------------"

# Loop through all matching directories
for dir in dgemm_kernel_8x8_zvl128b_lmul*; do
    if [ -d "$dir" ]; then
        cd "$dir"
        
        # Clean and compile silently
        make clean > /dev/null 2>&1
        make > build.log 2>&1
        
        if [ -f "./bench" ]; then
            # Run a small quick test and capture output
            OUTPUT=$(./bench 512 512 512 2>&1)
            
            # Check if the execution was successful
            if [ $? -eq 0 ]; then
                # Extract the GFLOPS value from the output
                GFLOPS=$(echo "$OUTPUT" | grep "GFLOPS:" | awk '{print $2}')
                printf "%-45s | [ OK ]     | %s\n" "$dir" "$GFLOPS"
            else
                printf "%-45s | [CRASH]    | Segfault or Error\n" "$dir"
            fi
        else
            printf "%-45s | [BUILD FA]| See build.log\n" "$dir"
        fi
        
        # Go back to the root directory
        cd ..
    fi
done
echo "=================================================================="
