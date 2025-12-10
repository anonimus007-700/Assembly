# manual_func — Function reference and linkage map

Consolidated, standards-oriented documentation for the manual_func directory.

Contents
- Quick links
  - [manual_func directory](https://github.com/anonimus007-700/Assembly/tree/034e4d1b9fa9717bca33224931c2f72f9eed9278/manual_func)
  - [Function reference](#function-reference)
  - [Linkage map](#linkage-map)

## Function reference
A concise summary of each exported/local function in manual_func with a one-line signature and a brief explanation of what it does.

- [pow](https://github.com/anonimus007-700/Assembly/manual_func/pow.asm) — integer exponentiation  
  Signature: rdi = base, rsi = exponent → rax = base^exponent  
  What it does: multiplies base by itself exponent times (simple repeated-multiplication loop; no overflow check).

- [stoi](https://github.com/anonimus007-700/Assembly/manual_func/atoi.asm) — ASCII decimal string → signed integer (+ processed-index)  
  Signature: rdi = ptr to null-terminated string → rax = integer, rdx = processed-index  
  What it does: reads optional leading '-' then consumes digits '0'..'9', accumulates numeric value, sets length/index in RDX.

- [stoiAD](https://github.com/anonimus007-700/Assembly/manual_func/atoi.asm) — fractional-digit string → double (0.<digits>)  
  Signature: rdi = ptr to digit substring → xmm0 = fractional double  
  What it does: parses the digit string to an integer (calls stoi), computes 10^N (calls pow), then returns integer / 10^N as an IEEE double in XMM0.

- [slise](https://github.com/anonimus007-700/Assembly/manual_func/slise.asm) — substring copy + NUL-terminate  
  Signature: rdi = src, rsi = start, rdx = end, rax = dst-buffer → rax = dst-buffer  
  What it does: copies bytes from source[start..end] into the destination buffer (destination expected in RAX) and writes a terminating NUL; has special-case index handling for start==0.

- [strlen](https://github.com/anonimus007-700/Assembly/manual_func/strlen.asm) — null-terminated string length  
  Signature: rdi = ptr → rax = length  
  What it does: scans bytes until a NUL and returns the byte count.

- [stof](https://github.com/anonimus007-700/Assembly/manual_func/stof.asm) — high-level string → double driver  
  Signature (driver): expects an input pointer (see source comments) → xmm0 = result (then exits)  
  What it does: finds the '.' in the input string, uses slise to extract integer and fractional substrings into a temporary buffer, calls stoi for the integer part and stoiAD for the fractional part, adds them into a double in XMM0, then issues an exit syscall (current implementation is a driver that terminates the process).
  
- [int_to_string / _start (itos.asm)](https://github.com/anonimus007-700/Assembly/manual_func/itos.asm) — demo: integer → ASCII and print via int 0x80  
  Signature: standalone demo using 32-bit int 0x80 syscalls  
  What it does: converts a 16-bit data-word (`num`) into ASCII digits in a buffer and writes it to stdout using legacy 32-bit syscalls; intended as an independent example (32-bit).

## Linkage map
- stof (driver) orchestrates parsing:
  - finddot → locates the '.' position (local helper in stof.asm)
  - slise → extracts integer and fractional substrings into the BSS buffer (slice_str)
  - stoi → parses the integer substring
  - strlen → computes substring lengths used by slise
  - stoiAD → parses fractional substring; stoiAD calls stoi and pow
- stoiAD depends on pow for computing 10^N.
- itos.asm is self-contained (32-bit demo) and does not integrate with the 64-bit flow without porting.
