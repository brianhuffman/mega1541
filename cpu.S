	.file	"cpu.S"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
_A_ = 4
_X_ = 5
_Y_ = 6
_S_ = 7
_P_ = 8
_N_ = 9
_Z_ = 10
_C_ = 11
_PCL_ = 28
_PCH_ = 29
_time0_ = 12
_time1_ = 13
_time2_ = 14
_time3_ = 15
_cycles_ = 24
_data_ = 22
XL = 26
XH = 27
YL = 28
YH = 29
ZL = 30
ZH = 31

 ;  GNU C (GCC) version 4.8.1 (avr)
 ; 	compiled by GNU C version 4.2.1 (Apple Inc. build 5646), GMP version 5.0.2, MPFR version 3.0.0, MPC version 0.9
 ;  GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 ;  options passed: 
 ;  -I /Users/huffman/Applications/Arduino.app/Contents/Resources/Java/hardware/arduino/avr/cores/arduino
 ;  -I /Users/huffman/Applications/Arduino.app/Contents/Resources/Java/hardware/arduino/avr/variants/standard
 ;  -imultilib avr5
 ;  -iprefix /Users/huffman/Applications/Arduino.app/Contents/Resources/Java/hardware/tools/avr/bin/../lib/gcc/avr/4.8.1/
 ;  -MMD build-uno/cpu.d -MQ build-uno/cpu.s -D F_CPU=16000000L
 ;  -D ARDUINO=160 -D ARDUINO_ARCH_AVR -D __PROG_TYPES_COMPAT__
 ;  -include Arduino.h cpu.c -mmcu=atmega328p
 ;  -auxbase-strip build-uno/cpu.s -Os -Wall -fverbose-asm
 ;  -ffunction-sections -fdata-sections
 ;  options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
 ;  -fbranch-count-reg -fcaller-saves -fcombine-stack-adjustments -fcommon
 ;  -fcompare-elim -fcprop-registers -fcrossjumping -fcse-follow-jumps
 ;  -fdata-sections -fdefer-pop -fdevirtualize -fdwarf2-cfi-asm
 ;  -fearly-inlining -feliminate-unused-debug-types
 ;  -fexpensive-optimizations -fforward-propagate -ffunction-cse
 ;  -ffunction-sections -fgcse -fgcse-lm -fgnu-runtime
 ;  -fguess-branch-probability -fhoist-adjacent-loads -fident
 ;  -fif-conversion -fif-conversion2 -findirect-inlining -finline
 ;  -finline-atomics -finline-functions -finline-functions-called-once
 ;  -finline-small-functions -fipa-cp -fipa-profile -fipa-pure-const
 ;  -fipa-reference -fipa-sra -fira-hoist-pressure -fira-share-save-slots
 ;  -fira-share-spill-slots -fivopts -fkeep-static-consts
 ;  -fleading-underscore -fmath-errno -fmerge-constants
 ;  -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
 ;  -foptimize-register-move -foptimize-sibling-calls -fpartial-inlining
 ;  -fpeephole -fpeephole2 -fprefetch-loop-arrays -freg-struct-return
 ;  -fregmove -freorder-blocks -freorder-functions -frerun-cse-after-loop
 ;  -fsched-critical-path-heuristic -fsched-dep-count-heuristic
 ;  -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
 ;  -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
 ;  -fsched-stalled-insns-dep -fshow-column -fshrink-wrap -fsigned-zeros
 ;  -fsplit-ivs-in-unroller -fsplit-wide-types -fstrict-aliasing
 ;  -fstrict-overflow -fstrict-volatile-bitfields -fsync-libcalls
 ;  -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
 ;  -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
 ;  -ftree-copy-prop -ftree-copyrename -ftree-dce -ftree-dominator-opts
 ;  -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-if-convert
 ;  -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
 ;  -ftree-parallelize-loops= -ftree-phiprop -ftree-pre -ftree-pta
 ;  -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slp-vectorize
 ;  -ftree-slsr -ftree-sra -ftree-switch-conversion -ftree-tail-merge
 ;  -ftree-ter -ftree-vect-loop-version -ftree-vrp -funit-at-a-time
 ;  -fverbose-asm -fzero-initialized-in-bss

	.section	.text.mem_read,"ax",@progbits
.global	mem_read
	.type	mem_read, @function
mem_read:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r25,0x04	 ; branch if addr_hi >= 0x40
	brsh .mem_L6	 ;
	movw r30,r24	 ;
	subi r30,lo8(-(ram))	 ;
	sbci r31,hi8(-(ram))	 ;
	ld r24,Z	 ; load from ram[addr]
	ret
.mem_L6:
	cpi r25,0xc0	 ; branch if addr_hi < 0xc0
	brlo .mem_L9	 ;
	movw r30,r24	 ;
	andi r31,0x3f	 ; mask to 16k range
	subi r30,lo8(-(dos1541))	 ;  D.2241,
	sbci r31,hi8(-(dos1541))	 ;  D.2241,
	lpm r24, Z	 ; load from rom[addr & 0x3fff]
	ret
.mem_L9:
	ldi r24,0xff	 ; other addresses return 0xff
	ret
	.size	mem_read, .-mem_read
/*
mem_read_pc
input address in _PCH_:_PCL_
output in r24
*/
	.section	.text.mem_read_pc,"ax",@progbits
.global	mem_read_pc
	.type	mem_read_pc, @function
mem_read_pc:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi _PCH_,0xc0	 ; branch if addr_hi < 0xc0
	brlo .mem_read_pc_L9	 ;
	movw ZL,_PCL_	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm r24,Z	 ; load from rom[addr - 0xc0000]
	ret
.mem_read_pc_L9:
	cpi _PCH_,0x04	 ; branch if addr_hi >= 0x40
	brsh .mem_read_pc_L6	 ;
	movw ZL,_PCL_	 ;
	subi ZH,hi8(-(ram))	 ;
	ld r24,Z	 ; load from ram[addr]
	ret
.mem_read_pc_L6:
	ldi r24,0xff	 ; other addresses return 0xff
	ret
	.size	mem_read_pc, .-mem_read_pc
	.section	.text.mem_read_16,"ax",@progbits
.global	mem_read_16
	.type	mem_read_16, @function
mem_read_16:
	push r17	 ; 
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24	 ;  address, address
	cpi r24,-1	 ;  address,
	ldi r20,3	 ; ,
	cpc r25,r20	 ;  address,
	brsh .mem_L11	 ; ,
	movw r30,r24	 ;  tmp71, address
	subi r30,lo8(-(ram+1))	 ;  tmp71,
	sbci r31,hi8(-(ram+1))	 ;  tmp71,
	ld r18,Z	 ;  tmp73, ram
	ldi r19,0	 ;  D.2246
	mov r19,r18	 ;  D.2245, D.2246
	clr r18	 ;  D.2245
	subi r28,lo8(-(ram))	 ;  tmp76,
	sbci r29,hi8(-(ram))	 ;  tmp76,
	ld r24,Y	 ;  tmp78, ram
	rjmp .mem_L14	 ; 
.mem_L11:
	adiw r24,1	 ;  D.2246,
	movw r18,r28	 ;  D.2246, address
	subi r18,1	 ;  D.2246,
	sbci r19,-64	 ;  D.2246,
	cpi r18,-2	 ;  D.2246,
	sbci r19,63	 ;  D.2246,
	brsh .mem_L13	 ; ,
	movw r30,r24	 ;  D.2248, D.2246
	andi r31,63	 ;  D.2248,
	subi r30,lo8(-(dos1541))	 ;  D.2248,
	sbci r31,hi8(-(dos1541))	 ;  D.2248,
	lpm r24, Z	 ;  __result
	movw r30,r28	 ;  D.2248, address
	andi r31,63	 ;  D.2248,
	subi r30,lo8(-(dos1541))	 ;  D.2248,
	sbci r31,hi8(-(dos1541))	 ;  D.2248,
	lpm r28, Z	 ;  __result
	mov r18,r28	 ;  D.2245, __result
	ldi r19,0	 ;  D.2245
	or r19,r24	 ;  D.2245, __result
	rjmp .mem_L12	 ; 
.mem_L13:
	call mem_read	 ; 
	mov r17,r24	 ;  D.2247,
	movw r24,r28	 ; , address
	call mem_read	 ; 
	mov r18,r17	 ;  D.2246, D.2247
	ldi r19,0	 ;  D.2246
	mov r19,r18	 ;  D.2245, D.2246
	clr r18	 ;  D.2245
.mem_L14:
	or r18,r24	 ;  D.2245,
.mem_L12:
	movw r24,r18	 ; , D.2245
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	pop r17	 ; 
	ret
	.size	mem_read_16, .-mem_read_16
	.section	.text.mem_write,"ax",@progbits
.global	mem_write
	.type	mem_write, @function
mem_write:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cp r24,__zero_reg__	 ;  address
	ldi r18,4	 ; ,
	cpc r25,r18	 ;  address,
	brsh .mem_L15	 ; ,
	movw r30,r24	 ;  tmp45, address
	subi r30,lo8(-(ram))	 ;  tmp45,
	sbci r31,hi8(-(ram))	 ;  tmp45,
	st Z,r22	 ;  ram, value
.mem_L15:
	ret
	.size	mem_write, .-mem_write
	.section	.text.clock_advance,"ax",@progbits
	.type	clock_advance, @function
clock_advance:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sub _time0_,r24	 ;  time_left.20, D.3675
	sbc _time1_,__zero_reg__	 ;  time_left.20, D.3675
	sbc _time2_,__zero_reg__	 ;  time_left.20, D.3675
	sbc _time3_,__zero_reg__	 ;  time_left.20, D.3675
	ret
	.size	clock_advance, .-clock_advance
	.section	.text.cpu6502_PLP,"ax",@progbits
	.type	cpu6502_PLP, @function
cpu6502_PLP:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	inc _S_	 ; S ++
	mov ZL,_S_	 ;
	ldi ZH,hi8(ram+256)	 ;
	ld _P_,Z	 ; P <- stack[S]
	mov _N_,_P_	 ; N <- P
	bst _P_,1	 ; b <- P bit 1
	clr _Z_	 ; Z <- 0
	bld _Z_,0	 ; Z bit 0 <- b
	ldi r18,0x01	 ; temp <- 0x01 (FIXME: save 1 instr if _Z_ >= 16)
	eor _Z_,r18	 ; Z ^= 0x01
	mov _C_,_P_	 ; C <- P (FIXME: save 1 instr if _C_ >= 16)
	and _C_,r18	 ; C &= 0x01
	ret
	.size	cpu6502_PLP, .-cpu6502_PLP
	.section	.text.cpu6502_JSR,"ax",@progbits
	.type	cpu6502_JSR, @function
cpu6502_JSR:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw _PCL_,1	 ; PC -= 1
	mov XL,_S_	 ;
	ldi XH,hi8(ram+256)	 ;
	st X,_PCH_	 ; stack[S] = PCH
	dec XL	 ;
	st X,_PCL_	 ; stack[S-1] = PCL
	dec _S_	 ;  S -= 2
	dec _S_	 ; (FIXME: save 1 instr if _S_ >= 16)
	movw _PCL_,r24	 ; PC <- address
	ret
	.size	cpu6502_JSR, .-cpu6502_JSR
	.section	.text.cpu6502_RTS,"ax",@progbits
	.type	cpu6502_RTS, @function
cpu6502_RTS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	inc _S_	 ; S += 1
	ldi XH,hi8(ram+256)	 ;
	mov XL,_S_	 ;
	ld _PCL_,X	 ; PCL <- stack[S]
	inc _S_	 ; S += 1
	mov XL,_S_	 ;
	ld _PCH_,X	 ; PCH <- stack[S]
	adiw _PCL_,1	 ; PC ++
	ret
	.size	cpu6502_RTS, .-cpu6502_RTS
	.section	.text.cpu6502_LSR_a,"ax",@progbits
	.type	cpu6502_LSR_a, @function
cpu6502_LSR_a:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	bst _A_,0
	bld _C_,0
	lsr _A_
	mov _Z_,_A_
	mov _N_,_A_
	ret
	.size	cpu6502_LSR_a, .-cpu6502_LSR_a
	.section	.text.cpu6502_ORA,"ax",@progbits
	.type	cpu6502_ORA, @function
cpu6502_ORA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ;  r24 <- mem_read
	or _A_,r24	 ;  A |= data
	mov _Z_,_A_
	mov _N_,_A_
	ret
	.size	cpu6502_ORA, .-cpu6502_ORA
	.section	.text.cpu6502_BIT,"ax",@progbits
	.type	cpu6502_BIT, @function
cpu6502_BIT:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov r25,r24	 ;  D.3706, data
	andi r25,lo8(64)	 ;  D.3706,
	mov r18,_P_	 ;  reg_p.101, reg_p
	andi r18,lo8(-65)	 ;  reg_p.101,
	or r25,r18	 ;  D.3706, reg_p.101
	mov _P_,r25	 ;  reg_p, D.3706
	mov _N_,r24	 ;  flag_n, data
	mov r25,_A_	 ;  flag_z.106, reg_a
	and r25,r24	 ;  flag_z.106, data
	mov _Z_,r25	 ;  flag_z, flag_z.106
	ret
	.size	cpu6502_BIT, .-cpu6502_BIT
	.section	.text.cpu6502_AND,"ax",@progbits
	.type	cpu6502_AND, @function
cpu6502_AND:
	push r16	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r16,_A_	 ;  reg_a.107, reg_a
	call mem_read	 ; 
	and r24,r16	 ;  flag_z.108, reg_a.107
	mov _Z_,r24	 ;  flag_z, flag_z.108
	mov _N_,r24	 ;  flag_n, flag_z.108
	mov _A_,r24	 ;  reg_a, flag_z.108
/* epilogue start */
	pop r16	 ; 
	ret
	.size	cpu6502_AND, .-cpu6502_AND
	.section	.text.cpu6502_EOR,"ax",@progbits
	.type	cpu6502_EOR, @function
cpu6502_EOR:
	push r16	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r16,_A_	 ;  reg_a.128, reg_a
	call mem_read	 ; 
	eor r24,r16	 ;  flag_z.129, reg_a.128
	mov _Z_,r24	 ;  flag_z, flag_z.129
	mov _N_,r24	 ;  flag_n, flag_z.129
	mov _A_,r24	 ;  reg_a, flag_z.129
/* epilogue start */
	pop r16	 ; 
	ret
	.size	cpu6502_EOR, .-cpu6502_EOR
	.section	.text.cpu6502_ADC,"ax",@progbits
	.type	cpu6502_ADC, @function
cpu6502_ADC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; r24 <- read_mem(r25:r24)
	sbrc _P_,3	 ; skip if decimal mode is set
	rjmp .ADC_dec	 ; jump if decimal mode is clear
.ADC_bin:
	lsr _C_	 ; carry <- C, C <- 0
	adc _A_,r24	 ; (carry, A) <- A + r24 + carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	brvs .ADC_bin_overflow	 ; branch on overflow
	rol _C_	 ; C <- carry, carry <- 0
	ldi r22,0xaf	 ;
	and _P_,r22	 ; P &= ~V_FLAG
	ret
.ADC_bin_overflow:
	rol _C_	 ; C <- carry, carry <- 0
	ldi r22,0x40	 ;
	or _P_,r22	 ; P |= V_FLAG
	ret
.ADC_dec:
	mov r25,_P_	 ; r25 <- P
	mov r30,_A_	 ; r30 <- A
	mov r26,_C_	 ; r26 <- C
	mov r22,r24	 ; r22 <- r24
	ldi r23,0	 ; r23 <- 0
	mov r31,_P_	 ; r31 <- P
	andi r31,lo8(-65)	 ; r31 &= ~V_FLAG
	mov r18,r30	 ;  total, reg_a.157
	ldi r19,0	 ;  total
	add r18,r26	 ;  total, flag_c
	adc r19,__zero_reg__	 ;  total
	add r18,r22	 ;  total, D.3729
	adc r19,r23	 ;  total, D.3729
	mov _Z_,r18	 ;  flag_z, total
	mov r25,r30	 ;  temp, reg_a.157
	andi r25,lo8(15)	 ;  temp,
	add r25,r26	 ;  temp, flag_c
	mov r20,r24	 ;  D.3728, D.3728
	andi r20,lo8(15)	 ;  D.3728,
	add r25,r20	 ;  temp, D.3728
	cpi r25,lo8(10)	 ;  temp,
	brlo .L12	 ; ,
	cpi r25,lo8(26)	 ;  temp,
	brsh .L13	 ; ,
	subi r18,-6	 ;  total,
	sbci r19,-1	 ;  total,
	rjmp .L12	 ; 
.L13:
	subi r18,10	 ;  total,
	sbc r19,__zero_reg__	 ;  total
.L12:
	mov _N_,r18	 ;  flag_n, total
	eor r24,r18	 ;  D.3728, total
	eor r30,r18	 ;  D.3728, total
	and r24,r30	 ;  D.3728, D.3728
	sbrc r24,7	 ;  D.3728,
	ori r31,lo8(64)	 ;  reg_p.161,
.L20:
	mov _P_,r31	 ;  reg_p, reg_p.161
	cpi r18,-96	 ;  total,
	cpc r19,__zero_reg__	 ;  total
	brlo .L16	 ; ,
	subi r18,-96	 ;  total,
	sbci r19,-1	 ;  total,
.L16:
	ldi r24,lo8(1)	 ;  D.3731,
	cpse r19,__zero_reg__	 ;  total,
	rjmp .L17	 ; 
	ldi r24,0	 ;  D.3731
.L17:
	mov _C_,r24	 ;  flag_c, D.3731
	rjmp .L18	 ; 
.L21:
	mov _P_,r31	 ;  reg_p, reg_p.161
.L18:
	mov _A_,r18	 ;  reg_a, result
	ret
	.size	cpu6502_ADC, .-cpu6502_ADC
	.section	.text.cpu6502_LDY,"ax",@progbits
	.type	cpu6502_LDY, @function
cpu6502_LDY:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov _Z_,r24	 ;  flag_z, flag_z.202
	mov _N_,r24	 ;  flag_n, flag_z.202
	mov _Y_,r24	 ;  reg_y, flag_z.202
	ret
	.size	cpu6502_LDY, .-cpu6502_LDY
	.section	.text.cpu6502_LDA,"ax",@progbits
	.type	cpu6502_LDA, @function
cpu6502_LDA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov _Z_,r24	 ;  flag_z, flag_z.205
	mov _N_,r24	 ;  flag_n, flag_z.205
	mov _A_,r24	 ;  reg_a, flag_z.205
	ret
	.size	cpu6502_LDA, .-cpu6502_LDA
	.section	.text.cpu6502_LDX,"ax",@progbits
	.type	cpu6502_LDX, @function
cpu6502_LDX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov _Z_,r24	 ;  flag_z, flag_z.208
	mov _N_,r24	 ;  flag_n, flag_z.208
	mov _X_,r24	 ;  reg_x, flag_z.208
	ret
	.size	cpu6502_LDX, .-cpu6502_LDX
	.section	.text.cpu6502_LAX,"ax",@progbits
	.type	cpu6502_LAX, @function
cpu6502_LAX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov _Z_,r24	 ;  flag_z, flag_z.211
	mov _N_,r24	 ;  flag_n, flag_z.211
	mov _X_,r24	 ;  reg_x, flag_z.211
	mov _A_,r24	 ;  reg_a, flag_z.211
	ret
	.size	cpu6502_LAX, .-cpu6502_LAX
	.section	.text.cpu6502_CPX,"ax",@progbits
	.type	cpu6502_CPX, @function
cpu6502_CPX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov r25,_X_	 ;  reg_x.243, reg_x
	ldi r18,lo8(1)	 ;  D.3747,
	cp r25,r24	 ;  reg_x.243, D.3746
	brsh .L28	 ; ,
	ldi r18,0	 ;  D.3747
.L28:
	mov _C_,r18	 ;  flag_c, D.3747
	sub r25,r24	 ;  reg_x.243, D.3746
	mov _Z_,r25	 ;  flag_z, flag_z.231
	mov _N_,r25	 ;  flag_n, flag_z.231
	ret
	.size	cpu6502_CPX, .-cpu6502_CPX
	.section	.text.cpu6502_SBC,"ax",@progbits
	.type	cpu6502_SBC, @function
cpu6502_SBC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov r21,_P_	 ;  reg_p.249, reg_p
	mov r20,_A_	 ;  reg_a.250, reg_a
	mov r18,_C_	 ;  flag_c, flag_c
	sbrs r21,3	 ;  reg_p.249,
	rjmp .L30	 ; 
	mov r25,r20	 ;  D.3761, reg_a.250
	andi r25,lo8(15)	 ;  D.3761,
	add r25,r18	 ;  D.3761, flag_c
	mov r18,r24	 ;  D.3761, D.3761
	andi r18,lo8(15)	 ;  D.3761,
	sub r25,r18	 ;  D.3761, D.3761
	ldi r18,lo8(-7)	 ;  result,
	add r18,r25	 ;  result, D.3761
	cpi r18,lo8(-16)	 ;  result,
	brsh .L31	 ; ,
	ldi r18,lo8(9)	 ;  result,
	add r18,r25	 ;  result, D.3761
.L31:
	mov r25,r20	 ;  result, reg_a.250
	andi r25,lo8(-16)	 ;  result,
	mov r19,r24	 ;  D.3761, D.3761
	andi r19,lo8(-16)	 ;  D.3761,
	sub r25,r19	 ;  result, D.3761
	add r25,r18	 ;  result, result
	mov _Z_,r25	 ;  flag_z, result
	mov _N_,r25	 ;  flag_n, result
	andi r21,lo8(-66)	 ;  reg_p.253,
	mov r18,r25	 ;  D.3761, result
	eor r18,r20	 ;  D.3761, reg_a.250
	eor r20,r24	 ;  D.3761, D.3761
	and r18,r20	 ;  D.3761, D.3761
	sbrc r18,7	 ;  D.3761,
	ori r21,lo8(64)	 ;  reg_p.254,
.L37:
	mov _P_,r21	 ;  reg_p, reg_p.254
	mov _C_,__zero_reg__	 ;  flag_c,
	subi r25,lo8(-(-96))	 ;  result,
	rjmp .L34	 ; 
.L30:
	ldi r19,0	 ;  total
	add r18,r20	 ;  total, reg_a.250
	adc r19,__zero_reg__	 ;  total
	subi r18,1	 ;  total,
	sbc r19,__zero_reg__	 ;  total
	sub r18,r24	 ;  total, D.3761
	sbc r19,__zero_reg__	 ;  total
	mov _C_,r19	 ;  flag_c, total
	mov r25,r18	 ;  result, total
	mov r22,r21	 ;  reg_p.257, reg_p.249
	andi r22,lo8(-65)	 ;  reg_p.257,
	mov r21,r20	 ;  D.3761, reg_a.250
	eor r21,r18	 ;  D.3761, total
	eor r20,r24	 ;  D.3761, D.3761
	and r21,r20	 ;  D.3761, D.3761
	sbrc r21,7	 ;  D.3761,
	ori r22,lo8(64)	 ;  reg_p.254,
.L38:
	mov _P_,r22	 ;  reg_p, reg_p.254
	mov _Z_,r18	 ;  flag_z, total
	mov _N_,r18	 ;  flag_n, total
.L34:
	mov _A_,r25	 ;  reg_a, result
	ret
	.size	cpu6502_SBC, .-cpu6502_SBC
	.section	.text.cpu6502_ASL,"ax",@progbits
	.type	cpu6502_ASL, @function
cpu6502_ASL:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	mov r25,r24	 ;  flag_c.81, data
	rol r25	 ;  flag_c.81
	clr r25	 ;  flag_c.81
	rol r25	 ;  flag_c.81
	mov _C_,r25	 ;  flag_c, flag_c.81
	mov r22,r24	 ;  flag_z.82, data
	lsl r22	 ;  flag_z.82
	mov _Z_,r22	 ;  flag_z, flag_z.82
	mov _N_,r22	 ;  flag_n, flag_z.82
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ASL, .-cpu6502_ASL
	.section	.text.cpu6502_SLO,"ax",@progbits
	.type	cpu6502_SLO, @function
cpu6502_SLO:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_ASL	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_ORA	 ; 
	.size	cpu6502_SLO, .-cpu6502_SLO
	.section	.text.cpu6502_ROL,"ax",@progbits
	.type	cpu6502_ROL, @function
cpu6502_ROL:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	mov r22,r24	 ;  result, data
	lsl r22	 ;  result
	mov r25,_C_	 ;  flag_c, flag_c
	or r22,r25	 ;  result, flag_c
	rol r24	 ;  flag_c.113
	clr r24	 ;  flag_c.113
	rol r24	 ;  flag_c.113
	mov _C_,r24	 ;  flag_c, flag_c.113
	mov _Z_,r22	 ;  flag_z, result
	mov _N_,r22	 ;  flag_n, result
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ROL, .-cpu6502_ROL
	.section	.text.cpu6502_RLA,"ax",@progbits
	.type	cpu6502_RLA, @function
cpu6502_RLA:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_ROL	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_AND	 ; 
	.size	cpu6502_RLA, .-cpu6502_RLA
	.section	.text.cpu6502_LSR,"ax",@progbits
	.type	cpu6502_LSR, @function
cpu6502_LSR:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	mov r25,r24	 ;  flag_c.132, data
	andi r25,lo8(1)	 ;  flag_c.132,
	mov _C_,r25	 ;  flag_c, flag_c.132
	mov r22,r24	 ;  flag_z.133, data
	lsr r22	 ;  flag_z.133
	mov _Z_,r22	 ;  flag_z, flag_z.133
	mov _N_,r22	 ;  flag_n, flag_z.133
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_LSR, .-cpu6502_LSR
	.section	.text.cpu6502_SRE,"ax",@progbits
	.type	cpu6502_SRE, @function
cpu6502_SRE:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_LSR	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_EOR	 ; 
	.size	cpu6502_SRE, .-cpu6502_SRE
	.section	.text.cpu6502_ROR,"ax",@progbits
	.type	cpu6502_ROR, @function
cpu6502_ROR:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	mov r22,r24	 ;  result, data
	lsr r22	 ;  result
	mov r18,_C_	 ;  flag_c, flag_c
	ldi r25,lo8(-128)	 ; ,
	mul r18,r25	 ;  flag_c,
	movw r18,r0	 ;  D.3782
	clr __zero_reg__
	or r22,r18	 ;  result, D.3782
	andi r24,lo8(1)	 ;  flag_c.166,
	mov _C_,r24	 ;  flag_c, flag_c.166
	mov _Z_,r22	 ;  flag_z, result
	mov _N_,r22	 ;  flag_n, result
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ROR, .-cpu6502_ROR
	.section	.text.cpu6502_RRA,"ax",@progbits
	.type	cpu6502_RRA, @function
cpu6502_RRA:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_ROR	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_ADC	 ; 
	.size	cpu6502_RRA, .-cpu6502_RRA
	.section	.text.cpu6502_SAX,"ax",@progbits
	.type	cpu6502_SAX, @function
cpu6502_SAX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,_X_	 ;  D.3787, reg_x
	and r22,_A_	 ;  D.3787, reg_a
	jmp mem_write	 ; 
	.size	cpu6502_SAX, .-cpu6502_SAX
	.section	.text.cpu6502_STA,"ax",@progbits
	.type	cpu6502_STA, @function
cpu6502_STA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,_A_	 ; , reg_a
	jmp mem_write	 ; 
	.size	cpu6502_STA, .-cpu6502_STA
	.section	.text.cpu6502_SHA,"ax",@progbits
	.type	cpu6502_SHA, @function
cpu6502_SHA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,_X_	 ;  D.3792, reg_x
	mov r18,_A_	 ;  reg_a, reg_a
	and r22,r18	 ;  D.3792, reg_a
	ldi r18,lo8(1)	 ;  D.3792,
	add r18,r25	 ;  D.3792, address
	and r22,r18	 ;  D.3792, D.3792
	jmp mem_write	 ; 
	.size	cpu6502_SHA, .-cpu6502_SHA
	.section	.text.cpu6502_DEC,"ax",@progbits
	.type	cpu6502_DEC, @function
cpu6502_DEC:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	ldi r22,lo8(-1)	 ;  flag_z.236,
	add r22,r24	 ;  flag_z.236,
	mov _Z_,r22	 ;  flag_z, flag_z.236
	mov _N_,r22	 ;  flag_n, flag_z.236
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_DEC, .-cpu6502_DEC
	.section	.text.cpu6502_INC,"ax",@progbits
	.type	cpu6502_INC, @function
cpu6502_INC:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call mem_read	 ; 
	ldi r22,lo8(1)	 ;  flag_z.258,
	add r22,r24	 ;  flag_z.258,
	mov _Z_,r22	 ;  flag_z, flag_z.258
	mov _N_,r22	 ;  flag_n, flag_z.258
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_INC, .-cpu6502_INC
	.section	.text.cpu6502_ISB,"ax",@progbits
	.type	cpu6502_ISB, @function
cpu6502_ISB:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_INC	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_SBC	 ; 
	.size	cpu6502_ISB, .-cpu6502_ISB
	.section	.text.cpu6502_JAM,"ax",@progbits
	.type	cpu6502_JAM, @function
cpu6502_JAM:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r24,_PCL_	 ;  reg_pc.245, reg_pc
	mov r25,_PCH_	 ;  reg_pc.245, reg_pc
	sbiw r24,1	 ;  reg_pc.245,
	mov _PCH_,r25	 ;  reg_pc, reg_pc.245
	mov _PCL_,r24	 ;  reg_pc, reg_pc.245
	call mem_read	 ; 
	ldi r22,lo8(1)	 ; ,
	ldi r24,lo8(13)	 ; ,
	jmp digitalWrite	 ; 
	.size	cpu6502_JAM, .-cpu6502_JAM
	.section	.text.update_p,"ax",@progbits
	.type	update_p, @function
update_p:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r24,_P_	 ;  reg_p.48, reg_p
	andi r24,lo8(108)	 ;  reg_p.48,
	mov r25,r24	 ;  reg_p.49, reg_p.48
	ori r25,lo8(32)	 ;  reg_p.49,
	mov _P_,r25	 ;  reg_p, reg_p.49
	mov r25,_N_	 ;  flag_n, flag_n
	sbrs r25,7	 ;  flag_n,
	rjmp .L55	 ; 
	ori r24,lo8(-96)	 ;  reg_p.50,
	mov _P_,r24	 ;  reg_p, reg_p.50
.L55:
	mov r24,_Z_	 ;  flag_z, flag_z
	cpse r24,__zero_reg__	 ;  flag_z,
	rjmp .L56	 ; 
	mov r24,_P_	 ;  reg_p.51, reg_p
	ori r24,lo8(2)	 ;  reg_p.51,
	mov _P_,r24	 ;  reg_p, reg_p.51
.L56:
	mov r24,_C_	 ;  flag_c, flag_c
	tst r24	 ;  flag_c
	breq .L54	 ; ,
	mov r24,_P_	 ;  reg_p.53, reg_p
	ori r24,lo8(1)	 ;  reg_p.53,
	mov _P_,r24	 ;  reg_p, reg_p.53
.L54:
	ret
	.size	update_p, .-update_p
	.section	.text.cpu6502_PHP,"ax",@progbits
	.type	cpu6502_PHP, @function
cpu6502_PHP:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call update_p	 ;
	inc _S_	 ; S ++
	mov ZL,_S_	 ;
	ldi ZH,hi8(ram+256)	 ;
	st Z,_P_	 ; stack[S] <- P
	ret
	.size	cpu6502_PHP, .-cpu6502_PHP
	.section	.text.cpu6502_CPY,"ax",@progbits
	.type	cpu6502_CPY, @function
cpu6502_CPY:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov r25,_Y_	 ;  reg_y.229, reg_y
	ldi r18,lo8(1)	 ;  D.3838,
	cp r25,r24	 ;  reg_y.229, D.3837
	brsh .L74	 ; ,
	ldi r18,0	 ;  D.3838
.L74:
	mov _C_,r18	 ;  flag_c, D.3838
	sub r25,r24	 ;  reg_y.229, D.3837
	mov _Z_,r25	 ;  flag_z, flag_z.231
	mov _N_,r25	 ;  flag_n, flag_z.231
	ret
	.size	cpu6502_CPY, .-cpu6502_CPY
	.section	.text.cpu6502_CMP,"ax",@progbits
	.type	cpu6502_CMP, @function
cpu6502_CMP:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	mov r25,_A_	 ;  reg_a.235, reg_a
	ldi r18,lo8(1)	 ;  D.3846,
	cp r25,r24	 ;  reg_a.235, D.3845
	brsh .L76	 ; ,
	ldi r18,0	 ;  D.3846
.L76:
	mov _C_,r18	 ;  flag_c, D.3846
	sub r25,r24	 ;  reg_a.235, D.3845
	mov _Z_,r25	 ;  flag_z, flag_z.231
	mov _N_,r25	 ;  flag_n, flag_z.231
	ret
	.size	cpu6502_CMP, .-cpu6502_CMP
	.section	.text.cpu6502_DCP,"ax",@progbits
	.type	cpu6502_DCP, @function
cpu6502_DCP:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r16,r24	 ;  address, address
	call cpu6502_DEC	 ; 
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	jmp cpu6502_CMP	 ; 
	.size	cpu6502_DCP, .-cpu6502_DCP
	.section	.text.addr_zpg,"ax",@progbits
.global	addr_zpg
	.type	addr_zpg, @function
addr_zpg:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r24,_PCL_	 ;  reg_pc.3, reg_pc
	adiw _PCL_,1	 ;  PC++
	call mem_read	 ; 
	ldi r25,0	 ; 
	ret
	.size	addr_zpg, .-addr_zpg
	.section	.text.addr_abs,"ax",@progbits
.global	addr_abs
	.type	addr_abs, @function
addr_abs:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r24,_PCL_	 ; , reg_pc
	call mem_read_16	 ; 
	adiw _PCL_,2	 ;  PC += 2
	ret
	.size	addr_abs, .-addr_abs
	.section	.text.addr_zpx,"ax",@progbits
.global	addr_zpx
	.type	addr_zpx, @function
addr_zpx:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ; PC++
	add r24,_X_
	ldi r25,0	 ; 
	ret
	.size	addr_zpx, .-addr_zpx
	.section	.text.addr_zpy,"ax",@progbits
.global	addr_zpy
	.type	addr_zpy, @function
addr_zpy:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ; PC++
	add r24,_Y_
	ldi r25,0	 ; 
	ret
	.size	addr_zpy, .-addr_zpy
	.section	.text.addr_abx,"ax",@progbits
.global	addr_abx
	.type	addr_abx, @function
addr_abx:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r24,_PCL_	 ; , reg_pc
	call mem_read_16	 ; 
	mov r18,_X_	 ;  reg_x, reg_x
	movw r16,r24	 ;  address, base
	add r16,r18	 ;  address, reg_x
	adc r17,__zero_reg__	 ;  address
	adiw _PCL_,2	 ;  PC += 2
	cp r17,r25	 ;  tmp18, base
	breq .L84	 ; ,
	ldi r24,lo8(1)	 ; ,
	call clock_advance	 ; 
.L84:
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	ret
	.size	addr_abx, .-addr_abx
	.section	.text.addr_aby,"ax",@progbits
.global	addr_aby
	.type	addr_aby, @function
addr_aby:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r24,_PCL_	 ; , reg_pc
	call mem_read_16	 ; 
	mov r18,_Y_	 ;  reg_y, reg_y
	movw r16,r24	 ;  address, base
	add r16,r18	 ;  address, reg_y
	adc r17,__zero_reg__	 ;  address
	adiw _PCL_,2	 ;  PC += 2
	cp r17,r25	 ;  tmp18, base
	breq .L86	 ; ,
	ldi r24,lo8(1)	 ; ,
	call clock_advance	 ; 
.L86:
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	ret
	.size	addr_aby, .-addr_aby
	.section	.text.addr_inx,"ax",@progbits
.global	addr_inx
	.type	addr_inx, @function
addr_inx:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ;  PC++
	add r24,_X_	 ;  index,
	ldi r25,0	 ; 
	jmp mem_read_16	 ; 
	.size	addr_inx, .-addr_inx
	.section	.text.addr_iny,"ax",@progbits
.global	addr_iny
	.type	addr_iny, @function
addr_iny:
	push r16	 ; 
	push r17	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ;  PC++
	mov r30,r24	 ;  tmp63, index
	ldi r31,0	 ; 
	subi r30,lo8(-(ram))	 ;  tmp63,
	sbci r31,hi8(-(ram))	 ;  tmp63,
	ldd r18,Z+1	 ;  tmp66, ram
	ldi r19,0	 ;  D.3882
	mov r19,r18	 ;  D.3885, D.3882
	clr r18	 ;  D.3885
	ld r24,Z	 ;  tmp71, ram
	or r18,r24	 ;  D.3885, tmp71
	mov r24,_Y_	 ;  reg_y, reg_y
	movw r16,r18	 ;  address, D.3885
	add r16,r24	 ;  address, reg_y
	adc r17,__zero_reg__	 ;  address
	cp r17,r19	 ;  tmp24, D.3885
	breq .L89	 ; ,
	ldi r24,lo8(1)	 ; ,
	call clock_advance	 ; 
.L89:
	movw r24,r16	 ; , address
/* epilogue start */
	pop r17	 ; 
	pop r16	 ; 
	ret
	.size	addr_iny, .-addr_iny
	.section	.text.addr_ind,"ax",@progbits
.global	addr_ind
	.type	addr_ind, @function
addr_ind:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r24,_PCL_	 ; , reg_pc
	call mem_read_16	 ; 
	adiw _PCL_,2	 ;  PC += 2
	jmp mem_read_16	 ; 
	.size	addr_ind, .-addr_ind
	.section	.text.cpu_reset,"ax",@progbits
.global	cpu_reset
	.type	cpu_reset, @function
cpu_reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-4)	 ; ,
	ldi r25,lo8(-1)	 ; ,
	call mem_read_16	 ; 
	movw _PCL_,r24	 ;  reg_pc,
	sts reg_pc,_PCL_
	sts reg_pc+1,_PCH_
	ldi r24,0xff
	sts time_left,r24
	sts time_left+1,r24
	sts time_left+2,r24
	sts time_left+3,r24
	ret
	.size	cpu_reset, .-cpu_reset
	.section	.text.cpu_get_pc,"ax",@progbits
.global	cpu_get_pc
	.type	cpu_get_pc, @function
cpu_get_pc:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_pc
	lds r25,reg_pc+1
	ret
	.size	cpu_get_pc, .-cpu_get_pc
	.section	.text.cpu_irq,"ax",@progbits
.global	cpu_irq
	.type	cpu_irq, @function
cpu_irq:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_p	 ;  reg_p, reg_p
	sbrc r24,2	 ;  reg_p,
	rjmp .L92	 ; 
	ldi r24,lo8(-2)	 ; ,
	ldi r25,lo8(-1)	 ; ,
	call mem_read_16	 ; 
	call cpu6502_JSR	 ; 
	call cpu6502_PHP	 ; 
	lds r24,reg_p	 ;  reg_p.57, reg_p
	ori r24,lo8(4)	 ;  reg_p.57,
	sts reg_p,r24	 ;  reg_p, reg_p.57
	ldi r24,7	 ; 7 cycles
	jmp clock_advance	 ; 
.L92:
	ret
	.size	cpu_irq, .-cpu_irq
	.section	.text.cpu_nmi,"ax",@progbits
.global	cpu_nmi
	.type	cpu_nmi, @function
cpu_nmi:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-6)	 ; ,
	ldi r25,lo8(-1)	 ; ,
	call mem_read_16	 ; 
	call cpu6502_JSR	 ; 
	call update_p	 ; 
	lds r24,reg_p	 ;  D.3900, reg_p
	andi r24,lo8(-17)	 ;  D.3900,
	mov r30,_S_	 ;  reg_s.59, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.61,
	add r25,r30	 ;  reg_s.61, reg_s.59
	mov _S_,r25	 ;  reg_s, reg_s.61
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp54,
	sbci r31,hi8(-(ram+256))	 ;  tmp54,
	st Z,r24	 ;  *_14, D.3900
	ret
	.size	cpu_nmi, .-cpu_nmi
	.section	.text.cpu_main,"ax",@progbits
.global	cpu_main
	.type	cpu_main, @function
cpu_main:
	push _PCL_
	push _PCH_
	push _A_
	push _X_
	push _Y_
	push _S_
	push _P_
	push _N_
	push _Z_
	push _C_
	push _time0_
	push _time1_
	push _time2_
	push _time3_
	push r16	 ; 
	push r17	 ; 
	lds _PCL_,reg_pc
	lds _PCH_,reg_pc+1
	lds _A_,reg_a
	lds _X_,reg_x
	lds _Y_,reg_y
	lds _S_,reg_s
	lds _P_,reg_p
	lds _N_,flag_n
	lds _Z_,flag_z
	lds _C_,flag_c
	lds _time0_,time_left
	lds _time1_,time_left+1
	lds _time2_,time_left+2
	lds _time3_,time_left+3
/* prologue: function */
/* frame size = 0 */
/* stack size = 17 */
.L__stack_usage = 17
	ldi r16,lo8(1)	 ; D.4025,
	add _time0_,r22	 ; time_left += cycles
	adc _time1_,r23	 ;
	adc _time2_,r24	 ;
	adc _time3_,r25	 ;
	brpl .L97	 ; continue if time >= 0
.L98:
	jmp .L366	 ; save state and exit
.tick:			 ;
	sub _time0_,_cycles_	 ; time_left -= cycles
	sbc _time1_,__zero_reg__	 ;
	sbc _time2_,__zero_reg__	 ;
	sbc _time3_,__zero_reg__	 ;
	brmi .L98	 ; quit if time < 0
.L97:
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ; PC++
	mov ZL,r24	 ;
	ldi ZH,0	 ;
	subi ZL,lo8(-(gs(.opcode_table)))	 ;
	sbci ZH,hi8(-(gs(.opcode_table)))	 ;
	ijmp	 ; jmp (.opcode_table + opcode)
.opcode_table:
	rjmp .x00
	rjmp .x01_ORA_inx
	rjmp .x02
	rjmp .x03
	rjmp .x04
	rjmp .x05_ORA_zpg
	rjmp .x06
	rjmp .x07
	rjmp .x08
	rjmp .x09_ORA_imm
	rjmp .x0a
	rjmp .x0b
	rjmp .x0c
	rjmp .x0d_ORA_abs
	rjmp .x0e
	rjmp .x0f
	rjmp .x10
	rjmp .x11_ORA_iny
	rjmp .x12
	rjmp .x13
	rjmp .x14
	rjmp .x15_ORA_zpx
	rjmp .x16
	rjmp .x17
	rjmp .x18
	rjmp .x19_ORA_aby
	rjmp .x1a
	rjmp .x1b
	rjmp .x1c
	rjmp .x1d_ORA_abx
	rjmp .x1e
	rjmp .x1f
	rjmp .x20
	rjmp .x21_AND_inx
	rjmp .x22
	rjmp .x23
	rjmp .x24
	rjmp .x25_AND_zpg
	rjmp .x26
	rjmp .x27
	rjmp .x28
	rjmp .x29_AND_imm
	rjmp .x2a
	rjmp .x2b
	rjmp .x2c
	rjmp .x2d_AND_abs
	rjmp .x2e
	rjmp .x2f
	rjmp .x30
	rjmp .x31_AND_iny
	rjmp .x32
	rjmp .x33
	rjmp .x34
	rjmp .x35_AND_zpx
	rjmp .x36
	rjmp .x37
	rjmp .x38
	rjmp .x39_AND_aby
	rjmp .x3a
	rjmp .x3b
	rjmp .x3c
	rjmp .x3d_AND_abx
	rjmp .x3e
	rjmp .x3f
	rjmp .x40
	rjmp .x41_EOR_inx
	rjmp .x42
	rjmp .x43
	rjmp .x44
	rjmp .x45_EOR_zpg
	rjmp .x46
	rjmp .x47
	rjmp .x48
	rjmp .x49_EOR_imm
	rjmp .x4a
	rjmp .x4b
	rjmp .x4c
	rjmp .x4d_EOR_abs
	rjmp .x4e
	rjmp .x4f
	rjmp .x50
	rjmp .x51_EOR_iny
	rjmp .x52
	rjmp .x53
	rjmp .x54
	rjmp .x55_EOR_zpx
	rjmp .x56
	rjmp .x57
	rjmp .x58
	rjmp .x59_EOR_aby
	rjmp .x5a
	rjmp .x5b
	rjmp .x5c
	rjmp .x5d_EOR_abx
	rjmp .x5e
	rjmp .x5f
	rjmp .x60
	rjmp .x61
	rjmp .x62
	rjmp .x63
	rjmp .x64
	rjmp .x65
	rjmp .x66
	rjmp .x67
	rjmp .x68
	rjmp .x69_ADC_imm
	rjmp .x6a
	rjmp .x6b
	rjmp .x6c
	rjmp .x6d
	rjmp .x6e
	rjmp .x6f
	rjmp .x70
	rjmp .x71
	rjmp .x72
	rjmp .x73
	rjmp .x74
	rjmp .x75
	rjmp .x76
	rjmp .x77
	rjmp .x78
	rjmp .x79
	rjmp .x7a
	rjmp .x7b
	rjmp .x7c
	rjmp .x7d
	rjmp .x7e
	rjmp .x7f
	rjmp .x80
	rjmp .x81
	rjmp .x82
	rjmp .x83
	rjmp .x84
	rjmp .x85
	rjmp .x86
	rjmp .x87
	rjmp .x88
	rjmp .x89
	rjmp .x8a
	rjmp .x8b
	rjmp .x8c
	rjmp .x8d
	rjmp .x8e
	rjmp .x8f
	rjmp .x90
	rjmp .x91
	rjmp .x92
	rjmp .x93
	rjmp .x94
	rjmp .x95_STA_zpx
	rjmp .x96
	rjmp .x97
	rjmp .x98
	rjmp .x99
	rjmp .x9a
	rjmp .x9b
	rjmp .x9c
	rjmp .x9d
	rjmp .x9e
	rjmp .x9f
	rjmp .xa0_LDY_imm
	rjmp .xa1_LDA_inx
	rjmp .xa2_LDX_imm
	rjmp .xa3
	rjmp .xa4_LDY_zpg
	rjmp .xa5_LDA_zpg
	rjmp .xa6_LDX_zpg
	rjmp .xa7
	rjmp .xa8
	rjmp .xa9_LDA_imm
	rjmp .xaa
	rjmp .xab
	rjmp .xac_LDY_abs
	rjmp .xad_LDA_abs
	rjmp .xae_LDX_abs
	rjmp .xaf
	rjmp .xb0
	rjmp .xb1_LDA_iny
	rjmp .xb2
	rjmp .xb3
	rjmp .xb4_LDY_zpx
	rjmp .xb5_LDA_zpx
	rjmp .xb6_LDX_zpy
	rjmp .xb7
	rjmp .xb8
	rjmp .xb9_LDA_aby
	rjmp .xba
	rjmp .xbb
	rjmp .xbc_LDY_abx
	rjmp .xbd_LDA_abx
	rjmp .xbe_LDX_aby
	rjmp .xbf
	rjmp .xc0
	rjmp .xc1_CMP_inx
	rjmp .xc2
	rjmp .xc3
	rjmp .xc4
	rjmp .xc5_CMP_zpg
	rjmp .xc6
	rjmp .xc7
	rjmp .xc8
	rjmp .xc9_CMP_imm
	rjmp .xca
	rjmp .xcb
	rjmp .xcc
	rjmp .xcd_CMP_abs
	rjmp .xce
	rjmp .xcf
	rjmp .xd0
	rjmp .xd1_CMP_iny
	rjmp .xd2
	rjmp .xd3
	rjmp .xd4
	rjmp .xd5_CMP_zpx
	rjmp .xd6
	rjmp .xd7
	rjmp .xd8
	rjmp .xd9_CMP_aby
	rjmp .xda
	rjmp .xdb
	rjmp .xdc
	rjmp .xdd_CMP_abx
	rjmp .xde
	rjmp .xdf
	rjmp .xe0
	rjmp .xe1
	rjmp .xe2
	rjmp .xe3
	rjmp .xe4
	rjmp .xe5
	rjmp .xe6
	rjmp .xe7
	rjmp .xe8
	rjmp .xe9
	rjmp .xea
	rjmp .xeb
	rjmp .xec
	rjmp .xed
	rjmp .xee
	rjmp .xef
	rjmp .xf0
	rjmp .xf1
	rjmp .xf2
	rjmp .xf3
	rjmp .xf4
	rjmp .xf5
	rjmp .xf6
	rjmp .xf7
	rjmp .xf8
	rjmp .xf9
	rjmp .xfa
	rjmp .xfb
	rjmp .xfc
	rjmp .xfd
	rjmp .xfe
	rjmp .xff

/***************************** LOAD INSTRUCTIONS ******************************/

.ORA:
	or _A_,_data_	 ; A |= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick	 ;
.x01_ORA_inx:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_inx
.x05_ORA_zpg:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_zpg
.x09_ORA_imm:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_imm
.x0d_ORA_abs:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_abs
.x11_ORA_iny:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_iny
.x15_ORA_zpx:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_zpx
.x19_ORA_aby:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_aby
.x1d_ORA_abx:
	ldi XL,lo8(gs(.ORA))
	ldi XH,hi8(gs(.ORA))
	rjmp .load_abx
.AND:
	and _A_,_data_	 ; A &= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick	 ;
.x21_AND_inx:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_inx
.x25_AND_zpg:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_zpg
.x29_AND_imm:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_imm
.x2d_AND_abs:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_abs
.x31_AND_iny:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_iny
.x35_AND_zpx:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_zpx
.x39_AND_aby:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_aby
.x3d_AND_abx:
	ldi XL,lo8(gs(.AND))
	ldi XH,hi8(gs(.AND))
	rjmp .load_abx
.EOR:
	eor _A_,_data_	 ; A ^= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick	 ;
.x41_EOR_inx:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_inx
.x45_EOR_zpg:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_zpg
.x49_EOR_imm:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_imm
.x4d_EOR_abs:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_abs
.x51_EOR_iny:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_iny
.x55_EOR_zpx:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_zpx
.x59_EOR_aby:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_aby
.x5d_EOR_abx:
	ldi XL,lo8(gs(.EOR))
	ldi XH,hi8(gs(.EOR))
	rjmp .load_abx
/*
.ADC:
	and _A_,_data_	 ;  A &= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick	 ;
.x61_ADC_inx:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_inx
.x65_ADC_zpg:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_zpg
.x69_ADC_imm:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_imm
.x6d_ADC_abs:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_abs
.x71_ADC_iny:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_iny
.x75_ADC_zpx:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_zpx
.x79_ADC_aby:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_aby
.x7d_ADC_abx:
	ldi XL,lo8(gs(.ADC))
	ldi XH,hi8(gs(.ADC))
	rjmp .load_abx
*/
.LDA:
	mov _A_,_data_	 ; A <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick	 ;
.xa1_LDA_inx:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_inx
.xa5_LDA_zpg:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_zpg
.xa9_LDA_imm:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_imm
.xad_LDA_abs:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_abs
.xb1_LDA_iny:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_iny
.xb5_LDA_zpx:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_zpx
.xb9_LDA_aby:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_aby
.xbd_LDA_abx:
	ldi XL,lo8(gs(.LDA))
	ldi XH,hi8(gs(.LDA))
	rjmp .load_abx
.CMP:
	mov _Z_,_A_	 ; Z <- A
	sub _Z_,_data_	 ; Z <- A - data
	mov _N_,_Z_	 ; N <- A - data
	brsh .CMP_carry	 ; branch if A >= data
	clr _C_	 ; C <- 0 if A < data
	rjmp .tick	 ;
.CMP_carry:
	clr _C_	 ;
	inc _C_	 ; C <- 1 if A >= data
	rjmp .tick	 ;
.xc1_CMP_inx:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_inx
.xc5_CMP_zpg:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_zpg
.xc9_CMP_imm:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_imm
.xcd_CMP_abs:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_abs
.xd1_CMP_iny:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_iny
.xd5_CMP_zpx:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_zpx
.xd9_CMP_aby:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_aby
.xdd_CMP_abx:
	ldi XL,lo8(gs(.CMP))
	ldi XH,hi8(gs(.CMP))
	rjmp .load_abx
/*
.SBC:
	mov _Z_,_A_	 ; Z <- A
	sub _Z_,_data_	 ; Z <- A - data
	mov _N_,_Z_	 ; N <- A - data
	brsh .SBC_carry	 ; branch if A >= data
	clr _C_	 ; C <- 0 if A < data
	rjmp .tick	 ;
.SBC_carry:
	clr _C_	 ;
	inc _C_	 ; C <- 1 if A >= data
	rjmp .tick	 ;
.xe1_SBC_inx:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_inx
.xe5_SBC_zpg:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_zpg
.xe9_SBC_imm:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_imm
.xed_SBC_abs:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_abs
.xf1_SBC_iny:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_iny
.xf5_SBC_zpx:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_zpx
.xf9_SBC_aby:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_aby
.xfd_SBC_abx:
	ldi XL,lo8(gs(.SBC))
	ldi XH,hi8(gs(.SBC))
	rjmp .load_abx
*/
.LDX:
	mov _X_,_data_	 ; X <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick	 ;
.xa2_LDX_imm:
	ldi XL,lo8(gs(.LDX))
	ldi XH,hi8(gs(.LDX))
	rjmp .load_imm
.xa6_LDX_zpg:
	ldi XL,lo8(gs(.LDX))
	ldi XH,hi8(gs(.LDX))
	rjmp .load_zpg
.xae_LDX_abs:
	ldi XL,lo8(gs(.LDX))
	ldi XH,hi8(gs(.LDX))
	rjmp .load_abs
.xb6_LDX_zpy:
	ldi XL,lo8(gs(.LDX))
	ldi XH,hi8(gs(.LDX))
	rjmp .load_zpy
.xbe_LDX_aby:
	ldi XL,lo8(gs(.LDX))
	ldi XH,hi8(gs(.LDX))
	rjmp .load_aby
.LDY:
	mov _Y_,_data_	 ; Y <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick	 ;
.xa0_LDY_imm:
	ldi XL,lo8(gs(.LDY))
	ldi XH,hi8(gs(.LDY))
	rjmp .load_imm
.xa4_LDY_zpg:
	ldi XL,lo8(gs(.LDY))
	ldi XH,hi8(gs(.LDY))
	rjmp .load_zpg
.xac_LDY_abs:
	ldi XL,lo8(gs(.LDY))
	ldi XH,hi8(gs(.LDY))
	rjmp .load_abs
.xb4_LDY_zpx:
	ldi XL,lo8(gs(.LDY))
	ldi XH,hi8(gs(.LDY))
	rjmp .load_zpx
.xbc_LDY_abx:
	ldi XL,lo8(gs(.LDY))
	ldi XH,hi8(gs(.LDY))
	rjmp .load_abx

/**************************** BRANCH INSTRUCTIONS *****************************/

/* BPL */
.x10:
	tst _N_	 ; branch on N >= 0
	brpl .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BMI */
.x30:
	tst _N_	 ; branch on N < 0
	brmi .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BVC */
.x50:
	bst _P_,6	 ; branch on P bit 6 = 0
	brtc .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BVS */
.x70:
	bst _P_,6	 ; branch on P bit 6 = 1
	brts .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.take_branch:
	call mem_read_pc	 ; r24 = mem_read(PC)
	adiw _PCL_,1	 ; PC++
	mov r19,_PCH_	 ; temp = PCH
	add _PCL_,r24	 ; reg_pc += offset
	adc _PCH_,__zero_reg__	 ;
	sbrc r24,7	 ; if (offset & 0x80) PCH--
	dec _PCH_	 ;
	ldi _cycles_,3	 ; 3 cycles for branch to same page
	cpse _PCH_,r19	 ; skip if same page
	ldi _cycles_,4	 ; 4 cycles for branch to different page
	rjmp .tick	 ;
/* BCC */
.x90:
	tst _C_	 ; branch on C = 0
	breq .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BCS */
.xb0:
	tst _C_	 ; branch on C != 0
	brne .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BNE */
.xd0:
	tst _Z_	 ; branch on Z != 0
	brne .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* BEQ */
.xf0:
	tst _Z_	 ; branch on Z = 0
	breq .take_branch	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;

/******************************************************************************/

/* BRK */
.x00:
	ldi r24,0xfe	 ;
	ldi r25,0xff	 ;
	call mem_read_16	 ;
	call cpu6502_JSR	 ;
	call update_p	 ;
	mov r25,_P_	 ; temp = P
	ori r25,0x10	 ; temp |= B_FLAG
	mov ZL,_S_	 ;
	ldi ZH,hi8(ram+256)	 ;
	st Z,r25	 ; stack[S] <- temp
	dec _S_	 ; S --
	ldi r25,0x04	 ; temp = I_FLAG
	or _P_,r25	 ; P |= I_FLAG (disable interrupts)
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x01:
	call addr_inx	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x03:
	call addr_inx	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x04:
	call addr_zpg	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x05:
	call addr_zpg	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x06:
	call addr_zpg	 ; 
	call cpu6502_ASL	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x07:
	call addr_zpg	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x08:
	call cpu6502_PHP	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
/* ORA imm */
.x09:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_ORA	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* ASL accumulator */
.x0a:
	clr _C_	 ; C <- 0
	lsl _A_	 ; A <- A << 1, carry <- A bit 7
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x0b:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_AND	 ; 
	mov r24,_A_	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	mov _C_,r24	 ;  flag_c, D.4025
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x0c:
	call addr_abs	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x0d:
	call addr_abs	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x0e:
	call addr_abs	 ; 
	call cpu6502_ASL	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x0f:
	call addr_abs	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x11:
	call addr_iny	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x13:
	call addr_iny	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x14:
	call addr_zpx	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x15:
	call addr_zpx	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x16:
	call addr_zpx	 ; 
	call cpu6502_ASL	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x17:
	call addr_zpx	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* CLC */
.x18:
	clr _C_	 ; C <- 0
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x19:
	call addr_aby	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x1a:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x1b:
	call addr_aby	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x1c:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x1d:
	call addr_abx	 ; 
	call cpu6502_ORA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x1e:
	call addr_abx	 ; 
	call cpu6502_ASL	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x1f:
	call addr_abx	 ; 
	call cpu6502_SLO	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x20:
	call addr_abs	 ; 
	call cpu6502_JSR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x21:
	call addr_inx	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x23:
	call addr_inx	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x24:
	call addr_zpg	 ; 
	call cpu6502_BIT	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x25:
	call addr_zpg	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x26:
	call addr_zpg	 ; 
	call cpu6502_ROL	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x27:
	call addr_zpg	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x28:
	call cpu6502_PLP	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x29:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_AND	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* ROL accumulator */
.x2a:
	lsr _C_	 ; carry <- C, C <- 0
	rol _A_	 ; carry <- A7, A <- [A6, A5 .. A1, carry]
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x2b:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_AND	 ; 
	mov r24,_A_	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	mov _C_,r24	 ;  flag_c, D.4025
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x2c:
	call addr_abs	 ; 
	call cpu6502_BIT	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x2d:
	call addr_abs	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x2e:
	call addr_abs	 ; 
	call cpu6502_ROL	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x2f:
	call addr_abs	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x31:
	call addr_iny	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x33:
	call addr_iny	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x34:
	call addr_zpx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x35:
	call addr_zpx	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x36:
	call addr_zpx	 ; 
	call cpu6502_ROL	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x37:
	call addr_zpx	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* CLC */
.x38:
	mov _C_,r16	 ;  flag_c, D.4025
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x39:
	call addr_aby	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x3a:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x3b:
	call addr_aby	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x3c:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x3d:
	call addr_abx	 ; 
	call cpu6502_AND	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x3e:
	call addr_abx	 ; 
	call cpu6502_ROL	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x3f:
	call addr_abx	 ; 
	call cpu6502_RLA	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x40:
	call cpu6502_PLP	 ; 
	call cpu6502_RTS	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x41:
	call addr_inx	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x43:
	call addr_inx	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x44:
	call addr_zpg	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x45:
	call addr_zpg	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x46:
	call addr_zpg	 ; 
	call cpu6502_LSR	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x47:
	call addr_zpg	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
/* PHA */
.x48:
	mov ZL,_S_	 ;
	ldi ZH,hi8(ram+256)	 ;
	st Z,_A_	 ; stack[S] <- A
	dec _S_	 ; S --
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x49:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_EOR	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* LSR accumulator */
.x4a:
	clr _C_	 ; C <- 0
	lsr _A_	 ; A <- [0, A7, .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x4b:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_AND	 ; 
	call cpu6502_LSR_a	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x4c:
	call addr_abs	 ; 
	mov _PCH_,r25	 ;  reg_pc,
	mov _PCL_,r24	 ;  reg_pc,
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x4d:
	call addr_abs	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x4e:
	call addr_abs	 ; 
	call cpu6502_LSR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x4f:
	call addr_abs	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x51:
	call addr_iny	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x53:
	call addr_iny	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x54:
	call addr_zpx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x55:
	call addr_zpx	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x56:
	call addr_zpx	 ; 
	call cpu6502_LSR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x57:
	call addr_zpx	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* CLI */
.x58:
	ldi r24,0xfa	 ; P &= ~I_FLAG
	and _P_,r24	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x59:
	call addr_aby	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x5a:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x5b:
	call addr_aby	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x5c:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x5d:
	call addr_abx	 ; 
	call cpu6502_EOR	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x5e:
	call addr_abx	 ; 
	call cpu6502_LSR	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x5f:
	call addr_abx	 ; 
	call cpu6502_SRE	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x60:
	call cpu6502_RTS	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x61:
	call addr_inx	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x63:
	call addr_inx	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x64:
	call addr_zpg	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x65:
	call addr_zpg	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x66:
	call addr_zpg	 ; 
	call cpu6502_ROR	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x67:
	call addr_zpg	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
/* PLA */
.x68:
	inc _S_	 ; S ++
	mov ZL,_S_	 ;
	ldi ZH,hi8(ram+256)	 ;
	ld _A_,Z	 ; A <- stack[S]
	mov _Z_,_A_	 ; Z <- A
	mov _N_,_A_	 ; N <- A
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x69_ADC_imm:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_ADC	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* ROR accumulator */
.x6a:
	lsr _C_	 ; carry <- C, C <- 0
	ror _A_	 ; A <- [carry, A7 .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x6b:
	/* TODO */
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x6c:
	call addr_ind	 ; 
	mov _PCH_,r25	 ;  reg_pc,
	mov _PCL_,r24	 ;  reg_pc,
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x6d:
	call addr_abs	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x6e:
	call addr_abs	 ; 
	call cpu6502_ROR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x6f:
	call addr_abs	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x71:
	call addr_iny	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x73:
	call addr_iny	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.x74:
	call addr_zpx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x75:
	call addr_zpx	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x76:
	call addr_zpx	 ; 
	call cpu6502_ROR	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x77:
	call addr_zpx	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* SEI */
.x78:
	ldi r24,0x04	 ;
	or _P_,r24	 ; P |= 0x04
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x79:
	call addr_aby	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x7a:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x7b:
	call addr_aby	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x7c:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x7d:
	call addr_abx	 ; 
	call cpu6502_ADC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x7e:
	call addr_abx	 ; 
	call cpu6502_ROR	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x7f:
	call addr_abx	 ; 
	call cpu6502_RRA	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x80:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x81:
	call addr_inx	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x82:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x83:
	call addr_inx	 ; 
	call cpu6502_SAX	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x84:
	call addr_zpg	 ; 
	mov r22,_Y_	 ; , reg_y
	call mem_write	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x85:
	call addr_zpg	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x86:
	call addr_zpg	 ; 
	mov r22,_X_	 ; , reg_x
	call mem_write	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.x87:
	call addr_zpg	 ; 
	call cpu6502_SAX	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
/* DEY */
.x88:
	dec _Y_	 ; Y--
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x89:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* TXA */
.x8a:
	mov _A_,_X_	 ; A <- X
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x8b:
	/* TODO */
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x8c:
	call addr_abs	 ; 
	mov r22,_Y_	 ; , reg_y
	call mem_write	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x8d:
	call addr_abs	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x8e:
	call addr_abs	 ; 
	mov r22,_X_	 ; , reg_x
	call mem_write	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x8f:
	call addr_abs	 ; 
	call cpu6502_SAX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x91:
	call addr_iny	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x93:
	call addr_iny	 ; 
	call cpu6502_SHA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.x94:
	call addr_zpx	 ; 
	mov r22,_Y_	 ; , reg_y
	call mem_write	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x95_STA_zpx:
	call mem_read_pc	 ; r24 <- mem_read(PC)
	adiw _PCL_,1	 ; PC++
	mov ZL,r24	 ;
	add ZL,_X_      ;
	ldi ZH,hi8(ram)	 ;
	st Z,_A_	 ; ram[r24+X] <- A
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x96:
	call addr_zpy	 ; 
	mov r22,_X_	 ; , reg_x
	call mem_write	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x97:
	call addr_zpy	 ; 
	call cpu6502_SAX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
/* TYA */
.x98:
	mov _A_,_Y_	 ; A <- Y
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x99:
	call addr_aby	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
/* TXS */
.x9a:
	mov _S_,_X_	 ; S <- X
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.x9b:
	/* TODO */
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x9c:
	call addr_abx	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	mov r18,_Y_	 ;  reg_y, reg_y
	and r22,r18	 ;  D.4021, reg_y
	call mem_write	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x9d:
	call addr_abx	 ; 
	call cpu6502_STA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.x9e:
	call addr_aby	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	mov r18,_X_	 ;  reg_x, reg_x
	and r22,r18	 ;  D.4021, reg_x
	call mem_write	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.x9f:
	call addr_aby	 ; 
	call cpu6502_SHA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xa0:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_LDY	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xa1:
	call addr_inx	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xa2:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_LDX	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xa3:
	call addr_inx	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xa4:
	call addr_zpg	 ; 
	call cpu6502_LDY	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xa5:
	call addr_zpg	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xa6:
	call addr_zpg	 ; 
	call cpu6502_LDX	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xa7:
	call addr_zpg	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
/* TAY */
.xa8:
	mov _Y_,_A_	 ; Y <- A
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xa9:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_LDA	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* TAX */
.xaa:
	mov _X_,_A_	 ; X <- A
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xab:
	/* TODO */
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xac:
	call addr_abs	 ; 
	call cpu6502_LDY	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xad:
	call addr_abs	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xae:
	call addr_abs	 ; 
	call cpu6502_LDX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xaf:
	call addr_abs	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xb1:
	call addr_iny	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xb3:
	call addr_iny	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xb4:
	call addr_zpx	 ; 
	call cpu6502_LDY	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xb5:
	call addr_zpx	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xb6:
	call addr_zpy	 ; 
	call cpu6502_LDX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xb7:
	call addr_zpy	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
/* CLV */
.xb8:
	ldi r24,0xaf	 ; P &= ~V_FLAG
	and _P_,r24	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xb9:
	call addr_aby	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
/* TSX */
.xba:
	mov _X_,_S_	 ; X <- S
	mov _Z_,_S_	 ;  flag_z, reg_s.199
	mov _N_,_S_	 ;  flag_n, reg_s.199
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xbb:
	/* TODO */
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xbc:
	call addr_abx	 ; 
	call cpu6502_LDY	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xbd:
	call addr_abx	 ; 
	call cpu6502_LDA	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xbe:
	call addr_aby	 ; 
	call cpu6502_LDX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xbf:
	call addr_aby	 ; 
	call cpu6502_LAX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xc0:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_CPY	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xc1:
	call addr_inx	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xc2:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xc3:
	call addr_inx	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.xc4:
	call addr_zpg	 ; 
	call cpu6502_CPY	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xc5:
	call addr_zpg	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xc6:
	call addr_zpg	 ; 
	call cpu6502_DEC	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xc7:
	call addr_zpg	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
/* INY */
.xc8:
	inc _Y_	 ; Y++
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xc9:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_CMP	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* DEX */
.xca:
	dec _X_	 ; X--
	mov _Z_,_X_	 ;  flag_z, flag_z.220
	mov _N_,_X_	 ;  flag_n, flag_z.220
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xcb:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call mem_read	 ; 
	mov r25,_X_	 ;  D.4021, reg_x
	mov r18,_A_	 ;  reg_a, reg_a
	and r25,r18	 ;  D.4021, reg_a
	ldi r18,lo8(1)	 ;  D.4025,
	cp r25,r24	 ;  D.4021, data
	brsh .L356	 ; ,
	ldi r18,0	 ;  D.4025
.L356:
	mov _C_,r18	 ;  flag_c, D.4025
	sub r25,r24	 ;  flag_z.226, data
	mov _Z_,r25	 ;  flag_z, flag_z.226
	mov _N_,r25	 ;  flag_n, flag_z.226
	mov _X_,r25	 ;  reg_x, flag_z.226
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xcc:
	call addr_abs	 ; 
	call cpu6502_CPY	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xcd:
	call addr_abs	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xce:
	call addr_abs	 ; 
	call cpu6502_DEC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xcf:
	call addr_abs	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xd1:
	call addr_iny	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xd3:
	call addr_iny	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.xd4:
	call addr_zpx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xd5:
	call addr_zpx	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xd6:
	call addr_zpx	 ; 
	call cpu6502_DEC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xd7:
	call addr_zpx	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* CLD */
.xd8:
	ldi r24,0xf7	 ; P &= ~D_FLAG
	and _P_,r24	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xd9:
	call addr_aby	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xda:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xdb:
	call addr_aby	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.xdc:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xdd:
	call addr_abx	 ; 
	call cpu6502_CMP	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xde:
	call addr_abx	 ; 
	call cpu6502_DEC	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.xdf:
	call addr_abx	 ; 
	call cpu6502_DCP	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.xe0:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_CPX	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xe1:
	call addr_inx	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xe2:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xe3:
	call addr_inx	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.xe4:
	call addr_zpg	 ; 
	call cpu6502_CPX	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xe5:
	call addr_zpg	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,3	 ; 3 cycles
	rjmp .tick	 ;
.xe6:
	call addr_zpg	 ; 
	call cpu6502_INC	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xe7:
	call addr_zpg	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
/* INX */
.xe8:
	inc _X_	 ; X++
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xe9:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_SBC	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
/* NOP */
.xea:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xeb:
	movw r24,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	call cpu6502_SBC	 ; 
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xec:
	call addr_abs	 ; 
	call cpu6502_CPX	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xed:
	call addr_abs	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xee:
	call addr_abs	 ; 
	call cpu6502_INC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xef:
	call addr_abs	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xf1:
	call addr_iny	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,5	 ; 5 cycles
	rjmp .tick	 ;
.xf3:
	call addr_iny	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,8	 ; 8 cycles
	rjmp .tick	 ;
.xf4:
	call addr_zpx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xf5:
	call addr_zpx	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xf6:
	call addr_zpx	 ; 
	call cpu6502_INC	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
.xf7:
	call addr_zpx	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,6	 ; 6 cycles
	rjmp .tick	 ;
/* SED */
.xf8:
	ldi r24,0x08	 ; P |= D_FLAG
	or _P_,r24	 ;
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xf9:
	call addr_aby	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xfa:
	ldi _cycles_,2	 ; 2 cycles
	rjmp .tick	 ;
.xfb:
	call addr_aby	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.xfc:
	call addr_abx	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xfd:
	call addr_abx	 ; 
	call cpu6502_SBC	 ; 
	ldi _cycles_,4	 ; 4 cycles
	rjmp .tick	 ;
.xfe:
	call addr_abx	 ; 
	call cpu6502_INC	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.xff:
	call addr_abx	 ; 
	call cpu6502_ISB	 ; 
	ldi _cycles_,7	 ; 7 cycles
	rjmp .tick	 ;
.x02:
.x12:
.x22:
.x32:
.x42:
.x52:
.x62:
.x72:
.x92:
.xb2:
.xd2:
.xf2:
	sbiw _PCL_,1	 ;  PC--
	ldi _cycles_,128	 ; loop in place, very slowly
	rjmp .tick	 ;

/******************* ADDRESSING MODES FOR LOAD INSTRUCTIONS *******************/
/*
input:  return address in XH:XL
output: data value in _data_, tick count in _cycles_
*/
.load_imm:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,2	 ; cycles <- 2
	movw ZL,XL
	ijmp
.load_zpg:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	mov ZL,r24	 ;
	ldi ZH,hi8(ram)	 ;
	ld _data_,Z	 ; data <- ram[r24]
	ldi _cycles_,3	 ; cycles <- 3
	movw ZL,XL
	ijmp
.load_zpx:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	add r24,_X_	 ; r24 += X
	mov ZL,r24	 ;
	ldi ZH,hi8(ram)	 ;
	ld _data_,Z	 ; data <- ram[r24]
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.load_zpy:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	add r24,_Y_	 ; r24 += Y
	mov ZL,r24	 ;
	ldi ZH,hi8(ram)	 ;
	ld _data_,Z	 ; data <- ram[r24]
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.load_abs:
	movw r24,_PCL_	 ; r25:r24 <- PC
	call mem_read_16	 ; r25:r24 <- read(PC)
	adiw _PCL_,2	 ; PC += 2
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.load_abx:
	movw r24,_PCL_	 ; r25:r24 <- PC
	call mem_read_16	 ; r25:r24 <- read(PC)
	adiw _PCL_,2	 ; PC += 2
	add r24,_X_	 ; r24 += X
	brcs .load_abx_carry	 ; branch if r24+X carries
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.load_abx_carry:
	inc r25	 ; r25++
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,5	 ; cycles <- 5
	movw ZL,XL
	ijmp
.load_aby:
	movw r24,_PCL_	 ; r25:r24 <- PC
	call mem_read_16	 ; r25:r24 <- read(PC)
	adiw _PCL_,2	 ; PC += 2
	add r24,_Y_	 ; r24 += Y
	brcs .load_aby_carry	 ; branch if r24+X carries
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.load_aby_carry:
	inc r25	 ; r25++
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,5	 ; cycles <- 5
	movw ZL,XL
	ijmp
.load_inx:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	add r24,_X_	 ; r24 += X
	mov ZL,r24	 ;
	ldi ZH,hi8(ram)	 ;
	ld r24,Z	 ; r24 <- ram[r24]
	inc ZL	 ; ZL++
	ld r25,Z	 ; r25 <- ram[r24+1]
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,6	 ; cycles <- 6
	movw ZL,XL
	ijmp
.load_iny:
	call mem_read_pc	 ; r24 <- read(PC)
	adiw _PCL_,1	 ; PC++
	mov ZL,r24	 ;
	ldi ZH,hi8(ram)	 ;
	ld r24,Z	 ; r24 <- ram[r24]
	inc ZL	 ; ZL++
	ld r25,Z	 ; r25 <- ram[r24+1]
	add r24,_Y_	 ; r24 += Y
	brcs .load_iny_carry	 ; branch if r24+Y carries
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,5	 ; cycles <- 5
	movw ZL,XL
	ijmp
.load_iny_carry:
	inc r25	 ; r25++
	call mem_read	 ; r24 <- read(r25:r24)
	mov _data_,r24	 ; data <- r24
	ldi _cycles_,6	 ; cycles <- 6
	movw ZL,XL
	ijmp

.L366:
/* epilogue start */
	sts reg_pc,_PCL_
	sts reg_pc+1,_PCH_
	sts reg_a,_A_
	sts reg_x,_X_
	sts reg_y,_Y_
	sts reg_s,_S_
	sts reg_p,_P_
	sts flag_n,_N_
	sts flag_z,_Z_
	sts flag_c,_C_
	sts time_left,_time0_
	sts time_left+1,_time1_
	sts time_left+2,_time2_
	sts time_left+3,_time3_
	pop r17	 ; 
	pop r16	 ; 
	pop _time3_
	pop _time2_
	pop _time1_
	pop _time0_
	pop _C_
	pop _Z_
	pop _N_
	pop _P_
	pop _S_
	pop _Y_
	pop _X_
	pop _A_
	pop _PCH_
	pop _PCL_
	ret
	.size	cpu_main, .-cpu_main
	.section	.bss.time_left,"aw",@nobits
	.type	time_left, @object
	.size	time_left, 4
time_left:
	.zero	4
	.comm	stack,2,1
	.section	.bss.flag_c,"aw",@nobits
	.type	flag_c, @object
	.size	flag_c, 1
flag_c:
	.zero	1
	.section	.bss.flag_z,"aw",@nobits
	.type	flag_z, @object
	.size	flag_z, 1
flag_z:
	.zero	1
	.section	.bss.flag_n,"aw",@nobits
	.type	flag_n, @object
	.size	flag_n, 1
flag_n:
	.zero	1
	.section	.bss.reg_p,"aw",@nobits
	.type	reg_p, @object
	.size	reg_p, 1
reg_p:
	.zero	1
	.section	.bss.reg_s,"aw",@nobits
	.type	reg_s, @object
	.size	reg_s, 1
reg_s:
	.zero	1
	.section	.bss.reg_y,"aw",@nobits
	.type	reg_y, @object
	.size	reg_y, 1
reg_y:
	.zero	1
	.section	.bss.reg_x,"aw",@nobits
	.type	reg_x, @object
	.size	reg_x, 1
reg_x:
	.zero	1
	.section	.bss.reg_a,"aw",@nobits
	.type	reg_a, @object
	.size	reg_a, 1
reg_a:
	.zero	1
	.section	.bss.reg_pc,"aw",@nobits
	.type	reg_pc, @object
	.size	reg_pc, 2
reg_pc:
	.zero	2
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
