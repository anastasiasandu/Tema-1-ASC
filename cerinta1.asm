.data
    formatScanf: .asciz "%s"
    formatPrintf1: .asciz "%d "
    formatPrintf11: .asciz "-%d "
    formatPrintf2: .asciz "%c "
    formatPrintf3: .asciz "%s "
    formatPrintf4: .asciz "\n"
    sirb16: .space 400 
    subbb: .asciz "sub"
    divvv: .asciz "div"
    mulll: .asciz "mul"
    lettt: .asciz "let"
    adddd: .asciz "add"  
    formatSscanf: .asciz "%2x"
    numar: .space 4 
    doi: .long 2
.text
.global main
main: 
    pushl $sirb16
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx 
    movl $sirb16, %edi 
    xorl %ecx,%ecx
et_for:
    movb (%edi,%ecx,1),%al
    cmp $0,%al
    je exit 
    cmp $56,%al      
    je nrpoz
    cmp $57,%al      
    je nrneg
    cmp $65,%al       
    je variabila 
    cmp $67,%al         
    je operatie 
cont:
    incl %ecx
    jmp et_for
variabila:
    incl %ecx
    addl %ecx,%edi
    pushl %ecx
    pushl $numar
    pushl $formatSscanf
    pushl %edi
    call sscanf
    popl %edi
    popl %ebx
    popl %ebx
    popl %ecx 
    pushl %ecx
    pushl numar
    pushl $formatPrintf2
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    subl %ecx,%edi
    incl %ecx
    jmp cont
operatie:
    addl doi,%ecx
    movb (%edi,%ecx,1),%al
    cmp $48, %al
    je et_let
    cmp $49, %al
    je et_add  
    cmp $50, %al
    je et_sub
    cmp $51, %al
    je et_mul
    cmp $52, %al
    je et_div 
et_let:
    pushl %ecx
    pushl $lettt
    pushl $formatPrintf3
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp cont 
et_add:
    pushl %ecx
    pushl $adddd
    pushl $formatPrintf3
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp cont
et_sub: 
    pushl %ecx
    pushl $subbb
    pushl $formatPrintf3
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp cont
et_mul:
    pushl %ecx
    pushl $mulll
    pushl $formatPrintf3
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp cont
et_div:
    pushl %ecx
    pushl $divvv
    pushl $formatPrintf3
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    jmp cont
nrneg:
    incl %ecx
    addl %ecx,%edi
    pushl %ecx
    pushl $numar
    pushl $formatSscanf
    pushl %edi
    call sscanf
    popl %edi
    popl %ebx
    popl %ebx
    popl %ecx 
    pushl %ecx
    pushl numar
    pushl $formatPrintf11
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    subl %ecx,%edi
    incl %ecx
    jmp cont
nrpoz: 
    incl %ecx
    addl %ecx,%edi 
    pushl %ecx
    pushl $numar
    pushl $formatSscanf
    pushl %edi
    call sscanf
    popl %edi
    popl %ebx
    popl %ebx
    popl %ecx 
    pushl %ecx
    pushl numar
    pushl $formatPrintf1
    call printf
    popl %ebx
    popl %ebx
    popl %ecx
    subl %ecx,%edi
    incl %ecx
    jmp cont
exit:
    push $0
    call fflush 
    popl %ebx
    pushl $formatPrintf4
    call printf 
    popl %ebx
    movl $1,%eax
    xorl %ebx,%ebx
    int $0x80