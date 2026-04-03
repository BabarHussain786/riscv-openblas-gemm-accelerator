#include <stdio.h>
#include <riscv_vector.h>
int main(){size_t vl=__riscv_vsetvl_e64m1(100); printf("VL=%zu bits=%zu\n",vl,vl*64); return 0;}
