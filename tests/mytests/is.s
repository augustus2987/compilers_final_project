.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_int
	movl %eax, %edi
	movl %edi, %ebx
	movl %edi, %edi
	movl %ebx, %ebx
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %esi
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %esi
	ir_tag0_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag1_cmp
	movl $0, %eax
	jmp ir_tag1_cmpend
	ir_tag1_cmp:
	movl $1, %eax
	ir_tag1_cmpend:
	movl %esi, -4(%ebp)
	orl %eax, -4(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, %esi
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %esi
	ir_tag2_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag3_cmp
	movl $0, %eax
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %eax
	ir_tag3_cmpend:
	movl %esi, %ecx
	orl %eax, %ecx
	movl -4(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag4_cmp
	movl $0, %eax
	jmp ir_tag4_cmpend
	ir_tag4_cmp:
	movl $1, %eax
	ir_tag4_cmpend:
	cmpl $0, %eax
	je ir_tag_else_5
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_5
	ir_tag_else_5:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_5
	ir_tag_end_5:
	cmpl $0, %esi
	je ir_tag_else_6
	pushl %edi
	call tag
	movl %eax, %esi
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl %esi, %eax
	je ir_tag7_cmp
	movl $0, %eax
	jmp ir_tag7_cmpend
	ir_tag7_cmp:
	movl $1, %eax
	ir_tag7_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag8_cmp
	movl $0, %eax
	jmp ir_tag8_cmpend
	ir_tag8_cmp:
	movl $1, %eax
	ir_tag8_cmpend:
	cmpl $0, %eax
	je ir_tag_else_9
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_9
	ir_tag_else_9:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_9
	ir_tag_end_9:
	cmpl $0, %esi
	je ir_tag_else_10
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag11_cmp
	movl $0, %eax
	jmp ir_tag11_cmpend
	ir_tag11_cmp:
	movl $1, %eax
	ir_tag11_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag12_cmp
	movl $0, %eax
	jmp ir_tag12_cmpend
	ir_tag12_cmp:
	movl $1, %eax
	ir_tag12_cmpend:
	cmpl $0, %eax
	je ir_tag_else_13
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_13
	ir_tag_else_13:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, %esi
	je ir_tag_else_14
	pushl %edi
	call project_int
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, -8(%ebp)
	jmp ir_tag_end_14
	ir_tag_end_14:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	cmpl $0, %eax
	je ir_tag_else_17
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_17
	ir_tag_else_17:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_17
	ir_tag_end_17:
	cmpl $0, %esi
	je ir_tag_else_18
	pushl %ebx
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_18
	ir_tag_else_18:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_18
	ir_tag_end_18:
	movl -8(%ebp), %eax
	cmpl %eax, %ecx
	je ir_tag19_cmp
	movl $0, %eax
	jmp ir_tag19_cmpend
	ir_tag19_cmp:
	movl $1, %eax
	ir_tag19_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl $0
	call inject_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_10
	ir_tag_end_10:
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag20_cmp
	movl $0, %esi
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %esi
	ir_tag20_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	movl %esi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag22_cmp
	movl $0, %eax
	jmp ir_tag22_cmpend
	ir_tag22_cmp:
	movl $1, %eax
	ir_tag22_cmpend:
	cmpl $0, %eax
	je ir_tag_else_23
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_23
	ir_tag_else_23:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_23
	ir_tag_end_23:
	cmpl $0, %esi
	je ir_tag_else_24
	cmpl %edi, %ebx
	je ir_tag25_cmp
	movl $0, %eax
	jmp ir_tag25_cmpend
	ir_tag25_cmp:
	movl $1, %eax
	ir_tag25_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	movl %eax, %eax
	jmp ir_tag_end_24
	ir_tag_else_24:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_24
	ir_tag_end_24:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %esi, %eax
	movl %esi, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag26_cmp
	movl $0, %eax
	jmp ir_tag26_cmpend
	ir_tag26_cmp:
	movl $1, %eax
	ir_tag26_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag27_cmp
	movl $0, %eax
	jmp ir_tag27_cmpend
	ir_tag27_cmp:
	movl $1, %eax
	ir_tag27_cmpend:
	cmpl $0, %eax
	je ir_tag_else_28
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_28
	ir_tag_else_28:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_28
	ir_tag_end_28:
	cmpl $0, %ebx
	je ir_tag_else_29
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_29
	ir_tag_else_29:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag30_cmp
	movl $0, %eax
	jmp ir_tag30_cmpend
	ir_tag30_cmp:
	movl $1, %eax
	ir_tag30_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag31_cmp
	movl $0, %eax
	jmp ir_tag31_cmpend
	ir_tag31_cmp:
	movl $1, %eax
	ir_tag31_cmpend:
	cmpl $0, %eax
	je ir_tag_else_32
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_32
	ir_tag_else_32:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_32
	ir_tag_end_32:
	cmpl $0, %ebx
	je ir_tag_else_33
	pushl %esi
	call print_any
	jmp ir_tag_end_33
	ir_tag_else_33:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag34_cmp
	movl $0, %eax
	jmp ir_tag34_cmpend
	ir_tag34_cmp:
	movl $1, %eax
	ir_tag34_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag35_cmp
	movl $0, %eax
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %eax
	ir_tag35_cmpend:
	cmpl $0, %eax
	je ir_tag_else_36
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_36
	ir_tag_else_36:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_36
	ir_tag_end_36:
	cmpl $0, %ebx
	je ir_tag_else_37
	pushl %esi
	call print_any
	jmp ir_tag_end_37
	ir_tag_else_37:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_37
	ir_tag_end_37:
	jmp ir_tag_end_33
	ir_tag_end_33:
	jmp ir_tag_end_29
	ir_tag_end_29:
	movl $0, %eax
	leave
	ret
