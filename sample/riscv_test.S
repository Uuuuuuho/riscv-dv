# # .include "user_define.h"
.globl _start
# .local _start
# .align 13
.section .text
_start:
     addi   a2,a1,32
     add    a3,a2,a4
     sw     a2,160(a1)
     sw     a4,160(a3)

     li x3, 0x0
     li x4, 0x0
     li x5, 0x0
     li x6, 0x0
     li x7, 0x0
     li x8, 0x0
     li x9, 0x0
     li x10, 0x0
     li x11, 0x0
     li x12, 0x0
     li x13, 0x0
     li x14, 0x0
     li x15, 0x0
     li x16, 0x0
     li x17, 0x0
     li x18, 0x0
     li x19, 0x0
     li x20, 0x0
     li x21, 0x0
     li x22, 0x0
     li x23, 0x0
     li x24, 0x0
     li x25, 0x0
     li x26, 0x0
     li x27, 0x0
     li x28, 0x0
     li x29, 0x0
     li x30, 0x0
     li x31, 0x0

_alu_test:

                  # sw
                  # mret
                  # ecall
# .data
# helloworld:       
#                   j main
# main: