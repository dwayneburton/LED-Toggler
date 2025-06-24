;------------------------------------------------------------------------------
; Purpose: Cortex-M3 Startup File for LPC1768 - Defines vector table, handlers,
;          and stack/heap memory layout for uVision projects
;------------------------------------------------------------------------------
                THUMB
                PRESERVE8

;------------------------------------------------------------------------------
; Section 1: Stack and Heap Configuration
;------------------------------------------------------------------------------
Stack_Size      EQU     0x00000200                  ; 512 bytes stack
                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp

Heap_Size       EQU     0x00000000                  ; No heap allocated
                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

;------------------------------------------------------------------------------
; Section 2: Vector Table at Address 0x00000000
;------------------------------------------------------------------------------
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp                ;  0: Initial stack pointer
                DCD     Reset_Handler               ;  1: Reset Handler
                DCD     NMI_Handler                 ;  2: NMI Handler
                DCD     HardFault_Handler           ;  3: Hard Fault Handler
                DCD     MemManage_Handler           ;  4: MPU Fault Handler
                DCD     BusFault_Handler            ;  5: Bus Fault Handler
                DCD     UsageFault_Handler          ;  6: Usage Fault Handler
                DCD     0                           ;  7: Reserved
                DCD     0                           ;  8: Reserved
                DCD     0                           ;  9: Reserved
                DCD     0                           ; 10: Reserved
                DCD     SVC_Handler                 ; 11: SVCall Handler
                DCD     DebugMon_Handler            ; 12: Debug Monitor Handler
                DCD     0                           ; 13: Reserved
                DCD     PendSV_Handler              ; 14: PendSV Handler
                DCD     SysTick_Handler             ; 15: SysTick Handler

; External Interrupt Vectors
                DCD     WDT_IRQHandler
                DCD     TIMER0_IRQHandler
                DCD     TIMER1_IRQHandler
                DCD     TIMER2_IRQHandler
                DCD     TIMER3_IRQHandler
                DCD     UART0_IRQHandler
                DCD     UART1_IRQHandler
                DCD     UART2_IRQHandler
                DCD     UART3_IRQHandler
                DCD     PWM1_IRQHandler
                DCD     I2C0_IRQHandler
                DCD     I2C1_IRQHandler
                DCD     I2C2_IRQHandler
                DCD     SPI_IRQHandler
                DCD     SSP0_IRQHandler
                DCD     SSP1_IRQHandler
                DCD     PLL0_IRQHandler
                DCD     RTC_IRQHandler
                DCD     EINT0_IRQHandler
                DCD     EINT1_IRQHandler
                DCD     EINT2_IRQHandler
                DCD     EINT3_IRQHandler
                DCD     ADC_IRQHandler
                DCD     BOD_IRQHandler
                DCD     USB_IRQHandler
                DCD     CAN_IRQHandler
                DCD     DMA_IRQHandler
                DCD     I2S_IRQHandler
                DCD     ENET_IRQHandler
                DCD     RIT_IRQHandler
                DCD     MCPWM_IRQHandler
                DCD     QEI_IRQHandler
                DCD     PLL1_IRQHandler
                DCD     USBActivity_IRQHandler
                DCD     CANActivity_IRQHandler

;------------------------------------------------------------------------------
; Section 3: Optional Code Read Protection Key (CRP)
;------------------------------------------------------------------------------
                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF

;------------------------------------------------------------------------------
; Section 4: Main Program Entry Point
;------------------------------------------------------------------------------
                AREA    |.text|, CODE, READONLY

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  __MAIN
                LDR     R0, =__MAIN               ; Load address of main
                BX      R0                        ; Branch to main
                ENDP

;------------------------------------------------------------------------------
; Section 5: Default Exception Handlers (infinite loop placeholders)
;------------------------------------------------------------------------------
NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP

HardFault_Handler PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP

MemManage_Handler PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP

BusFault_Handler PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP

UsageFault_Handler PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP

SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP

DebugMon_Handler PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP

PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP

SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

;------------------------------------------------------------------------------
; Section 6: External Interrupt Default Handlers (all branch to infinite loop)
;------------------------------------------------------------------------------
Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler           
TIMER0_IRQHandler         
TIMER1_IRQHandler         
TIMER2_IRQHandler         
TIMER3_IRQHandler         
UART0_IRQHandler          
UART1_IRQHandler          
UART2_IRQHandler          
UART3_IRQHandler          
PWM1_IRQHandler           
I2C0_IRQHandler           
I2C1_IRQHandler           
I2C2_IRQHandler           
SPI_IRQHandler            
SSP0_IRQHandler           
SSP1_IRQHandler           
PLL0_IRQHandler           
RTC_IRQHandler            
EINT0_IRQHandler          
EINT1_IRQHandler          
EINT2_IRQHandler          
EINT3_IRQHandler          
ADC_IRQHandler            
BOD_IRQHandler            
USB_IRQHandler            
CAN_IRQHandler            
DMA_IRQHandler            
I2S_IRQHandler            
ENET_IRQHandler           
RIT_IRQHandler            
MCPWM_IRQHandler          
QEI_IRQHandler            
PLL1_IRQHandler           
USBActivity_IRQHandler    
CANActivity_IRQHandler    

                B       .           ; Infinite loop for all unhandled IRQs
                ENDP

                ALIGN

;------------------------------------------------------------------------------
; Section 7: Stack/Heap Initialization (Microlib or Standard)
;------------------------------------------------------------------------------
                IF      :DEF:__MICROLIB
                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit
                ELSE
                EXPORT  __user_initial_stackheap
__user_initial_stackheap
                LDR     R0, =Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, =(Heap_Mem + Heap_Size)
                LDR     R3, =Stack_Mem
                BX      LR
                ALIGN
                ENDIF

                END