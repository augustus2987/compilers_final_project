.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	call create_dict
	pushl %eax
	call inject_big
	movl %eax, %edi
	pushl $1
	call inject_int
	movl %eax, %ecx
	movl %esi, %eax
	pushl %eax
	pushl %ecx
	pushl %edi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ecx
	movl %esi, %eax
	pushl %eax
	pushl %ecx
	pushl %edi
	call set_subscript
	pushl $3
	call inject_int
	movl %eax, %ecx
	movl %esi, %eax
	pushl %eax
	pushl %ecx
	pushl %edi
	call set_subscript
	movl %edi, %edi
	pushl $2
	call inject_int
	pushl %eax
	pushl %edi
	call get_subscript
	movl %eax, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	pushl %eax
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
	movl -4(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_1
	ir_tag_else_1:
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag2_cmp
	movl $0, %eax
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %eax
	ir_tag2_cmpend:
	cmpl $0, %eax
	je ir_tag_else_3
	movl -4(%ebp), %eax
	pushl %eax
	call inject_bool
	movl %eax, %eax
	pushl %eax
	call print_any
	jmp ir_tag_end_3
	ir_tag_else_3:
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag4_cmp
	movl $0, %eax
	jmp ir_tag4_cmpend
	ir_tag4_cmp:
	movl $1, %eax
	ir_tag4_cmpend:
	cmpl $0, %eax
	je ir_tag_else_5
	movl -4(%ebp), %eax
	pushl %eax
	call print_any
	jmp ir_tag_end_5
	ir_tag_else_5:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	jmp ir_tag_end_5
	ir_tag_end_5:
	jmp ir_tag_end_3
	ir_tag_end_3:
	jmp ir_tag_end_1
	ir_tag_end_1:
	movl %esi, %eax
	pushl $222
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %ebx
	pushl %eax
	pushl %edi
	call set_subscript
	movl $0, %eax
	leave
	ret
