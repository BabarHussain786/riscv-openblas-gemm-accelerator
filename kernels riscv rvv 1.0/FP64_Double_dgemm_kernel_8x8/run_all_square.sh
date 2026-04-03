#!/usr/bin/env bash

# Create a directory to hold all the cleanly named result logs
mkdir -p summary_results

# Define the matrix dimensions for the Square shape (Set to 4096³)
M=4096
N=4096
K=4096

echo "=========================================================="
echo " Starting Compilation & Square-Only Benchmarks (FP64 8x8)"
echo " Dimensions: M=$M, N=$N, K=$K"
echo "=========================================================="

# The complete list of your FP64 8x8 benchmark folders based on your 'ls' output
DIRS=(
    "dgemm_kernel_8x8_zvl128b_lmul1_unroll1"
    "dgemm_kernel_8x8_zvl128b_lmul1_unroll2"
    "dgemm_kernel_8x8_zvl128b_lmul1_unroll4"
    "dgemm_kernel_8x8_zvl128b_lmul1_unroll8"
    "dgemm_kernel_8x8_zvl128b_lmul2_unroll1"
    "dgemm_kernel_8x8_zvl128b_lmul2_unroll2"
    "dgemm_kernel_8x8_zvl128b_lmul2_unroll4"
    "dgemm_kernel_8x8_zvl128b_lmul2_unroll8"
    "dgemm_kernel_8x8_zvl128b_lmul4_unroll1"
    "dgemm_kernel_8x8_zvl128b_lmul4_unroll2"
    "dgemm_kernel_8x8_zvl128b_lmul4_unroll4"
    "dgemm_kernel_8x8_zvl128b_lmul4_unroll8"
    "dgemm_kernel_8x8_zvl128b_lmul8_unroll1"
    "dgemm_kernel_8x8_zvl128b_lmul8_unroll2"
    "dgemm_kernel_8x8_zvl128b_lmul8_unroll4"
    "dgemm_kernel_8x8_zvl128b_lmul8_unroll8"
)

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "----------------------------------------------------------"
        echo ">>> Processing: $dir"
        
        # Navigate into the specific kernel folder
        cd "$dir" || continue
        
        # Define the log file path (saved in the parent summary_results folder)
        LOGFILE="../summary_results/${dir}_square_results.log"
        
        # Initialize the log file
        echo "=======================================" > "$LOGFILE"
        echo "Kernel: $dir" >> "$LOGFILE"
        echo "Shape: Square ($M x $N x $K)" >> "$LOGFILE"
        echo "=======================================" >> "$LOGFILE"

        # Compile the code freshly
        make clean > /dev/null 2>&1
        make > /dev/null 2>&1
        
        # Check if compilation succeeded
        if [ -f "./bench" ]; then
            echo "    Compilation successful. Running 6 iterations..."
            
            # Run the benchmark 6 times for statistical accuracy, logging output
            for i in {1..6}; do
                echo "    Run $i..."
                echo "Run $i" >> "$LOGFILE"
                ./bench $M $N $K >> "$LOGFILE" 2>&1
            done
            
            echo "    Done. Results saved to $LOGFILE"
        else
            echo "    [ERROR] Compilation failed!"
            echo "[ERROR] Compilation failed during Make." >> "$LOGFILE"
        fi
        
        # Return to the root directory
        cd ..
        
        # Small sleep to let the CPU cool down so thermal throttling doesn't skew results
        sleep 2
    else
        echo "[WARNING] Directory $dir not found. Skipping."
    fi
done

echo "----------------------------------------------------------"
echo "All benchmarks finished! Check the 'summary_results' folder for your logs."
echo "=========================================================="
