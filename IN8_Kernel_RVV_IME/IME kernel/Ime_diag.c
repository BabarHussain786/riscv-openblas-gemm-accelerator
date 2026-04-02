/*
 * ime_diag.c — Diagnostic tool to reveal IME accumulator layout
 *
 * Feeds known values into vmadot and dumps the raw accumulator
 * to determine the exact row/column mapping.
 *
 * Build:  gcc -O2 -march=rv64gcv -o ime_diag ime_diag.c
 * Run:    taskset -c 0 ./ime_diag
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <sched.h>

#define VMADOT_TILE0  0xE348342Bu
#define _S(x) #x
#define S(x)  _S(x)

int main(void)
{
    int cpu = sched_getcpu();
    printf("Running on CPU %d\n\n", cpu);

    /*
     * TEST 1: Identity-like test
     *
     * Set A = identity-ish pattern so we can trace which element
     * ends up where in the accumulator.
     *
     * A is packed as row-major 4×8 in a 32-byte register:
     *   A[r*8 + k] for r=0..3, k=0..7
     *
     * B is packed as row-major 4×8:
     *   B[c*8 + k] for c=0..3, k=0..7
     *
     * vmadot computes: C[i][j] = sum_k A[i][k] * B[j][k]
     * (assuming A×B^T semantic)
     *
     * Test: set A row 0 = [1,0,0,0, 0,0,0,0]
     *           A row 1 = [0,1,0,0, 0,0,0,0]
     *           A row 2 = [0,0,1,0, 0,0,0,0]
     *           A row 3 = [0,0,0,1, 0,0,0,0]
     *       set B col 0 = [1,0,0,0, 0,0,0,0]
     *           B col 1 = [0,1,0,0, 0,0,0,0]
     *           B col 2 = [0,0,1,0, 0,0,0,0]
     *           B col 3 = [0,0,0,1, 0,0,0,0]
     *
     * Expected C = 4×4 identity matrix:
     *   C[0][0]=1 C[0][1]=0 C[0][2]=0 C[0][3]=0
     *   C[1][0]=0 C[1][1]=1 C[1][2]=0 C[1][3]=0
     *   C[2][0]=0 C[2][1]=0 C[2][2]=1 C[2][3]=0
     *   C[3][0]=0 C[3][1]=0 C[3][2]=0 C[3][3]=1
     */

    int8_t A_pack[32] __attribute__((aligned(64)));
    int8_t B_pack[32] __attribute__((aligned(64)));
    int32_t acc[16]   __attribute__((aligned(64)));

    memset(A_pack, 0, 32);
    memset(B_pack, 0, 32);

    /* A: 4×8 identity in first 4 columns */
    A_pack[0*8 + 0] = 1;  /* row 0, col 0 */
    A_pack[1*8 + 1] = 1;  /* row 1, col 1 */
    A_pack[2*8 + 2] = 1;  /* row 2, col 2 */
    A_pack[3*8 + 3] = 1;  /* row 3, col 3 */

    /* B: same as A */
    B_pack[0*8 + 0] = 1;
    B_pack[1*8 + 1] = 1;
    B_pack[2*8 + 2] = 1;
    B_pack[3*8 + 3] = 1;

    memset(acc, 0, 64);

    /* Fire vmadot and dump accumulator */
    __asm__ __volatile__ (
        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vmv.v.i v8, 0\n\t"

        "li     t0, 32\n\t"
        "vsetvli zero, t0, e8, m1, ta, ma\n\t"
        "vle8.v v16, (%[aptr])\n\t"
        "vle8.v v20, (%[bptr])\n\t"

        ".word " S(VMADOT_TILE0) "\n\t"

        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vse32.v v8, (%[acc])\n\t"

        :
        : [aptr] "r" (A_pack),
          [bptr] "r" (B_pack),
          [acc]  "r" (acc)
        : "t0", "memory",
          "v8", "v9", "v16", "v20"
    );

    printf("TEST 1: Identity A × Identity B\n");
    printf("Expected: 4×4 identity matrix\n\n");
    printf("Raw accumulator (v8,v9 = 16 × int32):\n");
    for (int i = 0; i < 16; i++) {
        printf("  acc[%2d] = %4d", i, acc[i]);
        if (i % 4 == 3) printf("\n");
    }

    printf("\nInterpreted as row-major 4×4:\n");
    for (int r = 0; r < 4; r++) {
        printf("  row %d: ", r);
        for (int c = 0; c < 4; c++)
            printf("%3d ", acc[r * 4 + c]);
        printf("\n");
    }

    printf("\nInterpreted as column-major 4×4:\n");
    for (int r = 0; r < 4; r++) {
        printf("  row %d: ", r);
        for (int c = 0; c < 4; c++)
            printf("%3d ", acc[c * 4 + r]);
        printf("\n");
    }

    /*
     * TEST 2: Asymmetric test to distinguish row-major vs column-major
     *
     * A row 0 = [1,0,0,0, 0,0,0,0]   (only k=0 nonzero)
     * A row 1 = [2,0,0,0, 0,0,0,0]
     * A row 2 = [3,0,0,0, 0,0,0,0]
     * A row 3 = [4,0,0,0, 0,0,0,0]
     *
     * B col 0 = [10,0,0,0, 0,0,0,0]
     * B col 1 = [20,0,0,0, 0,0,0,0]
     * B col 2 = [30,0,0,0, 0,0,0,0]
     * B col 3 = [40,0,0,0, 0,0,0,0]
     *
     * Expected: C[i][j] = A[i][0] * B[j][0]
     *   C = [ 10  20  30  40 ]
     *       [ 20  40  60  80 ]
     *       [ 30  60  90 120 ]
     *       [ 40  80 120  (overflow, but still shows pattern) ]
     *
     * Wait, int8 * int8 accumulates to int32, so no overflow for these values.
     * C[i][j] = (i+1) * (j+1) * 10
     */

    printf("\n========================================\n\n");

    memset(A_pack, 0, 32);
    memset(B_pack, 0, 32);

    A_pack[0*8 + 0] = 1;
    A_pack[1*8 + 0] = 2;
    A_pack[2*8 + 0] = 3;
    A_pack[3*8 + 0] = 4;

    B_pack[0*8 + 0] = 10;
    B_pack[1*8 + 0] = 20;
    B_pack[2*8 + 0] = 30;
    B_pack[3*8 + 0] = 40;

    memset(acc, 0, 64);

    __asm__ __volatile__ (
        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vmv.v.i v8, 0\n\t"

        "li     t0, 32\n\t"
        "vsetvli zero, t0, e8, m1, ta, ma\n\t"
        "vle8.v v16, (%[aptr])\n\t"
        "vle8.v v20, (%[bptr])\n\t"

        ".word " S(VMADOT_TILE0) "\n\t"

        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vse32.v v8, (%[acc])\n\t"

        :
        : [aptr] "r" (A_pack),
          [bptr] "r" (B_pack),
          [acc]  "r" (acc)
        : "t0", "memory",
          "v8", "v9", "v16", "v20"
    );

    printf("TEST 2: A=[1,2,3,4]×[10,20,30,40]^T\n");
    printf("Expected C[i][j] = (i+1) × (j+1) × 10:\n");
    printf("  [  10  20  30  40 ]\n");
    printf("  [  20  40  60  80 ]\n");
    printf("  [  30  60  90 120 ]\n");
    printf("  [  40  80 120 160 ]\n\n");

    printf("Raw accumulator (16 × int32):\n");
    for (int i = 0; i < 16; i++) {
        printf("  acc[%2d] = %4d", i, acc[i]);
        if (i % 4 == 3) printf("\n");
    }

    printf("\nAs row-major 4×4 (acc[r*4+c]):\n");
    for (int r = 0; r < 4; r++) {
        printf("  ");
        for (int c = 0; c < 4; c++)
            printf("%4d ", acc[r * 4 + c]);
        printf("\n");
    }

    printf("\nAs column-major 4×4 (acc[c*4+r]):\n");
    for (int r = 0; r < 4; r++) {
        printf("  ");
        for (int c = 0; c < 4; c++)
            printf("%4d ", acc[c * 4 + r]);
        printf("\n");
    }

    printf("\nAs 2×(2×4) interleaved (v8 first 8, v9 next 8):\n");
    printf("  v8[0:3] = %4d %4d %4d %4d\n", acc[0], acc[1], acc[2], acc[3]);
    printf("  v8[4:7] = %4d %4d %4d %4d\n", acc[4], acc[5], acc[6], acc[7]);
    printf("  v9[0:3] = %4d %4d %4d %4d\n", acc[8], acc[9], acc[10], acc[11]);
    printf("  v9[4:7] = %4d %4d %4d %4d\n", acc[12], acc[13], acc[14], acc[15]);

    printf("\n========================================\n\n");

    /*
     * TEST 3: Test with vs2/vs1 SWAPPED to compare
     *
     * Use the OTHER encoding: vs2=v16(A), vs1=v20(B)
     * encoding = 0xE200302B | (16<<20) | (20<<15) | (8<<7)
     */
    #define VMADOT_ALT  0xE30A342Bu

    memset(acc, 0, 64);

    __asm__ __volatile__ (
        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vmv.v.i v8, 0\n\t"

        "li     t0, 32\n\t"
        "vsetvli zero, t0, e8, m1, ta, ma\n\t"
        "vle8.v v16, (%[aptr])\n\t"
        "vle8.v v20, (%[bptr])\n\t"

        ".word " S(VMADOT_ALT) "\n\t"

        "li     t0, 8\n\t"
        "vsetvli zero, t0, e32, m2, ta, ma\n\t"
        "vse32.v v8, (%[acc])\n\t"

        :
        : [aptr] "r" (A_pack),
          [bptr] "r" (B_pack),
          [acc]  "r" (acc)
        : "t0", "memory",
          "v8", "v9", "v16", "v20"
    );

    printf("TEST 3: SWAPPED encoding (vs2=A, vs1=B) — same data\n\n");

    printf("Raw accumulator (16 × int32):\n");
    for (int i = 0; i < 16; i++) {
        printf("  acc[%2d] = %4d", i, acc[i]);
        if (i % 4 == 3) printf("\n");
    }

    printf("\nAs 2×(2×4) interleaved:\n");
    printf("  v8[0:3] = %4d %4d %4d %4d\n", acc[0], acc[1], acc[2], acc[3]);
    printf("  v8[4:7] = %4d %4d %4d %4d\n", acc[4], acc[5], acc[6], acc[7]);
    printf("  v9[0:3] = %4d %4d %4d %4d\n", acc[8], acc[9], acc[10], acc[11]);
    printf("  v9[4:7] = %4d %4d %4d %4d\n", acc[12], acc[13], acc[14], acc[15]);

    return 0;
}
