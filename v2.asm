format ELF64
public _start

section '.bss' writable
    bss_char rb 1

section '.start' executable
_start: 
    mov rax, 5443
    call print_array
    call print_line

    add rax, 200
    call print_array
    push rax
    mov rax, 32
    call print_char
    call print_char
    call print_char
    mov rax, '+'
    call print_char
    call print_line
    pop rax

    mov rbx, 20
    mul rbx
    call print_array
    push rax
    mov rax, 32 ; 32 - space
    call print_char

    mov rax, '*'
    call print_char
    pop rax
    call print_line

    mov rbx, 10
    div rbx
    call print_array
    push rax
    mov rax, 32 ; 32 - space
    call print_char
    call print_char
    mov rax, '/'
    call print_char
    pop rax
    call print_line

    mov rbx, 20
    sub rax, rbx
    call print_array
     push rax
    mov rax, 32 ; 32 - space
    call print_char
    call print_char
    mov rax, '-'
    call print_char
    pop rax
    call print_line

    call exit

section '.print_char' executable
print_char:
    push rax
    push rbx
    push rcx
    push rdx

    mov [bss_char], al
    mov rax, 4
    mov rbx, 1
    mov rcx, bss_char
    mov rdx, 1
    
    int 0x80
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

;   rax = 57 | rdx = 1
;   571 / 10 = 57 | 1
;   57 / 10 = 5 | 7
;   5 / 10 = 0 | 5
;
; '0' + 1

section '.print_array' executable
print_array:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:
        cmp rax, 0
        je .print_iter
        mov rbx, 10
        xor rdx, rdx
        div rbx
        add rdx, '0'
        push rdx
        inc rcx
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

section '.print_line' executable
print_line:
    push rax
    mov rax, 0xA
    call print_char
    pop rax
    ret

section '.exit' executable
exit:
    mov rax, 1
    xor rbx, rbx
    int 0x80

