section .data
    input_number dd 924

section .text
    global _start

_start:
    ; Call Primer subroutine
    call Primer

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Primer subroutine
Primer:
    ; Save registers
    pusha

    ; Load the input number
    mov eax, [input_number]

    ; Initialize divisor
    mov edi, 2

    ; Counter for prime factors found
    xor ebx, ebx

.check_divisor:
    ; Check if the divisor is a factor
    xor edx, edx
    div edi
    cmp edx, 0
    jne .next_divisor

    ; If the factor is found, store it and divide the input number
    inc ebx
    cmp ebx, 1
    je .store_factor_a1
    cmp ebx, 2
    je .store_factor_a2
    cmp ebx, 3
    je .store_factor_a3
    cmp ebx, 4
    je .store_factor_a4
    cmp ebx, 5
    je .store_factor_a5

.store_factor_a1:
    mov eax, [input_number]
    mov ecx, edi
    div ecx
    mov [input_number], eax
    mov eax, ecx
    jmp .check_divisor

.store_factor_a2:
    mov ebx, ecx
    jmp .check_divisor

.store_factor_a3:
    mov ecx, edi
    jmp .check_divisor

.store_factor_a4:
    mov edx, edi
    jmp .check_divisor

.store_factor_a5:
    mov esi, edi
    jmp .check_divisor

.next_divisor:
    ; Increase the divisor
    add edi, 1

    ; Check if the input number is greater than 1
    cmp eax, 1
    jg .check_divisor

    ; Restore registers and return
    popa
    ret