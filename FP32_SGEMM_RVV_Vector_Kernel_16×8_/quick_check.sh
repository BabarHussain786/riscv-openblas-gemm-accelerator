#!/usr/bin/env bash

# Small matrix size for instant verification
M=256
N=256
K=256

echo "=========================================================="
echo " Quick Kernel Verification Check"
echo " Compiling and running 1 iteration of M=$M, N=$N, K=$K"
echo "=========================================================="

DIRS=(
    "sgemm_kernel_16x8_zvl256b_lmulmf2_unroll1"
    "sgemm_kernel_16x8_zvl256b_lmulmf2_unroll2"
    "sgemm_kernel_16x8_zvl256b_lmulmf2_unroll4"
    "sgemm_kernel_16x8_zvl256b_lmulmf2_unroll8"
    "sgemm_kernel_16x8_zvl256b_lmul1_unroll1"
    "sgemm_kernel_16x8_zvl256b_lmul1_unroll2"
    "sgemm_kernel_16x8_zvl256b_lmul1_unroll4"
    "sgemm_kernel_16x8_zvl256b_lmul1_unroll8"
    "sgemm_kernel_16x8_zvl256b_lmul2_unroll1"
    "sgemm_kernel_16x8_zvl256b_lmul2_unroll2"
    "sgemm_kernel_16x8_zvl256b_lmul2_unroll4"
    "sgemm_kernel_16x8_zvl256b_lmul2_unroll8"
    "sgemm_kernel_16x8_zvl256b_lmul4_unroll1"
    "sgemm_kernel_16x8_zvl256b_lmul4_unroll2"
    "sgemm_kernel_16x8_zvl256b_lmul4_unroll4"
    "sgemm_kernel_16x8_zvl256b_lmul4_unroll8"
    "sgemm_kernel_16x8_zvl256b_lmul8_unroll1"
    "sgemm_kernel_16x8_zvl256b_lmul8_unroll2"
    "sgemm_kernel_16x8_zvl256b_lmul8_unroll4"
    "sgemm_kernel_16x8_zvl256b_lmul8_unroll8"
)

FAILED_KERNELS=()

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        # Print the directory name padded to 45 characters for alignment
        printf "%-45s " "$dir"
        
        cd "$dir" || continue
        
        # Compile silently
        make clean > /dev/null 2>&1
        make > /dev/null 2>&1
        
        if [ -f "./bench" ]; then
            # Run small benchmark silently
            ./bench $M $N $K > /dev/null 2>&1
            
            # Check exit code
            if [ $? -eq 0 ]; then
                echo "[ OK ]"
            else
                echo "[ RUNTIME ERROR ]"
                FAILED_KERNELS+=("$dir (Runtime Error)")
            fi
        else
            echo "[ COMPILATION FAILED ]"
            FAILED_KERNELS+=("$dir (Compile Error)")
        fi
        
        cd ..
    else
        printf "%-45s [ NOT FOUND ]\n" "$dir"
    fi
done

echo "=========================================================="
if [ ${#FAILED_KERNELS[@]} -eq 0 ]; then
    echo " All present kernels compiled and ran successfully!"
else
    echo " The following kernels had issues:"
    for failed in "${FAILED_KERNELS[@]}"; do
        echo "  - $failed"
    done
fi
echo "=========================================================="
