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
	pushl $3
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, -4(%ebp)
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl %esi
	pushl %ebx
	movl -4(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	movl -4(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	movl -4(%ebp), %eax
	pushl %eax
	call set_subscript
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
	pushl $4
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $5
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $6
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $3
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, -8(%ebp)
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $7
	call inject_int
	pushl %eax
	pushl %ebx
	movl -8(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $8
	call inject_int
	pushl %eax
	pushl %ebx
	movl -8(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $9
	call inject_int
	pushl %eax
	pushl %ebx
	movl -8(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $3
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %edi
	pushl $0
	call inject_int
	movl %eax, %ebx
	movl -4(%ebp), %eax
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl %esi
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	movl -8(%ebp), %eax
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, %esi
	pushl $0
	call inject_int
	pushl %eax
	pushl %esi
	call get_subscript
	movl %eax, %ebx
	pushl $0
	call inject_int
	pushl %eax
	pushl %ebx
	call get_subscript
	movl %eax, %ebx
	pushl $69
	call inject_int
	movl %eax, %edx
	pushl $0
	call inject_int
	pushl %edx
	pushl %eax
	pushl %ebx
	call set_subscript
	movl %esi, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %eax
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %eax
	ir_tag0_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag1_cmp
	movl $0, %eax
	jmp ir_tag1_cmpend
	ir_tag1_cmp:
	movl $1, %eax
	ir_tag1_cmpend:
	cmpl $0, %eax
	je ir_tag_else_2
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_2
	ir_tag_else_2:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_2
	ir_tag_end_2:
	cmpl $0, %ebx
	je ir_tag_else_3
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_3
	ir_tag_else_3:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag4_cmp
	movl $0, %eax
	jmp ir_tag4_cmpend
	ir_tag4_cmp:
	movl $1, %eax
	ir_tag4_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag5_cmp
	movl $0, %eax
	jmp ir_tag5_cmpend
	ir_tag5_cmp:
	movl $1, %eax
	ir_tag5_cmpend:
	cmpl $0, %eax
	je ir_tag_else_6
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_6
	ir_tag_end_6:
	cmpl $0, %ebx
	je ir_tag_else_7
	pushl %esi
	call print_any
	jmp ir_tag_end_7
	ir_tag_else_7:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag8_cmp
	movl $0, %eax
	jmp ir_tag8_cmpend
	ir_tag8_cmp:
	movl $1, %eax
	ir_tag8_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag9_cmp
	movl $0, %eax
	jmp ir_tag9_cmpend
	ir_tag9_cmp:
	movl $1, %eax
	ir_tag9_cmpend:
	cmpl $0, %eax
	je ir_tag_else_10
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_10
	ir_tag_end_10:
	cmpl $0, %ebx
	je ir_tag_else_11
	pushl %esi
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
	jmp ir_tag_end_7
	ir_tag_end_7:
	jmp ir_tag_end_3
	ir_tag_end_3:
	movl $0, %eax
	leave
	ret
