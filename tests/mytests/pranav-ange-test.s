.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	call input
	pushl %eax
	call inject_int
	movl %eax, %esi
	movl %esi, %ebx
	call input
	pushl %eax
	call inject_int
	movl %eax, %esi
	movl %esi, %eax
	movl %ebx, -4(%ebp)
	movl %eax, %esi
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %ebx
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %ebx
	ir_tag0_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag1_cmp
	movl $0, %eax
	jmp ir_tag1_cmpend
	ir_tag1_cmp:
	movl $1, %eax
	ir_tag1_cmpend:
	movl %ebx, -8(%ebp)
	andl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag2_cmp
	movl $0, %ebx
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %ebx
	ir_tag2_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag3_cmp
	movl $0, %eax
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %eax
	ir_tag3_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	movl -8(%ebp), %eax
	movl %eax, %eax
	orl %ecx, %eax
	cmpl $0, %eax
	je ir_tag_else_4
	movl -4(%ebp), %eax
	pushl %eax
	call inject_int
	movl %eax, %ebx
	pushl %esi
	call inject_int
	movl %eax, %eax
	cmpl %ebx, %eax
	je ir_tag5_cmp
	movl $0, %eax
	jmp ir_tag5_cmpend
	ir_tag5_cmp:
	movl $1, %eax
	ir_tag5_cmpend:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_4
	ir_tag_else_4:
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag6_cmp
	movl $0, %ebx
	jmp ir_tag6_cmpend
	ir_tag6_cmp:
	movl $1, %ebx
	ir_tag6_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag7_cmp
	movl $0, %eax
	jmp ir_tag7_cmpend
	ir_tag7_cmp:
	movl $1, %eax
	ir_tag7_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	cmpl $0, %ecx
	je ir_tag_else_8
	movl -4(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	pushl %esi
	call project_big
	movl %eax, %eax
	pushl %edi
	pushl %edi
	call equal
	movl %eax, %eax
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_8
	ir_tag_else_8:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	jmp ir_tag_end_8
	ir_tag_end_8:
	jmp ir_tag_end_4
	ir_tag_end_4:
	movl %ebx, %eax
	movl %ebx, %eax
	cmpl $0, %eax
	je ir_tag_else_9
	pushl $3
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %esi
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $1
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	jmp ir_tag_end_9
	ir_tag_else_9:
	pushl $3
	call inject_int
	movl %eax, %esi
	jmp ir_tag_end_9
	ir_tag_end_9:
	movl %esi, %eax
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag10_cmp
	movl $0, %eax
	jmp ir_tag10_cmpend
	ir_tag10_cmp:
	movl $1, %eax
	ir_tag10_cmpend:
	cmpl $0, %eax
	je ir_tag_else_11
	pushl %ebx
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_11
	ir_tag_else_11:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag12_cmp
	movl $0, %eax
	jmp ir_tag12_cmpend
	ir_tag12_cmp:
	movl $1, %eax
	ir_tag12_cmpend:
	cmpl $0, %eax
	je ir_tag_else_13
	pushl %ebx
	call inject_bool
	movl %eax, %eax
	pushl %eax
	call print_any
	jmp ir_tag_end_13
	ir_tag_else_13:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag14_cmp
	movl $0, %eax
	jmp ir_tag14_cmpend
	ir_tag14_cmp:
	movl $1, %eax
	ir_tag14_cmpend:
	cmpl $0, %eax
	je ir_tag_else_15
	pushl %ebx
	call print_any
	jmp ir_tag_end_15
	ir_tag_else_15:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	jmp ir_tag_end_15
	ir_tag_end_15:
	jmp ir_tag_end_13
	ir_tag_end_13:
	jmp ir_tag_end_11
	ir_tag_end_11:
	movl %edi, %eax
	movl $0, %eax
	leave
	ret
