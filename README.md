# scrypt_multi_romix_fpgas
Hardware implementation multi romix scrypt on fpgas

- rtl folder contains source codes for Scrypt core.

  1. scrypt_new_proposed.v (top scrypt core with 64 romix cores)
  2. scrypt_32_romix.v (top scrypt core with 32 romix cores)
  3. scrypt_new.v (normal scrypt cores)

- tb folder contains source codes for test benches.

- testcases folder contains source codes for Scrypt.

- reports folder contains evaluation reports for Scrypt versions on FPGA (ALVEO U280, Virtex 7 VC707).

The evaluated are performed on Xilinx Vivado Design Suite 2019.2

