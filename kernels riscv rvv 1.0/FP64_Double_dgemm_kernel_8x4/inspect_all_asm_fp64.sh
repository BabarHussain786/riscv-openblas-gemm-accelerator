#!/usr/bin/env bash

echo "=========================================================="
echo " Generating Assembly (.s) & Instruction Counts (FP64)"
echo "=========================================================="

# Create or clear the report file
REPORT_FILE="asm_inspection_report_fp64.txt"
echo "Assembly Instruction Counts (RVV FP64)" > $REPORT_FILE
echo "==========================================================" >> $REPORT_FILE
printf "%-40s | %-6s | %-6s | %-6s | %-6s\n" "Kernel Name" "vfmacc" "vfmul" "vle64" "vse64" >> $REPORT_FILE
echo "--------------------------------------------------------------------------------" >> $REPORT_FILE

# Loop through all the 8x4 FP64 directories
for dir in dgemm_kernel_8x4_zvl128b_*; do
    if [ -d "$dir" ]; then
        cd "$dir" || continue
        
        # Find the .c file (ignoring the bench.c file)
        C_FILE=$(ls *.c | grep -v "bench" | head -n 1)
        
        if [ -n "$C_FILE" ]; then
            echo "Compiling to assembly: $dir"
            
            # Generate the assembly file (.s)
            gcc -O3 -march=rv64gcv_zvl128b -mabi=lp64d -S -fverbose-asm -fno-asynchronous-unwind-tables "$C_FILE"
            
            # The generated .s file has the same name but with .s extension
            S_FILE="${C_FILE%.c}.s"
            
            # Count the important RVV FP64 instructions
            VFMACC_COUNT=$(grep -c "vfmacc" "$S_FILE")
            VFMUL_COUNT=$(grep -c "vfmul" "$S_FILE")
            VLE64_COUNT=$(grep -c "vle64\.v" "$S_FILE")
            VSE64_COUNT=$(grep -c "vse64\.v" "$S_FILE")
            
            # Log the counts to our report
            printf "%-40s | %-6s | %-6s | %-6s | %-6s\n" "$dir" "$VFMACC_COUNT" "$VFMUL_COUNT" "$VLE64_COUNT" "$VSE64_COUNT" >> "../$REPORT_FILE"
        fi
        
        cd ..
    fi
done

echo "=========================================================="
echo " Done! All .s files generated."
echo " Check 'asm_inspection_report_fp64.txt' for the summary."
echo "=========================================================="
