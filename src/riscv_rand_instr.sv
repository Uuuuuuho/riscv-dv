/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class riscv_rand_instr extends riscv_instr_base;

  riscv_instr_gen_config cfg;

  // Some additional reserved registers
  riscv_reg_t reserved_rd[];

  `uvm_object_utils(riscv_rand_instr)

  constraint instr_c {
    solve instr_name before imm;
    solve instr_name before rs1;
    solve instr_name before rs2;
    !(instr_name inside {cfg.unsupported_instr});
    category inside {LOAD, STORE, SHIFT, ARITHMETIC, LOGICAL, BRANCH, COMPARE, CSR, SYSTEM, SYNCH};
    group inside {cfg.march_list};
    // Avoid using any special purpose register as rd, those registers are reserved for
    // special instructions
    !(rd inside {cfg.reserved_regs});
    if(reserved_rd.size() > 0) {
      !(rd inside {reserved_rd});
    }
    // Compressed instruction may use the same CSR for both rs1 and rd
    if(group inside {RV32C, RV64C, RV128C, RV32FC, RV32DC}) {
      !(rs1 inside {cfg.reserved_regs, reserved_rd});
    }
    // Below instrutions will modify stack pointer, not allowed in normal instruction stream.
    // It can be used in stack operation instruction stream.
    !(instr_name inside {C_SWSP, C_SDSP, C_ADDI16SP});
    // Avoid using reserved registers as rs1 (base address)
    if(category inside {LOAD, STORE}) {
      !(rs1 inside {reserved_rd, cfg.reserved_regs, ZERO});
    }
    if(!cfg.enable_sfence) {
      instr_name != SFENCE_VMA;
    }
    if(cfg.no_fence) {
      !(instr_name inside {FENCE, FENCEI, SFENCE_VMA});
    }
    // TODO: Support C_ADDI4SPN
    instr_name != C_ADDI4SPN;
  }

  constraint rvc_csr_c {
    //  Registers specified by the three-bit rs1’, rs2’, and rd’ fields of the CIW, CL, CS,
    //  and CB formats
    if(format inside {CIW_FORMAT, CL_FORMAT, CS_FORMAT, CB_FORMAT}) {
      rs1 inside {[S0:A5]};
      rs2 inside {[S0:A5]};
      rd  inside {[S0:A5]};
    }
    // C_ADDI16SP is only valid when rd == SP
    if(instr_name == C_ADDI16SP) {
      rd == SP;
    }
  }

  constraint constraint_cfg_knob_c {
    if(cfg.no_csr_instr == 1) {
      category != CSR;
    }
    if(cfg.no_ebreak) {
      instr_name != EBREAK;
      instr_name != C_EBREAK;
    }
    // ecall is only used for terminating the test
    instr_name != ECALL;
    if(cfg.no_load_store) {
      category != LOAD;
      category != STORE;
    }
    if(cfg.no_branch_jump) {
      category != BRANCH;
    }
  }

  `uvm_object_new

endclass