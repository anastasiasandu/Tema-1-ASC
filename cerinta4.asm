.data 
    matrix: .space 1700
    n: .long 0
    m: .long 0 
    x: .space 4
    y: .long 0
    indexMatrix: .long 0
    linindex: .long 0
    colindex: .long 0
    final: .long 0
    res: .space 8
    str: .space 8
    zero: .long 0 
    minus: .long -1
    atoiRes: .space 8   
    chDelim: .asciz " "
    formatScanf1: .asciz "%d"
    formatScanf2: .asciz "%s"
    formatScanf3: .asciz "%300[^\n]"
    formatPrintf: .asciz "%d " 
    formatPrintf1: .asciz "\n"
.text
.global main
main:
    pushl $x 
    pushl $formatScanf2
    call scanf
    popl %ebx 
    popl %ebx 
    pushl $n 
    pushl $formatScanf1
    call scanf
    popl %ebx
    popl %ebx
    pushl $m
    pushl $formatScanf1
    call scanf
    popl %ebx
    popl %ebx
    movl $matrix, %edi
    movl n,%eax
    mull m 
    movl %eax,final
    xorl %ecx,%ecx
et_for:
    pushl %ecx 
    pushl $x 
    pushl $formatScanf1
    call scanf
    popl %ebx
    popl %ebx
    popl %ecx 
    movl x,%eax
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx     
    je cont
    jmp et_for
cont:
    pushl $str
    pushl $formatScanf2
    call scanf
    popl %ebx
    popl %ebx
    pushl $x 
    pushl $formatScanf2
    call scanf
    popl %ebx 
    popl %ebx
    pushl $str
    pushl $formatScanf3
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
    movl %eax,atoiRes 
    cmp $0,atoiRes
    je et_afis_dim
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx
    movl %eax,res
    movl res, %edi
    xorl %ecx,%ecx
    xorl %eax,%eax 
    movb (%edi,%ecx,1),%al
    xorl %ecx,%ecx 
    movl $matrix, %edi
    cmp $97,%al
    je et_add
    cmp $100,%al
    je et_div
    cmp $109,%al
    je et_mul
    cmp $115,%al
    je et_sub  
et_add:
    movl (%edi,%ecx,4),%eax
    addl atoiRes,%eax
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx
    je afis
    jmp et_add     
et_div:
    xorl %edx,%edx 
    movl (%edi,%ecx,4),%eax 
    movl atoiRes, %ebx 
    cmp zero,%eax 
    jl div2
    idivl %ebx 
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx
    je afis
    jmp et_div
div2: 
    xorl %edx,%edx
    imull minus
    xorl %edx,%edx
    movl %eax, x 
    movl %ebx,%eax 
    imull minus
    xorl %edx,%edx
    movl %eax, y
    movl x, %eax
    idivl y
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx 
    je afis
    jmp et_div 
et_mul:
    xorl %edx,%edx 
    movl (%edi,%ecx,4),%eax
    movl atoiRes, %ebx
    imull %ebx
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx
    je afis
    jmp et_mul    
et_sub:
    movl (%edi,%ecx,4),%eax
    subl atoiRes,%eax
    movl %eax,(%edi,%ecx,4)
    incl %ecx
    cmp final,%ecx
    je afis
    jmp et_sub    
afis:
    pushl n 
    pushl $formatPrintf
    call printf 
    popl %ebx
    popl %ebx 
    pushl m 
    pushl $formatPrintf
    call printf 
    popl %ebx
    popl %ebx 
    xorl %ecx,%ecx 
afis1:
    movl (%edi,%ecx,4),%ebx 
    pushl %ecx 
    pushl %ebx 
    pushl $formatPrintf 
    call printf 
    popl %ebx
    popl %ebx
    popl %ecx 
    incl %ecx
    cmp final,%ecx
    je exit
    jmp afis1
et_afis_dim:
    pushl m 
    pushl $formatPrintf
    call printf 
    popl %ebx
    popl %ebx 
    pushl n 
    pushl $formatPrintf
    call printf 
    popl %ebx
    popl %ebx 
et_afis_matr:
    movl $0, colindex  
    forlines: 
        movl colindex, %ecx 
        cmp %ecx, m
        je exit
        movl n,%ebx
        movl %ebx,linindex 
        decl linindex 
        forcol:
            movl linindex,%ecx 
            cmp zero,%ecx  
            jl cont2 
            movl linindex,%eax
            movl $0,%edx
            mull m
            addl colindex, %eax
            lea matrix,%edi
            movl (%edi,%eax,4),%ebx 
            pushl %ebx
            pushl $formatPrintf 
            call printf 
            popl %ebx
            popl %ebx
            decl linindex
            jmp forcol
cont2:
    incl colindex
    jmp forlines 
exit:
    pushl $formatPrintf1
    call printf
    popl %ebx
    popl %ebx 
    pushl $0
    call fflush
    popl %ebx
    movl $1,%eax
    xorl %ebx,%ebx
    int $0x80