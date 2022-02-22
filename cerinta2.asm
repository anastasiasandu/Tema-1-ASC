.data
    PrimulNumar: .space 4
    formatScanf: .asciz "%300[^\n]"
    formatPrintf: .asciz "%d\n"
    chDelim: .asciz " "
    res: .space 4
    str: .space 400
    atoiRes: .space 4  
.text
.global main
main:
    pushl $str
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx
    pushl $chDelim
    pushl $str
    call strtok
    popl %ebx
    popl %ebx
    movl %eax, res
    pushl res
    call atoi
    popl %ebx
    movl %eax, PrimulNumar
    pushl PrimulNumar
et_for:
    pushl $chDelim 
    push $0
    call strtok
    popl %ebx
    popl %ebx
    cmp $0,%eax
    je exit
    movl %eax,res
    pushl res
    call atoi
    popl %ebx
    movl %eax, atoiRes
    cmp $0,atoiRes
    jne et_numar
    movl res, %edi
    xorl %ecx,%ecx
    movb (%edi,%ecx,1),%al
    cmp $97,%al
    je et_add
    cmp $100,%al
    je et_div
    cmp $109,%al
    je et_mul
    cmp $115,%al
    je et_sub 
et_numar:
    pushl atoiRes
    jmp et_for
et_add:
    popl %eax
    popl %ebx
    addl %ebx, %eax
    pushl %eax
    jmp et_for
et_div:
    xorl %edx,%edx
    popl %ebx
    popl %eax
    divl %ebx
    pushl %eax
    jmp et_for
et_mul:
    xorl %edx,%edx
    popl %ebx
    popl %eax
    mull %ebx
    pushl %eax
    jmp et_for
et_sub:
    popl %ebx
    popl %eax 
    subl %ebx,%eax 
    pushl %eax
    jmp et_for
exit:
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    movl $1,%eax 
    xorl %ebx,%ebx
    int $0x80