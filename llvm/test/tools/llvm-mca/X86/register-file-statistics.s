# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=BARCELONA %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=bdver2 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL,BDVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL,BTVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver1 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL,ZNVER1 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver2 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL,ZNVER2 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=znver3 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL,ZNVER3 %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=sandybridge -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=ivybridge -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=haswell -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=broadwell -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=knl -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=skylake -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=skylake-avx512 -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-client -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=icelake-server -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=rocketlake -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=tigerlake -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=slm -iterations=1 -all-stats=false -all-views=false -register-file-stats < %s | FileCheck --check-prefixes=ALL %s

xor %eax, %ebx

# ALL:            Register File statistics:
# ALL-NEXT:       Total number of mappings created:    2
# ALL-NEXT:       Max number of mappings used:         2

# BARCELONA:      Register File statistics:
# BARCELONA-NEXT: Total number of mappings created:    2
# BARCELONA-NEXT: Max number of mappings used:         2

# BDVER2:         *  Register File #1 -- PdFpuPRF:
# BDVER2-NEXT:       Number of physical registers:     160
# BDVER2-NEXT:       Total number of mappings created: 0
# BDVER2-NEXT:       Max number of mappings used:      0

# BTVER2:         *  Register File #1 -- JFpuPRF:
# BTVER2-NEXT:       Number of physical registers:     72
# BTVER2-NEXT:       Total number of mappings created: 0
# BTVER2-NEXT:       Max number of mappings used:      0

# ZNVER1:         *  Register File #1 -- ZnFpuPRF:
# ZNVER1-NEXT:       Number of physical registers:     160
# ZNVER1-NEXT:       Total number of mappings created: 0
# ZNVER1-NEXT:       Max number of mappings used:      0

# ZNVER2:         *  Register File #1 -- Zn2FpuPRF:
# ZNVER2-NEXT:       Number of physical registers:     160
# ZNVER2-NEXT:       Total number of mappings created: 0
# ZNVER2-NEXT:       Max number of mappings used:      0

# ZNVER3:         *  Register File #1 -- Zn3FpPRF:
# ZNVER3-NEXT:       Number of physical registers:     160
# ZNVER3-NEXT:       Total number of mappings created: 0
# ZNVER3-NEXT:       Max number of mappings used:      0

# BDVER2:         *  Register File #2 -- PdIntegerPRF:
# BDVER2-NEXT:       Number of physical registers:     96
# BDVER2-NEXT:       Total number of mappings created: 2
# BDVER2-NEXT:       Max number of mappings used:      2

# BTVER2:         *  Register File #2 -- JIntegerPRF:
# BTVER2-NEXT:       Number of physical registers:     64
# BTVER2-NEXT:       Total number of mappings created: 2
# BTVER2-NEXT:       Max number of mappings used:      2

# ZNVER1:         *  Register File #2 -- ZnIntegerPRF:
# ZNVER1-NEXT:       Number of physical registers:     168
# ZNVER1-NEXT:       Total number of mappings created: 2
# ZNVER1-NEXT:       Max number of mappings used:      2

# ZNVER2:         *  Register File #2 -- Zn2IntegerPRF:
# ZNVER2-NEXT:       Number of physical registers:     168
# ZNVER2-NEXT:       Total number of mappings created: 2
# ZNVER2-NEXT:       Max number of mappings used:      2

# ZNVER3:         *  Register File #2 -- Zn3IntegerPRF:
# ZNVER3-NEXT:       Number of physical registers:     192
# ZNVER3-NEXT:       Total number of mappings created: 2
# ZNVER3-NEXT:       Max number of mappings used:      2
