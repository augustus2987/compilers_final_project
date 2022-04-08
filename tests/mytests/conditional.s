.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	call input
	pushl %eax
	call inject_int
	movl %eax, %ebx
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
	movl %eax, %ebx
	jmp ir_tag_end_1
	ir_tag_else_1:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_1
	ir_tag_end_1:
	cmpl $0, %ebx
	je ir_tag_else_2
	pushl $2
	call inject_int
	movl %eax, %esi
	movl %esi, %esi
	jmp ir_tag_end_2
	ir_tag_else_2:
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
	movl %esi, %esi
	jmp ir_tag_end_2
	ir_tag_end_2:
	movl %esi, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag3_cmp
	movl $0, %eax
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %eax
	ir_tag3_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_5
	ir_tag_else_5:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_5
	ir_tag_end_5:
	cmpl $0, %ebx
	je ir_tag_else_6
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag7_cmp
	movl $0, %eax
	jmp ir_tag7_cmpend
	ir_tag7_cmp:
	movl $1, %eax
	ir_tag7_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_9
	ir_tag_else_9:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_9
	ir_tag_end_9:
	cmpl $0, %ebx
	je ir_tag_else_10
	pushl %esi
	call print_any
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag11_cmp
	movl $0, %eax
	jmp ir_tag11_cmpend
	ir_tag11_cmp:
	movl $1, %eax
	ir_tag11_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_13
	ir_tag_else_13:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, %ebx
	je ir_tag_else_14
	pushl %esi
	call print_any
	jmp ir_tag_end_14
	ir_tag_else_14:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_end_14:
	jmp ir_tag_end_10
	ir_tag_end_10:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl $0, %eax
	leave
	ret
