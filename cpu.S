	.file	"cpu.S"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1

/* Register variables */
_A_ = 4
_X_ = 5
_Y_ = 6
_S_ = 7
_P_ = 17
_N_ = 9
_Z_ = 10
_C_ = 11
_PCL_ = 28
_PCH_ = 29
_time0_ = 12
_time1_ = 13
_time2_ = 14
_time3_ = 15
_cycles_ = 16
_opcode_ = 20
_opcode_pointer_ = 21
_data_ = 22
_value_ = 23
XL = 26
XH = 27
YL = 28
YH = 29
ZL = 30
ZH = 31

/* Status flags */
C_FLAG = 0x01
Z_FLAG = 0x02
I_FLAG = 0x04
D_FLAG = 0x08
B_FLAG = 0x10
/* bit 5 is always 1 */
V_FLAG = 0x40
N_FLAG = 0x80

/* define TICK(n) subi _time0_,(n) $ rjmp .ticked */
#define TICK(n) \
	ldi _cycles_,(n) $ \
	rjmp .tick

#define ZERO_PAGE hi8(ram)
#define STACK_PAGE hi8(ram+256)

#define PUSH(reg) \
	mov ZL, _S_ $ \
	ldi ZH, STACK_PAGE $ \
	st Z, (reg) $ \
	dec _S_

#define PULL(reg) \
	inc _S_ $ \
	mov ZL, _S_ $ \
	ldi ZH, STACK_PAGE $ \
	ld (reg), Z

/* reg <- ram[addr] */
#define LD_ZERO_PAGE(reg,addr) \
	mov ZL,(addr)	 $ \
	ldi ZH,ZERO_PAGE	 $ \
	ld (reg),Z

/* reg+1:reg <- ram[addr+1]:ram[addr] */
#define LDW_ZERO_PAGE(reg,addr) \
	mov ZL,(addr)	 $ \
	ldi ZH,ZERO_PAGE	 $ \
	ld (reg),Z	 $ \
	inc ZL	 $ \
	ld (reg)+1,Z

/* ram[addr] <- reg */
#define ST_ZERO_PAGE(addr,reg) \
	mov ZL,(addr)	 $ \
	ldi ZH,ZERO_PAGE	 $ \
	st Z,(reg)

/* XH:XL <- value */
#define LDI_X(value) \
	ldi XL,lo8(value) $ \
	ldi XH,hi8(value)

/* ZH:ZL <- value */
#define LDI_Z(value) \
	ldi ZL,lo8(value) $ \
	ldi ZH,hi8(value)

	.section	.text.mem_read,"ax",@progbits
.global	mem_read
	.type	mem_read, @function
mem_read:
/* input: r25:r24 */
/* output: _data_ */
/* touches: ZH, ZL */
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r25,0x04	 ; branch if addr_hi >= 0x40
	brsh .mem_L6	 ;
	movw ZL,r24	 ;
	subi ZH,hi8(-(ram))	 ;
	ld _data_,Z	 ; load from ram[addr]
	ret
.mem_L6:
	cpi r25,0xc0	 ; branch if addr_hi < 0xc0
	brlo .mem_L9	 ;
	movw ZL,r24	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm _data_,Z	 ; load from rom[addr - 0xc0000]
	ret
.mem_L9:
	ldi _data_,0xff	 ; other addresses return 0xff
	ret
	.size	mem_read, .-mem_read
	.section	.text.mem_read_16,"ax",@progbits
.global	mem_read_16
	.type	mem_read_16, @function
mem_read_16:
/* input: r25:r24 */
/* output: r25:r24 */
/* touches: ZH, ZL, _data_, r18 */
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,0xff	 ;
	breq .mem_L11	 ; branch if addr_lo = $ff
.mem_16_ram:
	cpi r25,0x04	 ;
	brsh .mem_16_L6	 ; branch if addr_hi >= 0x40
	movw ZL,r24	 ;
	subi ZH,hi8(-(ram))	 ;
	ld r24,Z+	 ; r24 <- ram[addr]
	ld r25,Z	 ; r25 <- ram[addr+1]
	ret
.mem_16_L6:
	cpi r25,0xc0	 ;
	brlo .mem_16_L9	 ; branch if addr_hi < 0xc0
.mem_16_rom:
	movw ZL,r24	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm r24,Z+	 ; r24 <- rom[addr - 0xc0000]
	lpm r25,Z	 ; r25 <- rom[addr+1 - 0xc0000]
	ret
.mem_16_L9:
	ldi r24,0xff	 ; other addresses return 0xff
	ldi r25,0xff	 ; other addresses return 0xff
	ret
.mem_L11:
	rcall mem_read	 ; data <- mem_read(addr)
	mov r18,_data_	 ; temp <- data
	adiw r24,1	 ; addr++
	rcall mem_read	 ; data <- mem_read(addr+1)
	mov r24,r18	 ;
	mov r25,_data_	 ;
	ret
	.size	mem_read_16, .-mem_read_16
	.section	.text.clock_advance,"ax",@progbits
	.type	clock_advance, @function
clock_advance:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sub _time0_,_cycles_	 ;  time_left.20, D.3675
	sbc _time1_,__zero_reg__	 ;  time_left.20, D.3675
	sbc _time2_,__zero_reg__	 ;  time_left.20, D.3675
	sbc _time3_,__zero_reg__	 ;  time_left.20, D.3675
	ret
	.size	clock_advance, .-clock_advance
	.section	.text.unpack_flags,"ax",@progbits
	.type	unpack_flags, @function
unpack_flags:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov _N_,_P_	 ; N <- P
	bst _P_,0	 ; t <- P.0
	bld _C_,0	 ; C <- t
	clr _Z_	 ; Z <- 0
	sbrs _P_,1	 ; skip if P.1 is set
	inc _Z_	 ; Z++ if P.1 is clear
	ret
	.size	unpack_flags, .-unpack_flags
	.section	.text.pack_flags,"ax",@progbits
	.type	pack_flags, @function
pack_flags:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	andi _P_,~(B_FLAG|C_FLAG)	 ; clear B and C flags
	or _P_,_C_	 ; P.0 <- C.0
	bst _N_,7	 ;
	bld _P_,7	 ; P.7 <- N.7
	ori _P_,Z_FLAG|0x20	 ; set Z flag and 1 flag
	cpse _Z_,__zero_reg__	 ; skip if Z = 0
	andi _P_,~Z_FLAG	 ; clear Z flag if Z != 0
	ret
	.size	pack_flags, .-pack_flags
	.section	.text.addr_abs,"ax",@progbits
.global	addr_abs
	.type	addr_abs, @function
addr_abs:
/* r25:r24 <- mem_read(++PC), PC += 2 */
/* assumes that mem(PC+1) is already in _data_ */
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	adiw _PCL_,2	 ; PC += 2
	mov r24,_data_	 ; r24 <- data
	movw ZL,_PCL_	 ;
	adiw _PCL_,1	 ; PC++
	cpi ZH,0x04	 ; branch if PCH >= 0x04
	brsh .addr_abs_hi	 ;
	subi ZH,hi8(-(ram))	 ;
	ld r25,Z	 ; load from ram[addr]
	ret
.addr_abs_hi:
	cpi ZH,0xc0	 ; branch if PCH < 0xc0
	brlo .addr_abs_io	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm r25,Z	 ; r25 <- rom[PC - 0xc0000]
	ret
.addr_abs_io:
	ldi r25,0xff	 ; other addresses return 0xff
	ret
	.size	addr_abs, .-addr_abs
	.section	.text.cpu_reset,"ax",@progbits
.global	cpu_reset
	.type	cpu_reset, @function
cpu_reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,0xfc	 ;
	ldi r25,0xff	 ;
	rcall mem_read_16	 ; r25:r24 <- mem_read(0xfffc)
	movw _PCL_,r24	 ; PC <- mem_read(0xfffc)
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
	sbrc _P_,2	 ; skip if I flag is clear
	ret	 ;
	PUSH(_PCH_)
	PUSH(_PCL_)
	rcall pack_flags	 ;
	PUSH(_P_)	 ; stack[S--] <- P
	ori _P_,I_FLAG	 ; set I flag
	ldi r24,0xfe	 ;
	ldi r25,0xff	 ;
	rcall mem_read_16	 ; r25:r24 <- mem_read(0xfffe)
	movw _PCL_,r24	 ; PC <- address
	ldi _cycles_,7	 ; 7 cycles
	rjmp clock_advance	 ; 
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
	PUSH(_PCH_)
	PUSH(_PCL_)
	rcall pack_flags	 ;
	PUSH(_P_)	 ; stack[S--] <- P
	ldi r24,0xfa	 ;
	ldi r25,0xff	 ;
	rcall mem_read_16	 ; r25:r24 <- mem_read(0xfffa)
	movw _PCL_,r24	 ; PC <- address
	ldi _cycles_,7	 ; 7 cycles
	rjmp clock_advance	 ;
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
/* stack size = 14 */
.L__stack_usage = 14
	ldi _opcode_pointer_,hi8(gs(.opcode_table))	 ;
	add _time0_,r22	 ; time_left += cycles
	adc _time1_,r23	 ;
	adc _time2_,r24	 ;
	adc _time3_,r25	 ;
	brpl .load_opcode	 ; continue if time >= 0
	rjmp .L366	 ; save state and exit
.tick_carry:
	sbc _time1_,__zero_reg__	 ;
	sbc _time2_,__zero_reg__	 ;
	sbc _time3_,__zero_reg__	 ;
	brpl .load_opcode	 ; continue if time >= 0
	rjmp .L366	 ; save state and exit
.tick:
	sub _time0_,_cycles_	 ; time_left -= cycles
.ticked:
	brcs .tick_carry	 ; abort early if no carry
.load_opcode:
	movw ZL,_PCL_	 ;
	cpi ZH,0xc0	 ;
	brlo .pc_no_rom	 ; branch if PC < 0xc000 */
.pc_in_rom:
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm _opcode_,Z+	 ; opcode <- rom[PC - 0xc0000]
	lpm _data_,Z+	 ; data <- rom[PC+1 - 0xc0000]
	movw ZL,_opcode_	 ; ZH:ZL <- _opcode_pointer_:_opcode_
	ijmp	 ; jmp (.opcode_table + opcode)
.pc_no_rom:
	cpi ZH,0x04	 ;
	brsh .pc_no_ram	 ; branch if PC >= 0x0400
.pc_in_ram:
	subi ZH,hi8(-(ram))	 ;
	ld _opcode_,Z+	 ; opcode <- ram[PC]
	ld _data_,Z	 ; data <- ram[PC+1]
	movw ZL,_opcode_	 ; ZH:ZL <- _opcode_pointer_:_opcode_
	ijmp	 ; jmp (.opcode_table + opcode)
.pc_no_ram:
	ldi _opcode_,0xff	 ; other addresses return 0xff
	ldi _data_,0xff	 ; other addresses return 0xff
	rjmp .xff_ISB_abx_undocumented

/* align to 256-word (512-byte) boundary */
.p2align 9
.opcode_table:
	rjmp .x00_BRK
	rjmp .x01_ORA_inx
	rjmp .x02
	rjmp .x03_SLO_inx_undocumented
	rjmp .x04_NOP_zpg_undocumented
	rjmp .x05_ORA_zpg
	rjmp .x06_ASL_zpg
	rjmp .x07_SLO_zpg_undocumented
	rjmp .x08_PHP
	rjmp .x09_ORA_imm
	rjmp .x0a_ASL_acc
	rjmp .x0b_ANC_imm_undocumented
	rjmp .x0c_NOP_abs_undocumented
	rjmp .x0d_ORA_abs
	rjmp .x0e_ASL_abs
	rjmp .x0f_SLO_abs_undocumented
	rjmp .x10_BPL
	rjmp .x11_ORA_iny
	rjmp .x12
	rjmp .x13_SLO_iny_undocumented
	rjmp .x14_NOP_zpx_undocumented
	rjmp .x15_ORA_zpx
	rjmp .x16_ASL_zpx
	rjmp .x17_SLO_zpx_undocumented
	rjmp .x18_CLC
	rjmp .x19_ORA_aby
	rjmp .x1a_NOP_undocumented
	rjmp .x1b_SLO_aby_undocumented
	rjmp .x1c_NOP_abx_undocumented
	rjmp .x1d_ORA_abx
	rjmp .x1e_ASL_abx
	rjmp .x1f_SLO_abx_undocumented
	rjmp .x20_JSR
	rjmp .x21_AND_inx
	rjmp .x22
	rjmp .x23_RLA_inx_undocumented
	rjmp .x24_BIT_zpg
	rjmp .x25_AND_zpg
	rjmp .x26_ROL_zpg
	rjmp .x27_RLA_zpg_undocumented
	rjmp .x28_PLP
	rjmp .x29_AND_imm
	rjmp .x2a_ROL_acc
	rjmp .x2b_ANC_imm_undocumented
	rjmp .x2c_BIT_abs
	rjmp .x2d_AND_abs
	rjmp .x2e_ROL_abs
	rjmp .x2f_RLA_abs_undocumented
	rjmp .x30_BMI
	rjmp .x31_AND_iny
	rjmp .x32
	rjmp .x33_RLA_iny_undocumented
	rjmp .x34_NOP_zpx_undocumented
	rjmp .x35_AND_zpx
	rjmp .x36_ROL_zpx
	rjmp .x37_RLA_zpx_undocumented
	rjmp .x38_SEC
	rjmp .x39_AND_aby
	rjmp .x3a_NOP_undocumented
	rjmp .x3b_RLA_aby_undocumented
	rjmp .x3c_NOP_abx_undocumented
	rjmp .x3d_AND_abx
	rjmp .x3e_ROL_abx
	rjmp .x3f_RLA_abx_undocumented
	rjmp .x40_RTI
	rjmp .x41_EOR_inx
	rjmp .x42
	rjmp .x43_SRE_inx_undocumented
	rjmp .x44_NOP_zpg_undocumented
	rjmp .x45_EOR_zpg
	rjmp .x46_LSR_zpg
	rjmp .x47_SRE_zpg_undocumented
	rjmp .x48_PHA
	rjmp .x49_EOR_imm
	rjmp .x4a_LSR_acc
	rjmp .x4b_ASR_imm_undocumented
	rjmp .x4c_JMP_abs
	rjmp .x4d_EOR_abs
	rjmp .x4e_LSR_abs
	rjmp .x4f_SRE_abs_undocumented
	rjmp .x50_BVC
	rjmp .x51_EOR_iny
	rjmp .x52
	rjmp .x53_SRE_iny_undocumented
	rjmp .x54_NOP_zpx_undocumented
	rjmp .x55_EOR_zpx
	rjmp .x56_LSR_zpx
	rjmp .x57_SRE_zpx_undocumented
	rjmp .x58_CLI
	rjmp .x59_EOR_aby
	rjmp .x5a_NOP_undocumented
	rjmp .x5b_SRE_aby_undocumented
	rjmp .x5c_NOP_abx_undocumented
	rjmp .x5d_EOR_abx
	rjmp .x5e_LSR_abx
	rjmp .x5f_SRE_abx_undocumented
	rjmp .x60_RTS
	rjmp .x61_ADC_inx
	rjmp .x62
	rjmp .x63_RRA_inx_undocumented
	rjmp .x64_NOP_zpg_undocumented
	rjmp .x65_ADC_zpg
	rjmp .x66_ROR_zpg
	rjmp .x67_RRA_zpg_undocumented
	rjmp .x68_PLA
	rjmp .x69_ADC_imm
	rjmp .x6a_ROR_acc
	rjmp .x6b
	rjmp .x6c_JMP_ind
	rjmp .x6d_ADC_abs
	rjmp .x6e_ROR_abs
	rjmp .x6f_RRA_abs_undocumented
	rjmp .x70_BVS
	rjmp .x71_ADC_iny
	rjmp .x72
	rjmp .x73_RRA_iny_undocumented
	rjmp .x74_NOP_zpx_undocumented
	rjmp .x75_ADC_zpx
	rjmp .x76_ROR_zpx
	rjmp .x77_RRA_zpx_undocumented
	rjmp .x78_SEI
	rjmp .x79_ADC_aby
	rjmp .x7a_NOP_undocumented
	rjmp .x7b_RRA_aby_undocumented
	rjmp .x7c_NOP_abx_undocumented
	rjmp .x7d_ADC_abx
	rjmp .x7e_ROR_abx
	rjmp .x7f_RRA_abx_undocumented
	rjmp .x80_NOP_imm_undocumented
	rjmp .x81_STA_inx
	rjmp .x82_NOP_imm_undocumented
	rjmp .x83_SAX_inx_undocumented
	rjmp .x84_STY_zpg
	rjmp .x85_STA_zpg
	rjmp .x86_STX_zpg
	rjmp .x87_SAX_zpg_undocumented
	rjmp .x88_DEY
	rjmp .x89_NOP_imm_undocumented
	rjmp .x8a_TXA
	rjmp .x8b
	rjmp .x8c_STY_abs
	rjmp .x8d_STA_abs
	rjmp .x8e_STX_abs
	rjmp .x8f_SAX_abs_undocumented
	rjmp .x90_BCC
	rjmp .x91_STA_iny
	rjmp .x92
	rjmp .x93_SHA_iny_undocumented
	rjmp .x94_STY_zpx
	rjmp .x95_STA_zpx
	rjmp .x96_STX_zpy
	rjmp .x97_SAX_zpy_undocumented
	rjmp .x98_TYA
	rjmp .x99_STA_aby
	rjmp .x9a_TXS
	rjmp .x9b
	rjmp .x9c_SHY_abx_undocumented
	rjmp .x9d_STA_abx
	rjmp .x9e_SHX_aby_undocumented
	rjmp .x9f_SHA_aby_undocumented
	rjmp .xa0_LDY_imm
	rjmp .xa1_LDA_inx
	rjmp .xa2_LDX_imm
	rjmp .xa3_LAX_inx_undocumented
	rjmp .xa4_LDY_zpg
	rjmp .xa5_LDA_zpg
	rjmp .xa6_LDX_zpg
	rjmp .xa7_LAX_zpg_undocumented
	rjmp .xa8_TAY
	rjmp .xa9_LDA_imm
	rjmp .xaa_TAX
	rjmp .xab
	rjmp .xac_LDY_abs
	rjmp .xad_LDA_abs
	rjmp .xae_LDX_abs
	rjmp .xaf_LAX_abs_undocumented
	rjmp .xb0_BCS
	rjmp .xb1_LDA_iny
	rjmp .xb2
	rjmp .xb3_LAX_iny_undocumented
	rjmp .xb4_LDY_zpx
	rjmp .xb5_LDA_zpx
	rjmp .xb6_LDX_zpy
	rjmp .xb7_LAX_zpy_undocumented
	rjmp .xb8_CLV
	rjmp .xb9_LDA_aby
	rjmp .xba_TSX
	rjmp .xbb
	rjmp .xbc_LDY_abx
	rjmp .xbd_LDA_abx
	rjmp .xbe_LDX_aby
	rjmp .xbf_LAX_aby_undocumented
	rjmp .xc0_CPY_imm
	rjmp .xc1_CMP_inx
	rjmp .xc2_NOP_imm_undocumented
	rjmp .xc3_DCP_inx_undocumented
	rjmp .xc4_CPY_zpg
	rjmp .xc5_CMP_zpg
	rjmp .xc6_DEC_zpg
	rjmp .xc7_DCP_zpg_undocumented
	rjmp .xc8_INY
	rjmp .xc9_CMP_imm
	rjmp .xca_DEX
	rjmp .xcb_SBX_imm_undocumented
	rjmp .xcc_CPY_abs
	rjmp .xcd_CMP_abs
	rjmp .xce_DEC_abs
	rjmp .xcf_DCP_abs_undocumented
	rjmp .xd0_BNE
	rjmp .xd1_CMP_iny
	rjmp .xd2
	rjmp .xd3_DCP_iny_undocumented
	rjmp .xd4_NOP_zpx_undocumented
	rjmp .xd5_CMP_zpx
	rjmp .xd6_DEC_zpx
	rjmp .xd7_DCP_zpx_undocumented
	rjmp .xd8_CLD
	rjmp .xd9_CMP_aby
	rjmp .xda_NOP_undocumented
	rjmp .xdb_DCP_aby_undocumented
	rjmp .xdc_NOP_abx_undocumented
	rjmp .xdd_CMP_abx
	rjmp .xde_DEC_abx
	rjmp .xdf_DCP_abx_undocumented
	rjmp .xe0_CPX_imm
	rjmp .xe1_SBC_inx
	rjmp .xe2_NOP_imm_undocumented
	rjmp .xe3_ISB_inx_undocumented
	rjmp .xe4_CPX_zpg
	rjmp .xe5_SBC_zpg
	rjmp .xe6_INC_zpg
	rjmp .xe7_ISB_zpg_undocumented
	rjmp .xe8_INX
	rjmp .xe9_SBC_imm
	rjmp .xea_NOP
	rjmp .xeb_SBC_imm_undocumented
	rjmp .xec_CPX_abs
	rjmp .xed_SBC_abs
	rjmp .xee_INC_abs
	rjmp .xef_ISB_abs_undocumented
	rjmp .xf0_BEQ
	rjmp .xf1_SBC_iny
	rjmp .xf2
	rjmp .xf3_ISB_iny_undocumented
	rjmp .xf4_NOP_zpx_undocumented
	rjmp .xf5_SBC_zpx
	rjmp .xf6_INC_zpx
	rjmp .xf7_ISB_zpx_undocumented
	rjmp .xf8_SED
	rjmp .xf9_SBC_aby
	rjmp .xfa_NOP_undocumented
	rjmp .xfb_ISB_aby_undocumented
	rjmp .xfc_NOP_abx_undocumented
	rjmp .xfd_SBC_abx
	rjmp .xfe_INC_abx
	rjmp .xff_ISB_abx_undocumented

/***************************** READ INSTRUCTIONS ******************************/

.x01_ORA_inx:
	LDI_X(gs(.ORA))
	rjmp .read_inx
.x05_ORA_zpg:
	LDI_X(gs(.ORA))
	rjmp .read_zpg
.x09_ORA_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.ORA:
	or _A_,_data_	 ; A |= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick
.x0d_ORA_abs:
	LDI_X(gs(.ORA))
	rjmp .read_abs
.x11_ORA_iny:
	LDI_X(gs(.ORA))
	rjmp .read_iny
.x15_ORA_zpx:
	LDI_X(gs(.ORA))
	rjmp .read_zpx
.x19_ORA_aby:
	LDI_X(gs(.ORA))
	rjmp .read_aby
.x1d_ORA_abx:
	LDI_X(gs(.ORA))
	rjmp .read_abx
.x21_AND_inx:
	LDI_X(gs(.AND))
	rjmp .read_inx
.x25_AND_zpg:
	LDI_X(gs(.AND))
	rjmp .read_zpg
.x29_AND_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.AND:
	and _A_,_data_	 ; A &= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick
.x2d_AND_abs:
	LDI_X(gs(.AND))
	rjmp .read_abs
.x31_AND_iny:
	LDI_X(gs(.AND))
	rjmp .read_iny
.x35_AND_zpx:
	LDI_X(gs(.AND))
	rjmp .read_zpx
.x39_AND_aby:
	LDI_X(gs(.AND))
	rjmp .read_aby
.x3d_AND_abx:
	LDI_X(gs(.AND))
	rjmp .read_abx
.x41_EOR_inx:
	LDI_X(gs(.EOR))
	rjmp .read_inx
.x45_EOR_zpg:
	LDI_X(gs(.EOR))
	rjmp .read_zpg
.x49_EOR_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.EOR:
	eor _A_,_data_	 ; A ^= data
	mov _Z_,_A_
	mov _N_,_A_
	rjmp .tick
.x4d_EOR_abs:
	LDI_X(gs(.EOR))
	rjmp .read_abs
.x51_EOR_iny:
	LDI_X(gs(.EOR))
	rjmp .read_iny
.x55_EOR_zpx:
	LDI_X(gs(.EOR))
	rjmp .read_zpx
.x59_EOR_aby:
	LDI_X(gs(.EOR))
	rjmp .read_aby
.x5d_EOR_abx:
	LDI_X(gs(.EOR))
	rjmp .read_abx
.x61_ADC_inx:
	LDI_X(gs(.ADC))
	rjmp .read_inx
.x65_ADC_zpg:
	LDI_X(gs(.ADC))
	rjmp .read_zpg
.x69_ADC_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.ADC:
	sbrc _P_,3	 ; skip if decimal mode is set
	rjmp .ADC_dec	 ; jump if decimal mode is clear
.ADC_bin:
	lsr _C_	 ; carry <- C <- 0
	adc _A_,_data_	 ; (carry, A) <- A + data + carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	brvs .ADC_bin_overflow	 ; branch on overflow
	rol _C_	 ; C <- carry <- 0
	andi _P_,~V_FLAG	 ; P &= ~V_FLAG
	rjmp .tick
.ADC_bin_overflow:
	rol _C_	 ; C <- carry <- 0
	ori _P_,V_FLAG	 ; P |= V_FLAG
	rjmp .tick
.ADC_dec:
	mov r30,_A_	 ; r30 <- A
	mov r18,_A_	 ; total <- A
	ldi r19,0	 ;
	add r18,_C_	 ; total += C
	adc r19,__zero_reg__	 ;
	add r18,_data_	 ; total += data
	adc r19,__zero_reg__	 ;
	mov _Z_,r18	 ; Z <- lo8(total)
	mov r25,_A_	 ; temp25 <- A
	andi r25,0x0f	 ; temp25 <- A & 0x0f
	add r25,_C_	 ; temp25 += C
	mov r20,_data_	 ; temp20 <- data
	andi r20,0x0f	 ; temp20 <- data & 0x0f
	add r25,r20	 ; temp25 += temp20
	cpi r25,10	 ;
	brlo .L12	 ; branch if temp25 < 10
	cpi r25,26	 ;
	brsh .L13	 ; branch if temp25 < 26
	subi r18,-6	 ; total += 6
	sbci r19,-1	 ;
	rjmp .L12	 ;
.L13:
	subi r18,10	 ; total -= 10
	sbc r19,__zero_reg__	 ;
.L12:
	/* set N, V after low nybble fixup */
	mov _N_,r18	 ; N <- lo8(total)
	eor _data_,r18	 ; data <- (data ^ total) & (A ^ total)
	eor r30,r18	 ;
	and _data_,r30	 ;
	bst _data_,7	 ; t <- (data ^ total) & (A ^ total) bit 7
	bld _P_,6	 ; P.overflow <- t
	/* high nybble fixup */
	cpi r18,0xa0	 ; total,
	cpc r19,__zero_reg__	 ;  total
	brlo .L16	 ; branch if total < 0xa0
	subi r18,-96	 ; total += 0x60
	sbci r19,-1	 ;
.L16:
	clr _C_	 ; C <- 0
	cpse r19,__zero_reg__	 ;
	inc _C_	 ; C <- 1 if r19 > 0
	mov _A_,r18	 ; A <- lo8(total)
	rjmp .tick
.x6d_ADC_abs:
	LDI_X(gs(.ADC))
	rjmp .read_abs
.x71_ADC_iny:
	LDI_X(gs(.ADC))
	rjmp .read_iny
.x75_ADC_zpx:
	LDI_X(gs(.ADC))
	rjmp .read_zpx
.x79_ADC_aby:
	LDI_X(gs(.ADC))
	rjmp .read_aby
.x7d_ADC_abx:
	LDI_X(gs(.ADC))
	rjmp .read_abx
.xa1_LDA_inx:
	LDI_X(gs(.LDA))
	rjmp .read_inx
.xa5_LDA_zpg:
	LDI_X(gs(.LDA))
	rjmp .read_zpg
.xa9_LDA_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.LDA:
	mov _A_,_data_	 ; A <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick
.xad_LDA_abs:
	LDI_X(gs(.LDA))
	rjmp .read_abs
.xb1_LDA_iny:
	LDI_X(gs(.LDA))
	rjmp .read_iny
.xb5_LDA_zpx:
	LDI_X(gs(.LDA))
	rjmp .read_zpx
.xb9_LDA_aby:
	LDI_X(gs(.LDA))
	rjmp .read_aby
.xbd_LDA_abx:
	LDI_X(gs(.LDA))
	rjmp .read_abx
.xc1_CMP_inx:
	LDI_X(gs(.CMP))
	rjmp .read_inx
.xc5_CMP_zpg:
	LDI_X(gs(.CMP))
	rjmp .read_zpg
.xc9_CMP_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.CMP:
	mov _Z_,_A_	 ; Z <- A
	sub _Z_,_data_	 ; Z <- A - data
	mov _N_,_Z_	 ; N <- A - data
	clr _C_	 ;
	brlo .CMP_carry	 ; branch if A < data
	inc _C_	 ; C <- 1 if A >= data
.CMP_carry:
	rjmp .tick
.xcd_CMP_abs:
	LDI_X(gs(.CMP))
	rjmp .read_abs
.xd1_CMP_iny:
	LDI_X(gs(.CMP))
	rjmp .read_iny
.xd5_CMP_zpx:
	LDI_X(gs(.CMP))
	rjmp .read_zpx
.xd9_CMP_aby:
	LDI_X(gs(.CMP))
	rjmp .read_aby
.xdd_CMP_abx:
	LDI_X(gs(.CMP))
	rjmp .read_abx
.xe1_SBC_inx:
	LDI_X(gs(.SBC))
	rjmp .read_inx
.xe5_SBC_zpg:
	LDI_X(gs(.SBC))
	rjmp .read_zpg
.xe9_SBC_imm:
.xeb_SBC_imm_undocumented:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.SBC:
	sbrc _P_,3	 ; skip if decimal mode is set
	rjmp .SBC_dec	 ; jump if decimal mode is clear
.SBC_bin:
	com _data_	 ; data <- ~data
	lsr _C_	 ; carry <- C <- 0
	adc _A_,_data_	 ; (carry, A) <- A + data + carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	brvs .SBC_bin_overflow	 ; branch on overflow
	rol _C_	 ; C <- carry <- 0
	andi _P_,~V_FLAG	 ; P &= ~V_FLAG
	rjmp .tick
.SBC_bin_overflow:
	rol _C_	 ; C <- carry <- 0
	ori _P_,V_FLAG	 ; P |= V_FLAG
	rjmp .tick
.SBC_dec:
	mov r20,_A_	 ;  reg_a.250, reg_a
	mov r18,_C_	 ;  flag_c, flag_c
	mov r25,r20	 ;  D.3761, reg_a.250
	andi r25,0x0f	 ;  D.3761,
	add r25,r18	 ;  D.3761, flag_c
	mov r18,_data_	 ;  D.3761, D.3761
	andi r18,0x0f	 ;  D.3761,
	sub r25,r18	 ;  D.3761, D.3761
	ldi r18,lo8(-7)	 ;  result,
	add r18,r25	 ;  result, D.3761
	cpi r18,lo8(-16)	 ;  result,
	brsh .L31	 ; ,
	ldi r18,lo8(9)	 ;  result,
	add r18,r25	 ;  result, D.3761
.L31:
	mov r25,r20	 ;  result, reg_a.250
	andi r25,0xf0	 ;  result,
	mov r19,_data_	 ;  D.3761, D.3761
	andi r19,0xf0	 ;  D.3761,
	sub r25,r19	 ;  result, D.3761
	add r25,r18	 ;  result, result
	mov _Z_,r25	 ;  flag_z, result
	mov _N_,r25	 ;  flag_n, result
	mov r18,r25	 ;  D.3761, result
	eor r18,r20	 ;  D.3761, reg_a.250
	eor r20,_data_	 ;  D.3761, D.3761
	and r18,r20	 ;  D.3761, D.3761
	bst r18,7	 ; t <- (A ^ result) & (A ^ data) bit 7
	bld _P_,6	 ; P.6 <- t
	mov _C_,__zero_reg__	 ;  flag_c,
	subi r25,0x60	 ;  result,
	mov _A_,r25	 ;  reg_a, result
	rjmp .tick
.xed_SBC_abs:
	LDI_X(gs(.SBC))
	rjmp .read_abs
.xf1_SBC_iny:
	LDI_X(gs(.SBC))
	rjmp .read_iny
.xf5_SBC_zpx:
	LDI_X(gs(.SBC))
	rjmp .read_zpx
.xf9_SBC_aby:
	LDI_X(gs(.SBC))
	rjmp .read_aby
.xfd_SBC_abx:
	LDI_X(gs(.SBC))
	rjmp .read_abx
.xa2_LDX_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.LDX:
	mov _X_,_data_	 ; X <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick	 ;
.xa6_LDX_zpg:
	LDI_X(gs(.LDX))
	rjmp .read_zpg
.xae_LDX_abs:
	LDI_X(gs(.LDX))
	rjmp .read_abs
.xb6_LDX_zpy:
	LDI_X(gs(.LDX))
	rjmp .read_zpy
.xbe_LDX_aby:
	LDI_X(gs(.LDX))
	rjmp .read_aby
.xa0_LDY_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.LDY:
	mov _Y_,_data_	 ; Y <- data
	sub _Z_,_data_	 ;
	mov _N_,_data_	 ;
	rjmp .tick	 ;
.xa4_LDY_zpg:
	LDI_X(gs(.LDY))
	rjmp .read_zpg
.xac_LDY_abs:
	LDI_X(gs(.LDY))
	rjmp .read_abs
.xb4_LDY_zpx:
	LDI_X(gs(.LDY))
	rjmp .read_zpx
.xbc_LDY_abx:
	LDI_X(gs(.LDY))
	rjmp .read_abx
.xe0_CPX_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.CPX:
	mov _Z_,_X_	 ; Z <- X
	sub _Z_,_data_	 ; Z <- X - data
	mov _N_,_Z_	 ; N <- X - data
	clr _C_	 ; C <- 0
	brlo .CPX_carry	 ; branch if X < data
	inc _C_	 ; C <- 1 if X >= data
.CPX_carry:
	rjmp .tick
.xe4_CPX_zpg:
	LDI_X(gs(.CPX))
	rjmp .read_zpg
.xec_CPX_abs:
	LDI_X(gs(.CPX))
	rjmp .read_abs
.xc0_CPY_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.CPY:
	mov _Z_,_Y_	 ; Z <- Y
	sub _Z_,_data_	 ; Z <- Y - data
	mov _N_,_Z_	 ; N <- Y - data
	clr _C_	 ; C <- 0
	brlo .CPY_carry	 ; branch if Y < data
	inc _C_	 ; C <- 1 if Y >= data
.CPY_carry:
	rjmp .tick
.xc4_CPY_zpg:
	LDI_X(gs(.CPY))
	rjmp .read_zpg
.xcc_CPY_abs:
	LDI_X(gs(.CPY))
	rjmp .read_abs
.x24_BIT_zpg:
	LDI_X(gs(.BIT))
	rjmp .read_zpg
.x2c_BIT_abs:
	LDI_X(gs(.BIT))
	rjmp .read_abs
.BIT:
	bst _data_,6	 ;
	bld _P_,6	 ; V <- data.6
	mov _N_,_data_	 ; N <- data.7
	and _data_,_A_	 ;
	mov _Z_,_data_	 ; Z <- data & A
	rjmp .tick

/* Undocumented read instructions */

.LAX:
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	mov _X_,_data_	 ;
	mov _A_,_data_	 ;
	rjmp .tick
.xa3_LAX_inx_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_inx
.xa7_LAX_zpg_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_zpg
.xaf_LAX_abs_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_abs
.xb3_LAX_iny_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_iny
.xb7_LAX_zpy_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_zpy
.xbf_LAX_aby_undocumented:
	LDI_X(gs(.LAX))
	rjmp .read_aby

.x80_NOP_imm_undocumented:
.x82_NOP_imm_undocumented:
.x89_NOP_imm_undocumented:
.xc2_NOP_imm_undocumented:
.xe2_NOP_imm_undocumented:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
.NOP:
	rjmp .tick	 ;
.x04_NOP_zpg_undocumented:
.x44_NOP_zpg_undocumented:
.x64_NOP_zpg_undocumented:
	LDI_X(gs(.NOP))
	rjmp .read_zpg
.x0c_NOP_abs_undocumented:
	LDI_X(gs(.NOP))
	rjmp .read_abs
.x14_NOP_zpx_undocumented:
.x34_NOP_zpx_undocumented:
.x54_NOP_zpx_undocumented:
.x74_NOP_zpx_undocumented:
.xd4_NOP_zpx_undocumented:
.xf4_NOP_zpx_undocumented:
	LDI_X(gs(.NOP))
	rjmp .read_zpx
.x1c_NOP_abx_undocumented:
.x3c_NOP_abx_undocumented:
.x5c_NOP_abx_undocumented:
.x7c_NOP_abx_undocumented:
.xdc_NOP_abx_undocumented:
.xfc_NOP_abx_undocumented:
	LDI_X(gs(.NOP))
	rjmp .read_abx

/******************* ADDRESSING MODES FOR READ INSTRUCTIONS *******************/
/*
input:  return address in XH:XL
output: data value in _data_, tick count in _cycles_
*/
.read_imm:
	adiw _PCL_,2	 ; PC += 2
	ldi _cycles_,2	 ; cycles <- 2
	movw ZL,XL
	ijmp
.read_zpg:
	adiw _PCL_,2	 ; PC += 2
	LD_ZERO_PAGE(_data_,_data_)	 ; data <- ram[data]
	ldi _cycles_,3	 ; cycles <- 3
	movw ZL,XL
	ijmp
.read_zpx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	LD_ZERO_PAGE(_data_,_data_)	 ; data <- ram[data]
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.read_zpy:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_Y_	 ; r24 += Y
	LD_ZERO_PAGE(_data_,_data_)	 ; data <- ram[data]
	ldi _cycles_,4	 ; cycles <- 4
	movw ZL,XL
	ijmp
.read_abs:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
.read_abs_no_carry:
	ldi _cycles_,4	 ; cycles <- 4
.read_mem:	 ; data <- read(r25:r24), ijmp (XH:XL)
	cpi r25,0x04	 ; branch if addr_hi >= 0x40
	brsh .read_mem_L6	 ;
	movw ZL,r24	 ;
	subi ZH,hi8(-(ram))	 ;
	ld _data_,Z	 ; load from ram[addr]
	movw ZL,XL
	ijmp
.read_mem_L6:
	cpi r25,0xc0	 ; branch if addr_hi < 0xc0
	brlo .read_mem_L9	 ;
	movw ZL,r24	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm _data_,Z	 ; load from rom[addr - 0xc0000]
	movw ZL,XL
	ijmp
.read_mem_L9:
	ldi _data_,0xff	 ; other addresses return 0xff
	movw ZL,XL
	ijmp
.read_abx:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_X_	 ; r24 += X
	brcc .read_abs_no_carry	 ; branch unless r24+X carries
	inc r25	 ; r25++
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .read_mem	 ; data <- read(r25:r24), ijmp (XH:XL)
.read_aby:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_Y_	 ; r24 += Y
	brcc .read_abs_no_carry	 ; branch unless r24+X carries
	inc r25	 ; r25++
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .read_mem	 ; data <- read(r25:r24), ijmp (XH:XL)
.read_inx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	ldi _cycles_,6	 ; cycles <- 6
	rjmp .read_mem	 ; data <- read(r25:r24), ijmp (XH:XL)
.read_iny:
	adiw _PCL_,2	 ; PC += 2
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	add r24,_Y_	 ; r24 += Y
	brcs .read_iny_carry	 ; branch if r24+Y carries
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .read_mem	 ; data <- read(r25:r24), ijmp (XH:XL)
.read_iny_carry:
	inc r25	 ; r25++
	ldi _cycles_,6	 ; cycles <- 6
	rjmp .read_mem	 ; data <- read(r25:r24), ijmp (XH:XL)

/*********************** READ-MODIFY-WRITE INSTRUCTIONS ***********************/

.x0a_ASL_acc:
	adiw _PCL_,1	 ; PC++
	clr _C_	 ; C <- 0
	lsl _A_	 ; A <- A << 1, carry <- A bit 7
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x2a_ROL_acc:
	adiw _PCL_,1	 ; PC++
	lsr _C_	 ; carry <- C, C <- 0
	rol _A_	 ; carry <- A7, A <- [A6, A5 .. A0, carry]
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x4a_LSR_acc:
	adiw _PCL_,1	 ; PC++
	clr _C_	 ; C <- 0
	lsr _A_	 ; A <- [0, A7, .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x6a_ROR_acc:
	adiw _PCL_,1	 ; PC++
	lsr _C_	 ; carry <- C, C <- 0
	ror _A_	 ; A <- [carry, A7 .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)

.ASL:
	clr _C_	 ; C <- 0
	lsl _data_	 ; A <- A << 1, carry <- A bit 7
	rol _C_	 ; C <- carry
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.x06_ASL_zpg:
	LDI_Z(gs(.ASL))
	rjmp .modify_zpg
.x0e_ASL_abs:
	LDI_X(gs(.ASL))
	rjmp .modify_abs
.x16_ASL_zpx:
	LDI_Z(gs(.ASL))
	rjmp .modify_zpx
.x1e_ASL_abx:
	LDI_X(gs(.ASL))
	rjmp .modify_abx
.ROL:
	lsr _C_	 ; carry <- C, C <- 0
	rol _data_	 ; carry <- A7, A <- [A6, A5 .. A0, carry]
	rol _C_	 ; C <- carry
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.x26_ROL_zpg:
	LDI_Z(gs(.ROL))
	rjmp .modify_zpg
.x2e_ROL_abs:
	LDI_X(gs(.ROL))
	rjmp .modify_abs
.x36_ROL_zpx:
	LDI_Z(gs(.ROL))
	rjmp .modify_zpx
.x3e_ROL_abx:
	LDI_X(gs(.ROL))
	rjmp .modify_abx
.LSR:
	clr _C_	 ; C <- 0
	lsr _data_	 ; A <- [0, A7, .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.x46_LSR_zpg:
	LDI_Z(gs(.LSR))
	rjmp .modify_zpg
.x4e_LSR_abs:
	LDI_X(gs(.LSR))
	rjmp .modify_abs
.x56_LSR_zpx:
	LDI_Z(gs(.LSR))
	rjmp .modify_zpx
.x5e_LSR_abx:
	LDI_X(gs(.LSR))
	rjmp .modify_abx
.ROR:
	lsr _C_	 ; carry <- C, C <- 0
	ror _data_	 ; A <- [carry, A7 .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.x66_ROR_zpg:
	LDI_Z(gs(.ROR))
	rjmp .modify_zpg
.x6e_ROR_abs:
	LDI_X(gs(.ROR))
	rjmp .modify_abs
.x76_ROR_zpx:
	LDI_Z(gs(.ROR))
	rjmp .modify_zpx
.x7e_ROR_abx:
	LDI_X(gs(.ROR))
	rjmp .modify_abx
.DEC:
	dec _data_	 ; data--
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.xc6_DEC_zpg:
	LDI_Z(gs(.DEC))
	rjmp .modify_zpg
.xce_DEC_abs:
	LDI_X(gs(.DEC))
	rjmp .modify_abs
.xd6_DEC_zpx:
	LDI_Z(gs(.DEC))
	rjmp .modify_zpx
.xde_DEC_abx:
	LDI_X(gs(.DEC))
	rjmp .modify_abx
.INC:
	inc _data_	 ; data++
	mov _Z_,_data_	 ;
	mov _N_,_data_	 ;
	ret
.xe6_INC_zpg:
	LDI_Z(gs(.INC))
	rjmp .modify_zpg
.xee_INC_abs:
	LDI_X(gs(.INC))
	rjmp .modify_abs
.xf6_INC_zpx:
	LDI_Z(gs(.INC))
	rjmp .modify_zpx
.xfe_INC_abx:
	LDI_X(gs(.INC))
	rjmp .modify_abx

.SLO:
	/* ASL */
	lsr _C_	 ; carry <- C <- 0
	lsl _data_	 ; carry <- data.7 <- ... <- data.0 <- 0
	rol _C_	 ; C <- carry <- 0
	/* ORA */
	or _A_,_data_	 ; A |= data
	mov _Z_,_A_
	mov _N_,_A_
	ret
.x03_SLO_inx_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_inx
.x07_SLO_zpg_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_zpg
.x0f_SLO_abs_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_abs
.x13_SLO_iny_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_iny
.x17_SLO_zpx_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_zpx
.x1b_SLO_aby_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_aby
.x1f_SLO_abx_undocumented:
	LDI_Z(gs(.SLO))
	rjmp .modify_abx
.RLA:
	/* ROL */
	lsr _C_	 ; carry <- C <- 0
	rol _data_	 ; carry <- data.7 <- ... <- data.0 <- carry
	rol _C_	 ; C <- carry <- 0
	/* AND */
	and _A_,_data_	 ; A &= data
	mov _Z_,_A_
	mov _N_,_A_
	ret
.x23_RLA_inx_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_inx
.x27_RLA_zpg_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_zpg
.x2f_RLA_abs_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_abs
.x33_RLA_iny_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_iny
.x37_RLA_zpx_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_zpx
.x3b_RLA_aby_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_aby
.x3f_RLA_abx_undocumented:
	LDI_Z(gs(.RLA))
	rjmp .modify_abx
.SRE:
	/* LSR */
	lsr _C_	 ; carry <- C <- 0
	lsr _data_	 ; carry <- data.0 <- ... <- data.7 <- 0
	rol _C_	 ; C <- carry <- 0
	/* EOR */
	eor _A_,_data_	 ; A ^= data
	mov _Z_,_A_
	mov _N_,_A_
	ret
.x43_SRE_inx_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_inx
.x47_SRE_zpg_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_zpg
.x4f_SRE_abs_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_abs
.x53_SRE_iny_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_iny
.x57_SRE_zpx_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_zpx
.x5b_SRE_aby_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_aby
.x5f_SRE_abx_undocumented:
	LDI_Z(gs(.SRE))
	rjmp .modify_abx
.RRA:
	/* ROR */
	lsr _C_	 ; carry <- C <- 0
	ror _data_	 ; carry <- data.0 <- ... <- data.7 <- carry
	/* ADC */
	adc _A_,_data_	 ; (carry, A) <- A + data + carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	brvs .RRA_overflow	 ; branch on overflow
	rol _C_	 ; C <- carry <- 0
	andi _P_,~V_FLAG	 ; P &= ~V_FLAG
	ret
.RRA_overflow:
	rol _C_	 ; C <- carry <- 0
	ori _P_,V_FLAG	 ; P |= V_FLAG
	ret
.x63_RRA_inx_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_inx
.x67_RRA_zpg_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_zpg
.x6f_RRA_abs_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_abs
.x73_RRA_iny_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_iny
.x77_RRA_zpx_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_zpx
.x7b_RRA_aby_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_aby
.x7f_RRA_abx_undocumented:
	LDI_Z(gs(.RRA))
	rjmp .modify_abx
.DCP:
	/* DEC */
	dec _data_	 ; data--
	/* CMP */
	mov _Z_,_A_	 ; Z <- A
	sub _Z_,_data_	 ; Z <- A - data
	mov _N_,_Z_	 ; N <- A - data
	clr _C_	 ;
	brlo .DCP_carry	 ; branch if A < data
	inc _C_	 ; C <- 1 if A >= data
.DCP_carry:
	ret
.xc3_DCP_inx_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_inx
.xc7_DCP_zpg_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_zpg
.xcf_DCP_abs_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_abs
.xd3_DCP_iny_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_iny
.xd7_DCP_zpx_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_zpx
.xdb_DCP_aby_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_aby
.xdf_DCP_abx_undocumented:
	LDI_Z(gs(.DCP))
	rjmp .modify_abx
.ISB:
	/* INC */
	inc _data_	 ; data++
	/* SBC */
	com _C_	 ; toggle carry
	lsr _C_	 ; carry <- ~C <- 0
	sbc _A_,_data_	 ; (carry, A) <- A - data - carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	brvs .ISB_overflow	 ; branch on overflow
	rol _C_	 ; ~C <- carry <- 0
	com _C_	 ; un-toggle carry
	andi _P_,~V_FLAG	 ; P &= ~V_FLAG
	ret
.ISB_overflow:
	rol _C_	 ; C <- carry <- 0
	com _C_	 ; un-toggle carry
	ori _P_,V_FLAG	 ; P |= V_FLAG
	ret
.xe3_ISB_inx_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_inx
.xe7_ISB_zpg_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_zpg
.xef_ISB_abs_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_abs
.xf3_ISB_iny_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_iny
.xf7_ISB_zpx_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_zpx
.xfb_ISB_aby_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_aby
.xff_ISB_abx_undocumented:
	LDI_Z(gs(.ISB))
	rjmp .modify_abx

/*
input:  function pointer in ZH:ZL, to be used with icall
        the function should use _data_ as input and output
*/
.modify_zpg:
	adiw _PCL_,2	 ; PC += 2
	mov XL,_data_	 ;
	ldi XH,ZERO_PAGE	 ;
	ld _data_,X	 ; data <- zero_page
	icall	 ; data <- f(data)
	st X,_data_	 ; zero_page <- data
	TICK(5)
.modify_zpx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	mov XL,_data_	 ;
	ldi XH,ZERO_PAGE	 ;
	ld _data_,X	 ; data <- ram[addr]
	icall	 ; data <- f(data)
	st X,_data_	 ; ram[addr] <- data
	TICK(6)
.modify_abs:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	ldi _cycles_,6	 ; cycles <- 6
.modify_mem:	 ; data <- read(r25:r24), ijmp (XH:XL)
	cpi r25,0x04	 ; branch if addr_hi >= 0x40
	brsh .modify_mem_hi	 ;
	movw XL,r24	 ;
	subi XH,hi8(-(ram))	 ;
	ld _data_,X	 ; data <- ram[r25:r24]
	icall	 ; data <- f(data)
	st X,_data_	 ; ram[r25:r24] <- data
	rjmp .tick
.modify_mem_hi:
	cpi r25,0xc0	 ; branch if addr_hi < 0xc0
	brlo .modify_mem_io	 ;
	movw XL,ZL	 ; save call address in X
	movw ZL,r24	 ;
	subi ZH,hi8(-(dos1541-0xc000))	 ;
	lpm _data_,Z	 ; data <- rom[addr - 0xc0000]
	movw ZL,XL	 ; restore call address from X
	icall	 ; data <- f(data)
	rjmp .tick
.modify_mem_io:
	/* TODO: read/write to IO memory */
	ldi _data_,0xff	 ; other addresses return 0xff
	icall	 ; data <- f(data)
	rjmp .tick
.modify_abx:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_X_	 ; r25:r24 += X
	adc r25,__zero_reg__	 ;
	ldi _cycles_,7	 ; cycles <- 7
	rjmp .modify_mem	 ; data <- modify(r25:r24), ijmp (XH:XL)
.modify_aby:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	ldi _cycles_,7	 ; cycles <- 7
	rjmp .modify_mem	 ; data <- modify(r25:r24), ijmp (XH:XL)
.modify_inx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	mov XL,_data_	 ;
	ldi XH,ZERO_PAGE	 ;
	ld r24,X	 ; r24 <- ram[data]
	inc XL	 ;
	ld r25,X	 ; r25 <- ram[data+1]
	ldi _cycles_,8	 ; cycles <- 8
	rjmp .modify_mem	 ; data <- modify(r25:r24), ijmp (XH:XL)
.modify_iny:
	adiw _PCL_,2	 ; PC += 2
	mov XL,_data_	 ;
	ldi XH,ZERO_PAGE	 ;
	ld r24,X	 ; r24 <- ram[data]
	inc XL	 ;
	ld r25,X	 ; r25 <- ram[data+1]
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	ldi _cycles_,8	 ; cycles <- 5
	rjmp .modify_mem	 ; data <- modify(r25:r24), ijmp (XH:XL)

/***************************** WRITE INSTRUCTIONS *****************************/

.x81_STA_inx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	ldi _cycles_,6	 ; cycles <- 6
	mov _value_,_A_	 ; value <- A
	rjmp .write_mem	 ; write(r25:r24,data), rjmp .tick
.x84_STY_zpg:
	adiw _PCL_,2	 ; PC += 2
	ST_ZERO_PAGE(_data_,_Y_)	 ; ram[data] <- Y
	TICK(3)
.x85_STA_zpg:
	adiw _PCL_,2	 ; PC += 2
	ST_ZERO_PAGE(_data_,_A_)	 ; ram[data] <- A
	TICK(3)
.x86_STX_zpg:
	adiw _PCL_,2	 ; PC += 2
	ST_ZERO_PAGE(_data_,_X_)	 ; ram[data] <- X
	TICK(3)
.x8c_STY_abs:
	mov _value_,_Y_
	rjmp .write_abs
.x8d_STA_abs:
	mov _value_,_A_
	rjmp .write_abs
.x8e_STX_abs:
	mov _value_,_X_
	rjmp .write_abs
.x91_STA_iny:
	adiw _PCL_,2	 ; PC += 2
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	ldi _cycles_,6	 ; cycles <- 6
	mov _value_,_A_	 ; value <- A
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.x94_STY_zpx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	ST_ZERO_PAGE(_data_,_Y_)	 ; ram[data] <- Y
	TICK(4)
.x95_STA_zpx:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	ST_ZERO_PAGE(_data_,_A_)	 ; ram[data] <- A
	TICK(4)
.x96_STX_zpy:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_Y_	 ; data += Y
	ST_ZERO_PAGE(_data_,_X_)	 ; ram[data] <- X
	TICK(4)
.x99_STA_aby:
	mov _value_,_A_
	rjmp .write_aby
.x9d_STA_abx:
	mov _value_,_A_
	rjmp .write_abx

.x83_SAX_inx_undocumented:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_X_	 ; data += X
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	ldi _cycles_,6	 ; cycles <- 6
	mov _value_,_A_	 ; value <- A
	and _value_,_X_	 ; value <- A & X
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.x87_SAX_zpg_undocumented:
	adiw _PCL_,2	 ; PC += 2
	mov r24,_A_
	and r24,_X_
	ST_ZERO_PAGE(_data_,24)	 ; ram[data] <- A & X
	TICK(3)
.x8f_SAX_abs_undocumented:
	mov _value_,_A_
	and _value_,_X_
	rjmp .write_abs
.x97_SAX_zpy_undocumented:
	adiw _PCL_,2	 ; PC += 2
	add _data_,_Y_	 ; data += Y
	mov r24,_A_	 ; temp <- A
	and r24,_X_	 ; temp <- A & X
	ST_ZERO_PAGE(_data_,24)	 ; ram[data] <- A & X
	TICK(4)
.x93_SHA_iny_undocumented:
	adiw _PCL_,2	 ; PC += 2
	LDW_ZERO_PAGE(24,_data_)	 ; r25:r24 <- ram[data+1]:ram[data]
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	ldi _cycles_,6	 ; cycles <- 6
	mov _value_,r25	 ; value <- addr_hi
	inc _value_	 ; value += 1
	and _value_,_X_	 ; value &= X
	and _value_,_A_	 ; value &= A
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.x9f_SHA_aby_undocumented:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	mov _value_,r25	 ; value <- addr_hi
	inc _value_	 ; value += 1
	and _value_,_X_	 ; value &= X
	and _value_,_A_	 ; value &= A
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.x9c_SHY_abx_undocumented:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_X_	 ; r25:r24 += X
	adc r25,__zero_reg__	 ;
	mov _value_,r25	 ; value <- addr_hi
	inc _value_	 ; value += 1
	and _value_,_Y_	 ; value &= Y
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.x9e_SHX_aby_undocumented:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	mov _value_,r25	 ; value <- addr_hi
	inc _value_	 ; value += 1
	and _value_,_X_	 ; value &= X
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick

.write_abs:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	ldi _cycles_,4	 ; cycles <- 4
.write_mem:	 ; write(r25:r24,value), rjmp .tick
	cpi r25,4	 ;
	brsh .write_mem_hi	 ; branch if address >= $0400
	movw ZL,r24	 ;
	subi ZH,hi8(-(ram))	 ;
	st Z,_value_	 ; ram[r25:r24] <- data
.write_mem_hi:
	/* TODO: write io memory */
	rjmp .tick
.write_abx:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_X_	 ; r25:r24 += X
	adc r25,__zero_reg__	 ;
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick
.write_aby:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	add r24,_Y_	 ; r25:r24 += Y
	adc r25,__zero_reg__	 ;
	ldi _cycles_,5	 ; cycles <- 5
	rjmp .write_mem	 ; write(r25:r24,value), rjmp .tick

/**************************** BRANCH INSTRUCTIONS *****************************/

.x10_BPL:
	adiw _PCL_,2	 ; PC += 2
	tst _N_	 ; branch on N >= 0
	brpl .take_branch	 ;
	TICK(2)
.x30_BMI:
	adiw _PCL_,2	 ; PC += 2
	tst _N_	 ; branch on N < 0
	brmi .take_branch	 ;
	TICK(2)
.x50_BVC:
	adiw _PCL_,2	 ; PC += 2
	bst _P_,6	 ; branch on P bit 6 = 0
	brtc .take_branch	 ;
	TICK(2)
.x70_BVS:
	adiw _PCL_,2	 ; PC += 2
	bst _P_,6	 ; branch on P bit 6 = 1
	brts .take_branch	 ;
	TICK(2)
.take_branch:
	add _PCL_,_data_	 ; PC += data
        tst _data_
        brcs .branch_carry
        brpl .branch_same_page	 ; branch if offset is positive
	dec _PCH_
	TICK(4)	 ; 4 cycles for branch to previous page
.branch_carry:
        brmi .branch_same_page	 ; branch if offset is negative
	inc _PCH_	 ;
	TICK(4)	 ; 4 cycles for branch to next page
.branch_same_page:
	TICK(3)	 ; 3 cycles for branch to same page
.x90_BCC:
	adiw _PCL_,2	 ; PC += 2
	tst _C_	 ; branch on C = 0
	breq .take_branch	 ;
	TICK(2)
.xb0_BCS:
	adiw _PCL_,2	 ; PC += 2
	tst _C_	 ; branch on C != 0
	brne .take_branch	 ;
	TICK(2)
.xd0_BNE:
	adiw _PCL_,2	 ; PC += 2
	tst _Z_	 ; branch on Z != 0
	brne .take_branch	 ;
	TICK(2)
.xf0_BEQ:
	adiw _PCL_,2	 ; PC += 2
	tst _Z_	 ; branch on Z = 0
	breq .take_branch	 ;
	TICK(2)

/***************************** FLAG INSTRUCTIONS ******************************/

.x18_CLC:
	adiw _PCL_,1	 ; PC++
	clr _C_	 ; C <- 0
	TICK(2)
.x38_SEC:
	adiw _PCL_,1	 ; PC++
	clr _C_	 ;
	inc _C_	 ; C <- 1
	TICK(2)
.x58_CLI:
	adiw _PCL_,1	 ; PC++
	andi _P_,~I_FLAG	 ; P &= ~I_FLAG
	TICK(2)
.x78_SEI:
	adiw _PCL_,1	 ; PC++
	ori _P_,I_FLAG	 ; P |= I_FLAG
	TICK(2)
.xb8_CLV:
	adiw _PCL_,1	 ; PC++
	andi _P_,~V_FLAG	 ; P &= ~V_FLAG
	TICK(2)
.xd8_CLD:
	adiw _PCL_,1	 ; PC++
	andi _P_,~D_FLAG	 ; P &= ~D_FLAG
	TICK(2)
.xf8_SED:
	adiw _PCL_,1	 ; PC++
	ori _P_,D_FLAG	 ; P |= D_FLAG
	TICK(2)

/*************************** REGISTER INSTRUCTIONS ****************************/

.xca_DEX:
	adiw _PCL_,1	 ; PC++
	dec _X_	 ; X--
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	TICK(2)
.xe8_INX:
	adiw _PCL_,1	 ; PC++
	inc _X_	 ; X++
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	TICK(2)
.x88_DEY:
	adiw _PCL_,1	 ; PC++
	dec _Y_	 ; Y--
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	TICK(2)
.xc8_INY:
	adiw _PCL_,1	 ; PC++
	inc _Y_	 ; Y++
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	TICK(2)
.x8a_TXA:
	adiw _PCL_,1	 ; PC++
	mov _A_,_X_	 ; A <- X
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	TICK(2)
.xaa_TAX:
	adiw _PCL_,1	 ; PC++
	mov _X_,_A_	 ; X <- A
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x98_TYA:
	adiw _PCL_,1	 ; PC++
	mov _A_,_Y_	 ; A <- Y
	mov _Z_,_Y_	 ;
	mov _N_,_Y_	 ;
	TICK(2)
.xa8_TAY:
	adiw _PCL_,1	 ; PC++
	mov _Y_,_A_	 ; Y <- A
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x9a_TXS:
	adiw _PCL_,1	 ; PC++
	mov _S_,_X_	 ; S <- X
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	TICK(2)
.xba_TSX:
	adiw _PCL_,1	 ; PC++
	mov _X_,_S_	 ; X <- S
	mov _Z_,_S_	 ;
	mov _N_,_S_	 ;
	TICK(2)
.xea_NOP:
.x1a_NOP_undocumented:
.x3a_NOP_undocumented:
.x5a_NOP_undocumented:
.x7a_NOP_undocumented:
.xda_NOP_undocumented:
.xfa_NOP_undocumented:
	adiw _PCL_,1	 ; PC++
	TICK(2)

/*************************** STACK/PC INSTRUCTIONS ****************************/

.x00_BRK:
	adiw _PCL_,2	 ; PC += 2
	PUSH(_PCH_)	 ; push address of the BRK instruction +2
	PUSH(_PCL_)
	rcall pack_flags	 ;
	ori _P_,B_FLAG	 ; P |= B_FLAG
	PUSH(_P_)	 ; stack[S--] <- P
	ori _P_,I_FLAG	 ; P |= I_FLAG (disable interrupts)
	ldi r24,0xfe	 ;
	ldi r25,0xff	 ;
	rcall mem_read_16	 ; r25:r24 <- mem_read(0xfffe)
	movw _PCL_,r24	 ; PC <- r25:r24
	TICK(7)
.x20_JSR:
	rcall addr_abs	 ;
	sbiw _PCL_,1	 ; PC -= 1
	PUSH(_PCH_)	 ; push address of next instruction - 1
	PUSH(_PCL_)	 ;
	movw _PCL_,r24	 ; PC <- address
	TICK(6)
.x40_RTI:
	PULL(_P_)	 ; P <- stack[++S]
	rcall unpack_flags	 ;
	PULL(_PCL_)	 ; PCL <- stack[++S]
	PULL(_PCH_)	 ; PCH <- stack[++S]
	TICK(6)
.x60_RTS:
	PULL(_PCL_)	 ; PCL <- stack[++S]
	PULL(_PCH_)	 ; PCH <- stack[++S]
	adiw _PCL_,1	 ; PC ++
	TICK(6)
.x4c_JMP_abs:
	rcall addr_abs	 ;
	movw _PCL_,r24	 ;  reg_pc,
	TICK(3)
.x6c_JMP_ind:
	rcall addr_abs	 ; r25:r24 <- mem_read(++PC), PC += 2
	rcall mem_read_16	 ; r25:r24 <- mem_read(r25:r24)
	movw _PCL_,r24	 ;  reg_pc,
	TICK(5)
.x08_PHP:
	adiw _PCL_,1	 ; PC++
	rcall pack_flags	 ;
	PUSH(_P_)	 ; stack[S--] <- P
	TICK(3)
.x28_PLP:
	adiw _PCL_,1	 ; PC++
	PULL(_P_)	 ; P <- stack[++S]
	rcall unpack_flags	 ;
	TICK(4)
.x48_PHA:
	adiw _PCL_,1	 ; PC++
	PUSH(_A_)	 ; stack[S--] <- A
	TICK(3)
.x68_PLA:
	adiw _PCL_,1	 ; PC++
	PULL(_A_)	 ; A <- stack[++S]
	mov _Z_,_A_	 ; Z <- A
	mov _N_,_A_	 ; N <- A
	TICK(4)

/******************************************************************************/

.x0b_ANC_imm_undocumented:
.x2b_ANC_imm_undocumented:
	adiw _PCL_,2	 ; PC += 2
	and _A_,_data_	 ; A &= data
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	bst _A_,7	 ;
	bld _C_,0	 ; C <- A.7
	TICK(2)
.x4b_ASR_imm_undocumented:
	/* AND + LSR */
	adiw _PCL_,2	 ; PC += 2
	and _A_,_data_	 ; A &= data
	clr _C_	 ; C <- 0
	lsr _A_	 ; A <- [0, A7, .. A2, A1], carry <- A0
	rol _C_	 ; C <- carry
	mov _Z_,_A_	 ;
	mov _N_,_A_	 ;
	TICK(2)
.x6b:
	adiw _PCL_,1	 ; PC++
	/* TODO */
	TICK(2)
.x8b:
	adiw _PCL_,1	 ; PC++
	/* TODO */
	TICK(2)
.x9b:
	adiw _PCL_,1	 ; PC++
	/* TODO */
	TICK(5)

.xab:
	adiw _PCL_,1	 ; PC++
	/* TODO */
	TICK(2)
.xbb:
	adiw _PCL_,1	 ; PC++
	/* TODO */
	TICK(4)
.xcb_SBX_imm_undocumented:
	adiw _PCL_,2	 ; PC += 2
	and _X_,_A_	 ; X &= A
	sub _X_,_data_	 ; X -= data
	clr _C_	 ; C <- 0
	brlo .L356	 ; branch if X & A < data
	inc _C_	 ; C <- 1 if X & A >= data
.L356:
	mov _Z_,_X_	 ;
	mov _N_,_X_	 ;
	TICK(2)
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
	TICK(128)	 ; loop in place, very slowly

/******************************************************************************/

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
