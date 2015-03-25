        .file        "cpu.S"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
const_one = 2

/* Static register variables */
_A = 20
_X = 4
_Y = 5
_S = 6
_P = 16
_NZC = 17
_PCL = 24
_PCH = 25
time0 = 18
time1 = 19
time2 = 14
time3 = 15
/* Loop-local register variables */
value = 3
opcode = 10
opcode_hi = 11
cycles = 21
fptr_lo = 22
fptr_hi = 23
data = 28
addr_lo = 28
addr_hi = 29
XL = 26
XH = 27
YL = 28
YH = 29
ZL = 30
ZH = 31
temp0 = 26

;;; Format of status flag (6502 vs AVR)
;;; 6502: NV1BDIZC
;;; AVR:  ITHSVNZC

/* Status flags */
C_FLAG = 0x01
Z_FLAG = 0x02
I_FLAG = 0x04
D_FLAG = 0x08
B_FLAG = 0x10
/* bit 5 is always 1 */
V_FLAG = 0x40
N_FLAG = 0x80

#define TICK(n) \
        subi time0,(n) $ \
        rjmp ticked

#define TICK1(n) \
        subi time0,(n) $ \
        rjmp ticked1

#define ZERO_PAGE hi8(ram)
#define STACK_PAGE hi8(ram+256)
#define ROM_PAGE_FF hi8(dos1541-0xc000+0xff00)
#define RAM_PAGES 4 /* should be 8 if we have more than 2k of SRAM available */

.macro LED_INIT
        ;; Bit 5 for Nano, bit 7 for Mega
        sbi 4,5                 ; Set DDRB5 to 'output'
.endm
.macro LED_ON                   ; Turn on LED
        sbi 5,5                 ; Set PORTB5 (pin 13, LED)
.endm
.macro LED_OFF                  ; Turn off LED
        cbi 5,5                 ; Clear PORTB5 (pin 13, LED)
.endm

#define PUSH(reg)                 \
        mov ZL, _S              $ \
        ldi ZH, STACK_PAGE      $ \
        st Z, (reg)             $ \
        dec _S

#define PULL(reg)                 \
        inc _S                  $ \
        mov ZL, _S              $ \
        ldi ZH, STACK_PAGE      $ \
        ld (reg), Z

/* reg+1:reg <- ram[addr+1]:ram[addr] */
#define LDW_ZERO_PAGE(reg,addr)   \
        mov ZL,(addr)           $ \
        ldi ZH,ZERO_PAGE        $ \
        ld (reg),Z              $ \
        inc ZL                  $ \
        ld (reg)+1,Z

        .section        .text.clock_advance,"ax",@progbits
        .type        clock_advance, @function
clock_advance:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        sub time0,cycles        ;  time_left.20, D.3675
        sbc time1,__zero_reg__  ;  time_left.20, D.3675
        sbc time2,__zero_reg__  ;  time_left.20, D.3675
        sbc time3,__zero_reg__  ;  time_left.20, D.3675
        ret
        .size        clock_advance, .-clock_advance
        .section        .text.unpack_flags,"ax",@progbits
        .type        unpack_flags, @function
unpack_flags:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        bst _P,0                ; C <- P.0
        bld _NZC,0
        bst _P,1                ; Z <- P.1
        bld _NZC,1
        bst _P,7                ; N <- P.7
        bld _NZC,2
        ret
        .size        unpack_flags, .-unpack_flags
        .section        .text.pack_flags,"ax",@progbits
        .type        pack_flags, @function
pack_flags:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        bst _NZC,0              ; P.0 <- C
        bld _P,0
        bst _NZC,1              ; P.1 <- Z
        bld _P,1
        bst _NZC,2              ; P.7 <- N
        bld _P,7
        cbr _P,B_FLAG           ; clear B flag
        sbr _P,0x20             ; set 1 flag
        ret
        .size        pack_flags, .-pack_flags
        .section        .text.addr_abs,"ax",@progbits
.global        addr_abs
        .type        addr_abs, @function
addr_abs:
/* addr_hi:addr_lo <- mem_read(++PC), PC += 2 */
/* assumes that mem(PC+1) is already in data/addr_lo */
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
/* cycles: 8+ret = 12 */
.L__stack_usage = 0
        movw ZL,_PCL            ; Z <- PC
        adiw _PCL,1             ; PC++
        brpl addr_abs_lo        ;
addr_abs_hi:
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm addr_hi,Z           ; addr_hi <- rom[PC - 0xc0000]
        ret
addr_abs_lo:
        subi ZH,hi8(-(ram))     ;
        ld addr_hi,Z            ; load from ram[addr]
        ret
        .size        addr_abs, .-addr_abs
        .section        .text.cpu_reset,"ax",@progbits
.global        cpu_reset
        .type        cpu_reset, @function
cpu_reset:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        ldi ZL,0xfc
        ldi ZH,ROM_PAGE_FF
        lpm r24,Z+              ; PCL <- rom[0xfffc]
        sts reg_pc,r24
        lpm r24,Z               ; PCH <- rom[0xfffd]
        sts reg_pc+1,r24
        ldi r24,0xff
        sts time_left,r24
        sts time_left+1,r24
        sts time_left+2,r24
        sts time_left+3,r24
        ret
        .size        cpu_reset, .-cpu_reset
        .section        .text.cpu_get_pc,"ax",@progbits
.global        cpu_get_pc
        .type        cpu_get_pc, @function
cpu_get_pc:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        lds r24,reg_pc
        lds r25,reg_pc+1
        ret
        .size        cpu_get_pc, .-cpu_get_pc
        .section        .text.cpu_get_regs,"ax",@progbits
.global        cpu_get_regs
        .type        cpu_get_regs, @function
cpu_get_regs:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        lds r25,reg_a
        lds r24,reg_x
        lds r23,reg_y
        lds r22,reg_s
        ret
        .size        cpu_get_regs, .-cpu_get_regs
        .section        .text.cpu_irq,"ax",@progbits
.global        cpu_irq
        .type        cpu_irq, @function
cpu_irq:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        sbrc _P,2               ; skip if I flag is clear
        ret                     ;
        PUSH(_PCH)
        PUSH(_PCL)
        rcall pack_flags        ;
        PUSH(_P)                ; stack[S--] <- P
        sbr _P,I_FLAG           ; set I flag
        ldi ZL,0xfe
        ldi ZH,ROM_PAGE_FF
        lpm _PCL,Z+             ; PCL <- rom[0xfffe]
        lpm _PCH,Z              ; PCH <- rom[0xffff]
        ldi cycles,7            ; 7 cycles
        rjmp clock_advance      ;
        ret
        .size        cpu_irq, .-cpu_irq
        .section        .text.cpu_nmi,"ax",@progbits
.global        cpu_nmi
        .type        cpu_nmi, @function
cpu_nmi:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        PUSH(_PCH)
        PUSH(_PCL)
        rcall pack_flags        ;
        PUSH(_P)                ; stack[S--] <- P
        ldi ZL,0xfa
        ldi ZH,ROM_PAGE_FF
        lpm _PCL,Z+             ; PCL <- rom[0xfffa]
        lpm _PCH,Z              ; PCH <- rom[0xfffb]
        ldi cycles,7            ; 7 cycles
        rjmp clock_advance      ;
        ret
        .size        cpu_nmi, .-cpu_nmi
        .section        .text.cpu_main,"ax",@progbits
/* align to 256-word (512-byte) boundary */
.p2align 9
opcode_table:
        rjmp x00_BRK
        rjmp x01_ORA_inx
        rjmp x02
        rjmp x03_SLO_inx_undocumented
        rjmp x04_NOP_zpg_undocumented
        rjmp x05_ORA_zpg
        rjmp x06_ASL_zpg
        rjmp x07_SLO_zpg_undocumented
        rjmp x08_PHP
        rjmp x09_ORA_imm
        rjmp x0a_ASL_acc
        rjmp x0b_ANC_imm_undocumented
        rjmp x0c_NOP_abs_undocumented
        rjmp x0d_ORA_abs
        rjmp x0e_ASL_abs
        rjmp x0f_SLO_abs_undocumented
        rjmp x10_BPL
        rjmp x11_ORA_iny
        rjmp x12
        rjmp x13_SLO_iny_undocumented
        rjmp x14_NOP_zpx_undocumented
        rjmp x15_ORA_zpx
        rjmp x16_ASL_zpx
        rjmp x17_SLO_zpx_undocumented
        rjmp x18_CLC
        rjmp x19_ORA_aby
        rjmp x1a_NOP_undocumented
        rjmp x1b_SLO_aby_undocumented
        rjmp x1c_NOP_abx_undocumented
        rjmp x1d_ORA_abx
        rjmp x1e_ASL_abx
        rjmp x1f_SLO_abx_undocumented
        rjmp x20_JSR
        rjmp x21_AND_inx
        rjmp x22
        rjmp x23_RLA_inx_undocumented
        rjmp x24_BIT_zpg
        rjmp x25_AND_zpg
        rjmp x26_ROL_zpg
        rjmp x27_RLA_zpg_undocumented
        rjmp x28_PLP
        rjmp x29_AND_imm
        rjmp x2a_ROL_acc
        rjmp x2b_ANC_imm_undocumented
        rjmp x2c_BIT_abs
        rjmp x2d_AND_abs
        rjmp x2e_ROL_abs
        rjmp x2f_RLA_abs_undocumented
        rjmp x30_BMI
        rjmp x31_AND_iny
        rjmp x32
        rjmp x33_RLA_iny_undocumented
        rjmp x34_NOP_zpx_undocumented
        rjmp x35_AND_zpx
        rjmp x36_ROL_zpx
        rjmp x37_RLA_zpx_undocumented
        rjmp x38_SEC
        rjmp x39_AND_aby
        rjmp x3a_NOP_undocumented
        rjmp x3b_RLA_aby_undocumented
        rjmp x3c_NOP_abx_undocumented
        rjmp x3d_AND_abx
        rjmp x3e_ROL_abx
        rjmp x3f_RLA_abx_undocumented
        rjmp x40_RTI
        rjmp x41_EOR_inx
        rjmp x42
        rjmp x43_SRE_inx_undocumented
        rjmp x44_NOP_zpg_undocumented
        rjmp x45_EOR_zpg
        rjmp x46_LSR_zpg
        rjmp x47_SRE_zpg_undocumented
        rjmp x48_PHA
        rjmp x49_EOR_imm
        rjmp x4a_LSR_acc
        rjmp x4b_ASR_imm_undocumented
        rjmp x4c_JMP_abs
        rjmp x4d_EOR_abs
        rjmp x4e_LSR_abs
        rjmp x4f_SRE_abs_undocumented
        rjmp x50_BVC
        rjmp x51_EOR_iny
        rjmp x52
        rjmp x53_SRE_iny_undocumented
        rjmp x54_NOP_zpx_undocumented
        rjmp x55_EOR_zpx
        rjmp x56_LSR_zpx
        rjmp x57_SRE_zpx_undocumented
        rjmp x58_CLI
        rjmp x59_EOR_aby
        rjmp x5a_NOP_undocumented
        rjmp x5b_SRE_aby_undocumented
        rjmp x5c_NOP_abx_undocumented
        rjmp x5d_EOR_abx
        rjmp x5e_LSR_abx
        rjmp x5f_SRE_abx_undocumented
        rjmp x60_RTS
        rjmp x61_ADC_inx
        rjmp x62
        rjmp x63_RRA_inx_undocumented
        rjmp x64_NOP_zpg_undocumented
        rjmp x65_ADC_zpg
        rjmp x66_ROR_zpg
        rjmp x67_RRA_zpg_undocumented
        rjmp x68_PLA
        rjmp x69_ADC_imm
        rjmp x6a_ROR_acc
        rjmp x6b
        rjmp x6c_JMP_ind
        rjmp x6d_ADC_abs
        rjmp x6e_ROR_abs
        rjmp x6f_RRA_abs_undocumented
        rjmp x70_BVS
        rjmp x71_ADC_iny
        rjmp x72
        rjmp x73_RRA_iny_undocumented
        rjmp x74_NOP_zpx_undocumented
        rjmp x75_ADC_zpx
        rjmp x76_ROR_zpx
        rjmp x77_RRA_zpx_undocumented
        rjmp x78_SEI
        rjmp x79_ADC_aby
        rjmp x7a_NOP_undocumented
        rjmp x7b_RRA_aby_undocumented
        rjmp x7c_NOP_abx_undocumented
        rjmp x7d_ADC_abx
        rjmp x7e_ROR_abx
        rjmp x7f_RRA_abx_undocumented
        rjmp x80_NOP_imm_undocumented
        rjmp x81_STA_inx
        rjmp x82_NOP_imm_undocumented
        rjmp x83_SAX_inx_undocumented
        rjmp x84_STY_zpg
        rjmp x85_STA_zpg
        rjmp x86_STX_zpg
        rjmp x87_SAX_zpg_undocumented
        rjmp x88_DEY
        rjmp x89_NOP_imm_undocumented
        rjmp x8a_TXA
        rjmp x8b
        rjmp x8c_STY_abs
        rjmp x8d_STA_abs
        rjmp x8e_STX_abs
        rjmp x8f_SAX_abs_undocumented
        rjmp x90_BCC
        rjmp x91_STA_iny
        rjmp x92
        rjmp x93_SHA_iny_undocumented
        rjmp x94_STY_zpx
        rjmp x95_STA_zpx
        rjmp x96_STX_zpy
        rjmp x97_SAX_zpy_undocumented
        rjmp x98_TYA
        rjmp x99_STA_aby
        rjmp x9a_TXS
        rjmp x9b
        rjmp x9c_SHY_abx_undocumented
        rjmp x9d_STA_abx
        rjmp x9e_SHX_aby_undocumented
        rjmp x9f_SHA_aby_undocumented
        rjmp xa0_LDY_imm
        rjmp xa1_LDA_inx
        rjmp xa2_LDX_imm
        rjmp xa3_LAX_inx_undocumented
        rjmp xa4_LDY_zpg
        rjmp xa5_LDA_zpg
        rjmp xa6_LDX_zpg
        rjmp xa7_LAX_zpg_undocumented
        rjmp xa8_TAY
        rjmp xa9_LDA_imm
        rjmp xaa_TAX
        rjmp xab
        rjmp xac_LDY_abs
        rjmp xad_LDA_abs
        rjmp xae_LDX_abs
        rjmp xaf_LAX_abs_undocumented
        rjmp xb0_BCS
        rjmp xb1_LDA_iny
        rjmp xb2
        rjmp xb3_LAX_iny_undocumented
        rjmp xb4_LDY_zpx
        rjmp xb5_LDA_zpx
        rjmp xb6_LDX_zpy
        rjmp xb7_LAX_zpy_undocumented
        rjmp xb8_CLV
        rjmp xb9_LDA_aby
        rjmp xba_TSX
        rjmp xbb
        rjmp xbc_LDY_abx
        rjmp xbd_LDA_abx
        rjmp xbe_LDX_aby
        rjmp xbf_LAX_aby_undocumented
        rjmp xc0_CPY_imm
        rjmp xc1_CMP_inx
        rjmp xc2_NOP_imm_undocumented
        rjmp xc3_DCP_inx_undocumented
        rjmp xc4_CPY_zpg
        rjmp xc5_CMP_zpg
        rjmp xc6_DEC_zpg
        rjmp xc7_DCP_zpg_undocumented
        rjmp xc8_INY
        rjmp xc9_CMP_imm
        rjmp xca_DEX
        rjmp xcb_SBX_imm_undocumented
        rjmp xcc_CPY_abs
        rjmp xcd_CMP_abs
        rjmp xce_DEC_abs
        rjmp xcf_DCP_abs_undocumented
        rjmp xd0_BNE
        rjmp xd1_CMP_iny
        rjmp xd2
        rjmp xd3_DCP_iny_undocumented
        rjmp xd4_NOP_zpx_undocumented
        rjmp xd5_CMP_zpx
        rjmp xd6_DEC_zpx
        rjmp xd7_DCP_zpx_undocumented
        rjmp xd8_CLD
        rjmp xd9_CMP_aby
        rjmp xda_NOP_undocumented
        rjmp xdb_DCP_aby_undocumented
        rjmp xdc_NOP_abx_undocumented
        rjmp xdd_CMP_abx
        rjmp xde_DEC_abx
        rjmp xdf_DCP_abx_undocumented
        rjmp xe0_CPX_imm
        rjmp xe1_SBC_inx
        rjmp xe2_NOP_imm_undocumented
        rjmp xe3_ISB_inx_undocumented
        rjmp xe4_CPX_zpg
        rjmp xe5_SBC_zpg
        rjmp xe6_INC_zpg
        rjmp xe7_ISB_zpg_undocumented
        rjmp xe8_INX
        rjmp xe9_SBC_imm
        rjmp xea_NOP
        rjmp xeb_SBC_imm_undocumented
        rjmp xec_CPX_abs
        rjmp xed_SBC_abs
        rjmp xee_INC_abs
        rjmp xef_ISB_abs_undocumented
        rjmp xf0_BEQ
        rjmp xf1_SBC_iny
        rjmp xf2
        rjmp xf3_ISB_iny_undocumented
        rjmp xf4_NOP_zpx_undocumented
        rjmp xf5_SBC_zpx
        rjmp xf6_INC_zpx
        rjmp xf7_ISB_zpx_undocumented
        rjmp xf8_SED
        rjmp xf9_SBC_aby
        rjmp xfa_NOP_undocumented
        rjmp xfb_ISB_aby_undocumented
        rjmp xfc_NOP_abx_undocumented
        rjmp xfd_SBC_abx
        rjmp xfe_INC_abx
        rjmp xff_ISB_abx_undocumented

.global        cpu_main
        .type        cpu_main, @function
cpu_main:
        push r2
        push r3
        push r4
        push r5
        push r6
        push r7
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        push r16
        push r17
        push r28
        push r29
        lds time0,time_left
        lds time1,time_left+1
        lds time2,time_left+2
        lds time3,time_left+3
        add time0,r22           ; time_left += cycles
        adc time1,r23           ;
        adc time2,r24           ;
        adc time3,r25           ;
        lds _PCL,reg_pc
        lds _PCH,reg_pc+1
        lds _A,reg_a
        lds _X,reg_x
        lds _Y,reg_y
        lds _S,reg_s
        lds _P,reg_p
        in _NZC,__SREG__        ; copy upper bits of _NZC from AVR status
        call unpack_flags       ; load N, Z, and C from P
/* prologue: function */
/* frame size = 0 */
/* stack size = 14 */
.L__stack_usage = 14
        ;; initialize constant registers
        ldi r30,1
        mov const_one,r30
        ldi r30,hi8(gs(opcode_table))
        mov opcode_hi,r30
        brpl load_opcode        ; continue if time >= 0
        rjmp .L366              ; save state and exit
tick_carry:
        sbc time1,__zero_reg__  ;
        sbc time2,__zero_reg__  ;
        sbc time3,__zero_reg__  ;
        brpl load_opcode        ; continue if time >= 0
        rjmp .L366              ; save state and exit
tick:
        sub time0,cycles        ; time_left -= cycles
ticked:
        brcs tick_carry         ; abort early if no carry
load_opcode:
        movw ZL,_PCL            ;
        adiw _PCL,2             ; PC += 2
        brpl load_opcode_ram    ; branch if PC < 0x8000
load_opcode_rom:
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm opcode,Z+           ; opcode <- rom[PC - 0xc0000]
        lpm data,Z+             ; data <- rom[PC+1 - 0xc0000]
        movw ZL,opcode          ; ZH:ZL <- opcode_hi:opcode
        ijmp                    ; jmp (opcode_table + opcode)
load_opcode_ram:
        subi ZH,hi8(-(ram))     ;
        ld opcode,Z+            ; opcode <- ram[PC]
        ld data,Z               ; data <- ram[PC+1]
        movw ZL,opcode          ; ZH:ZL <- opcode_hi:opcode
        ijmp                    ; jmp (opcode_table + opcode)

tick_carry1:
        sbc time1,__zero_reg__  ;
        sbc time2,__zero_reg__  ;
        sbc time3,__zero_reg__  ;
        brpl load_opcode1       ; continue if time >= 0
        sbiw _PCL,1             ; restore PC to proper location
        rjmp .L366              ; save state and exit
ticked1:
        ;; At this point, PC points to the the byte AFTER the upcoming opcode
        ;; The upcoming opcode was prefetched last time and stored in `data`
        brcs tick_carry1        ; abort early if no carry
load_opcode1:
        movw ZL,_PCL            ;
        mov opcode,data         ; opcode <- prefetched data from before
        adiw _PCL,1             ; PC ++
        brpl load_opcode_ram1   ; branch if PC < 0x8000
load_opcode_rom1:
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm data,Z              ; data <- rom[PC+1 - 0xc0000]
        movw ZL,opcode          ; ZH:ZL <- opcode_hi:opcode
        ijmp                    ; jmp (opcode_table + opcode)
load_opcode_ram1:
        subi ZH,hi8(-(ram))     ;
        ld data,Z               ; data <- ram[PC+1]
        movw ZL,opcode          ; ZH:ZL <- opcode_hi:opcode
        ijmp                    ; jmp (opcode_table + opcode)

/***************************** READ INSTRUCTIONS ******************************/

#define READ_ZPG(label)           \
        ldi addr_hi,ZERO_PAGE   $ \
        ld data,Y               $ \
        ldi cycles,3            $ \
        rjmp label

#define READ_ZPX(label)           \
        add addr_lo,_X          $ \
        ldi addr_hi,ZERO_PAGE   $ \
        ld data,Y               $ \
        ldi cycles,4            $ \
        rjmp label

#define READ_ZPY(label)           \
        add addr_lo,_Y          $ \
        ldi addr_hi,ZERO_PAGE   $ \
        ld data,Y               $ \
        ldi cycles,4            $ \
        rjmp label

#define READ_ABS(label)           \
        ldi fptr_lo,lo8(gs(label)) $ \
        ldi fptr_hi,hi8(gs(label)) $ \
        rjmp read_abs

#define READ_ABX(label)           \
        ldi fptr_lo,lo8(gs(label)) $ \
        ldi fptr_hi,hi8(gs(label)) $ \
        add addr_lo,_X             $ \
        rjmp read_abs_indexed

#define READ_ABY(label)           \
        ldi fptr_lo,lo8(gs(label)) $ \
        ldi fptr_hi,hi8(gs(label)) $ \
        add addr_lo,_Y             $ \
        rjmp read_abs_indexed

#define READ_INX(label)           \
        ldi fptr_lo,lo8(gs(label)) $ \
        ldi fptr_hi,hi8(gs(label)) $ \
        rjmp read_inx

#define READ_INY(label)           \
        ldi fptr_lo,lo8(gs(label)) $ \
        ldi fptr_hi,hi8(gs(label)) $ \
        rjmp read_iny


x01_ORA_inx:
        READ_INX(ORA)
x05_ORA_zpg:
        READ_ZPG(ORA)
x09_ORA_imm:
        ldi cycles,2            ; cycles <- 2
ORA:
        out __SREG__,_NZC
        or _A,data              ; A |= data
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick
x0d_ORA_abs:
        READ_ABS(ORA)
x11_ORA_iny:
        READ_INY(ORA)
x15_ORA_zpx:
        READ_ZPX(ORA)
x19_ORA_aby:
        READ_ABY(ORA)
x1d_ORA_abx:
        READ_ABX(ORA)
x21_AND_inx:
        READ_INX(AND)
x25_AND_zpg:
        READ_ZPG(AND)
x29_AND_imm:
        ldi cycles,2            ; cycles <- 2
AND:
        out __SREG__,_NZC
        and _A,data             ; A &= data
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick
x2d_AND_abs:
        READ_ABS(AND)
x31_AND_iny:
        READ_INY(AND)
x35_AND_zpx:
        READ_ZPX(AND)
x39_AND_aby:
        READ_ABY(AND)
x3d_AND_abx:
        READ_ABX(AND)
x41_EOR_inx:
        READ_INX(EOR)
x45_EOR_zpg:
        READ_ZPG(EOR)
x49_EOR_imm:
        ldi cycles,2            ; cycles <- 2
EOR:
        out __SREG__,_NZC
        eor _A,data             ; A ^= data
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick
x4d_EOR_abs:
        READ_ABS(EOR)
x51_EOR_iny:
        READ_INY(EOR)
x55_EOR_zpx:
        READ_ZPX(EOR)
x59_EOR_aby:
        READ_ABY(EOR)
x5d_EOR_abx:
        READ_ABX(EOR)
x61_ADC_inx:
        READ_INX(ADC)
x65_ADC_zpg:
        READ_ZPG(ADC)
x69_ADC_imm:
        ldi cycles,2            ; cycles <- 2
ADC:
        sbrc _P,3               ; skip if decimal mode is clear
        rjmp ADC_dec            ; jump if decimal mode is set
ADC_bin:
        out __SREG__,_NZC       ; carry <- C
        adc _A,data             ; (carry, A) <- A + data + carry
        in _NZC,__SREG__        ; save N,Z,C
        bst _NZC,3              ; P.6 <- overflow
        bld _P,6
        rjmp tick
ADC_dec:
        subi data,0x9a          ; data += 0x66 (valid BCD won't overflow)
        out __SREG__,_NZC       ; carry <- C
        adc _A,data             ; (carry, A) <- A + data + carry
        in _NZC,__SREG__        ; save N,Z,C
        sbrs _NZC,5             ; if no half-carry, then A -= 0x06
        subi _A,0x06
        sbrs _NZC,0             ; if no carry, then A -= 0x60
        subi _A,0x60
        rjmp tick
x6d_ADC_abs:
        READ_ABS(ADC)
x71_ADC_iny:
        READ_INY(ADC)
x75_ADC_zpx:
        READ_ZPX(ADC)
x79_ADC_aby:
        READ_ABY(ADC)
x7d_ADC_abx:
        READ_ABX(ADC)
xa1_LDA_inx:
        READ_INX(LDA)
xa5_LDA_zpg:
        READ_ZPG(LDA)
xa9_LDA_imm:
        ldi cycles,2            ; cycles <- 2
LDA:
        out __SREG__,_NZC       ; carry <- C
        mov _A,data             ; A <- data
        tst _A
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick
xad_LDA_abs:
        READ_ABS(LDA)
xb1_LDA_iny:
        READ_INY(LDA)
xb5_LDA_zpx:
        READ_ZPX(LDA)
xb9_LDA_aby:
        READ_ABY(LDA)
xbd_LDA_abx:
        READ_ABX(LDA)
xc1_CMP_inx:
        READ_INX(CMP)
xc5_CMP_zpg:
        READ_ZPG(CMP)
xc9_CMP_imm:
        ldi cycles,2            ; cycles <- 2
CMP:
        cp _A,data              ; A - data
        in _NZC,__SREG__        ; save N,Z,C
        eor _NZC,const_one      ; invert C (AVR and 6502 have opposite convention for compare)
        rjmp tick
xcd_CMP_abs:
        READ_ABS(CMP)
xd1_CMP_iny:
        READ_INY(CMP)
xd5_CMP_zpx:
        READ_ZPX(CMP)
xd9_CMP_aby:
        READ_ABY(CMP)
xdd_CMP_abx:
        READ_ABX(CMP)
xe1_SBC_inx:
        READ_INX(SBC)
xe5_SBC_zpg:
        READ_ZPG(SBC)
xe9_SBC_imm:
xeb_SBC_imm_undocumented:
        ldi cycles,2            ; cycles <- 2
SBC:
        ;; N, V, Z, C are set the same in decimal and binary mode
        com data                ; data <- ~data
        out __SREG__,_NZC       ; carry <- C
        adc _A,data             ; (carry, A) <- A + data + carry
        in _NZC,__SREG__        ; save N,Z,C
        bst _NZC,3              ; P.6 <- overflow
        bld _P,6
        sbrs _P,3               ; skip if decimal mode is set
        rjmp tick
SBC_dec:
        sbrs _NZC,5             ; if no half-carry, then A -= 0x06
        subi _A,0x06
        sbrs _NZC,0             ; if no carry, then A -= 0x60
        subi _A,0x60
        rjmp tick
xed_SBC_abs:
        READ_ABS(SBC)
xf1_SBC_iny:
        READ_INY(SBC)
xf5_SBC_zpx:
        READ_ZPX(SBC)
xf9_SBC_aby:
        READ_ABY(SBC)
xfd_SBC_abx:
        READ_ABX(SBC)
xa2_LDX_imm:
        ldi cycles,2            ; cycles <- 2
LDX:
        out __SREG__,_NZC       ; carry <- C
        mov _X,data             ; X <- data
        tst _X
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick               ;
xa6_LDX_zpg:
        READ_ZPG(LDX)
xae_LDX_abs:
        READ_ABS(LDX)
xb6_LDX_zpy:
        READ_ZPY(LDX)
xbe_LDX_aby:
        READ_ABY(LDX)
xa0_LDY_imm:
        ldi cycles,2            ; cycles <- 2
LDY:
        out __SREG__,_NZC       ; carry <- C
        mov _Y,data             ; Y <- data
        tst _Y
        in _NZC,__SREG__        ; save N,Z,C
        rjmp tick               ;
xa4_LDY_zpg:
        READ_ZPG(LDY)
xac_LDY_abs:
        READ_ABS(LDY)
xb4_LDY_zpx:
        READ_ZPX(LDY)
xbc_LDY_abx:
        READ_ABX(LDY)
xe0_CPX_imm:
        ldi cycles,2            ; cycles <- 2
CPX:
        cp _X,data              ; X - data
        in _NZC,__SREG__        ; save N,Z,C
        eor _NZC,const_one      ; invert C (AVR and 6502 have opposite convention for compare)
        rjmp tick
xe4_CPX_zpg:
        READ_ZPG(CPX)
xec_CPX_abs:
        READ_ABS(CPX)
xc0_CPY_imm:
        ldi cycles,2            ; cycles <- 2
CPY:
        cp _Y,data              ; Y - data
        in _NZC,__SREG__        ; save N,Z,C
        eor _NZC,const_one      ; invert C (AVR and 6502 have opposite convention for compare)
        rjmp tick
xc4_CPY_zpg:
        READ_ZPG(CPY)
xcc_CPY_abs:
        READ_ABS(CPY)
x24_BIT_zpg:
        READ_ZPG(BIT)
x2c_BIT_abs:
        READ_ABS(BIT)
BIT:
        bst data,7              ; N <- data.7
        bld _NZC,2
        bst data,6              ; P.6 <- data.6
        bld _P,6
        and data,_A             ; Z <- data & A
        in temp0,__SREG__
        bst temp0,1
        bld _NZC,1
        rjmp tick

/* Undocumented read instructions */

LAX:
        out __SREG__,_NZC       ; carry <- C
        tst data
        in _NZC,__SREG__        ; save N,Z,C
        mov _X,data             ;
        mov _A,data             ;
        rjmp tick
xa3_LAX_inx_undocumented:
        READ_INX(LAX)
xa7_LAX_zpg_undocumented:
        READ_ZPG(LAX)
xaf_LAX_abs_undocumented:
        READ_ABS(LAX)
xb3_LAX_iny_undocumented:
        READ_INY(LAX)
xb7_LAX_zpy_undocumented:
        READ_ZPY(LAX)
xbf_LAX_aby_undocumented:
        READ_ABY(LAX)

x80_NOP_imm_undocumented:
x82_NOP_imm_undocumented:
x89_NOP_imm_undocumented:
xc2_NOP_imm_undocumented:
xe2_NOP_imm_undocumented:
        ldi cycles,2            ; cycles <- 2
NOP:
        rjmp tick               ;
x04_NOP_zpg_undocumented:
x44_NOP_zpg_undocumented:
x64_NOP_zpg_undocumented:
        READ_ZPG(NOP)
x0c_NOP_abs_undocumented:
        READ_ABS(NOP)
x14_NOP_zpx_undocumented:
x34_NOP_zpx_undocumented:
x54_NOP_zpx_undocumented:
x74_NOP_zpx_undocumented:
xd4_NOP_zpx_undocumented:
xf4_NOP_zpx_undocumented:
        READ_ZPX(NOP)
x1c_NOP_abx_undocumented:
x3c_NOP_abx_undocumented:
x5c_NOP_abx_undocumented:
x7c_NOP_abx_undocumented:
xdc_NOP_abx_undocumented:
xfc_NOP_abx_undocumented:
        READ_ABX(NOP)

/******************* ADDRESSING MODES FOR READ INSTRUCTIONS *******************/
/*
input:  return address in fptr_hi:fptr_lo
output: data value in data, tick count in cycles
*/

.macro READ_ADDR_HI             ; addr_hi <- read(PC++)
        movw ZL,_PCL            ; Z <- PC
        adiw _PCL,1             ; PC++
        brmi 1f                 ; branch if address in rom area
        subi ZH,hi8(-(ram))     ;
        ld addr_hi,Z            ; addr_hi <- ram[addr]
        rjmp 2f
1:
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm addr_hi,Z           ; addr_hi <- rom[PC - 0xc0000]
2:
.endm

read_abs_carry:
        READ_ADDR_HI            ; addr_hi <- read(PC++)
        inc addr_hi             ; addr_hi++
        ldi cycles,5            ; cycles <- 5
        rjmp read_mem           ; data <- read(addr_hi:addr_lo), ijmp (fptr)
read_abs_indexed:
        brcs read_abs_carry
read_abs:
        READ_ADDR_HI            ; addr_hi <- read(PC++)
        ldi cycles,4            ; cycles <- 4
read_mem:                       ; data <- read(addr_hi:addr_lo), ijmp (ret)
        cpi addr_hi,0xc0        ; branch if addr is in ROM
        brsh read_mem_rom       ;
read_mem_ram:
        cpi addr_hi,RAM_PAGES   ; branch if addr is above RAM
        brsh read_mem_io        ;
        subi addr_hi,hi8(-(ram));
        ld data,Y               ; load from ram[addr]
        movw ZL,fptr_lo
        ijmp
read_mem_rom:
        movw ZL,addr_lo         ;
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm data,Z              ; load from rom[addr - 0xc0000]
        movw ZL,fptr_lo
        ijmp
read_mem_io:
        cpi addr_hi,0x18
        brne 1f
        ldi ZL,lo8(gs(read_via1_table))
        ldi ZH,hi8(gs(read_via1_table))
        andi addr_lo,0x0f
        or ZL,addr_lo
        ijmp
1:
        cpi addr_hi,0x1c
        brne 2f
        ldi ZL,lo8(gs(read_via2_table))
        ldi ZH,hi8(gs(read_via2_table))
        andi addr_lo,0x0f
        or ZL,addr_lo
        ijmp
2:
        ldi data,0xff           ; other addresses return 0xff
        movw ZL,fptr_lo
        ijmp

read_inx:
        add data,_X             ; data += X
        LDW_ZERO_PAGE(addr_lo,data)   ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        ldi cycles,6            ; cycles <- 6
        rjmp read_mem           ; data <- read(addr_hi:addr_lo), ijmp (fptr)
read_iny:
        LDW_ZERO_PAGE(addr_lo,data)   ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        add addr_lo,_Y          ; addr_lo += Y
        brcs read_iny_carry     ; branch if addr_lo+Y carries
        ldi cycles,5            ; cycles <- 5
        rjmp read_mem           ; data <- read(addr_hi:addr_lo), ijmp (fptr)
read_iny_carry:
        inc addr_hi             ; addr_hi++
        ldi cycles,6            ; cycles <- 6
        rjmp read_mem           ; data <- read(addr_hi:addr_lo), ijmp (fptr)

/*********************** READ-MODIFY-WRITE INSTRUCTIONS ***********************/

#define MODIFY_ZPG(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_zpg

#define MODIFY_ZPX(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_zpx

#define MODIFY_ABS(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_abs

#define MODIFY_ABX(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_abx

#define MODIFY_ABY(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_aby

#define MODIFY_INX(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_inx

#define MODIFY_INY(label)         \
        ldi ZL,lo8(gs(label))   $ \
        ldi ZH,hi8(gs(label))   $ \
        rjmp modify_iny

x0a_ASL_acc:
        lsl _A                  ; A <- A << 1, carry <- A bit 7
        in _NZC,__SREG__        ; save N,Z,C
        TICK1(2)
x2a_ROL_acc:
        out __SREG__,_NZC       ; carry <- C
        rol _A                  ; carry <- A7, A <- [A6, A5 .. A0, carry]
        in _NZC,__SREG__        ; save N,Z,C
        TICK1(2)
x4a_LSR_acc:
        lsr _A                  ; A <- [0, A7, .. A2, A1], carry <- A0
        in _NZC,__SREG__        ; save N,Z,C
        TICK1(2)
x6a_ROR_acc:
        out __SREG__,_NZC       ; carry <- C
        ror _A                  ; A <- [carry, A7 .. A2, A1], carry <- A0
        in _NZC,__SREG__        ; save N,Z,C
        TICK1(2)

ASL:
        lsl value               ; A <- A << 1, carry <- A bit 7
        in _NZC,__SREG__        ; save N,Z,C
        ret
x06_ASL_zpg:
        MODIFY_ZPG(ASL)
x0e_ASL_abs:
        MODIFY_ABS(ASL)
x16_ASL_zpx:
        MODIFY_ZPX(ASL)
x1e_ASL_abx:
        MODIFY_ABX(ASL)
ROL:
        out __SREG__,_NZC       ; carry <- C
        rol value               ; carry <- A7, A <- [A6, A5 .. A0, carry]
        in _NZC,__SREG__        ; save N,Z,C
        ret
x26_ROL_zpg:
        MODIFY_ZPG(ROL)
x2e_ROL_abs:
        MODIFY_ABS(ROL)
x36_ROL_zpx:
        MODIFY_ZPX(ROL)
x3e_ROL_abx:
        MODIFY_ABX(ROL)
LSR:
        lsr value               ; A <- [0, A7, .. A2, A1], carry <- A0
        in _NZC,__SREG__        ; save N,Z,C
        ret
x46_LSR_zpg:
        MODIFY_ZPG(LSR)
x4e_LSR_abs:
        MODIFY_ABS(LSR)
x56_LSR_zpx:
        MODIFY_ZPX(LSR)
x5e_LSR_abx:
        MODIFY_ABX(LSR)
ROR:
        out __SREG__,_NZC       ; carry <- C
        ror value               ; A <- [carry, A7 .. A2, A1], carry <- A0
        in _NZC,__SREG__        ; save N,Z,C
        ret
x66_ROR_zpg:
        MODIFY_ZPG(ROR)
x6e_ROR_abs:
        MODIFY_ABS(ROR)
x76_ROR_zpx:
        MODIFY_ZPX(ROR)
x7e_ROR_abx:
        MODIFY_ABX(ROR)
DEC:
        out __SREG__,_NZC       ; carry <- C
        dec value               ; value--
        in _NZC,__SREG__        ; save N,Z,C
        ret
xc6_DEC_zpg:
        MODIFY_ZPG(DEC)
xce_DEC_abs:
        MODIFY_ABS(DEC)
xd6_DEC_zpx:
        MODIFY_ZPX(DEC)
xde_DEC_abx:
        MODIFY_ABX(DEC)
INC:
        out __SREG__,_NZC       ; carry <- C
        inc value               ; value++
        in _NZC,__SREG__        ; save N,Z,C
        ret
xe6_INC_zpg:
        MODIFY_ZPG(INC)
xee_INC_abs:
        MODIFY_ABS(INC)
xf6_INC_zpx:
        MODIFY_ZPX(INC)
xfe_INC_abx:
        MODIFY_ABX(INC)

SLO:
        ;; ASL + ORA
        lsl value               ; carry <- value.7 <- ... <- value.0 <- 0
        or _A,value             ; A |= value
        in _NZC,__SREG__        ; save N,Z,C
        ret
x03_SLO_inx_undocumented:
        MODIFY_INX(SLO)
x07_SLO_zpg_undocumented:
        MODIFY_ZPG(SLO)
x0f_SLO_abs_undocumented:
        MODIFY_ABS(SLO)
x13_SLO_iny_undocumented:
        MODIFY_INY(SLO)
x17_SLO_zpx_undocumented:
        MODIFY_ZPX(SLO)
x1b_SLO_aby_undocumented:
        MODIFY_ABY(SLO)
x1f_SLO_abx_undocumented:
        MODIFY_ABX(SLO)
RLA:
        ;; ROL + AND
        out __SREG__,_NZC       ; carry <- C
        rol value               ; carry <- value.7 <- ... <- value.0 <- carry
        and _A,value            ; A &= value
        in _NZC,__SREG__        ; save N,Z,C
        ret
x23_RLA_inx_undocumented:
        MODIFY_INX(RLA)
x27_RLA_zpg_undocumented:
        MODIFY_ZPG(RLA)
x2f_RLA_abs_undocumented:
        MODIFY_ABS(RLA)
x33_RLA_iny_undocumented:
        MODIFY_INY(RLA)
x37_RLA_zpx_undocumented:
        MODIFY_ZPX(RLA)
x3b_RLA_aby_undocumented:
        MODIFY_ABY(RLA)
x3f_RLA_abx_undocumented:
        MODIFY_ABX(RLA)
SRE:
        ;; LSR + EOR
        lsr value               ; carry <- value.0 <- ... <- value.7 <- 0
        eor _A,value            ; A ^= value
        in _NZC,__SREG__        ; save N,Z,C
        ret
x43_SRE_inx_undocumented:
        MODIFY_INX(SRE)
x47_SRE_zpg_undocumented:
        MODIFY_ZPG(SRE)
x4f_SRE_abs_undocumented:
        MODIFY_ABS(SRE)
x53_SRE_iny_undocumented:
        MODIFY_INY(SRE)
x57_SRE_zpx_undocumented:
        MODIFY_ZPX(SRE)
x5b_SRE_aby_undocumented:
        MODIFY_ABY(SRE)
x5f_SRE_abx_undocumented:
        MODIFY_ABX(SRE)
RRA:
        ;; ROR + ADC
        out __SREG__,_NZC       ; carry <- C
        ror value               ; carry <- value.0 <- ... <- value.7 <- carry
        adc _A,value            ; (carry, A) <- A + value + carry
        in _NZC,__SREG__        ; save N,Z,C
        bst _NZC,3              ; P.6 <- overflow
        bld _P,6
        ret
x63_RRA_inx_undocumented:
        MODIFY_INX(RRA)
x67_RRA_zpg_undocumented:
        MODIFY_ZPG(RRA)
x6f_RRA_abs_undocumented:
        MODIFY_ABS(RRA)
x73_RRA_iny_undocumented:
        MODIFY_INY(RRA)
x77_RRA_zpx_undocumented:
        MODIFY_ZPX(RRA)
x7b_RRA_aby_undocumented:
        MODIFY_ABY(RRA)
x7f_RRA_abx_undocumented:
        MODIFY_ABX(RRA)
DCP:
        ;; DEC + CMP
        dec value               ; value--
        cp _A,value             ; A - value
        in _NZC,__SREG__        ; save N,Z,C
        eor _NZC,const_one      ; invert C (AVR and 6502 have opposite convention for compare)
        ret
xc3_DCP_inx_undocumented:
        MODIFY_INX(DCP)
xc7_DCP_zpg_undocumented:
        MODIFY_ZPG(DCP)
xcf_DCP_abs_undocumented:
        MODIFY_ABS(DCP)
xd3_DCP_iny_undocumented:
        MODIFY_INY(DCP)
xd7_DCP_zpx_undocumented:
        MODIFY_ZPX(DCP)
xdb_DCP_aby_undocumented:
        MODIFY_ABY(DCP)
xdf_DCP_abx_undocumented:
        MODIFY_ABX(DCP)
ISB:
        ;; INC + SBC
        inc value               ; value++
        com value               ; value <- ~value
        out __SREG__,_NZC       ; carry <- C
        adc _A,value            ; (carry, A) <- A + value + carry
        in _NZC,__SREG__        ; save N,Z,C
        bst _NZC,3              ; P.6 <- overflow
        bld _P,6
        com value               ; value <- ~value
        ret
xe3_ISB_inx_undocumented:
        MODIFY_INX(ISB)
xe7_ISB_zpg_undocumented:
        MODIFY_ZPG(ISB)
xef_ISB_abs_undocumented:
        MODIFY_ABS(ISB)
xf3_ISB_iny_undocumented:
        MODIFY_INY(ISB)
xf7_ISB_zpx_undocumented:
        MODIFY_ZPX(ISB)
xfb_ISB_aby_undocumented:
        MODIFY_ABY(ISB)
xff_ISB_abx_undocumented:
        MODIFY_ABX(ISB)

/*
input:  function pointer in ZH:ZL, to be used with icall
        the function should use 'value' as input and output
*/
modify_zpg:
        ldi addr_hi,ZERO_PAGE   ;
        ld value,Y              ; value <- ram[addr]
        icall                   ; value <- f(value)
        st Y,value              ; zero_page <- value
        TICK(5)
modify_zpx:
        add addr_lo,_X          ; addr_lo += X
        ldi addr_hi,ZERO_PAGE   ;
        ld value,Y              ; value <- ram[addr]
        icall                   ; value <- f(value)
        st Y,value              ; ram[addr] <- value
        TICK(6)
modify_abs:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        ldi cycles,6            ; cycles <- 6
modify_mem:                     ; data <- read(addr_hi:addr_lo), ijmp (Z)
        cpi addr_hi,RAM_PAGES   ; branch if addr is above RAM
        brsh modify_mem_hi      ;
        subi addr_hi,hi8(-(ram));
        ld value,Y              ; value <- ram[addr_hi:addr_lo]
        icall                   ; value <- f(value)
        st Y,value              ; ram[addr_hi:addr_lo] <- value
        rjmp tick
modify_mem_hi:
        cpi addr_hi,0xc0        ; branch if addr_hi < 0xc0
        brlo modify_mem_io      ;
        movw fptr_lo,ZL         ; save call address in fptr
        movw ZL,addr_lo         ;
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm value,Z             ; value <- rom[addr - 0xc0000]
        movw ZL,fptr_lo         ; restore call address from fptr
        icall                   ; value <- f(value)
        rjmp tick
modify_mem_io:
        /* TODO: read/write to IO memory */
        clr value               ; other addresses return 0xff
        com value
        icall                   ; value <- f(value)
        rjmp tick
modify_abx:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_X          ; addr_hi:addr_lo += X
        adc addr_hi,__zero_reg__;
        ldi cycles,7            ; cycles <- 7
        rjmp modify_mem         ; data <- modify(addr_hi:addr_lo), ijmp (Z)
modify_aby:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        ldi cycles,7            ; cycles <- 7
        rjmp modify_mem         ; data <- modify(addr_hi:addr_lo), ijmp (Z)
modify_inx:
        add data,_X             ; data += X
        mov XL,data             ;
        ldi XH,ZERO_PAGE        ;
        ld addr_lo,X            ; addr_lo <- ram[data]
        inc XL                  ;
        ld addr_hi,X            ; addr_hi <- ram[data+1]
        ldi cycles,8            ; cycles <- 8
        rjmp modify_mem         ; data <- modify(addr_hi:addr_lo), ijmp (Z)
modify_iny:
        mov XL,data             ;
        ldi XH,ZERO_PAGE        ;
        ld addr_lo,X            ; addr_lo <- ram[data]
        inc XL                  ;
        ld addr_hi,X            ; addr_hi <- ram[data+1]
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        ldi cycles,8            ; cycles <- 5
        rjmp modify_mem         ; data <- modify(addr_hi:addr_lo), ijmp (Z)

/***************************** WRITE INSTRUCTIONS *****************************/

x81_STA_inx:
        add data,_X             ; data += X
        LDW_ZERO_PAGE(addr_lo,data) ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        ldi cycles,6            ; cycles <- 6
        mov value,_A            ; value <- A
        rjmp write_mem          ; write(addr_hi:addr_lo,data), rjmp tick
x84_STY_zpg:
        ldi addr_hi,ZERO_PAGE
        st Y,_Y                 ; ram[addr] <- Y
        TICK(3)
x85_STA_zpg:
        ldi addr_hi,ZERO_PAGE
        st Y,_A                 ; ram[addr] <- A
        TICK(3)
x86_STX_zpg:
        ldi addr_hi,ZERO_PAGE
        st Y,_X                 ; ram[addr] <- X
        TICK(3)
x8c_STY_abs:
        mov value,_Y
        rjmp write_abs
x8d_STA_abs:
        mov value,_A
        rjmp write_abs
x8e_STX_abs:
        mov value,_X
        rjmp write_abs
x91_STA_iny:
        LDW_ZERO_PAGE(addr_lo,data) ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        ldi cycles,6            ; cycles <- 6
        mov value,_A            ; value <- A
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x94_STY_zpx:
        add addr_lo,_X          ; addr_lo += X
        ldi addr_hi,ZERO_PAGE
        st Y,_Y                 ; ram[addr] <- Y
        TICK(4)
x95_STA_zpx:
        add addr_lo,_X          ; addr_lo += X
        ldi addr_hi,ZERO_PAGE
        st Y,_A                 ; ram[addr] <- A
        TICK(4)
x96_STX_zpy:
        add addr_lo,_Y          ; addr_lo += Y
        ldi addr_hi,ZERO_PAGE
        st Y,_X                 ; ram[addr] <- X
        TICK(4)
x99_STA_aby:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        ldi cycles,5            ; cycles <- 5
        mov value,_A
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x9d_STA_abx:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_X          ; addr_hi:addr_lo += X
        adc addr_hi,__zero_reg__;
        ldi cycles,5            ; cycles <- 5
        mov value,_A
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick

x83_SAX_inx_undocumented:
        add data,_X             ; data += X
        LDW_ZERO_PAGE(addr_lo,data) ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        ldi cycles,6            ; cycles <- 6
        mov value,_A            ; value <- A
        and value,_X            ; value <- A & X
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x87_SAX_zpg_undocumented:
        mov value,_A
        and value,_X
        ldi addr_hi,ZERO_PAGE
        st Y,value              ; ram[addr] <- A & X
        TICK(3)
x8f_SAX_abs_undocumented:
        mov value,_A
        and value,_X
        rjmp write_abs
x97_SAX_zpy_undocumented:
        mov value,_A            ; value <- A
        and value,_X            ; value <- A & X
        add addr_lo,_Y          ; addr_lo += Y
        ldi addr_hi,ZERO_PAGE
        st Y,value              ; ram[addr] <- A & X
        TICK(4)
x93_SHA_iny_undocumented:
        LDW_ZERO_PAGE(addr_lo,data) ; addr_hi:addr_lo <- ram[data+1]:ram[data]
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        ldi cycles,6            ; cycles <- 6
        mov value,addr_hi       ; value <- addr_hi
        inc value               ; value += 1
        and value,_X            ; value &= X
        and value,_A            ; value &= A
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x9f_SHA_aby_undocumented:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        mov value,addr_hi       ; value <- addr_hi
        inc value               ; value += 1
        and value,_X            ; value &= X
        and value,_A            ; value &= A
        ldi cycles,5            ; cycles <- 5
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x9c_SHY_abx_undocumented:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_X          ; addr_hi:addr_lo += X
        adc addr_hi,__zero_reg__;
        mov value,addr_hi       ; value <- addr_hi
        inc value               ; value += 1
        and value,_Y            ; value &= Y
        ldi cycles,5            ; cycles <- 5
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick
x9e_SHX_aby_undocumented:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        add addr_lo,_Y          ; addr_hi:addr_lo += Y
        adc addr_hi,__zero_reg__;
        mov value,addr_hi       ; value <- addr_hi
        inc value               ; value += 1
        and value,_X            ; value &= X
        ldi cycles,5            ; cycles <- 5
        rjmp write_mem          ; write(addr_hi:addr_lo,value), rjmp tick

write_abs:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        ldi cycles,4            ; cycles <- 4
write_mem:                      ; write(addr_hi:addr_lo,value), rjmp tick
        cpi addr_hi,RAM_PAGES   ;
        brsh write_mem_hi       ; branch if address is above RAM
        movw ZL,addr_lo         ;
        subi ZH,hi8(-(ram))     ;
        st Z,value              ; ram[addr_hi:addr_lo] <- data
        rjmp tick
write_mem_hi:
        cpi addr_hi,0x18
        brne 1f
        ldi ZL,lo8(gs(write_via1_table))
        ldi ZH,hi8(gs(write_via1_table))
        andi addr_lo,0x0f
        or ZL,addr_lo
        ijmp
1:
        cpi addr_hi,0x1c
        brne 2f
        ldi ZL,lo8(gs(write_via2_table))
        ldi ZH,hi8(gs(write_via2_table))
        andi addr_lo,0x0f
        or ZL,addr_lo
        ijmp
2:
        rjmp tick               ; other addresses have no effect

/**************************** BRANCH INSTRUCTIONS *****************************/

x10_BPL:
        bst _NZC,2              ; branch on N clear
        brtc take_branch
        TICK(2)
x30_BMI:
        bst _NZC,2              ; branch on N set
        brts take_branch
        TICK(2)
x50_BVC:
        bst _P,6                ; branch on P bit 6 = 0
        brtc take_branch        ;
        TICK(2)
x70_BVS:
        bst _P,6                ; branch on P bit 6 = 1
        brts take_branch        ;
        TICK(2)
x90_BCC:
        bst _NZC,0              ; branch on C clear
        brtc take_branch
        TICK(2)
xb0_BCS:
        bst _NZC,0              ; branch on C set
        brts take_branch
        TICK(2)
xd0_BNE:
        bst _NZC,1              ; branch on Z clear
        brtc take_branch
        TICK(2)
xf0_BEQ:
        bst _NZC,1              ; branch on Z set
        brts take_branch
        TICK(2)
take_branch:
        subi _PCL,0x80          ; PCL += 0x80
        add _PCL,data           ; PCL += data
        brvs branch_page        ; jump if branching to different page
        subi _PCL,0x80          ; PCL -= 0x80
        TICK(3)                 ; 3 cycles for branch to same page
branch_page:
        subi _PCL,0x80          ; PCL -= 0x80
        brpl branch_next_page   ; branch if offset is negative
        dec _PCH                ;
        TICK(4)                 ; 4 cycles for branch to previous page
branch_next_page:
        inc _PCH                ;
        TICK(4)                 ; 4 cycles for branch to next page

/***************************** FLAG INSTRUCTIONS ******************************/

x18_CLC:
        cbr _NZC,0x01           ; C <- 0
        TICK1(2)
x38_SEC:
        sbr _NZC,0x01           ; C <- 1
        TICK1(2)
x58_CLI:
        cbr _P,I_FLAG           ; P &= ~I_FLAG
        TICK1(2)
x78_SEI:
        sbr _P,I_FLAG           ; P |= I_FLAG
        TICK1(2)
xb8_CLV:
        cbr _P,V_FLAG           ; P &= ~V_FLAG
        TICK1(2)
xd8_CLD:
        cbr _P,D_FLAG           ; P &= ~D_FLAG
        TICK1(2)
xf8_SED:
        sbr _P,D_FLAG           ; P |= D_FLAG
        TICK1(2)

/*************************** REGISTER INSTRUCTIONS ****************************/

#define DECREMENT(reg)            \
        out __SREG__,_NZC       $ \
        dec (reg)               $ \
        in _NZC,__SREG__        $ \
        TICK1(2)

#define INCREMENT(reg)            \
        out __SREG__,_NZC       $ \
        inc (reg)               $ \
        in _NZC,__SREG__        $ \
        TICK1(2)

#define TRANSFER(src,dest)        \
        out __SREG__,_NZC       $ \
        mov (dest),(src)        $ \
        tst (dest)              $ \
        in _NZC,__SREG__        $ \
        TICK1(2)

xca_DEX:
        DECREMENT(_X)
xe8_INX:
        INCREMENT(_X)
x88_DEY:
        DECREMENT(_Y)
xc8_INY:
        INCREMENT(_Y)
x8a_TXA:
        TRANSFER(_X,_A)
xaa_TAX:
        TRANSFER(_A,_X)
x98_TYA:
        TRANSFER(_Y,_A)
xa8_TAY:
        TRANSFER(_A,_Y)
x9a_TXS:
        TRANSFER(_X,_S)
xba_TSX:
        TRANSFER(_S,_X)
xea_NOP:
x1a_NOP_undocumented:
x3a_NOP_undocumented:
x5a_NOP_undocumented:
x7a_NOP_undocumented:
xda_NOP_undocumented:
xfa_NOP_undocumented:
        TICK1(2)

/*************************** STACK/PC INSTRUCTIONS ****************************/

x00_BRK:
        PUSH(_PCH)              ; push address of the BRK instruction +2
        PUSH(_PCL)
        rcall pack_flags        ;
        sbr _P,B_FLAG           ; P |= B_FLAG
        PUSH(_P)                ; stack[S--] <- P
        sbr _P,I_FLAG           ; P |= I_FLAG (disable interrupts)
        ldi ZL,0xfe
        ldi ZH,ROM_PAGE_FF
        lpm _PCL,Z+             ; PCL <- rom[0xfffe]
        lpm _PCH,Z              ; PCH <- rom[0xffff]
        TICK(7)
x20_JSR:
        rcall addr_abs          ;
        sbiw _PCL,1             ; PC -= 1
        PUSH(_PCH)              ; push address of next instruction - 1
        PUSH(_PCL)              ;
        movw _PCL,addr_lo       ; PC <- address
        TICK(6)
x40_RTI:
        PULL(_P)                ; P <- stack[++S]
        rcall unpack_flags      ;
        PULL(_PCL)              ; PCL <- stack[++S]
        PULL(_PCH)              ; PCH <- stack[++S]
        TICK(6)
x60_RTS:
        PULL(_PCL)              ; PCL <- stack[++S]
        PULL(_PCH)              ; PCH <- stack[++S]
        adiw _PCL,1             ; PC ++
        TICK(6)
x4c_JMP_abs:
        rcall addr_abs          ;
        movw _PCL,addr_lo       ; PC <- addr
        TICK(3)
x6c_JMP_ind:
        rcall addr_abs          ; addr_hi:addr_lo <- mem_read(++PC), PC += 2
        cpi addr_hi,0xc0        ; branch if addr is below ROM
        brlo mem_16_ram         ;
        movw ZL,addr_lo
        subi ZH,hi8(-(dos1541-0xc000))  ;
        lpm _PCL,Z+             ; addr_lo <- rom[addr - 0xc0000]
        lpm _PCH,Z              ; addr_hi <- rom[addr+1 - 0xc0000]
        TICK(5)
mem_16_ram:
        subi addr_hi,hi8(-(ram))
        ld _PCL,Y+              ; addr_lo <- ram[addr]
        ld _PCH,Y               ; addr_hi <- ram[addr+1]
        TICK(5)
x08_PHP:
        rcall pack_flags        ;
        PUSH(_P)                ; stack[S--] <- P
        TICK1(3)
x28_PLP:
        PULL(_P)                ; P <- stack[++S]
        rcall unpack_flags      ;
        TICK1(4)
x48_PHA:
        PUSH(_A)                ; stack[S--] <- A
        TICK1(3)
x68_PLA:
        PULL(_A)                ; A <- stack[++S]
        out __SREG__,_NZC       ; carry <- C
        tst _A
        in _NZC,__SREG__        ; save N,Z,C
        TICK1(4)

/******************************************************************************/

x0b_ANC_imm_undocumented:
x2b_ANC_imm_undocumented:
        and _A,data             ; A &= data
        in _NZC,__SREG__        ; save N,Z,C
        bst _A,7                ; C <- A.7
        bld _NZC,0
        TICK(2)
x4b_ASR_imm_undocumented:
        ;; AND + LSR
        and _A,data             ; A &= data
        lsr _A                  ; A <- [0, A7, .. A2, A1], carry <- A0
        in _NZC,__SREG__        ; save N,Z,C
        TICK(2)
x6b:
        ;; TODO
        TICK1(2)
x8b:
        ;; TODO
        TICK1(2)
x9b:
        ;; TODO
        TICK1(5)

xab:
        ;; TODO
        TICK1(2)
xbb:
        ;; TODO
        TICK1(4)
xcb_SBX_imm_undocumented:
        and _X,_A               ; X &= A
        sub _X,data             ; X -= data
        in _NZC,__SREG__        ; save N,Z,C
        eor _NZC,const_one      ; invert C (AVR and 6502 have opposite convention for compare)
        TICK(2)
x02:
x12:
x22:
x32:
x42:
x52:
x62:
x72:
x92:
xb2:
xd2:
xf2:
        sbiw _PCL,2
        TICK(128)               ; loop in place, very slowly

/******************************************************************************/
/**************************** IO MEMORY READ/WRITE ****************************/
/* align to 16-word (32-byte) boundary */
.p2align 5
read_via1_table:
        rjmp read_via1_0
        rjmp read_via1_1
        rjmp read_via1_2
        rjmp read_via1_3
        rjmp read_via1_4
        rjmp read_via1_5
        rjmp read_via1_6
        rjmp read_via1_7
        rjmp read_via1_8
        rjmp read_via1_9
        rjmp read_via1_a
        rjmp read_via1_b
        rjmp read_via1_c
        rjmp read_via1_d
        rjmp read_via1_e
        rjmp read_via1_f
read_via2_table:
        rjmp read_via2_0
        rjmp read_via2_1
        rjmp read_via2_2
        rjmp read_via2_3
        rjmp read_via2_4
        rjmp read_via2_5
        rjmp read_via2_6
        rjmp read_via2_7
        rjmp read_via2_8
        rjmp read_via2_9
        rjmp read_via2_a
        rjmp read_via2_b
        rjmp read_via2_c
        rjmp read_via2_d
        rjmp read_via2_e
        rjmp read_via2_f
write_via1_table:
        rjmp write_via1_0
        rjmp write_via1_1
        rjmp write_via1_2
        rjmp write_via1_3
        rjmp write_via1_4
        rjmp write_via1_5
        rjmp write_via1_6
        rjmp write_via1_7
        rjmp write_via1_8
        rjmp write_via1_9
        rjmp write_via1_a
        rjmp write_via1_b
        rjmp write_via1_c
        rjmp write_via1_d
        rjmp write_via1_e
        rjmp write_via1_f
write_via2_table:
        rjmp write_via2_0
        rjmp write_via2_1
        rjmp write_via2_2
        rjmp write_via2_3
        rjmp write_via2_4
        rjmp write_via2_5
        rjmp write_via2_6
        rjmp write_via2_7
        rjmp write_via2_8
        rjmp write_via2_9
        rjmp write_via2_a
        rjmp write_via2_b
        rjmp write_via2_c
        rjmp write_via2_d
        rjmp write_via2_e
        rjmp write_via2_f

read_via1_0:
read_via1_1:
read_via1_2:
read_via1_3:
read_via1_4:
read_via1_5:
read_via1_6:
read_via1_7:
read_via1_8:
read_via1_9:
read_via1_a:
read_via1_b:
read_via1_c:
read_via1_d:
read_via1_e:
read_via1_f:
read_via2_0:
read_via2_1:
read_via2_2:
read_via2_3:
read_via2_4:
read_via2_5:
read_via2_6:
read_via2_7:
read_via2_8:
read_via2_9:
read_via2_a:
read_via2_b:
read_via2_c:
read_via2_d:
read_via2_e:
read_via2_f:
        /*
        clr time0
        clr time1
        clr time2
        clr time3
        */
        ldi data,0xff           ; other addresses return 0xff
        movw ZL,fptr_lo
        ijmp

write_via1_0:
write_via1_1:
write_via1_2:
write_via1_3:
write_via1_4:
write_via1_5:
write_via1_6:
write_via1_7:
write_via1_8:
write_via1_9:
write_via1_a:
write_via1_b:
write_via1_c:
write_via1_d:
write_via1_e:
write_via1_f:
write_via2_1:
write_via2_2:
write_via2_3:
write_via2_4:
write_via2_5:
write_via2_6:
write_via2_7:
write_via2_8:
write_via2_9:
write_via2_a:
write_via2_b:
write_via2_c:
write_via2_d:
write_via2_e:
write_via2_f:
        /*
        clr time0
        clr time1
        clr time2
        clr time3
        */
        rjmp tick

write_via2_0:                   ; DSKCNT (Data Port B)
        LED_INIT                ; Set LED pin to 'output'
        bst value,3             ; bit 3 = LED output
        brts led_on
        LED_OFF                 ; Turn off LED
        rjmp tick
led_on:
        LED_ON                  ; Turn on LED
        rjmp tick
write_mem_done:
        /*
        clr time0
        clr time1
        clr time2
        clr time3
        */
        rjmp tick

/******************************************************************************/

.L366:
/* epilogue start */
        call pack_flags         ; save N, Z, and C into P
        sts reg_pc,_PCL
        sts reg_pc+1,_PCH
        sts reg_a,_A
        sts reg_x,_X
        sts reg_y,_Y
        sts reg_s,_S
        sts reg_p,_P
        sts time_left,time0
        sts time_left+1,time1
        sts time_left+2,time2
        sts time_left+3,time3
        pop r29
        pop r28
        pop r17
        pop r16
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop r7
        pop r6
        pop r5
        pop r4
        pop r3
        pop r2
        ret
        .size        cpu_main, .-cpu_main
/******************************************************************************/
        .section        .text.cpu_get_state,"ax",@progbits
.global        cpu_get_state
        .type        cpu_get_state, @function
cpu_get_state:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
        movw r30,r24
        lds r24,reg_pc
        st Z+,r24
        lds r24,reg_pc+1
        st Z+,r24
        lds r24,reg_a
        st Z+,r24
        lds r24,reg_x
        st Z+,r24
        lds r24,reg_y
        st Z+,r24
        lds r24,reg_s
        st Z+,r24
        lds r24,reg_p
        st Z+,r24
        ret
        .size        cpu_get_state, .-cpu_get_state
        .section        .text.cpu_sprintf_state,"ax",@progbits
.global        cpu_sprintf_state
        .type        cpu_sprintf_state, @function
cpu_sprintf_state:
        movw ZL,r24      ; Z index <- pointer argument
        ldi XL,'P $ st Z+,XL
        ldi XL,'C $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        ldi XL,'$ $ st Z+,XL
        lds XL,reg_pc+1 $ call sprintf_hex
        lds XL,reg_pc $ call sprintf_hex
        ldi XL,', $ st Z+,XL
        ldi XL,32 $ st Z+,XL
        ldi XL,'A $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        ldi XL,'$ $ st Z+,XL
        lds XL,reg_a $ call sprintf_hex
        ldi XL,', $ st Z+,XL
        ldi XL,32 $ st Z+,XL
        ldi XL,'X $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        ldi XL,'$ $ st Z+,XL
        lds XL,reg_x $ call sprintf_hex
        ldi XL,', $ st Z+,XL
        ldi XL,32 $ st Z+,XL
        ldi XL,'Y $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        ldi XL,'$ $ st Z+,XL
        lds XL,reg_y $ call sprintf_hex
        ldi XL,', $ st Z+,XL
        ldi XL,32 $ st Z+,XL
        ldi XL,'S $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        ldi XL,'$ $ st Z+,XL
        lds XL,reg_s $ call sprintf_hex
        ldi XL,', $ st Z+,XL
        ldi XL,32 $ st Z+,XL
        ldi XL,'P $ st Z+,XL
        ldi XL,'= $ st Z+,XL
        lds XH,reg_p
        ldi XL,'- $ sbrc XH,7 $ ldi XL,'N $ st Z+,XL
        ldi XL,'- $ sbrc XH,6 $ ldi XL,'V $ st Z+,XL
        ldi XL,'- $ st Z+,XL
        ldi XL,'- $ st Z+,XL
        ldi XL,'- $ sbrc XH,3 $ ldi XL,'D $ st Z+,XL
        ldi XL,'- $ sbrc XH,2 $ ldi XL,'I $ st Z+,XL
        ldi XL,'- $ sbrc XH,1 $ ldi XL,'Z $ st Z+,XL
        ldi XL,'- $ sbrc XH,0 $ ldi XL,'C $ st Z+,XL
        ldi XL,0 $ st Z+,XL
        ret
sprintf_hex:
        mov XH,XL
        swap XH
        andi XH,0x0f
        cpi XH,10
        brlo .+2
        subi XH,-7
        subi XH,-48
        st Z+,XH
        andi XL,0x0f
        cpi XL,10
        brlo .+2
        subi XL,-7
        subi XL,-48
        st Z+,XL
        ret
        .size        cpu_sprintf_state, .-cpu_sprintf_state
        .section        .bss.time_left,"aw",@nobits
        .type        time_left, @object
        .size        time_left, 4
time_left:
        .zero        4
        .section        .bss.reg_p,"aw",@nobits
        .type        reg_p, @object
        .size        reg_p, 1
reg_p:
        .zero        1
        .section        .bss.reg_s,"aw",@nobits
        .type        reg_s, @object
        .size        reg_s, 1
reg_s:
        .zero        1
        .section        .bss.reg_y,"aw",@nobits
        .type        reg_y, @object
        .size        reg_y, 1
reg_y:
        .zero        1
        .section        .bss.reg_x,"aw",@nobits
        .type        reg_x, @object
        .size        reg_x, 1
reg_x:
        .zero        1
        .section        .bss.reg_a,"aw",@nobits
        .type        reg_a, @object
        .size        reg_a, 1
reg_a:
        .zero        1
        .section        .bss.reg_pc,"aw",@nobits
        .type        reg_pc, @object
        .size        reg_pc, 2
reg_pc:
        .zero        2
        .ident        "GCC: (GNU) 4.8.1"
.global __do_clear_bss
