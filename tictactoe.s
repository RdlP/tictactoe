.data

.balign 4
board: .skip 12

.balign 4
return: .word 0

.text

.balign 4
.global main
main:
    ldr r1, address_of_return
    str lr, [r1]
    b init_board
    mov r8, #0
after_init_board:
    b print_board_init
after_print_board:
    cmp r8, #256
    add r8, r8, #1
    bne after_print_board
    ldr r1, address_of_return
    ldr lr, [r1]  
    bx lr

init_board:
    mov r0, #32
    mov r1, #0
loop_init_board:
    ldr r3, addr_of_board
    str r0, [r3, r1]
    add r1, r1, #1
    cmp r1, #9
    bne loop_init_board
    b after_init_board

print_board_init:
    mov r1, #4
    mov r2, #3
    mov r3, #0
    mov r4, #0
    mov r0, #32
    mov r7, r2
    mov r6, r1
    mov r10, r3
    bl putchar
    mov r2, r7
    mov r1, r6
    mov r3, r10

print_row:
    cmp r3, #0
    beq print_header_column
    cmp r4, #0
    beq print_header_row
    ldr r9, addr_of_board
    sub r3, r3, #1
    sub r4, r4, #1
    mul r0, r3,r1
    add r0, r0, r4
    ldrb r0, [r9, r0]
    add r3, r3, #1
    add r4, r4, #1
    
    mov r7, r2
    mov r6, r1
    mov r10, r3
    bl putchar
    mov r0, #32
    bl putchar
    mov r2, r7
    mov r1, r6
    mov r3, r10
    /* print char */

return_print_header:
    add r4, r4, #1
    cmp r4, r2
    bne print_row
    mov r0, #10
    mov r7, r2
    mov r6, r1
    mov r10, r3
    bl putchar
    mov r3, r10
    mov r1, r6
    mov r2, r7
    mov r4, #0
    add r3, r3, #1
    cmp r1, r3
    bne print_row
    b after_print_board

print_header_row:
    mov r0,  #48
    add r0, r0, r3
    mov r7, r2
    mov r6, r1
    mov r10, r3
    bl putchar
    mov r3, r10
    mov r2, r7
    mov r1, r6
    b return_print_header

print_header_column:
    mov r0, #65
    add r0, r0, r4
    mov r7, r2
    mov r6, r1
    mov r10, r3
    bl putchar
    mov r0, #32
    bl putchar
    mov r3, r10
    mov r2, r7
    mov r1, r6
    b return_print_header


addr_of_board : .word board
address_of_return: .word return


/*External*/
.global putchar
