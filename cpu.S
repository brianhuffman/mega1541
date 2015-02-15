	.file	"cpu.S"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1

#define rPC0 r28
#define rPC1 r29
#define rA r4
#define rX r5
#define rY r6
#define rS r7
#define rP r8
#define rN r9
#define rZ r10
#define rC r11
#define rTIME0 r12
#define rTIME1 r13
#define rTIME2 r14
#define rTIME3 r15

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
	sub rTIME0,r24	 ;  time_left.20, D.3675
	sbc rTIME1,__zero_reg__	 ;  time_left.20, D.3675
	sbc rTIME2,__zero_reg__	 ;  time_left.20, D.3675
	sbc rTIME3,__zero_reg__	 ;  time_left.20, D.3675
	ret
	.size	clock_advance, .-clock_advance
	.section	.text.cpu6502_PLP,"ax",@progbits
	.type	cpu6502_PLP, @function
cpu6502_PLP:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	inc rS
	mov r30,rS	 ;  reg_s.86, reg_s
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp55,
	sbci r31,hi8(-(ram+256))	 ;  tmp55,
	ld r24,Z	 ;  D.3681, *_14
	mov rP,r24	 ;  reg_p, D.3681
	mov rN,r24	 ;  flag_n, D.3681
	bst r24,1	 ;  D.3681,
	clr rZ	 ;  D.3678
	bld rZ,0	 ;  D.3678
	ldi r18,lo8(1)	 ;  tmp58,
	eor rZ,r18	 ;  D.3678, tmp58
	andi r24,lo8(1)	 ;  flag_c.90,
	mov rC,r24	 ;  flag_c, flag_c.90
	ret
	.size	cpu6502_PLP, .-cpu6502_PLP
	.section	.text.cpu6502_JSR,"ax",@progbits
	.type	cpu6502_JSR, @function
cpu6502_JSR:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,rPC0	 ;  PC -= 1
	subi r18,1	 ;
	sbc r19,__zero_reg__	 ;
	mov r30,rS	 ;  reg_s.38, reg_s
	mov r26,rS	 ;  tmp60, reg_s
	ldi r27,0	 ; 
	subi r26,lo8(-(ram+256))	 ;  tmp60,
	sbci r27,hi8(-(ram+256))	 ;  tmp60,
	st X,r19	 ;  stack[S] = PC
	ldi r19,lo8(-2)	 ;  S -= 2
	add r19,rS	 ;  reg_s.42, reg_s.38
	mov rS,r19	 ;  reg_s, reg_s.42
	subi r30,lo8(-(-1))	 ;  reg_s.40,
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp66,
	sbci r31,hi8(-(ram+256))	 ;  tmp66,
	st Z,r18	 ;  *_22, reg_pc.37
	movw rPC0,r24	 ;  reg_pc, address
	ret
	.size	cpu6502_JSR, .-cpu6502_JSR
	.section	.text.cpu6502_RTS,"ax",@progbits
	.type	cpu6502_RTS, @function
cpu6502_RTS:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r30,rS	 ;  reg_s.136, reg_s
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
	mov rS,r18	 ;  reg_s, D.3693
	adiw r24,1	 ;  reg_pc.143,
	mov rPC1,r25	 ;  reg_pc, reg_pc.143
	mov rPC0,r24	 ;  reg_pc, reg_pc.143
	ret
	.size	cpu6502_RTS, .-cpu6502_RTS
	.section	.text.cpu6502_LSR_a,"ax",@progbits
	.type	cpu6502_LSR_a, @function
cpu6502_LSR_a:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	bst rA,0
	bld rC,0
	lsr rA
	mov rZ,rA
	mov rN,rA
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
	or rA,r24	 ;  A |= data
	mov rZ,rA
	mov rN,rA
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
	mov r18,rP	 ;  reg_p.101, reg_p
	andi r18,lo8(-65)	 ;  reg_p.101,
	or r25,r18	 ;  D.3706, reg_p.101
	mov rP,r25	 ;  reg_p, D.3706
	mov rN,r24	 ;  flag_n, data
	mov r25,rA	 ;  flag_z.106, reg_a
	and r25,r24	 ;  flag_z.106, data
	mov rZ,r25	 ;  flag_z, flag_z.106
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
	mov r16,rA	 ;  reg_a.107, reg_a
	call mem_read	 ; 
	and r24,r16	 ;  flag_z.108, reg_a.107
	mov rZ,r24	 ;  flag_z, flag_z.108
	mov rN,r24	 ;  flag_n, flag_z.108
	mov rA,r24	 ;  reg_a, flag_z.108
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
	mov r16,rA	 ;  reg_a.128, reg_a
	call mem_read	 ; 
	eor r24,r16	 ;  flag_z.129, reg_a.128
	mov rZ,r24	 ;  flag_z, flag_z.129
	mov rN,r24	 ;  flag_n, flag_z.129
	mov rA,r24	 ;  reg_a, flag_z.129
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
	call mem_read	 ; 
	mov r25,rP	 ;  reg_p.156, reg_p
	mov r30,rA	 ;  reg_a.157, reg_a
	mov r26,rC	 ;  flag_c, flag_c
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
	mov rZ,r18	 ;  flag_z, total
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
	mov rN,r18	 ;  flag_n, total
	eor r24,r18	 ;  D.3728, total
	eor r30,r18	 ;  D.3728, total
	and r24,r30	 ;  D.3728, D.3728
	sbrc r24,7	 ;  D.3728,
	ori r31,lo8(64)	 ;  reg_p.161,
.L20:
	mov rP,r31	 ;  reg_p, reg_p.161
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
	mov rC,r24	 ;  flag_c, D.3731
	rjmp .L18	 ; 
.L11:
	mov r20,r30	 ;  total, reg_a.157
	ldi r21,0	 ;  total
	add r20,r26	 ;  total, flag_c
	adc r21,__zero_reg__	 ;  total
	add r20,r22	 ;  total, D.3729
	adc r21,r23	 ;  total, D.3729
	mov rC,r21	 ;  flag_c, total
	mov r18,r20	 ;  result, total
	mov rZ,r20	 ;  flag_z, total
	mov rN,r20	 ;  flag_n, total
	eor r24,r20	 ;  D.3728, total
	eor r20,r30	 ;  D.3728, reg_a.157
	and r24,r20	 ;  D.3728, D.3728
	sbrc r24,7	 ;  D.3728,
	ori r31,lo8(64)	 ;  reg_p.161,
.L21:
	mov rP,r31	 ;  reg_p, reg_p.161
.L18:
	mov rA,r18	 ;  reg_a, result
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
	mov rZ,r24	 ;  flag_z, flag_z.202
	mov rN,r24	 ;  flag_n, flag_z.202
	mov rY,r24	 ;  reg_y, flag_z.202
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
	mov rZ,r24	 ;  flag_z, flag_z.205
	mov rN,r24	 ;  flag_n, flag_z.205
	mov rA,r24	 ;  reg_a, flag_z.205
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
	mov rZ,r24	 ;  flag_z, flag_z.208
	mov rN,r24	 ;  flag_n, flag_z.208
	mov rX,r24	 ;  reg_x, flag_z.208
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
	mov rZ,r24	 ;  flag_z, flag_z.211
	mov rN,r24	 ;  flag_n, flag_z.211
	mov rX,r24	 ;  reg_x, flag_z.211
	mov rA,r24	 ;  reg_a, flag_z.211
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
	mov r25,rX	 ;  reg_x.243, reg_x
	ldi r18,lo8(1)	 ;  D.3747,
	cp r25,r24	 ;  reg_x.243, D.3746
	brsh .L28	 ; ,
	ldi r18,0	 ;  D.3747
.L28:
	mov rC,r18	 ;  flag_c, D.3747
	sub r25,r24	 ;  reg_x.243, D.3746
	mov rZ,r25	 ;  flag_z, flag_z.231
	mov rN,r25	 ;  flag_n, flag_z.231
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
	mov r21,rP	 ;  reg_p.249, reg_p
	mov r20,rA	 ;  reg_a.250, reg_a
	mov r18,rC	 ;  flag_c, flag_c
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
	mov rZ,r25	 ;  flag_z, result
	mov rN,r25	 ;  flag_n, result
	andi r21,lo8(-66)	 ;  reg_p.253,
	mov r18,r25	 ;  D.3761, result
	eor r18,r20	 ;  D.3761, reg_a.250
	eor r20,r24	 ;  D.3761, D.3761
	and r18,r20	 ;  D.3761, D.3761
	sbrc r18,7	 ;  D.3761,
	ori r21,lo8(64)	 ;  reg_p.254,
.L37:
	mov rP,r21	 ;  reg_p, reg_p.254
	mov rC,__zero_reg__	 ;  flag_c,
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
	mov rC,r19	 ;  flag_c, total
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
	mov rP,r22	 ;  reg_p, reg_p.254
	mov rZ,r18	 ;  flag_z, total
	mov rN,r18	 ;  flag_n, total
.L34:
	mov rA,r25	 ;  reg_a, result
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
	mov rC,r25	 ;  flag_c, flag_c.81
	mov r22,r24	 ;  flag_z.82, data
	lsl r22	 ;  flag_z.82
	mov rZ,r22	 ;  flag_z, flag_z.82
	mov rN,r22	 ;  flag_n, flag_z.82
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
	mov r25,rC	 ;  flag_c, flag_c
	or r22,r25	 ;  result, flag_c
	rol r24	 ;  flag_c.113
	clr r24	 ;  flag_c.113
	rol r24	 ;  flag_c.113
	mov rC,r24	 ;  flag_c, flag_c.113
	mov rZ,r22	 ;  flag_z, result
	mov rN,r22	 ;  flag_n, result
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
	mov rC,r25	 ;  flag_c, flag_c.132
	mov r22,r24	 ;  flag_z.133, data
	lsr r22	 ;  flag_z.133
	mov rZ,r22	 ;  flag_z, flag_z.133
	mov rN,r22	 ;  flag_n, flag_z.133
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
	mov r18,rC	 ;  flag_c, flag_c
	ldi r25,lo8(-128)	 ; ,
	mul r18,r25	 ;  flag_c,
	movw r18,r0	 ;  D.3782
	clr __zero_reg__
	or r22,r18	 ;  result, D.3782
	andi r24,lo8(1)	 ;  flag_c.166,
	mov rC,r24	 ;  flag_c, flag_c.166
	mov rZ,r22	 ;  flag_z, result
	mov rN,r22	 ;  flag_n, result
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
	mov r22,rX	 ;  D.3787, reg_x
	and r22,rA	 ;  D.3787, reg_a
	jmp mem_write	 ; 
	.size	cpu6502_SAX, .-cpu6502_SAX
	.section	.text.cpu6502_STA,"ax",@progbits
	.type	cpu6502_STA, @function
cpu6502_STA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,rA	 ; , reg_a
	jmp mem_write	 ; 
	.size	cpu6502_STA, .-cpu6502_STA
	.section	.text.cpu6502_SHA,"ax",@progbits
	.type	cpu6502_SHA, @function
cpu6502_SHA:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r22,rX	 ;  D.3792, reg_x
	mov r18,rA	 ;  reg_a, reg_a
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
	mov rZ,r22	 ;  flag_z, flag_z.236
	mov rN,r22	 ;  flag_n, flag_z.236
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
	mov rZ,r22	 ;  flag_z, flag_z.258
	mov rN,r22	 ;  flag_n, flag_z.258
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
	mov r24,rPC0	 ;  reg_pc.245, reg_pc
	mov r25,rPC1	 ;  reg_pc.245, reg_pc
	sbiw r24,1	 ;  reg_pc.245,
	mov rPC1,r25	 ;  reg_pc, reg_pc.245
	mov rPC0,r24	 ;  reg_pc, reg_pc.245
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
	mov r24,rP	 ;  reg_p.48, reg_p
	andi r24,lo8(108)	 ;  reg_p.48,
	mov r25,r24	 ;  reg_p.49, reg_p.48
	ori r25,lo8(32)	 ;  reg_p.49,
	mov rP,r25	 ;  reg_p, reg_p.49
	mov r25,rN	 ;  flag_n, flag_n
	sbrs r25,7	 ;  flag_n,
	rjmp .L55	 ; 
	ori r24,lo8(-96)	 ;  reg_p.50,
	mov rP,r24	 ;  reg_p, reg_p.50
.L55:
	mov r24,rZ	 ;  flag_z, flag_z
	cpse r24,__zero_reg__	 ;  flag_z,
	rjmp .L56	 ; 
	mov r24,rP	 ;  reg_p.51, reg_p
	ori r24,lo8(2)	 ;  reg_p.51,
	mov rP,r24	 ;  reg_p, reg_p.51
.L56:
	mov r24,rC	 ;  flag_c, flag_c
	tst r24	 ;  flag_c
	breq .L54	 ; ,
	mov r24,rP	 ;  reg_p.53, reg_p
	ori r24,lo8(1)	 ;  reg_p.53,
	mov rP,r24	 ;  reg_p, reg_p.53
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
	mov r24,rP	 ;  reg_p.43, reg_p
	mov r30,rS	 ;  reg_s.44, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.46,
	add r25,r30	 ;  reg_s.46, reg_s.44
	mov rS,r25	 ;  reg_s, reg_s.46
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp51,
	sbci r31,hi8(-(ram+256))	 ;  tmp51,
	st Z,r24	 ;  *_10, reg_p.43
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
	mov r25,rY	 ;  reg_y.229, reg_y
	ldi r18,lo8(1)	 ;  D.3838,
	cp r25,r24	 ;  reg_y.229, D.3837
	brsh .L74	 ; ,
	ldi r18,0	 ;  D.3838
.L74:
	mov rC,r18	 ;  flag_c, D.3838
	sub r25,r24	 ;  reg_y.229, D.3837
	mov rZ,r25	 ;  flag_z, flag_z.231
	mov rN,r25	 ;  flag_n, flag_z.231
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
	mov r25,rA	 ;  reg_a.235, reg_a
	ldi r18,lo8(1)	 ;  D.3846,
	cp r25,r24	 ;  reg_a.235, D.3845
	brsh .L76	 ; ,
	ldi r18,0	 ;  D.3846
.L76:
	mov rC,r18	 ;  flag_c, D.3846
	sub r25,r24	 ;  reg_a.235, D.3845
	mov rZ,r25	 ;  flag_z, flag_z.231
	mov rN,r25	 ;  flag_n, flag_z.231
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
	.section	.text.addr_imm,"ax",@progbits
.global	addr_imm
	.type	addr_imm, @function
addr_imm:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r24,rPC0	 ;  reg_pc.0, reg_pc
	adiw rPC0,1	 ;  PC++
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
	movw r24,rPC0	 ;  reg_pc.3, reg_pc
	adiw rPC0,1	 ;  PC++
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
	movw r24,rPC0	 ; , reg_pc
	call mem_read_16	 ; 
	adiw rPC0,2	 ;  PC += 2
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
	movw r24,rPC0	 ;  reg_pc.8, reg_pc
	adiw rPC0,1	 ;  PC++
	call mem_read	 ; 
	add r24,rX
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
	movw r24,rPC0	 ;  reg_pc.12, reg_pc
	adiw rPC0,1	 ;  PC++
	call mem_read	 ; 
	add r24,rY
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
	movw r24,rPC0	 ; , reg_pc
	call mem_read_16	 ; 
	mov r18,rX	 ;  reg_x, reg_x
	movw r16,r24	 ;  address, base
	add r16,r18	 ;  address, reg_x
	adc r17,__zero_reg__	 ;  address
	adiw rPC0,2	 ;  PC += 2
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
	movw r24,rPC0	 ; , reg_pc
	call mem_read_16	 ; 
	mov r18,rY	 ;  reg_y, reg_y
	movw r16,r24	 ;  address, base
	add r16,r18	 ;  address, reg_y
	adc r17,__zero_reg__	 ;  address
	adiw rPC0,2	 ;  PC += 2
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
	movw r24,rPC0	 ;  reg_pc.24, reg_pc
	adiw rPC0,1	 ;  PC++
	call mem_read	 ; 
	add r24,rX	 ;  index,
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
	movw r24,rPC0	 ;  reg_pc.28, reg_pc
	adiw rPC0,1	 ;  PC++
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
	mov r24,rY	 ;  reg_y, reg_y
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
	movw r24,rPC0	 ; , reg_pc
	call mem_read_16	 ; 
	adiw rPC0,2	 ;  PC += 2
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
	movw rPC0,r24	 ;  reg_pc,
	sts reg_pc,rPC0
	sts reg_pc+1,rPC1
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
	mov r30,rS	 ;  reg_s.59, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.61,
	add r25,r30	 ;  reg_s.61, reg_s.59
	mov rS,r25	 ;  reg_s, reg_s.61
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
	push rPC0
	push rPC1
	push rA
	push rX
	push rY
	push rS
	push rP
	push rN
	push rZ
	push rC
	push rTIME0
	push rTIME1
	push rTIME2
	push rTIME3
	push r16	 ; 
	push r17	 ; 
	lds rPC0,reg_pc
	lds rPC1,reg_pc+1
	lds rA,reg_a
	lds rX,reg_x
	lds rY,reg_y
	lds rS,reg_s
	lds rP,reg_p
	lds rN,flag_n
	lds rZ,flag_z
	lds rC,flag_c
	lds rTIME0,time_left
	lds rTIME1,time_left+1
	lds rTIME2,time_left+2
	lds rTIME3,time_left+3
/* prologue: function */
/* frame size = 0 */
/* stack size = 17 */
.L__stack_usage = 17
	ldi r16,lo8(1)	 ; D.4025,
	add rTIME0,r22	 ; time_left += cycles
	adc rTIME1,r23	 ;
	adc rTIME2,r24	 ;
	adc rTIME3,r25	 ;
	rjmp .L97	 ;
.tick:			 ;
	sub rTIME0,r24	 ; time_left -= r24
	sbc rTIME1,__zero_reg__	 ;
	sbc rTIME2,__zero_reg__	 ;
	sbc rTIME3,__zero_reg__	 ;
.L97:
	brpl .L98	 ; time >= 0?
	jmp .L366	 ; save state and exit
.L98:
	movw r24,rPC0	 ; reg_pc.64, reg_pc
	adiw rPC0,1	 ; PC++
	call mem_read	 ; read opcode
	ldi r25,0	 ; opcode
	movw r30,r24	 ;  tmp360,
	subi r30,lo8(-(gs(.L99)))	 ;  tmp360,
	sbci r31,hi8(-(gs(.L99)))	 ;  tmp360,
	jmp __tablejump2__
	/*

0001f48c <__tablejump2__>:
   1f48c:	ee 0f       	add	r30, r30
   1f48e:	ff 1f       	adc	r31, r31

0001f490 <__tablejump__>:
   1f490:	05 90       	lpm	r0, Z+
   1f492:	f4 91       	lpm	r31, Z
   1f494:	e0 2d       	mov	r30, r0
   1f496:	09 94       	ijmp
	*/
	.section	.progmem.gcc_sw_table.cpu_main,"a",@progbits
	.p2align	1
.L99:
	.word gs(.x00), gs(.x01), gs(.x02), gs(.x03)
	.word gs(.x04), gs(.x05), gs(.x06), gs(.x07)
	.word gs(.x08), gs(.x09), gs(.x0a), gs(.x0b)
	.word gs(.x0c), gs(.x0d), gs(.x0e), gs(.x0f)
	.word gs(.x10), gs(.x11), gs(.x12), gs(.x13)
	.word gs(.x14), gs(.x15), gs(.x16), gs(.x17)
	.word gs(.x18), gs(.x19), gs(.x1a), gs(.x1b)
	.word gs(.x1c), gs(.x1d), gs(.x1e), gs(.x1f)
	.word gs(.x20), gs(.x21), gs(.x22), gs(.x23)
	.word gs(.x24), gs(.x25), gs(.x26), gs(.x27)
	.word gs(.x28), gs(.x29), gs(.x2a), gs(.x2b)
	.word gs(.x2c), gs(.x2d), gs(.x2e), gs(.x2f)
	.word gs(.x30), gs(.x31), gs(.x32), gs(.x33)
	.word gs(.x34), gs(.x35), gs(.x36), gs(.x37)
	.word gs(.x38), gs(.x39), gs(.x3a), gs(.x3b)
	.word gs(.x3c), gs(.x3d), gs(.x3e), gs(.x3f)
	.word gs(.x40), gs(.x41), gs(.x42), gs(.x43)
	.word gs(.x44), gs(.x45), gs(.x46), gs(.x47)
	.word gs(.x48), gs(.x49), gs(.x4a), gs(.x4b)
	.word gs(.x4c), gs(.x4d), gs(.x4e), gs(.x4f)
	.word gs(.x50), gs(.x51), gs(.x52), gs(.x53)
	.word gs(.x54), gs(.x55), gs(.x56), gs(.x57)
	.word gs(.x58), gs(.x59), gs(.x5a), gs(.x5b)
	.word gs(.x5c), gs(.x5d), gs(.x5e), gs(.x5f)
	.word gs(.x60), gs(.x61), gs(.x62), gs(.x63)
	.word gs(.x64), gs(.x65), gs(.x66), gs(.x67)
	.word gs(.x68), gs(.x69), gs(.x6a), gs(.x6b)
	.word gs(.x6c), gs(.x6d), gs(.x6e), gs(.x6f)
	.word gs(.x70), gs(.x71), gs(.x72), gs(.x73)
	.word gs(.x74), gs(.x75), gs(.x76), gs(.x77)
	.word gs(.x78), gs(.x79), gs(.x7a), gs(.x7b)
	.word gs(.x7c), gs(.x7d), gs(.x7e), gs(.x7f)
	.word gs(.x80), gs(.x81), gs(.x82), gs(.x83)
	.word gs(.x84), gs(.x85), gs(.x86), gs(.x87)
	.word gs(.x88), gs(.x89), gs(.x8a), gs(.x8b)
	.word gs(.x8c), gs(.x8d), gs(.x8e), gs(.x8f)
	.word gs(.x90), gs(.x91), gs(.x92), gs(.x93)
	.word gs(.x94), gs(.x95), gs(.x96), gs(.x97)
	.word gs(.x98), gs(.x99), gs(.x9a), gs(.x9b)
	.word gs(.x9c), gs(.x9d), gs(.x9e), gs(.x9f)
	.word gs(.xa0), gs(.xa1), gs(.xa2), gs(.xa3)
	.word gs(.xa4), gs(.xa5), gs(.xa6), gs(.xa7)
	.word gs(.xa8), gs(.xa9), gs(.xaa), gs(.xab)
	.word gs(.xac), gs(.xad), gs(.xae), gs(.xaf)
	.word gs(.xb0), gs(.xb1), gs(.xb2), gs(.xb3)
	.word gs(.xb4), gs(.xb5), gs(.xb6), gs(.xb7)
	.word gs(.xb8), gs(.xb9), gs(.xba), gs(.xbb)
	.word gs(.xbc), gs(.xbd), gs(.xbe), gs(.xbf)
	.word gs(.xc0), gs(.xc1), gs(.xc2), gs(.xc3)
	.word gs(.xc4), gs(.xc5), gs(.xc6), gs(.xc7)
	.word gs(.xc8), gs(.xc9), gs(.xca), gs(.xcb)
	.word gs(.xcc), gs(.xcd), gs(.xce), gs(.xcf)
	.word gs(.xd0), gs(.xd1), gs(.xd2), gs(.xd3)
	.word gs(.xd4), gs(.xd5), gs(.xd6), gs(.xd7)
	.word gs(.xd8), gs(.xd9), gs(.xda), gs(.xdb)
	.word gs(.xdc), gs(.xdd), gs(.xde), gs(.xdf)
	.word gs(.xe0), gs(.xe1), gs(.xe2), gs(.xe3)
	.word gs(.xe4), gs(.xe5), gs(.xe6), gs(.xe7)
	.word gs(.xe8), gs(.xe9), gs(.xea), gs(.xeb)
	.word gs(.xec), gs(.xed), gs(.xee), gs(.xef)
	.word gs(.xf0), gs(.xf1), gs(.xf2), gs(.xf3)
	.word gs(.xf4), gs(.xf5), gs(.xf6), gs(.xf7)
	.word gs(.xf8), gs(.xf9), gs(.xfa), gs(.xfb)
	.word gs(.xfc), gs(.xfd), gs(.xfe), gs(.xff)
	.section	.text.cpu_main
/* BPL */
.x10:
	call addr_imm	 ;
	tst rN	 ; branch on N >= 0
	brpl .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BMI */
.x30:
	call addr_imm	 ;
	tst rN	 ; branch on N < 0
	brmi .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BVC */
.x50:
	call addr_imm	 ;
	bst rP,6	 ; branch on P bit 6 = 0
	brtc .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BVS */
.x70:
	call addr_imm	 ;
	bst rP,6	 ; branch on P bit 6 = 1
	brts .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.take_branch:
	call mem_read	 ;
	movw r18,rPC0	 ; old_pc = reg_pc
	add rPC0,r24	 ; reg_pc += offset
	adc rPC1,__zero_reg__	 ;
	sbrc r24,7	 ; if (offset & 0x80) reg_pc -= 0x100
	dec rPC1	 ;
	ldi r24,3	 ; 3 cycles for branch to same page
	cpse rPC1,r19	 ; skip if same page
	ldi r24,4	 ; 4 cycles for branch to different page
	rjmp .tick	 ;
/* BCC */
.x90:
	call addr_imm	 ;
	tst rC	 ; branch on rC = 0
	breq .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BCS */
.xb0:
	call addr_imm	 ;
	tst rC	 ; branch on rC != 0
	brne .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BNE */
.xd0:
	call addr_imm	 ;
	tst rZ	 ; branch on rZ != 0
	brne .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
/* BEQ */
.xf0:
	call addr_imm	 ;
	tst rZ	 ; branch on rZ = 0
	breq .take_branch	 ;
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x00:
	ldi r24,0xfe	 ; ,
	ldi r25,0xff	 ; ,
	call mem_read_16	 ; 
	call cpu6502_JSR	 ; 
	call update_p	 ; 
	lds r24,reg_p	 ;  reg_p.67, reg_p
	mov r30,rS	 ;  reg_s.68, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.70,
	add r25,r30	 ;  reg_s.70, reg_s.68
	mov rS,r25	 ;  reg_s, reg_s.70
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp364,
	sbci r31,hi8(-(ram+256))	 ;  tmp364,
	mov r25,r24	 ;  D.4021, reg_p.67
	ori r25,lo8(16)	 ;  D.4021,
	st Z,r25	 ;  *_884, D.4021
	ori r24,lo8(4)	 ;  reg_p.57,
	sts reg_p,r24	 ;  reg_p, reg_p.57
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ; 
.x01:
	call addr_inx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x02:
	call cpu6502_JAM	 ;
        ldi 24,7	 ; 7 cycles (?)
	rjmp .tick	 ;
.x03:
	call addr_inx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x04:
	call addr_zpg	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x05:
	call addr_zpg	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x06:
	call addr_zpg	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x07:
	call addr_zpg	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x08:
	call cpu6502_PHP	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x09:
	call addr_imm	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x0a:
	mov r24,rA	 ;  reg_a.71, reg_a
	mov r25,r24	 ;  flag_c.72, reg_a.71
	rol r25	 ;  flag_c.72
	clr r25	 ;  flag_c.72
	rol r25	 ;  flag_c.72
	mov rC,r25	 ;  flag_c, flag_c.72
	ldi r25,0	 ;  D.4024
	lsl r24	 ;  D.4024
	rol r25	 ;  D.4024
	mov rZ,r24	 ;  flag_z, D.4024
	mov rN,r24	 ;  flag_n, D.4024
	mov rA,r24	 ;  reg_a, D.4024
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x0b:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	mov r24,rA	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	mov rC,r24	 ;  flag_c, D.4025
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x0c:
	call addr_abs	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x0d:
	call addr_abs	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x0e:
	call addr_abs	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x0f:
	call addr_abs	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x11:
	call addr_iny	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x12:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x13:
	call addr_iny	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x14:
	call addr_zpx	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x15:
	call addr_zpx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x16:
	call addr_zpx	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x17:
	call addr_zpx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x18:
	mov rC,__zero_reg__	 ;  flag_c,
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x19:
	call addr_aby	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x1a:
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x1b:
	call addr_aby	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x1c:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x1d:
	call addr_abx	 ; 
	call cpu6502_ORA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x1e:
	call addr_abx	 ; 
	call cpu6502_ASL	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x1f:
	call addr_abx	 ; 
	call cpu6502_SLO	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x20:
	call addr_abs	 ; 
	call cpu6502_JSR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x21:
	call addr_inx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x22:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x23:
	call addr_inx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x24:
	call addr_zpg	 ; 
	call cpu6502_BIT	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x25:
	call addr_zpg	 ; 
	call cpu6502_AND	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x26:
	call addr_zpg	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x27:
	call addr_zpg	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x28:
	call cpu6502_PLP	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x29:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x2a:
	mov r25,rA	 ;  reg_a.91, reg_a
	mov r24,r25	 ;  result, reg_a.91
	lsl r24	 ;  result
	mov r18,rC	 ;  flag_c, flag_c
	or r24,r18	 ;  result, flag_c
	rol r25	 ;  flag_c.94
	clr r25	 ;  flag_c.94
	rol r25	 ;  flag_c.94
	mov rC,r25	 ;  flag_c, flag_c.94
	mov rZ,r24	 ;  flag_z, result
	mov rN,r24	 ;  flag_n, result
	mov rA,r24	 ;  reg_a, result
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x2b:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	mov r24,rA	 ;  D.4025, reg_a
	com r24	 ;  D.4025
	rol r24	 ;  D.4025
	clr r24	 ;  D.4025
	rol r24	 ;  D.4025
	mov rC,r24	 ;  flag_c, D.4025
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x2c:
	call addr_abs	 ; 
	call cpu6502_BIT	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x2d:
	call addr_abs	 ; 
	call cpu6502_AND	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x2e:
	call addr_abs	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x2f:
	call addr_abs	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x31:
	call addr_iny	 ; 
	call cpu6502_AND	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x32:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x33:
	call addr_iny	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x34:
	call addr_zpx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x35:
	call addr_zpx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x36:
	call addr_zpx	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x37:
	call addr_zpx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x38:
	mov rC,r16	 ;  flag_c, D.4025
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x39:
	call addr_aby	 ; 
	call cpu6502_AND	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x3a:
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x3b:
	call addr_aby	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x3c:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x3d:
	call addr_abx	 ; 
	call cpu6502_AND	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x3e:
	call addr_abx	 ; 
	call cpu6502_ROL	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x3f:
	call addr_abx	 ; 
	call cpu6502_RLA	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x40:
	call cpu6502_PLP	 ; 
	call cpu6502_RTS	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x41:
	call addr_inx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x42:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x43:
	call addr_inx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x44:
	call addr_zpg	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x45:
	call addr_zpg	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x46:
	call addr_zpg	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x47:
	call addr_zpg	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x48:
	mov r24,rA	 ;  reg_a.116, reg_a
	mov r30,rS	 ;  reg_s.117, reg_s
	ldi r25,lo8(-1)	 ;  reg_s.119,
	add r25,r30	 ;  reg_s.119, reg_s.117
	mov rS,r25	 ;  reg_s, reg_s.119
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp389,
	sbci r31,hi8(-(ram+256))	 ;  tmp389,
	st Z,r24	 ;  *_920, reg_a.116
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x49:
	call addr_imm	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x4a:
	call cpu6502_LSR_a	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x4b:
	call addr_imm	 ; 
	call cpu6502_AND	 ; 
	call cpu6502_LSR_a	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x4c:
	call addr_abs	 ; 
	mov rPC1,r25	 ;  reg_pc,
	mov rPC0,r24	 ;  reg_pc,
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x4d:
	call addr_abs	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x4e:
	call addr_abs	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x4f:
	call addr_abs	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x51:
	call addr_iny	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x52:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x53:
	call addr_iny	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x54:
	call addr_zpx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x55:
	call addr_zpx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x56:
	call addr_zpx	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x57:
	call addr_zpx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x58:
	lds r24,reg_p	 ;  reg_p.127, reg_p
	andi r24,lo8(-5)	 ;  reg_p.127,
	sts reg_p,r24	 ;  reg_p, reg_p.127
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x59:
	call addr_aby	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x5a:
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x5b:
	call addr_aby	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x5c:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x5d:
	call addr_abx	 ; 
	call cpu6502_EOR	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x5e:
	call addr_abx	 ; 
	call cpu6502_LSR	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x5f:
	call addr_abx	 ; 
	call cpu6502_SRE	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x60:
	call cpu6502_RTS	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x61:
	call addr_inx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x62:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x63:
	call addr_inx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x64:
	call addr_zpg	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x65:
	call addr_zpg	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x66:
	call addr_zpg	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x67:
	call addr_zpg	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x68:
	mov r30,rS	 ;  reg_s.145, reg_s
	subi r30,lo8(-(1))	 ;  reg_s.145,
	mov rS,r30	 ;  reg_s, reg_s.145
	ldi r31,0	 ; 
	subi r30,lo8(-(ram+256))	 ;  tmp400,
	sbci r31,hi8(-(ram+256))	 ;  tmp400,
	ld r24,Z	 ;  D.4026, *_931
	mov rZ,r24	 ;  flag_z, D.4026
	mov rN,r24	 ;  flag_n, D.4026
	mov rA,r24	 ;  reg_a, D.4026
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x69:
	call addr_imm	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x6a:
	mov r18,rA	 ;  reg_a.149, reg_a
	mov r24,rC	 ;  flag_c, flag_c
	ldi r19,lo8(-128)	 ; ,
	mul r24,r19	 ;  flag_c,
	movw r24,r0	 ;  D.4024
	clr __zero_reg__
	mov r25,r18	 ;  result, reg_a.149
	lsr r25	 ;  result
	or r25,r24	 ;  result, D.4024
	andi r18,lo8(1)	 ;  flag_c.151,
	mov rC,r18	 ;  flag_c, flag_c.151
	mov rZ,r25	 ;  flag_z, result
	mov rN,r25	 ;  flag_n, result
	mov rA,r25	 ;  reg_a, result
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x6b:
	call cpu6502_JAM	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x6c:
	call addr_ind	 ; 
	mov rPC1,r25	 ;  reg_pc,
	mov rPC0,r24	 ;  reg_pc,
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x6d:
	call addr_abs	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x6e:
	call addr_abs	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x6f:
	call addr_abs	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x71:
	call addr_iny	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x72:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x73:
	call addr_iny	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.x74:
	call addr_zpx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x75:
	call addr_zpx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x76:
	call addr_zpx	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x77:
	call addr_zpx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x78:
	lds r24,reg_p	 ;  reg_p.57, reg_p
	ori r24,lo8(4)	 ;  reg_p.57,
	sts reg_p,r24	 ;  reg_p, reg_p.57
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x79:
	call addr_aby	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x7a:
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x7b:
	call addr_aby	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x7c:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x7d:
	call addr_abx	 ; 
	call cpu6502_ADC	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x7e:
	call addr_abx	 ; 
	call cpu6502_ROR	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x7f:
	call addr_abx	 ; 
	call cpu6502_RRA	 ; 
	ldi r24,7	 ; 7 cycles
	rjmp .tick	 ;
.x80:
	call addr_imm	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x81:
	call addr_inx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x82:
	call addr_imm	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x83:
	call addr_inx	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x84:
	call addr_zpg	 ; 
	mov r22,rY	 ; , reg_y
	call mem_write	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x85:
	call addr_zpg	 ; 
	call cpu6502_STA	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x86:
	call addr_zpg	 ; 
	mov r22,rX	 ; , reg_x
	call mem_write	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x87:
	call addr_zpg	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.x88:
	mov r24,rY	 ;  flag_z.170, reg_y
	subi r24,lo8(-(-1))	 ;  flag_z.170,
	mov rZ,r24	 ;  flag_z, flag_z.170
	mov rN,r24	 ;  flag_n, flag_z.170
	mov rY,r24	 ;  reg_y, flag_z.170
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x89:
	call addr_imm	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x8a:
	mov r24,rX	 ;  reg_x.173, reg_x
	mov rZ,r24	 ;  flag_z, reg_x.173
	mov rN,r24	 ;  flag_n, reg_x.173
	mov rA,r24	 ;  reg_a, reg_x.173
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x8b:
	call cpu6502_JAM	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x8c:
	call addr_abs	 ; 
	mov r22,rY	 ; , reg_y
	call mem_write	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x8d:
	call addr_abs	 ; 
	call cpu6502_STA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x8e:
	call addr_abs	 ; 
	mov r22,rX	 ; , reg_x
	call mem_write	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x8f:
	call addr_abs	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x91:
	call addr_iny	 ; 
	call cpu6502_STA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x92:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.x93:
	call addr_iny	 ; 
	call cpu6502_SHA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.x94:
	call addr_zpx	 ; 
	mov r22,rY	 ; , reg_y
	call mem_write	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x95:
	call addr_zpx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x96:
	call addr_zpy	 ; 
	mov r22,rX	 ; , reg_x
	call mem_write	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x97:
	call addr_zpy	 ; 
	call cpu6502_SAX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x98:
	mov r24,rY	 ;  reg_y.181, reg_y
	mov rZ,r24	 ;  flag_z, reg_y.181
	mov rN,r24	 ;  flag_n, reg_y.181
	mov rA,r24	 ;  reg_a, reg_y.181
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x99:
	call addr_aby	 ; 
	call cpu6502_STA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x9a:
	mov r24,rX	 ;  reg_x, reg_x
	mov rS,r24	 ;  reg_s, reg_x
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.x9b:
	call cpu6502_JAM	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x9c:
	call addr_abx	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	mov r18,rY	 ;  reg_y, reg_y
	and r22,r18	 ;  D.4021, reg_y
	call mem_write	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x9d:
	call addr_abx	 ; 
	call cpu6502_STA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.x9e:
	call addr_aby	 ; 
	ldi r22,lo8(1)	 ;  D.4021,
	add r22,r25	 ;  D.4021, D.4020
	mov r18,rX	 ;  reg_x, reg_x
	and r22,r18	 ;  D.4021, reg_x
	call mem_write	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.x9f:
	call addr_aby	 ; 
	call cpu6502_SHA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xa0:
	call addr_imm	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xa1:
	call addr_inx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.xa2:
	call addr_imm	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xa3:
	call addr_inx	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.xa4:
	call addr_zpg	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xa5:
	call addr_zpg	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xa6:
	call addr_zpg	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xa7:
	call addr_zpg	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xa8:
	mov r24,rA	 ;  reg_a.190, reg_a
	mov rZ,r24	 ;  flag_z, reg_a.190
	mov rN,r24	 ;  flag_n, reg_a.190
	mov rY,r24	 ;  reg_y, reg_a.190
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xa9:
	call addr_imm	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xaa:
	mov r24,rA	 ;  reg_a.193, reg_a
	mov rZ,r24	 ;  flag_z, reg_a.193
	mov rN,r24	 ;  flag_n, reg_a.193
	mov rX,r24	 ;  reg_x, reg_a.193
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xab:
	call cpu6502_JAM	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xac:
	call addr_abs	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xad:
	call addr_abs	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xae:
	call addr_abs	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xaf:
	call addr_abs	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xb1:
	call addr_iny	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xb2:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.xb3:
	call addr_iny	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xb4:
	call addr_zpx	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xb5:
	call addr_zpx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xb6:
	call addr_zpy	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xb7:
	call addr_zpy	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xb8:
	lds r24,reg_p	 ;  reg_p.198, reg_p
	andi r24,lo8(-65)	 ;  reg_p.198,
	sts reg_p,r24	 ;  reg_p, reg_p.198
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xb9:
	call addr_aby	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xba:
	mov r24,rS	 ;  reg_s.199, reg_s
	mov rZ,r24	 ;  flag_z, reg_s.199
	mov rN,r24	 ;  flag_n, reg_s.199
	mov rX,r24	 ;  reg_x, reg_s.199
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xbb:
	call cpu6502_JAM	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xbc:
	call addr_abx	 ; 
	call cpu6502_LDY	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xbd:
	call addr_abx	 ; 
	call cpu6502_LDA	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xbe:
	call addr_aby	 ; 
	call cpu6502_LDX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xbf:
	call addr_aby	 ; 
	call cpu6502_LAX	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xc0:
	call addr_imm	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xc1:
	call addr_inx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.xc2:
	call addr_imm	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xc3:
	call addr_inx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.xc4:
	call addr_zpg	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xc5:
	call addr_zpg	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,3	 ; 3 cycles
	rjmp .tick	 ;
.xc6:
	call addr_zpg	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xc7:
	call addr_zpg	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xc8:
	mov r24,rY	 ;  flag_z.216, reg_y
	subi r24,lo8(-(1))	 ;  flag_z.216,
	mov rZ,r24	 ;  flag_z, flag_z.216
	mov rN,r24	 ;  flag_n, flag_z.216
	mov rY,r24	 ;  reg_y, flag_z.216
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xc9:
	call addr_imm	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xca:
	mov r24,rX	 ;  flag_z.220, reg_x
	subi r24,lo8(-(-1))	 ;  flag_z.220,
	mov rZ,r24	 ;  flag_z, flag_z.220
	mov rN,r24	 ;  flag_n, flag_z.220
	mov rX,r24	 ;  reg_x, flag_z.220
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xcb:
	call addr_imm	 ; 
	call mem_read	 ; 
	mov r25,rX	 ;  D.4021, reg_x
	mov r18,rA	 ;  reg_a, reg_a
	and r25,r18	 ;  D.4021, reg_a
	ldi r18,lo8(1)	 ;  D.4025,
	cp r25,r24	 ;  D.4021, data
	brsh .L356	 ; ,
	ldi r18,0	 ;  D.4025
.L356:
	mov rC,r18	 ;  flag_c, D.4025
	sub r25,r24	 ;  flag_z.226, data
	mov rZ,r25	 ;  flag_z, flag_z.226
	mov rN,r25	 ;  flag_n, flag_z.226
	mov rX,r25	 ;  reg_x, flag_z.226
	ldi r24,2	 ; 2 cycles
	rjmp .tick	 ;
.xcc:
	call addr_abs	 ; 
	call cpu6502_CPY	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xcd:
	call addr_abs	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xce:
	call addr_abs	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.xcf:
	call addr_abs	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,6	 ; 6 cycles
	rjmp .tick	 ;
.xd1:
	call addr_iny	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,5	 ; 5 cycles
	rjmp .tick	 ;
.xd2:
	call cpu6502_JAM	 ; 
	rjmp .tick	 ;
.xd3:
	call addr_iny	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,8	 ; 8 cycles
	rjmp .tick	 ;
.xd4:
	call addr_zpx	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xd5:
	call addr_zpx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,4	 ; 4 cycles
	rjmp .tick	 ;
.xd6:
	call addr_zpx	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xd7:
	call addr_zpx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xd8:
	lds r24,reg_p	 ;  reg_p.234, reg_p
	andi r24,lo8(-9)	 ;  reg_p.234,
	sts reg_p,r24	 ;  reg_p, reg_p.234
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xd9:
	call addr_aby	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xda:
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xdb:
	call addr_aby	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.xdc:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xdd:
	call addr_abx	 ; 
	call cpu6502_CMP	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xde:
	call addr_abx	 ; 
	call cpu6502_DEC	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.xdf:
	call addr_abx	 ; 
	call cpu6502_DCP	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.xe0:
	call addr_imm	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xe1:
	call addr_inx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xe2:
	call addr_imm	 ; 
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xe3:
	call addr_inx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,8	 ; 8 cycles
	jmp .tick	 ;
.xe4:
	call addr_zpg	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,3	 ; 3 cycles
	jmp .tick	 ;
.xe5:
	call addr_zpg	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,3	 ; 3 cycles
	jmp .tick	 ;
.xe6:
	call addr_zpg	 ; 
	call cpu6502_INC	 ; 
	ldi r24,5	 ; 5 cycles
	jmp .tick	 ;
.xe7:
	call addr_zpg	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,5	 ; 5 cycles
	jmp .tick	 ;
.xe8:
	mov r24,rX	 ;  flag_z.240, reg_x
	subi r24,lo8(-(1))	 ;  flag_z.240,
	mov rZ,r24	 ;  flag_z, flag_z.240
	mov rN,r24	 ;  flag_n, flag_z.240
	mov rX,r24	 ;  reg_x, flag_z.240
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xe9:
	call addr_imm	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xea:
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xeb:
	call addr_imm	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xec:
	call addr_abs	 ; 
	call cpu6502_CPX	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xed:
	call addr_abs	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xee:
	call addr_abs	 ; 
	call cpu6502_INC	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xef:
	call addr_abs	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xf1:
	call addr_iny	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,5	 ; 5 cycles
	jmp .tick	 ;
.xf2:
	call cpu6502_JAM	 ; 
	jmp .tick	 ;
.xf3:
	call addr_iny	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,8	 ; 8 cycles
	jmp .tick	 ;
.xf4:
	call addr_zpx	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xf5:
	call addr_zpx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xf6:
	call addr_zpx	 ; 
	call cpu6502_INC	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xf7:
	call addr_zpx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,6	 ; 6 cycles
	jmp .tick	 ;
.xf8:
	lds r24,reg_p	 ;  reg_p.247, reg_p
	ori r24,lo8(8)	 ;  reg_p.247,
	sts reg_p,r24	 ;  reg_p, reg_p.247
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xf9:
	call addr_aby	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xfa:
	ldi r24,2	 ; 2 cycles
	jmp .tick	 ;
.xfb:
	call addr_aby	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.xfc:
	call addr_abx	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xfd:
	call addr_abx	 ; 
	call cpu6502_SBC	 ; 
	ldi r24,4	 ; 4 cycles
	jmp .tick	 ;
.xfe:
	call addr_abx	 ; 
	call cpu6502_INC	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.xff:
	call addr_abx	 ; 
	call cpu6502_ISB	 ; 
	ldi r24,7	 ; 7 cycles
	jmp .tick	 ;
.L366:
/* epilogue start */
	sts reg_pc,rPC0
	sts reg_pc+1,rPC1
	sts reg_a,rA
	sts reg_x,rX
	sts reg_y,rY
	sts reg_s,rS
	sts reg_p,rP
	sts flag_n,rN
	sts flag_z,rZ
	sts flag_c,rC
	sts time_left,rTIME0
	sts time_left+1,rTIME1
	sts time_left+2,rTIME2
	sts time_left+3,rTIME3
	pop r17	 ; 
	pop r16	 ; 
	pop rTIME3
	pop rTIME2
	pop rTIME1
	pop rTIME0
	pop rC
	pop rZ
	pop rN
	pop rP
	pop rS
	pop rY
	pop rX
	pop rA
	pop rPC1
	pop rPC0
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
