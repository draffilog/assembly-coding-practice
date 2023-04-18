; Constants
section .data
    num_students equ 55
    record_size equ 12

; FindMax subroutine
FindMax:
    ; Save registers
    pusha

    ; Initialize memory address (0x10000), max_mark and max_mark_address
    mov esi, 0x10000
    xor ebx, ebx
    xor edi, edi

    ; Loop through student records
    mov ecx, num_students
.loop_records:
    ; Load the mark and compare with max_mark
    movzx eax, byte [esi + 10]
    cmp al, bl
    jle .skip_record

    ; Update max_mark and max_mark_address
    mov bl, al
    mov edi, esi

.skip_record:
    ; Move to the next record
    add esi, record_size
    dec ecx
    jnz .loop_records

    ; Store the max_mark_address in a5 (EBP)
    mov ebp, edi

    ; Restore registers and return
    popa
    ret
