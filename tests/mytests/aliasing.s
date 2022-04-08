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
	movl %ebx, %esi
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
	pushl $4
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $5
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $6
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, %ebx
	movl %esi, %edi
	pushl %edi
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
	movl %eax, %esi
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
	cmpl $0, %eax
	je ir_tag_else_2
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_2
	ir_tag_else_2:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_2
	ir_tag_end_2:
	cmpl $0, %esi
	je ir_tag_else_3
	pushl %edi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_3
	ir_tag_else_3:
	pushl %edi
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_6
	ir_tag_end_6:
	cmpl $0, %esi
	je ir_tag_else_7
	pushl %edi
	call print_any
	jmp ir_tag_end_7
	ir_tag_else_7:
	pushl %edi
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_10
	ir_tag_end_10:
	cmpl $0, %esi
	je ir_tag_else_11
	pushl %edi
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
	movl %ebx, %esi
	pushl $7
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
	je ir_tag12_cmp
	movl $0, %eax
	jmp ir_tag12_cmpend
	ir_tag12_cmp:
	movl $1, %eax
	ir_tag12_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag13_cmp
	movl $0, %eax
	jmp ir_tag13_cmpend
	ir_tag13_cmp:
	movl $1, %eax
	ir_tag13_cmpend:
	cmpl $0, %eax
	je ir_tag_else_14
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_14
	ir_tag_end_14:
	cmpl $0, %ebx
	je ir_tag_else_15
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_15
	ir_tag_else_15:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag17_cmp
	movl $0, %eax
	jmp ir_tag17_cmpend
	ir_tag17_cmp:
	movl $1, %eax
	ir_tag17_cmpend:
	cmpl $0, %eax
	je ir_tag_else_18
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_18
	ir_tag_else_18:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_18
	ir_tag_end_18:
	cmpl $0, %ebx
	je ir_tag_else_19
	pushl %esi
	call print_any
	jmp ir_tag_end_19
	ir_tag_else_19:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag20_cmp
	movl $0, %eax
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %eax
	ir_tag20_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	cmpl $0, %eax
	je ir_tag_else_22
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_22
	ir_tag_else_22:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, %ebx
	je ir_tag_else_23
	pushl %esi
	call print_any
	jmp ir_tag_end_23
	ir_tag_else_23:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_23
	ir_tag_end_23:
	jmp ir_tag_end_19
	ir_tag_end_19:
	jmp ir_tag_end_15
	ir_tag_end_15:
	movl $0, %eax
	leave
	ret
