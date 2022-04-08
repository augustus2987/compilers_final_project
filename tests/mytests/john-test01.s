.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

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
	movl %esi, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %eax
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %eax
	ir_tag0_cmpend:
	cmpl $0, %eax
	je ir_tag_else_1
	pushl %ebx
	call project_int
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag_not_notzero_2
	movl $0, %eax
	jmp ir_tag_not_end_2
	ir_tag_not_notzero_2:
	movl $1, %eax
	ir_tag_not_end_2:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_1
	ir_tag_else_1:
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
	cmpl $0, %eax
	je ir_tag_else_4
	pushl %ebx
	call project_int
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag_not_notzero_5
	movl $0, %eax
	jmp ir_tag_not_end_5
	ir_tag_not_notzero_5:
	movl $1, %eax
	ir_tag_not_end_5:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	movl %eax, %eax
	jmp ir_tag_end_4
	ir_tag_else_4:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_4
	ir_tag_end_4:
	jmp ir_tag_end_1
	ir_tag_end_1:
	movl %esi, %esi
	movl %esi, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag6_cmp
	movl $0, %eax
	jmp ir_tag6_cmpend
	ir_tag6_cmp:
	movl $1, %eax
	ir_tag6_cmpend:
	cmpl $0, %eax
	je ir_tag_else_7
	pushl %ebx
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_7
	ir_tag_else_7:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag8_cmp
	movl $0, %eax
	jmp ir_tag8_cmpend
	ir_tag8_cmp:
	movl $1, %eax
	ir_tag8_cmpend:
	cmpl $0, %eax
	je ir_tag_else_9
	pushl %ebx
	call print_any
	jmp ir_tag_end_9
	ir_tag_else_9:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag10_cmp
	movl $0, %eax
	jmp ir_tag10_cmpend
	ir_tag10_cmp:
	movl $1, %eax
	ir_tag10_cmpend:
	cmpl $0, %eax
	je ir_tag_else_11
	pushl %ebx
	call print_any
	jmp ir_tag_end_11
	ir_tag_else_11:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_11
	ir_tag_end_11:
	jmp ir_tag_end_9
	ir_tag_end_9:
	jmp ir_tag_end_7
	ir_tag_end_7:
	movl $0, %eax
	leave
	ret
