# # .include "user_define.h"
.globl _start
# .local _start
# .align 13
.section .text
_start:
     li x0     ,    0x00000100        //useless
     li x1     ,    0x00000100
     li x2     ,    0x00000100
     li x3     ,    0x00000100
     li x4     ,    0x00000100
     li x5     ,    0x00000100
     li x6     ,    0x00000100
     li x7     ,    0x00000100
     li x8     ,    0x00000100
     li x9     ,    0x00000100
     li x10    ,    0x00000100
     li x11    ,    0x00000100
     li x12    ,    0x00000100
     li x13    ,    0x00000100
     li x14    ,    0x00000100
     li x15    ,    0x00000100
     li x16    ,    0x00000100
     li x17    ,    0x00000200
     li x18    ,    0x00000100
     li x19    ,    0x00000104
     li x20    ,    0x00000100
     li x21    ,    0x00000100
     li x22    ,    0x00000100
     li x23    ,    0x00000100
     li x24    ,    0x00000100
     li x25    ,    0x00000100
     li x26    ,    0x00000100
     li x27    ,    0x00000100
     li x28    ,    0x00000100
     li x29    ,    0x00000100
     li x30    ,    0x00000100
     li x31    ,    0x00000100

_r_type:
     add        x18, x19, x20
     sub        x18, x19, x20
     sll        x18, x19, x20
     slt        x18, x19, x20
     sltu       x18, x19, x20
     xor        x18, x19, x20
     srl        x18, x19, x20
     sra        x18, x19, x20
     or         x18, x19, x20
     and        x18, x19, x20

_i_type_arithmetic:
     addi       x18, x19, 0x00000036
     slti       x18, x19, 0x00000203
     sltiu      x18, x19, 0x00000001
     xori       x18, x19, 0x000000ff
     ori        x18, x19, 0x000000ff
     andi       x18, x19, 0x000000ff
     slli       x18, x19, 0x00000003
     srli       x18, x19, 0x00000003
     srai       x18, x19, 0x00000003

_m_type:
     mul        x18, x19, x20
     div        x18, x19, x20

_s_type:
     li         x0,  0x00001000
     li         x0,  0x00001000
     li         x0,  0x00001000
     li         x0,  0x00001000
     li         x20, 0x0000ffff
     sw         x20, 8(x17)
     li         x20, 0x0000ffff
     sh         x20, 4(x17)
     li         x20, 0x0000ffff
     sb         x20, 0(x17)

_i_type_load:
     li         x18, 0x00000100
     lw         x18, 8(x17)
     li         x18, 0x00000100
     lh         x18, 8(x17)
     li         x18, 0x00000100
     lb         x18, 8(x17)
     lbu        x18, 8(x17)
     lhu        x18, 8(x17)



_b_type:
_beq:
     beq        x23, x23, _beq_j
_bne:
     bne        x18, x23, _bne_j
_blt:
     blt        x18, x23, _blt_j
_bge:
     bge        x23, x18, _bge_j
_bltu:
     bltu       x18, x23, _bltu_j
_bgeu:
     bgeu       x23, x18, _bgeu_j




_i_type_jalr:
     jalr       ra, x0, 0x500

# .align 13

_u_type:
     lui        x18, 0x00001000
     auipc      x18, 0x80000

_beq_j:
     jal        ra, _bne

_bne_j:
     jal        ra, _blt

_blt_j:
     jal        ra, _bge

_bge_j:
     jal        ra, _bltu

_bltu_j:
     jal        ra, _bgeu

_bgeu_j:
     jal        ra, _i_type_jalr