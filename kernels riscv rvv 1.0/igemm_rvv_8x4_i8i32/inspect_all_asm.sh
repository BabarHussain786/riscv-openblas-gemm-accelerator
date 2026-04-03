#!/usr/bin/env bash

echo "=========================================================="
echo " Generating Assembly (.s) & Instruction Counts"
echo "=========================================================="

# Create or clear the report file
REPORT_FILE="asm_inspection_report.txt"
echo "Assembly Instruction Counts (RVV)" > $REPORT_FILE
echo "==========================================================" >> $REPORT_FILE
printf "%-40s | %-6s | %-6s | %-6s | %-6s\n" "Kernel Name" "vmacc" "vmul" "vle8" "vse8" >> $REPORT_FILE
echo "--------------------------------------------------------------------------------" >> $REPORT_FILE

# Loop through all the 8x4 directories
for dir in igemm_kernel_8x4_zvl128b_*; do
    if [ -d "$dir" ]; then
        cd "$dir" || continue
        
        # Find the .c file (assuming only one main kernel .c file exists per folder)
        C_FILE=$(ls *.c | grep -v "bench")
        
        if [ -n "$C_FILE" ]; then
            echo "Compiling to assembly: $dir"
            
            # Generate the assembly file (.s)
            gcc -O3 -march=rv64gcv_zvl128b -mabi=lp64d -S -fverbose-asm -fno-asynchronous-unwind-tables "$C_FILE"
            
            # The generated .s file has the same name but with .s extension
            S_FILE="${C_FILE%.c}.s"
            
            # Count the important RVV instructions
            VMACC_COUNT=$(grep -c "vmacc\.vx" "$S_FILE")
            VMUL_COUNT=$(grep -c "vmul\.vx" "$S_FILE")
            VLE8_COUNT=$(grep -c "vle8\.v" "$S_FILE")
            VSE8_COUNT=$(grep -c "vse8\.v" "$S_FILE")
            
            # Log the counts to our report
            printf "%-40s | %-6s | %-6s | %-6s | %-6s\n" "$dir" "$VMACC_COUNT" "$VMUL_COUNT" "$VLE8_COUNT" "$VSE8_COUNT" >> "../$REPORT_FILE"
        fi
        
        cd ..
    fi
done

echo "=========================================================="
echo " Done! All .s files generated."
echo " Check 'asm_inspection_report.txt' for the summary."
echo "=========================================================="
