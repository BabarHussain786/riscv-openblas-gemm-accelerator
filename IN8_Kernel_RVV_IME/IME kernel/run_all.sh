#!/bin/bash
# ==============================================================================
#  run_all.sh — Build and run full IME GEMM benchmark suite
#
#  What this script does:
#    1. Shows system info (CPU, frequency, governor, thermal)
#    2. Tries to set performance governor (needs root or already set)
#    3. Builds the benchmark
#    4. Runs correctness test on both clusters
#    5. Runs performance benchmark on both clusters
#    6. Runs size sweep on AI core
#
#  Usage:
#    chmod +x run_all.sh
#    ./run_all.sh              # default: test + bench 1024
#    ./run_all.sh quick        # just correctness test
#    ./run_all.sh full         # everything including 2048
# ==============================================================================

set -e

MODE=${1:-default}

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  SpacemiT K1 IME GEMM — Full Benchmark Suite           ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── System info ──
echo "──── System Information ────"
echo "  Kernel:  $(uname -r)"
echo "  Arch:    $(uname -m)"
echo "  CPUs:    $(nproc)"
echo "  uarch:   $(grep -m1 'uarch' /proc/cpuinfo 2>/dev/null | awk '{print $3}' || echo 'N/A')"

# Frequency
if [ -f /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq ]; then
    freq=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq)
    gov=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)
    echo "  Freq:    $((freq / 1000)) MHz"
    echo "  Governor: $gov"
fi

# AI core detection
echo ""
echo "──── Core Detection ────"
for cpu in 0 1 2 3 4 5 6 7; do
    if [ -d "/sys/firmware/devicetree/base/cpus/cpu@${cpu}/cpu-ai" ]; then
        echo "  CPU $cpu: AI ✓  (Cluster0)"
    else
        echo "  CPU $cpu: GP    (Cluster1)"
    fi
done

# TCM
if [ -e /dev/tcm ]; then
    echo "  TCM:   available (/dev/tcm)"
fi
echo ""

# ── Try to set performance governor ──
echo "──── Performance Setup ────"
if [ -w /sys/devices/system/cpu/cpufreq/policy0/scaling_governor ]; then
    echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo "  Governor set to 'performance'"
else
    echo "  Cannot set governor (need root). For stable results:"
    echo "  sudo sh -c 'echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor'"
fi
echo ""

# ── Build ──
echo "──── Building ────"
make clean
make
echo ""

# ── Run based on mode ──
case "$MODE" in
    quick)
        echo "──── Quick Correctness Test ────"
        echo ""
        echo "=== AI Core (CPU 0) ==="
        taskset -c 0 ./gemm_bench 64
        echo ""
        echo "=== General Core (CPU 4) ==="
        taskset -c 4 ./gemm_bench 64
        echo ""
        echo "=== AI Core 256×256×256 ==="
        taskset -c 0 ./gemm_bench 256
        echo ""
        echo "=== General Core 256×256×256 ==="
        taskset -c 4 ./gemm_bench 256
        ;;

    full)
        echo "──── Full Test Suite ────"
        echo ""

        # Correctness
        echo ">>> Correctness Test (64³) <<<"
        taskset -c 0 ./gemm_bench 64
        taskset -c 4 ./gemm_bench 64

        echo ""
        echo ">>> Size Sweep (AI Core, CPU 0) <<<"
        for size in 128 256 512 1024 2048; do
            echo ""
            echo "--- ${size}×${size}×${size} ---"
            taskset -c 0 ./gemm_bench $size
        done

        echo ""
        echo ">>> AI vs General Comparison <<<"
        for size in 256 512 1024; do
            echo ""
            echo "--- ${size}³ on AI Core ---"
            taskset -c 0 ./gemm_bench $size
            echo "--- ${size}³ on General Core ---"
            taskset -c 4 ./gemm_bench $size
        done
        ;;

    *)
        echo "──── Default: Correctness + Benchmark ────"
        echo ""

        # Correctness on both clusters
        echo ">>> Correctness Test (64³, both clusters) <<<"
        echo "AI Core (CPU 0):"
        taskset -c 0 ./gemm_bench 64
        echo ""
        echo "General Core (CPU 4):"
        taskset -c 4 ./gemm_bench 64

        echo ""

        # Main benchmark
        echo ">>> Benchmark 1024³ <<<"
        echo ""
        echo "AI Core (CPU 0):"
        taskset -c 0 ./gemm_bench 1024
        echo ""
        echo "General Core (CPU 4):"
        taskset -c 4 ./gemm_bench 1024
        ;;
esac

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  All tests complete.                                    ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
