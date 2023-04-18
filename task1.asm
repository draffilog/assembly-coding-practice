global _start
extern printf

section .data
    pi dq 3.14159265359
    format db "%lf", 10, 0

section .bss
    result resq 1

section .text
_start:
    ; Save registers
    push rbp
    mov rbp, rsp

    ; Load R value from s0 into xmm0
    mov edi, 5
    cvtsi2sd xmm0, edi
    
    ; Load b value from s1 into xmm1
    mov esi, 2
    cvtsi2sd xmm1, esi

    ; Calculate R^2
    mulsd xmm0, xmm0

    ; Multiply 2π with R^2
    movsd xmm2, [pi]
    addsd xmm2, xmm2
    mulsd xmm0, xmm2

    ; Divide the result by b
    divsd xmm0, xmm1

    ; Store the result in a new location
    movq [result], xmm0

    ; Print the result
    mov rdi, format
    movsd xmm0, [result]
    call printf

    ; Exit
    mov eax, 1
    xor edi, edi
    syscall
