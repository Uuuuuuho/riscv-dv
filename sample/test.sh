riscv32-unknown-elf-gcc -march=rv32imc  -mabi=ilp32 -e 0x00000000 -nostdlib -o test.o isa_test.S
riscv32-unknown-elf-ld -T sec test.o -o out
riscv32-unknown-elf-objdump -D out > out.dump