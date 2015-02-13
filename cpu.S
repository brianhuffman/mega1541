	.file	"cpu.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
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

	.section	.text.clock_advance,"ax",@progbits
	.type	clock_advance, @function
clock_advance:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	clr r26	 ;  D.3675
	sbrc r25,7	 ;  D.3675
	com r26	 ;  D.3675
	mov r27,r26	 ;  D.3675
	lds r20,time_left	 ;  time_left.20, time_left
	lds r21,time_left+1	 ;  time_left.20, time_left
	lds r22,time_left+2	 ;  time_left.20, time_left
	lds r23,time_left+3	 ;  time_left.20, time_left
	sub r20,r24	 ;  time_left.20, D.3675
	sbc r21,r25	 ;  time_left.20, D.3675
	sbc r22,r26	 ;  time_left.20, D.3675
	sbc r23,r27	 ;  time_left.20, D.3675
	sts time_left,r20	 ;  time_left, time_left.20
	sts time_left+1,r21	 ;  time_left, time_left.20
	sts time_left+2,r22	 ;  time_left, time_left.20
	sts time_left+3,r23	 ;  time_left, time_left.20
	ret
	.size	clock_advance, .-clock_advance
	.section	.text.cpu6502_PLP,"ax",@progbits
	.type	cpu6502_PLP, @function
cpu6502_PLP:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,reg_s	 ;  reg_s.86, reg_s
	subi r30,lo8(-(1))	 ;  reg_s.86,
	sts reg_s,r30	 ;  reg_s, reg_s.86
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp55,
	sbci r31,hi8(-(ram+256))	 ;  tmp55,
	ld r24,Z	 ;  D.3681, *_14
	sts reg_p,r24	 ;  reg_p, D.3681
	sts flag_n,r24	 ;  flag_n, D.3681
	bst r24,1	 ;  D.3681,
	clr r25	 ;  D.3678
	bld r25,0	 ;  D.3678
	ldi r18,lo8(1)	 ;  tmp58,
	eor r25,r18	 ;  D.3678, tmp58
	sts flag_z,r25	 ;  flag_z, D.3678
	andi r24,lo8(1)	 ;  flag_c.90,
	sts flag_c,r24	 ;  flag_c, flag_c.90
	ret
	.size	cpu6502_PLP, .-cpu6502_PLP
	.section	.text.cpu6502_JSR,"ax",@progbits
	.type	cpu6502_JSR, @function
cpu6502_JSR:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r18,reg_pc	 ;  reg_pc.37, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.37, reg_pc
	subi r18,1	 ;  reg_pc.37,
	sbc r19,__zero_reg__	 ;  reg_pc.37
	lds r30,reg_s	 ;  reg_s.38, reg_s
	mov r26,r30	 ;  tmp60, reg_s.38
	ldi r27,0	 ; 
	subi r26,lo8(-(ram+256))	 ;  tmp60,
	sbci r27,hi8(-(ram+256))	 ;  tmp60,
	st X,r19	 ;  *_19, reg_pc.37
	ldi r19,lo8(-2)	 ;  reg_s.42,
	add r19,r30	 ;  reg_s.42, reg_s.38
	sts reg_s,r19	 ;  reg_s, reg_s.42
	subi r30,lo8(-(-1))	 ;  reg_s.40,
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp66,
	sbci r31,hi8(-(ram+256))	 ;  tmp66,
	st Z,r18	 ;  *_22, reg_pc.37
	sts reg_pc+1,r25	 ;  reg_pc, address
	sts reg_pc,r24	 ;  reg_pc, address
	ret
	.size	cpu6502_JSR, .-cpu6502_JSR
	.section	.text.cpu6502_RTS,"ax",@progbits
	.type	cpu6502_RTS, @function
cpu6502_RTS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r30,reg_s	 ;  reg_s.136, reg_s
	ldi r18,lo8(2)	 ;  D.3693,
	add r18,r30	 ;  D.3693, reg_s.136
	mov r26,r18	 ;  tmp60, D.3693
	ldi r27,0	 ; 
	subi r26,lo8(-(ram+256))	 ;  tmp60,
	sbci r27,hi8(-(ram+256))	 ;  tmp60,
	ld r24,X	 ;  *_14, *_14
	ldi r25,0	 ;  D.3697
	mov r25,r24	 ;  reg_pc.143, D.3697
	clr r24	 ;  reg_pc.143
	subi r30,lo8(-(1))	 ;  reg_s.138,
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp67,
	sbci r31,hi8(-(ram+256))	 ;  tmp67,
	ld r19,Z	 ;  *_20, *_20
	or r24,r19	 ;  reg_pc.143, *_20
	sts reg_s,r18	 ;  reg_s, D.3693
	adiw r24,1	 ;  reg_pc.143,
	sts reg_pc+1,r25	 ;  reg_pc, reg_pc.143
	sts reg_pc,r24	 ;  reg_pc, reg_pc.143
	ret
	.size	cpu6502_RTS, .-cpu6502_RTS
	.section	.text.cpu6502_LSR_a,"ax",@progbits
	.type	cpu6502_LSR_a, @function
cpu6502_LSR_a:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_a	 ;  reg_a.120, reg_a
	mov r25,r24	 ;  flag_c.121, reg_a.120
	andi r25,lo8(1)	 ;  flag_c.121,
	sts flag_c,r25	 ;  flag_c, flag_c.121
	lsr r24	 ;  flag_z.122
	sts flag_z,r24	 ;  flag_z, flag_z.122
	sts flag_n,r24	 ;  flag_n, flag_z.122
	sts reg_a,r24	 ;  reg_a, flag_z.122
	ret
	.size	cpu6502_LSR_a, .-cpu6502_LSR_a
	.section	.text.cpu6502_ORA,"ax",@progbits
	.type	cpu6502_ORA, @function
cpu6502_ORA:
	push r28	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r28,reg_a	 ;  reg_a.77, reg_a
	call mem_read	 ; 
	or r24,r28	 ;  flag_z.78, reg_a.77
	sts flag_z,r24	 ;  flag_z, flag_z.78
	sts flag_n,r24	 ;  flag_n, flag_z.78
	sts reg_a,r24	 ;  reg_a, flag_z.78
/* epilogue start */
	pop r28	 ; 
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
	lds r18,reg_p	 ;  reg_p.101, reg_p
	andi r18,lo8(-65)	 ;  reg_p.101,
	or r25,r18	 ;  D.3706, reg_p.101
	sts reg_p,r25	 ;  reg_p, D.3706
	sts flag_n,r24	 ;  flag_n, data
	lds r25,reg_a	 ;  flag_z.106, reg_a
	and r25,r24	 ;  flag_z.106, data
	sts flag_z,r25	 ;  flag_z, flag_z.106
	ret
	.size	cpu6502_BIT, .-cpu6502_BIT
	.section	.text.cpu6502_AND,"ax",@progbits
	.type	cpu6502_AND, @function
cpu6502_AND:
	push r28	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r28,reg_a	 ;  reg_a.107, reg_a
	call mem_read	 ; 
	and r24,r28	 ;  flag_z.108, reg_a.107
	sts flag_z,r24	 ;  flag_z, flag_z.108
	sts flag_n,r24	 ;  flag_n, flag_z.108
	sts reg_a,r24	 ;  reg_a, flag_z.108
/* epilogue start */
	pop r28	 ; 
	ret
	.size	cpu6502_AND, .-cpu6502_AND
	.section	.text.cpu6502_EOR,"ax",@progbits
	.type	cpu6502_EOR, @function
cpu6502_EOR:
	push r28	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r28,reg_a	 ;  reg_a.128, reg_a
	call mem_read	 ; 
	eor r24,r28	 ;  flag_z.129, reg_a.128
	sts flag_z,r24	 ;  flag_z, flag_z.129
	sts flag_n,r24	 ;  flag_n, flag_z.129
	sts reg_a,r24	 ;  reg_a, flag_z.129
/* epilogue start */
	pop r28	 ; 
	ret
	.size	cpu6502_EOR, .-cpu6502_EOR
	.section	.text.cpu6502_ADC,"ax",@progbits
	.type	cpu6502_ADC, @function
cpu6502_ADC:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	lds r25,reg_p	 ;  reg_p.156, reg_p
	lds r30,reg_a	 ;  reg_a.157, reg_a
	lds r26,flag_c	 ;  flag_c, flag_c
	mov r22,r24	 ;  D.3729, D.3728
	ldi r23,0	 ;  D.3729
	mov r31,r25	 ;  reg_p.160, reg_p.156
	andi r31,lo8(-65)	 ;  reg_p.160,
	sbrs r25,3	 ;  reg_p.156,
	rjmp .L11	 ; 
	mov r18,r30	 ;  total, reg_a.157
	ldi r19,0	 ;  total
	add r18,r26	 ;  total, flag_c
	adc r19,__zero_reg__	 ;  total
	add r18,r22	 ;  total, D.3729
	adc r19,r23	 ;  total, D.3729
	sts flag_z,r18	 ;  flag_z, total
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
	sts flag_n,r18	 ;  flag_n, total
	eor r24,r18	 ;  D.3728, total
	eor r30,r18	 ;  D.3728, total
	and r24,r30	 ;  D.3728, D.3728
	sbrc r24,7	 ;  D.3728,
	ori r31,lo8(64)	 ;  reg_p.161,
.L20:
	sts reg_p,r31	 ;  reg_p, reg_p.161
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
	sts flag_c,r24	 ;  flag_c, D.3731
	rjmp .L18	 ; 
.L11:
	mov r20,r30	 ;  total, reg_a.157
	ldi r21,0	 ;  total
	add r20,r26	 ;  total, flag_c
	adc r21,__zero_reg__	 ;  total
	add r20,r22	 ;  total, D.3729
	adc r21,r23	 ;  total, D.3729
	sts flag_c,r21	 ;  flag_c, total
	mov r18,r20	 ;  result, total
	sts flag_z,r20	 ;  flag_z, total
	sts flag_n,r20	 ;  flag_n, total
	eor r24,r20	 ;  D.3728, total
	eor r20,r30	 ;  D.3728, reg_a.157
	and r24,r20	 ;  D.3728, D.3728
	sbrc r24,7	 ;  D.3728,
	ori r31,lo8(64)	 ;  reg_p.161,
.L21:
	sts reg_p,r31	 ;  reg_p, reg_p.161
.L18:
	sts reg_a,r18	 ;  reg_a, result
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
	sts flag_z,r24	 ;  flag_z, flag_z.202
	sts flag_n,r24	 ;  flag_n, flag_z.202
	sts reg_y,r24	 ;  reg_y, flag_z.202
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
	sts flag_z,r24	 ;  flag_z, flag_z.205
	sts flag_n,r24	 ;  flag_n, flag_z.205
	sts reg_a,r24	 ;  reg_a, flag_z.205
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
	sts flag_z,r24	 ;  flag_z, flag_z.208
	sts flag_n,r24	 ;  flag_n, flag_z.208
	sts reg_x,r24	 ;  reg_x, flag_z.208
	ret
	.size	cpu6502_LDX, .-cpu6502_LDX
	.section	.text.cpu6502_LAX,"ax",@progbits
	.type	cpu6502_LAX, @function
cpu6502_LAX:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	sts flag_z,r24	 ;  flag_z, flag_z.211
	sts flag_n,r24	 ;  flag_n, flag_z.211
	sts reg_x,r24	 ;  reg_x, flag_z.211
	sts reg_a,r24	 ;  reg_a, flag_z.211
	movw r24,r28	 ; , address
	call cpu6502_LDA	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_LDX	 ; 
	.size	cpu6502_LAX, .-cpu6502_LAX
	.section	.text.cpu6502_CPX,"ax",@progbits
	.type	cpu6502_CPX, @function
cpu6502_CPX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	lds r25,reg_x	 ;  reg_x.243, reg_x
	ldi r18,lo8(1)	 ;  D.3747,
	cp r25,r24	 ;  reg_x.243, D.3746
	brsh .L28	 ; ,
	ldi r18,0	 ;  D.3747
.L28:
	sts flag_c,r18	 ;  flag_c, D.3747
	sub r25,r24	 ;  reg_x.243, D.3746
	sts flag_z,r25	 ;  flag_z, flag_z.231
	sts flag_n,r25	 ;  flag_n, flag_z.231
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
	lds r21,reg_p	 ;  reg_p.249, reg_p
	lds r20,reg_a	 ;  reg_a.250, reg_a
	lds r18,flag_c	 ;  flag_c, flag_c
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
	sts flag_z,r25	 ;  flag_z, result
	sts flag_n,r25	 ;  flag_n, result
	andi r21,lo8(-66)	 ;  reg_p.253,
	mov r18,r25	 ;  D.3761, result
	eor r18,r20	 ;  D.3761, reg_a.250
	eor r20,r24	 ;  D.3761, D.3761
	and r18,r20	 ;  D.3761, D.3761
	sbrc r18,7	 ;  D.3761,
	ori r21,lo8(64)	 ;  reg_p.254,
.L37:
	sts reg_p,r21	 ;  reg_p, reg_p.254
	sts flag_c,__zero_reg__	 ;  flag_c,
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
	sts flag_c,r19	 ;  flag_c, total
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
	sts reg_p,r22	 ;  reg_p, reg_p.254
	sts flag_z,r18	 ;  flag_z, total
	sts flag_n,r18	 ;  flag_n, total
.L34:
	sts reg_a,r25	 ;  reg_a, result
	ret
	.size	cpu6502_SBC, .-cpu6502_SBC
	.section	.text.cpu6502_ASL,"ax",@progbits
	.type	cpu6502_ASL, @function
cpu6502_ASL:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	mov r25,r24	 ;  flag_c.81, data
	rol r25	 ;  flag_c.81
	clr r25	 ;  flag_c.81
	rol r25	 ;  flag_c.81
	sts flag_c,r25	 ;  flag_c, flag_c.81
	mov r22,r24	 ;  flag_z.82, data
	lsl r22	 ;  flag_z.82
	sts flag_z,r22	 ;  flag_z, flag_z.82
	sts flag_n,r22	 ;  flag_n, flag_z.82
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ASL, .-cpu6502_ASL
	.section	.text.cpu6502_SLO,"ax",@progbits
	.type	cpu6502_SLO, @function
cpu6502_SLO:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_ASL	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_ORA	 ; 
	.size	cpu6502_SLO, .-cpu6502_SLO
	.section	.text.cpu6502_ROL,"ax",@progbits
	.type	cpu6502_ROL, @function
cpu6502_ROL:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	mov r22,r24	 ;  result, data
	lsl r22	 ;  result
	lds r25,flag_c	 ;  flag_c, flag_c
	or r22,r25	 ;  result, flag_c
	rol r24	 ;  flag_c.113
	clr r24	 ;  flag_c.113
	rol r24	 ;  flag_c.113
	sts flag_c,r24	 ;  flag_c, flag_c.113
	sts flag_z,r22	 ;  flag_z, result
	sts flag_n,r22	 ;  flag_n, result
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ROL, .-cpu6502_ROL
	.section	.text.cpu6502_RLA,"ax",@progbits
	.type	cpu6502_RLA, @function
cpu6502_RLA:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_ROL	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_AND	 ; 
	.size	cpu6502_RLA, .-cpu6502_RLA
	.section	.text.cpu6502_LSR,"ax",@progbits
	.type	cpu6502_LSR, @function
cpu6502_LSR:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	mov r25,r24	 ;  flag_c.132, data
	andi r25,lo8(1)	 ;  flag_c.132,
	sts flag_c,r25	 ;  flag_c, flag_c.132
	mov r22,r24	 ;  flag_z.133, data
	lsr r22	 ;  flag_z.133
	sts flag_z,r22	 ;  flag_z, flag_z.133
	sts flag_n,r22	 ;  flag_n, flag_z.133
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_LSR, .-cpu6502_LSR
	.section	.text.cpu6502_SRE,"ax",@progbits
	.type	cpu6502_SRE, @function
cpu6502_SRE:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_LSR	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_EOR	 ; 
	.size	cpu6502_SRE, .-cpu6502_SRE
	.section	.text.cpu6502_ROR,"ax",@progbits
	.type	cpu6502_ROR, @function
cpu6502_ROR:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	mov r22,r24	 ;  result, data
	lsr r22	 ;  result
	lds r18,flag_c	 ;  flag_c, flag_c
	ldi r25,lo8(-128)	 ; ,
	mul r18,r25	 ;  flag_c,
	movw r18,r0	 ;  D.3782
	clr __zero_reg__
	or r22,r18	 ;  result, D.3782
	andi r24,lo8(1)	 ;  flag_c.166,
	sts flag_c,r24	 ;  flag_c, flag_c.166
	sts flag_z,r22	 ;  flag_z, result
	sts flag_n,r22	 ;  flag_n, result
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_ROR, .-cpu6502_ROR
	.section	.text.cpu6502_RRA,"ax",@progbits
	.type	cpu6502_RRA, @function
cpu6502_RRA:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_ROR	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_ADC	 ; 
	.size	cpu6502_RRA, .-cpu6502_RRA
	.section	.text.cpu6502_SAX,"ax",@progbits
	.type	cpu6502_SAX, @function
cpu6502_SAX:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,reg_x	 ;  D.3787, reg_x
	lds r18,reg_a	 ;  reg_a, reg_a
	and r22,r18	 ;  D.3787, reg_a
	jmp mem_write	 ; 
	.size	cpu6502_SAX, .-cpu6502_SAX
	.section	.text.cpu6502_STA,"ax",@progbits
	.type	cpu6502_STA, @function
cpu6502_STA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,reg_a	 ; , reg_a
	jmp mem_write	 ; 
	.size	cpu6502_STA, .-cpu6502_STA
	.section	.text.cpu6502_SHA,"ax",@progbits
	.type	cpu6502_SHA, @function
cpu6502_SHA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,reg_x	 ;  D.3792, reg_x
	lds r18,reg_a	 ;  reg_a, reg_a
	and r22,r18	 ;  D.3792, reg_a
	ldi r18,lo8(1)	 ;  D.3792,
	add r18,r25	 ;  D.3792, address
	and r22,r18	 ;  D.3792, D.3792
	jmp mem_write	 ; 
	.size	cpu6502_SHA, .-cpu6502_SHA
	.section	.text.cpu6502_DEC,"ax",@progbits
	.type	cpu6502_DEC, @function
cpu6502_DEC:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	ldi r22,lo8(-1)	 ;  flag_z.236,
	add r22,r24	 ;  flag_z.236,
	sts flag_z,r22	 ;  flag_z, flag_z.236
	sts flag_n,r22	 ;  flag_n, flag_z.236
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_DEC, .-cpu6502_DEC
	.section	.text.cpu6502_INC,"ax",@progbits
	.type	cpu6502_INC, @function
cpu6502_INC:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call mem_read	 ; 
	ldi r22,lo8(1)	 ;  flag_z.258,
	add r22,r24	 ;  flag_z.258,
	sts flag_z,r22	 ;  flag_z, flag_z.258
	sts flag_n,r22	 ;  flag_n, flag_z.258
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp mem_write	 ; 
	.size	cpu6502_INC, .-cpu6502_INC
	.section	.text.cpu6502_ISB,"ax",@progbits
	.type	cpu6502_ISB, @function
cpu6502_ISB:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_INC	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_SBC	 ; 
	.size	cpu6502_ISB, .-cpu6502_ISB
	.section	.text.cpu6502_JAM,"ax",@progbits
	.type	cpu6502_JAM, @function
cpu6502_JAM:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_pc	 ;  reg_pc.245, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.245, reg_pc
	sbiw r24,1	 ;  reg_pc.245,
	sts reg_pc+1,r25	 ;  reg_pc, reg_pc.245
	sts reg_pc,r24	 ;  reg_pc, reg_pc.245
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
	lds r24,reg_p	 ;  reg_p.48, reg_p
	andi r24,lo8(108)	 ;  reg_p.48,
	mov r25,r24	 ;  reg_p.49, reg_p.48
	ori r25,lo8(32)	 ;  reg_p.49,
	sts reg_p,r25	 ;  reg_p, reg_p.49
	lds r25,flag_n	 ;  flag_n, flag_n
	sbrs r25,7	 ;  flag_n,
	rjmp .L55	 ; 
	ori r24,lo8(-96)	 ;  reg_p.50,
	sts reg_p,r24	 ;  reg_p, reg_p.50
.L55:
	lds r24,flag_z	 ;  flag_z, flag_z
	cpse r24,__zero_reg__	 ;  flag_z,
	rjmp .L56	 ; 
	lds r24,reg_p	 ;  reg_p.51, reg_p
	ori r24,lo8(2)	 ;  reg_p.51,
	sts reg_p,r24	 ;  reg_p, reg_p.51
.L56:
	lds r24,flag_c	 ;  flag_c, flag_c
	tst r24	 ;  flag_c
	breq .L54	 ; ,
	lds r24,reg_p	 ;  reg_p.53, reg_p
	ori r24,lo8(1)	 ;  reg_p.53,
	sts reg_p,r24	 ;  reg_p, reg_p.53
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
	lds r24,reg_p	 ;  reg_p.43, reg_p
	lds r30,reg_s	 ;  reg_s.44, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.46,
	add r25,r30	 ;  reg_s.46, reg_s.44
	sts reg_s,r25	 ;  reg_s, reg_s.46
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp51,
	sbci r31,hi8(-(ram+256))	 ;  tmp51,
	st Z,r24	 ;  *_10, reg_p.43
	ret
	.size	cpu6502_PHP, .-cpu6502_PHP
	.section	.text.cpu6502_branch,"ax",@progbits
	.type	cpu6502_branch, @function
cpu6502_branch:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	tst r24	 ;  condition
	breq .L65	 ; ,
	movw r24,r22	 ; , address
	call mem_read	 ; 
	lds r18,reg_pc	 ;  reg_pc.76, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.76, reg_pc
	movw r28,r18	 ;  new_pc, reg_pc.76
	add r28,r24	 ;  new_pc,
	adc r29,__zero_reg__	 ;  new_pc
	sbrc r24,7	 ; 
	dec r29	 ;  new_pc
	cp r29,r19	 ;  tmp24, reg_pc.76
	breq .L67	 ; ,
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	rjmp .L72	 ; 
.L67:
	ldi r24,lo8(1)	 ; ,
	ldi r25,0	 ; 
.L72:
	call clock_advance	 ; 
	sts reg_pc+1,r29	 ;  reg_pc, new_pc
	sts reg_pc,r28	 ;  reg_pc, new_pc
.L65:
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	ret
	.size	cpu6502_branch, .-cpu6502_branch
	.section	.text.cpu6502_CPY,"ax",@progbits
	.type	cpu6502_CPY, @function
cpu6502_CPY:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call mem_read	 ; 
	lds r25,reg_y	 ;  reg_y.229, reg_y
	ldi r18,lo8(1)	 ;  D.3838,
	cp r25,r24	 ;  reg_y.229, D.3837
	brsh .L74	 ; ,
	ldi r18,0	 ;  D.3838
.L74:
	sts flag_c,r18	 ;  flag_c, D.3838
	sub r25,r24	 ;  reg_y.229, D.3837
	sts flag_z,r25	 ;  flag_z, flag_z.231
	sts flag_n,r25	 ;  flag_n, flag_z.231
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
	lds r25,reg_a	 ;  reg_a.235, reg_a
	ldi r18,lo8(1)	 ;  D.3846,
	cp r25,r24	 ;  reg_a.235, D.3845
	brsh .L76	 ; ,
	ldi r18,0	 ;  D.3846
.L76:
	sts flag_c,r18	 ;  flag_c, D.3846
	sub r25,r24	 ;  reg_a.235, D.3845
	sts flag_z,r25	 ;  flag_z, flag_z.231
	sts flag_n,r25	 ;  flag_n, flag_z.231
	ret
	.size	cpu6502_CMP, .-cpu6502_CMP
	.section	.text.cpu6502_DCP,"ax",@progbits
	.type	cpu6502_DCP, @function
cpu6502_DCP:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24	 ;  address, address
	call cpu6502_DEC	 ; 
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	jmp cpu6502_CMP	 ; 
	.size	cpu6502_DCP, .-cpu6502_DCP
	.section	.text.addr_imm,"ax",@progbits
.global	addr_imm
	.type	addr_imm, @function
addr_imm:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_pc	 ;  reg_pc.0, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.0, reg_pc
	movw r18,r24	 ;  reg_pc.2, reg_pc.0
	subi r18,-1	 ;  reg_pc.2,
	sbci r19,-1	 ;  reg_pc.2,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.2
	sts reg_pc,r18	 ;  reg_pc, reg_pc.2
	ret
	.size	addr_imm, .-addr_imm
	.section	.text.addr_zpg,"ax",@progbits
.global	addr_zpg
	.type	addr_zpg, @function
addr_zpg:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,reg_pc	 ;  reg_pc.3, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.3, reg_pc
	movw r18,r24	 ;  reg_pc.5, reg_pc.3
	subi r18,-1	 ;  reg_pc.5,
	sbci r19,-1	 ;  reg_pc.5,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.5
	sts reg_pc,r18	 ;  reg_pc, reg_pc.5
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
	lds r24,reg_pc	 ; , reg_pc
	lds r25,reg_pc+1	 ; , reg_pc
	call mem_read_16	 ; 
	lds r18,reg_pc	 ;  reg_pc.7, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.7, reg_pc
	subi r18,-2	 ;  reg_pc.7,
	sbci r19,-1	 ;  reg_pc.7,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.7
	sts reg_pc,r18	 ;  reg_pc, reg_pc.7
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
	lds r24,reg_pc	 ;  reg_pc.8, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.8, reg_pc
	movw r18,r24	 ;  reg_pc.10, reg_pc.8
	subi r18,-1	 ;  reg_pc.10,
	sbci r19,-1	 ;  reg_pc.10,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.10
	sts reg_pc,r18	 ;  reg_pc, reg_pc.10
	call mem_read	 ; 
	lds r25,reg_x	 ;  address, reg_x
	add r25,r24	 ;  address,
	mov r24,r25	 ; , address
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
	lds r24,reg_pc	 ;  reg_pc.12, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.12, reg_pc
	movw r18,r24	 ;  reg_pc.14, reg_pc.12
	subi r18,-1	 ;  reg_pc.14,
	sbci r19,-1	 ;  reg_pc.14,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.14
	sts reg_pc,r18	 ;  reg_pc, reg_pc.14
	call mem_read	 ; 
	lds r25,reg_y	 ;  address, reg_y
	add r25,r24	 ;  address,
	mov r24,r25	 ; , address
	ldi r25,0	 ; 
	ret
	.size	addr_zpy, .-addr_zpy
	.section	.text.addr_abx,"ax",@progbits
.global	addr_abx
	.type	addr_abx, @function
addr_abx:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r24,reg_pc	 ; , reg_pc
	lds r25,reg_pc+1	 ; , reg_pc
	call mem_read_16	 ; 
	lds r18,reg_x	 ;  reg_x, reg_x
	movw r28,r24	 ;  address, base
	add r28,r18	 ;  address, reg_x
	adc r29,__zero_reg__	 ;  address
	lds r18,reg_pc	 ;  reg_pc.18, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.18, reg_pc
	subi r18,-2	 ;  reg_pc.18,
	sbci r19,-1	 ;  reg_pc.18,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.18
	sts reg_pc,r18	 ;  reg_pc, reg_pc.18
	cp r29,r25	 ;  tmp18, base
	breq .L84	 ; ,
	ldi r24,lo8(1)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
.L84:
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
	ret
	.size	addr_abx, .-addr_abx
	.section	.text.addr_aby,"ax",@progbits
.global	addr_aby
	.type	addr_aby, @function
addr_aby:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r24,reg_pc	 ; , reg_pc
	lds r25,reg_pc+1	 ; , reg_pc
	call mem_read_16	 ; 
	lds r18,reg_y	 ;  reg_y, reg_y
	movw r28,r24	 ;  address, base
	add r28,r18	 ;  address, reg_y
	adc r29,__zero_reg__	 ;  address
	lds r18,reg_pc	 ;  reg_pc.23, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.23, reg_pc
	subi r18,-2	 ;  reg_pc.23,
	sbci r19,-1	 ;  reg_pc.23,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.23
	sts reg_pc,r18	 ;  reg_pc, reg_pc.23
	cp r29,r25	 ;  tmp18, base
	breq .L86	 ; ,
	ldi r24,lo8(1)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
.L86:
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
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
	lds r24,reg_pc	 ;  reg_pc.24, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.24, reg_pc
	movw r18,r24	 ;  reg_pc.26, reg_pc.24
	subi r18,-1	 ;  reg_pc.26,
	sbci r19,-1	 ;  reg_pc.26,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.26
	sts reg_pc,r18	 ;  reg_pc, reg_pc.26
	call mem_read	 ; 
	lds r25,reg_x	 ;  index, reg_x
	add r25,r24	 ;  index,
	mov r24,r25	 ; , index
	ldi r25,0	 ; 
	jmp mem_read_16	 ; 
	.size	addr_inx, .-addr_inx
	.section	.text.addr_iny,"ax",@progbits
.global	addr_iny
	.type	addr_iny, @function
addr_iny:
	push r28	 ; 
	push r29	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r24,reg_pc	 ;  reg_pc.28, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.28, reg_pc
	movw r18,r24	 ;  reg_pc.30, reg_pc.28
	subi r18,-1	 ;  reg_pc.30,
	sbci r19,-1	 ;  reg_pc.30,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.30
	sts reg_pc,r18	 ;  reg_pc, reg_pc.30
	call mem_read	 ; 
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
	lds r24,reg_y	 ;  reg_y, reg_y
	movw r28,r18	 ;  address, D.3885
	add r28,r24	 ;  address, reg_y
	adc r29,__zero_reg__	 ;  address
	cp r29,r19	 ;  tmp24, D.3885
	breq .L89	 ; ,
	ldi r24,lo8(1)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
.L89:
	movw r24,r28	 ; , address
/* epilogue start */
	pop r29	 ; 
	pop r28	 ; 
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
	lds r24,reg_pc	 ; , reg_pc
	lds r25,reg_pc+1	 ; , reg_pc
	call mem_read_16	 ; 
	lds r18,reg_pc	 ;  reg_pc.33, reg_pc
	lds r19,reg_pc+1	 ;  reg_pc.33, reg_pc
	subi r18,-2	 ;  reg_pc.33,
	sbci r19,-1	 ;  reg_pc.33,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.33
	sts reg_pc,r18	 ;  reg_pc, reg_pc.33
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
	sts reg_pc+1,r25	 ;  reg_pc,
	sts reg_pc,r24	 ;  reg_pc,
	ret
	.size	cpu_reset, .-cpu_reset
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
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
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
	lds r30,reg_s	 ;  reg_s.59, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.61,
	add r25,r30	 ;  reg_s.61, reg_s.59
	sts reg_s,r25	 ;  reg_s, reg_s.61
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
	push r16	 ; 
	push r17	 ; 
	push r28	 ; 
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	lds r16,time_left	 ;  time_left.63, time_left
	lds r17,time_left+1	 ;  time_left.63, time_left
	lds r18,time_left+2	 ;  time_left.63, time_left
	lds r19,time_left+3	 ;  time_left.63, time_left
	add r16,r22	 ;  time_left.63, cycles
	adc r17,r23	 ;  time_left.63, cycles
	adc r18,r24	 ;  time_left.63, cycles
	adc r19,r25	 ;  time_left.63, cycles
	sts time_left,r16	 ;  time_left, time_left.63
	sts time_left+1,r17	 ;  time_left, time_left.63
	sts time_left+2,r18	 ;  time_left, time_left.63
	sts time_left+3,r19	 ;  time_left, time_left.63
	ldi r28,lo8(1)	 ;  D.4025,
.L96:
	lds r24,time_left	 ;  time_left, time_left
	lds r25,time_left+1	 ;  time_left, time_left
	lds r26,time_left+2	 ;  time_left, time_left
	lds r27,time_left+3	 ;  time_left, time_left
	cp __zero_reg__,r24	 ;  time_left
	cpc __zero_reg__,r25	 ;  time_left
	cpc __zero_reg__,r26	 ;  time_left
	cpc __zero_reg__,r27	 ;  time_left
	brlt .+4	 ; 
	jmp .L366	 ; 
	lds r24,reg_pc	 ;  reg_pc.64, reg_pc
	lds r25,reg_pc+1	 ;  reg_pc.64, reg_pc
	movw r18,r24	 ;  reg_pc.66, reg_pc.64
	subi r18,-1	 ;  reg_pc.66,
	sbci r19,-1	 ;  reg_pc.66,
	sts reg_pc+1,r19	 ;  reg_pc, reg_pc.66
	sts reg_pc,r18	 ;  reg_pc, reg_pc.66
	call mem_read	 ; 
	ldi r25,0	 ;  opcode
	movw r30,r24	 ;  tmp360,
	sbiw r30,1	 ;  tmp360,
	cpi r30,-1	 ;  tmp360,
	cpc r31,__zero_reg__	 ; 
	brsh .L97	 ; ,
	subi r30,lo8(-(gs(.L99)))	 ;  tmp360,
	sbci r31,hi8(-(gs(.L99)))	 ;  tmp360,
	jmp __tablejump2__
	.section	.progmem.gcc_sw_table.cpu_main,"a",@progbits
	.p2align	1
.L99:
	.word gs(.L98)
	.word gs(.L100)
	.word gs(.L101)
	.word gs(.L102)
	.word gs(.L103)
	.word gs(.L104)
	.word gs(.L105)
	.word gs(.L106)
	.word gs(.L107)
	.word gs(.L108)
	.word gs(.L109)
	.word gs(.L110)
	.word gs(.L111)
	.word gs(.L112)
	.word gs(.L113)
	.word gs(.L114)
	.word gs(.L115)
	.word gs(.L116)
	.word gs(.L117)
	.word gs(.L118)
	.word gs(.L119)
	.word gs(.L120)
	.word gs(.L121)
	.word gs(.L122)
	.word gs(.L123)
	.word gs(.L124)
	.word gs(.L125)
	.word gs(.L126)
	.word gs(.L127)
	.word gs(.L128)
	.word gs(.L129)
	.word gs(.L130)
	.word gs(.L131)
	.word gs(.L132)
	.word gs(.L133)
	.word gs(.L134)
	.word gs(.L135)
	.word gs(.L136)
	.word gs(.L137)
	.word gs(.L138)
	.word gs(.L139)
	.word gs(.L140)
	.word gs(.L141)
	.word gs(.L142)
	.word gs(.L143)
	.word gs(.L144)
	.word gs(.L145)
	.word gs(.L146)
	.word gs(.L147)
	.word gs(.L148)
	.word gs(.L149)
	.word gs(.L150)
	.word gs(.L151)
	.word gs(.L152)
	.word gs(.L153)
	.word gs(.L154)
	.word gs(.L155)
	.word gs(.L156)
	.word gs(.L157)
	.word gs(.L158)
	.word gs(.L159)
	.word gs(.L160)
	.word gs(.L161)
	.word gs(.L162)
	.word gs(.L163)
	.word gs(.L164)
	.word gs(.L165)
	.word gs(.L166)
	.word gs(.L167)
	.word gs(.L168)
	.word gs(.L169)
	.word gs(.L170)
	.word gs(.L171)
	.word gs(.L172)
	.word gs(.L173)
	.word gs(.L174)
	.word gs(.L175)
	.word gs(.L176)
	.word gs(.L177)
	.word gs(.L178)
	.word gs(.L179)
	.word gs(.L180)
	.word gs(.L181)
	.word gs(.L182)
	.word gs(.L183)
	.word gs(.L184)
	.word gs(.L185)
	.word gs(.L186)
	.word gs(.L187)
	.word gs(.L188)
	.word gs(.L189)
	.word gs(.L190)
	.word gs(.L191)
	.word gs(.L192)
	.word gs(.L193)
	.word gs(.L194)
	.word gs(.L195)
	.word gs(.L196)
	.word gs(.L197)
	.word gs(.L198)
	.word gs(.L199)
	.word gs(.L200)
	.word gs(.L201)
	.word gs(.L202)
	.word gs(.L203)
	.word gs(.L204)
	.word gs(.L205)
	.word gs(.L206)
	.word gs(.L207)
	.word gs(.L208)
	.word gs(.L209)
	.word gs(.L210)
	.word gs(.L211)
	.word gs(.L212)
	.word gs(.L213)
	.word gs(.L214)
	.word gs(.L215)
	.word gs(.L216)
	.word gs(.L217)
	.word gs(.L218)
	.word gs(.L219)
	.word gs(.L220)
	.word gs(.L221)
	.word gs(.L222)
	.word gs(.L223)
	.word gs(.L224)
	.word gs(.L225)
	.word gs(.L226)
	.word gs(.L227)
	.word gs(.L228)
	.word gs(.L229)
	.word gs(.L230)
	.word gs(.L231)
	.word gs(.L232)
	.word gs(.L233)
	.word gs(.L234)
	.word gs(.L235)
	.word gs(.L236)
	.word gs(.L237)
	.word gs(.L238)
	.word gs(.L239)
	.word gs(.L240)
	.word gs(.L241)
	.word gs(.L242)
	.word gs(.L243)
	.word gs(.L244)
	.word gs(.L245)
	.word gs(.L246)
	.word gs(.L247)
	.word gs(.L248)
	.word gs(.L249)
	.word gs(.L250)
	.word gs(.L251)
	.word gs(.L252)
	.word gs(.L253)
	.word gs(.L254)
	.word gs(.L255)
	.word gs(.L256)
	.word gs(.L257)
	.word gs(.L258)
	.word gs(.L259)
	.word gs(.L260)
	.word gs(.L261)
	.word gs(.L262)
	.word gs(.L263)
	.word gs(.L264)
	.word gs(.L265)
	.word gs(.L266)
	.word gs(.L267)
	.word gs(.L268)
	.word gs(.L269)
	.word gs(.L270)
	.word gs(.L271)
	.word gs(.L272)
	.word gs(.L273)
	.word gs(.L274)
	.word gs(.L275)
	.word gs(.L276)
	.word gs(.L277)
	.word gs(.L278)
	.word gs(.L279)
	.word gs(.L280)
	.word gs(.L281)
	.word gs(.L282)
	.word gs(.L283)
	.word gs(.L284)
	.word gs(.L285)
	.word gs(.L286)
	.word gs(.L287)
	.word gs(.L288)
	.word gs(.L289)
	.word gs(.L290)
	.word gs(.L291)
	.word gs(.L292)
	.word gs(.L293)
	.word gs(.L294)
	.word gs(.L295)
	.word gs(.L296)
	.word gs(.L297)
	.word gs(.L298)
	.word gs(.L299)
	.word gs(.L300)
	.word gs(.L301)
	.word gs(.L302)
	.word gs(.L303)
	.word gs(.L304)
	.word gs(.L305)
	.word gs(.L306)
	.word gs(.L307)
	.word gs(.L308)
	.word gs(.L309)
	.word gs(.L310)
	.word gs(.L311)
	.word gs(.L312)
	.word gs(.L313)
	.word gs(.L314)
	.word gs(.L315)
	.word gs(.L316)
	.word gs(.L317)
	.word gs(.L318)
	.word gs(.L319)
	.word gs(.L320)
	.word gs(.L321)
	.word gs(.L322)
	.word gs(.L323)
	.word gs(.L324)
	.word gs(.L325)
	.word gs(.L326)
	.word gs(.L327)
	.word gs(.L328)
	.word gs(.L329)
	.word gs(.L330)
	.word gs(.L331)
	.word gs(.L332)
	.word gs(.L333)
	.word gs(.L334)
	.word gs(.L335)
	.word gs(.L336)
	.word gs(.L337)
	.word gs(.L338)
	.word gs(.L339)
	.word gs(.L340)
	.word gs(.L341)
	.word gs(.L342)
	.word gs(.L343)
	.word gs(.L344)
	.word gs(.L345)
	.word gs(.L346)
	.word gs(.L347)
	.word gs(.L348)
	.word gs(.L349)
	.word gs(.L350)
	.word gs(.L351)
	.word gs(.L352)
	.word gs(.L353)
	.section	.text.cpu_main
.L97:
	ldi r24,lo8(-2)	 ; ,
	ldi r25,lo8(-1)	 ; ,
	call mem_read_16	 ; 
	call cpu6502_JSR	 ; 
	call update_p	 ; 
	lds r24,reg_p	 ;  reg_p.67, reg_p
	lds r30,reg_s	 ;  reg_s.68, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.70,
	add r25,r30	 ;  reg_s.70, reg_s.68
	sts reg_s,r25	 ;  reg_s, reg_s.70
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp364,
	sbci r31,hi8(-(ram+256))	 ;  tmp364,
	mov r25,r24	 ;  D.4021, reg_p.67
	ori r25,lo8(16)	 ;  D.4021,
	st Z,r25	 ;  *_884, D.4021
	ori r24,lo8(4)	 ;  reg_p.57,
	sts reg_p,r24	 ;  reg_p, reg_p.57
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L98:
	call addr_inx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L100:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L101:
	call addr_inx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L102:
	call addr_zpg	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L103:
	call addr_zpg	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L104:
	call addr_zpg	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L105:
	call addr_zpg	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L106:
	call cpu6502_PHP	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L107:
	call addr_imm	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L108:
	lds r24,reg_a	 ;  reg_a.71, reg_a
	mov r25,r24	 ;  flag_c.72, reg_a.71
	rol r25	 ;  flag_c.72
	clr r25	 ;  flag_c.72
	rol r25	 ;  flag_c.72
	sts flag_c,r25	 ;  flag_c, flag_c.72
	ldi r25,0	 ;  D.4024
	lsl r24	 ;  D.4024
	rol r25	 ;  D.4024
	sts flag_z,r24	 ;  flag_z, D.4024
	sts flag_n,r24	 ;  flag_n, D.4024
	sts reg_a,r24	 ;  reg_a, D.4024
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L109:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	lds r24,reg_a	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	sts flag_c,r24	 ;  flag_c, D.4025
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L110:
	call addr_abs	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L111:
	call addr_abs	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L112:
	call addr_abs	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L113:
	call addr_abs	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L114:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	lds r24,flag_n	 ;  tmp374, flag_n
	com r24	 ;  tmp374
	rol r24	 ; 
	clr r24	 ; 
	rol r24	 ; 
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L115:
	call addr_iny	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L116:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L117:
	call addr_iny	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L118:
	call addr_zpx	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L119:
	call addr_zpx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L120:
	call addr_zpx	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L121:
	call addr_zpx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L122:
	sts flag_c,__zero_reg__	 ;  flag_c,
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L123:
	call addr_aby	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L124:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L125:
	call addr_aby	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L126:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L127:
	call addr_abx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L128:
	call addr_abx	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L129:
	call addr_abx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L130:
	call addr_abs	 ; 
	call cpu6502_JSR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L131:
	call addr_inx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L132:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L133:
	call addr_inx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L134:
	call addr_zpg	 ; 
	call cpu6502_BIT	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L135:
	call addr_zpg	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L136:
	call addr_zpg	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L137:
	call addr_zpg	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L138:
	call cpu6502_PLP	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L139:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L140:
	lds r25,reg_a	 ;  reg_a.91, reg_a
	mov r24,r25	 ;  result, reg_a.91
	lsl r24	 ;  result
	lds r18,flag_c	 ;  flag_c, flag_c
	or r24,r18	 ;  result, flag_c
	rol r25	 ;  flag_c.94
	clr r25	 ;  flag_c.94
	rol r25	 ;  flag_c.94
	sts flag_c,r25	 ;  flag_c, flag_c.94
	sts flag_z,r24	 ;  flag_z, result
	sts flag_n,r24	 ;  flag_n, result
	sts reg_a,r24	 ;  reg_a, result
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L141:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	lds r24,reg_a	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	sts flag_c,r24	 ;  flag_c, D.4025
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L142:
	call addr_abs	 ; 
	call cpu6502_BIT	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L143:
	call addr_abs	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L144:
	call addr_abs	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L145:
	call addr_abs	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L146:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	lds r24,flag_n	 ;  flag_n, flag_n
	andi r24,lo8(-128)	 ; ,
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L147:
	call addr_iny	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L148:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L149:
	call addr_iny	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L150:
	call addr_zpx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L151:
	call addr_zpx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L152:
	call addr_zpx	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L153:
	call addr_zpx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L154:
	sts flag_c,r28	 ;  flag_c, D.4025
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L155:
	call addr_aby	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L156:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L157:
	call addr_aby	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L158:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L159:
	call addr_abx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L160:
	call addr_abx	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L161:
	call addr_abx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L162:
	call cpu6502_PLP	 ; 
	call cpu6502_RTS	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L163:
	call addr_inx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L164:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L165:
	call addr_inx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L166:
	call addr_zpg	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L167:
	call addr_zpg	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L168:
	call addr_zpg	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L169:
	call addr_zpg	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L170:
	lds r24,reg_a	 ;  reg_a.116, reg_a
	lds r30,reg_s	 ;  reg_s.117, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.119,
	add r25,r30	 ;  reg_s.119, reg_s.117
	sts reg_s,r25	 ;  reg_s, reg_s.119
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp389,
	sbci r31,hi8(-(ram+256))	 ;  tmp389,
	st Z,r24	 ;  *_920, reg_a.116
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L171:
	call addr_imm	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L172:
	call cpu6502_LSR_a	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L173:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	call cpu6502_LSR_a	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L174:
	call addr_abs	 ; 
	sts reg_pc+1,r25	 ;  reg_pc,
	sts reg_pc,r24	 ;  reg_pc,
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L175:
	call addr_abs	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L176:
	call addr_abs	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L177:
	call addr_abs	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L178:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	lds r24,reg_p	 ;  reg_p, reg_p
	bst r24,6	 ;  reg_p,
	clr r24	 ;  tmp392
	bld r24,0	 ;  tmp392
	eor r24,r28	 ; , D.4025
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L179:
	call addr_iny	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L180:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L181:
	call addr_iny	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L182:
	call addr_zpx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L183:
	call addr_zpx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L184:
	call addr_zpx	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L185:
	call addr_zpx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L186:
	lds r24,reg_p	 ;  reg_p.127, reg_p
	andi r24,lo8(-5)	 ;  reg_p.127,
	sts reg_p,r24	 ;  reg_p, reg_p.127
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L187:
	call addr_aby	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L188:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L189:
	call addr_aby	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L190:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L191:
	call addr_abx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L192:
	call addr_abx	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L193:
	call addr_abx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L194:
	call cpu6502_RTS	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L195:
	call addr_inx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L196:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L197:
	call addr_inx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L198:
	call addr_zpg	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L199:
	call addr_zpg	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L200:
	call addr_zpg	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L201:
	call addr_zpg	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L202:
	lds r30,reg_s	 ;  reg_s.145, reg_s
	subi r30,lo8(-(1))	 ;  reg_s.145,
	sts reg_s,r30	 ;  reg_s, reg_s.145
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp400,
	sbci r31,hi8(-(ram+256))	 ;  tmp400,
	ld r24,Z	 ;  D.4026, *_931
	sts flag_z,r24	 ;  flag_z, D.4026
	sts flag_n,r24	 ;  flag_n, D.4026
	sts reg_a,r24	 ;  reg_a, D.4026
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L203:
	call addr_imm	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L204:
	lds r18,reg_a	 ;  reg_a.149, reg_a
	lds r24,flag_c	 ;  flag_c, flag_c
	ldi r19,lo8(-128)	 ; ,
	mul r24,r19	 ;  flag_c,
	movw r24,r0	 ;  D.4024
	clr __zero_reg__
	mov r25,r18	 ;  result, reg_a.149
	lsr r25	 ;  result
	or r25,r24	 ;  result, D.4024
	andi r18,lo8(1)	 ;  flag_c.151,
	sts flag_c,r18	 ;  flag_c, flag_c.151
	sts flag_z,r25	 ;  flag_z, result
	sts flag_n,r25	 ;  flag_n, result
	sts reg_a,r25	 ;  reg_a, result
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L205:
	call cpu6502_JAM	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L206:
	call addr_ind	 ; 
	sts reg_pc+1,r25	 ;  reg_pc,
	sts reg_pc,r24	 ;  reg_pc,
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L207:
	call addr_abs	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L208:
	call addr_abs	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L209:
	call addr_abs	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L210:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	lds r24,reg_p	 ;  reg_p, reg_p
	andi r24,lo8(64)	 ; ,
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L211:
	call addr_iny	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L212:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L213:
	call addr_iny	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L214:
	call addr_zpx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L215:
	call addr_zpx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L216:
	call addr_zpx	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L217:
	call addr_zpx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L218:
	lds r24,reg_p	 ;  reg_p.57, reg_p
	ori r24,lo8(4)	 ;  reg_p.57,
	sts reg_p,r24	 ;  reg_p, reg_p.57
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L219:
	call addr_aby	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L220:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L221:
	call addr_aby	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L222:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L223:
	call addr_abx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L224:
	call addr_abx	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L225:
	call addr_abx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L226:
	call addr_imm	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L227:
	call addr_inx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L228:
	call addr_imm	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L229:
	call addr_inx	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L230:
	call addr_zpg	 ; 
	lds r22,reg_y	 ; , reg_y
	call mem_write	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L231:
	call addr_zpg	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L232:
	call addr_zpg	 ; 
	lds r22,reg_x	 ; , reg_x
	call mem_write	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L233:
	call addr_zpg	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L234:
	lds r24,reg_y	 ;  flag_z.170, reg_y
	subi r24,lo8(-(-1))	 ;  flag_z.170,
	sts flag_z,r24	 ;  flag_z, flag_z.170
	sts flag_n,r24	 ;  flag_n, flag_z.170
	sts reg_y,r24	 ;  reg_y, flag_z.170
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L235:
	call addr_imm	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L236:
	lds r24,reg_x	 ;  reg_x.173, reg_x
	sts flag_z,r24	 ;  flag_z, reg_x.173
	sts flag_n,r24	 ;  flag_n, reg_x.173
	sts reg_a,r24	 ;  reg_a, reg_x.173
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L237:
	call cpu6502_JAM	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L238:
	call addr_abs	 ; 
	lds r22,reg_y	 ; , reg_y
	call mem_write	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L239:
	call addr_abs	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L240:
	call addr_abs	 ; 
	lds r22,reg_x	 ; , reg_x
	call mem_write	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L241:
	call addr_abs	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L242:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	ldi r24,lo8(1)	 ;  D.4025,
	lds r25,flag_c	 ;  flag_c, flag_c
	cpse r25,__zero_reg__	 ;  flag_c
	ldi r24,0	 ;  D.4025
.L355:
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L243:
	call addr_iny	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L244:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L245:
	call addr_iny	 ; 
	call cpu6502_SHA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L246:
	call addr_zpx	 ; 
	lds r22,reg_y	 ; , reg_y
	call mem_write	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L247:
	call addr_zpx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L248:
	call addr_zpy	 ; 
	lds r22,reg_x	 ; , reg_x
	call mem_write	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L249:
	call addr_zpy	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L250:
	lds r24,reg_y	 ;  reg_y.181, reg_y
	sts flag_z,r24	 ;  flag_z, reg_y.181
	sts flag_n,r24	 ;  flag_n, reg_y.181
	sts reg_a,r24	 ;  reg_a, reg_y.181
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L251:
	call addr_aby	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L252:
	lds r24,reg_x	 ;  reg_x, reg_x
	sts reg_s,r24	 ;  reg_s, reg_x
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L253:
	call cpu6502_JAM	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L254:
	call addr_abx	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	lds r18,reg_y	 ;  reg_y, reg_y
	and r22,r18	 ;  D.4021, reg_y
	call mem_write	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L255:
	call addr_abx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L256:
	call addr_aby	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	lds r18,reg_x	 ;  reg_x, reg_x
	and r22,r18	 ;  D.4021, reg_x
	call mem_write	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L257:
	call addr_aby	 ; 
	call cpu6502_SHA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L258:
	call addr_imm	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L259:
	call addr_inx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L260:
	call addr_imm	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L261:
	call addr_inx	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L262:
	call addr_zpg	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L263:
	call addr_zpg	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L264:
	call addr_zpg	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L265:
	call addr_zpg	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L266:
	lds r24,reg_a	 ;  reg_a.190, reg_a
	sts flag_z,r24	 ;  flag_z, reg_a.190
	sts flag_n,r24	 ;  flag_n, reg_a.190
	sts reg_y,r24	 ;  reg_y, reg_a.190
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L267:
	call addr_imm	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L268:
	lds r24,reg_a	 ;  reg_a.193, reg_a
	sts flag_z,r24	 ;  flag_z, reg_a.193
	sts flag_n,r24	 ;  flag_n, reg_a.193
	sts reg_x,r24	 ;  reg_x, reg_a.193
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L269:
	call cpu6502_JAM	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L270:
	call addr_abs	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L271:
	call addr_abs	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L272:
	call addr_abs	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L273:
	call addr_abs	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L274:
	call addr_imm	 ; 
	movw r22,r24	 ; , D.4020
	lds r24,flag_c	 ; , flag_c
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L275:
	call addr_iny	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L276:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L277:
	call addr_iny	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L278:
	call addr_zpx	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L279:
	call addr_zpx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L280:
	call addr_zpy	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L281:
	call addr_zpy	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L282:
	lds r24,reg_p	 ;  reg_p.198, reg_p
	andi r24,lo8(-65)	 ;  reg_p.198,
	sts reg_p,r24	 ;  reg_p, reg_p.198
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L283:
	call addr_aby	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L284:
	lds r24,reg_s	 ;  reg_s.199, reg_s
	sts flag_z,r24	 ;  flag_z, reg_s.199
	sts flag_n,r24	 ;  flag_n, reg_s.199
	sts reg_x,r24	 ;  reg_x, reg_s.199
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L285:
	call cpu6502_JAM	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L286:
	call addr_abx	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L287:
	call addr_abx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L288:
	call addr_aby	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L289:
	call addr_aby	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L290:
	call addr_imm	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L291:
	call addr_inx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L292:
	call addr_imm	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L293:
	call addr_inx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L294:
	call addr_zpg	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L295:
	call addr_zpg	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L296:
	call addr_zpg	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L297:
	call addr_zpg	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L298:
	lds r24,reg_y	 ;  flag_z.216, reg_y
	subi r24,lo8(-(1))	 ;  flag_z.216,
	sts flag_z,r24	 ;  flag_z, flag_z.216
	sts flag_n,r24	 ;  flag_n, flag_z.216
	sts reg_y,r24	 ;  reg_y, flag_z.216
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L299:
	call addr_imm	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L300:
	lds r24,reg_x	 ;  flag_z.220, reg_x
	subi r24,lo8(-(-1))	 ;  flag_z.220,
	sts flag_z,r24	 ;  flag_z, flag_z.220
	sts flag_n,r24	 ;  flag_n, flag_z.220
	sts reg_x,r24	 ;  reg_x, flag_z.220
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L301:
	call addr_imm	 ; 
	call mem_read	 ; 
	lds r25,reg_x	 ;  D.4021, reg_x
	lds r18,reg_a	 ;  reg_a, reg_a
	and r25,r18	 ;  D.4021, reg_a
	ldi r18,lo8(1)	 ;  D.4025,
	cp r25,r24	 ;  D.4021, data
	brsh .L356	 ; ,
	ldi r18,0	 ;  D.4025
.L356:
	sts flag_c,r18	 ;  flag_c, D.4025
	sub r25,r24	 ;  flag_z.226, data
	sts flag_z,r25	 ;  flag_z, flag_z.226
	sts flag_n,r25	 ;  flag_n, flag_z.226
	sts reg_x,r25	 ;  reg_x, flag_z.226
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L302:
	call addr_abs	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L303:
	call addr_abs	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L304:
	call addr_abs	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L305:
	call addr_abs	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L306:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	ldi r24,lo8(1)	 ;  D.4025,
	lds r25,flag_z	 ;  flag_z, flag_z
	cpse r25,__zero_reg__	 ;  flag_z,
	rjmp .L357	 ; 
	ldi r24,0	 ;  D.4025
.L357:
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L307:
	call addr_iny	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L308:
	call cpu6502_JAM	 ; 
	rjmp .L96	 ; 
.L309:
	call addr_iny	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L310:
	call addr_zpx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L311:
	call addr_zpx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	rjmp .L96	 ; 
.L312:
	call addr_zpx	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L313:
	call addr_zpx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L314:
	lds r24,reg_p	 ;  reg_p.234, reg_p
	andi r24,lo8(-9)	 ;  reg_p.234,
	sts reg_p,r24	 ;  reg_p, reg_p.234
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L315:
	call addr_aby	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L316:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L317:
	call addr_aby	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L318:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L319:
	call addr_abx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L320:
	call addr_abx	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L321:
	call addr_abx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L322:
	call addr_imm	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L323:
	call addr_inx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L324:
	call addr_imm	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L325:
	call addr_inx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L326:
	call addr_zpg	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L327:
	call addr_zpg	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(3)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L328:
	call addr_zpg	 ; 
	call cpu6502_INC	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L329:
	call addr_zpg	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L330:
	lds r24,reg_x	 ;  flag_z.240, reg_x
	subi r24,lo8(-(1))	 ;  flag_z.240,
	sts flag_z,r24	 ;  flag_z, flag_z.240
	sts flag_n,r24	 ;  flag_n, flag_z.240
	sts reg_x,r24	 ;  reg_x, flag_z.240
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L331:
	call addr_imm	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L332:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L333:
	call addr_imm	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L334:
	call addr_abs	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L335:
	call addr_abs	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L336:
	call addr_abs	 ; 
	call cpu6502_INC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L337:
	call addr_abs	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L338:
	call addr_imm	 ; 
	movw r22,r24	 ;  D.4020,
	ldi r24,lo8(1)	 ;  D.4025,
	lds r25,flag_z	 ;  flag_z, flag_z
	cpse r25,__zero_reg__	 ;  flag_z
	ldi r24,0	 ;  D.4025
.L358:
	call cpu6502_branch	 ; 
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L339:
	call addr_iny	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(5)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L340:
	call cpu6502_JAM	 ; 
	jmp .L96	 ; 
.L341:
	call addr_iny	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(8)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L342:
	call addr_zpx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L343:
	call addr_zpx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L344:
	call addr_zpx	 ; 
	call cpu6502_INC	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L345:
	call addr_zpx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(6)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L346:
	lds r24,reg_p	 ;  reg_p.247, reg_p
	ori r24,lo8(8)	 ;  reg_p.247,
	sts reg_p,r24	 ;  reg_p, reg_p.247
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L347:
	call addr_aby	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L348:
	ldi r24,lo8(2)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L349:
	call addr_aby	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L350:
	call addr_abx	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L351:
	call addr_abx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,lo8(4)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L352:
	call addr_abx	 ; 
	call cpu6502_INC	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L353:
	call addr_abx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,lo8(7)	 ; ,
	ldi r25,0	 ; 
	call clock_advance	 ; 
	jmp .L96	 ; 
.L366:
/* epilogue start */
	pop r28	 ; 
	pop r17	 ; 
	pop r16	 ; 
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
