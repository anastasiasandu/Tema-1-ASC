 
.data 
    formatScanf: .asciz "%300[^\n]"
    formatPrintf: .asciz "%d\n"
    chDelim: .asciz " "
    res: .space 4
    str: .space 400
    atoiRes: .space 4   
    dif: .long 97
    v: .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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
    cmp $0,%eax 
    je et_primavariabila 
    pushl %eax 
    jmp et_for 
et_primavariabila:
    pushl res
    jmp et_for
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
    pushl res
    call strlen
    popl %ebx
    cmp $1,%eax
    je et_variabila 
    movl res, %edi
    xorl %ecx,%ecx
    movb (%edi,%ecx,1),%al
    cmp $97,%al
    je et_add
    cmp $100,%al
    je et_div
    cmp $108,%al
    je et_let 
    cmp $109,%al
    je et_mul
    cmp $115,%al
    je et_sub 
et_variabila:  
    movl $v,%edi
    movl res,%eax 
    movl %eax, %esi 
    xorl %ecx,%ecx
    xorl %eax,%eax 
    movb (%esi,%ecx,1),%al
    subb dif,%al
    movl %eax,%ecx 
    movl (%edi,%ecx,4),%eax
    cmp $0,%eax 
    jne et_valoare 
    pushl res 
    jmp et_for
et_valoare:
    pushl %eax 
    jmp et_for 
et_numar:
    pushl atoiRes
    jmp et_for
et_let:
    popl %ebx
    popl %eax 
    movl $v,%edi 
    movl %eax,%esi 
    xorl %ecx,%ecx 
    xorl %eax,%eax 
    movb (%esi,%ecx,1),%al
    subb dif,%al
    movl %eax,%ecx  
    movl %ebx,(%edi,%ecx,4) 
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