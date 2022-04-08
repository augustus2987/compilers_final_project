.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_int
	movl %eax, %edi
	pushl $2
	call inject_int
	movl %eax, -4(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %ebx
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %ebx
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
	movl %ebx, -8(%ebp)
	orl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, %ebx
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %ebx
	ir_tag2_cmpend:
	movl -4(%ebp), %eax
	pushl %eax
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
	orl %eax, %ecx
	movl -8(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
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
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
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
	pushl %edi
	call project_int
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_10
	ir_tag_end_10:
	movl -4(%ebp), %eax
	pushl %eax
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
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	pushl %eax
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
	movl -12(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -12(%ebp)
	jmp ir_tag_end_13
	ir_tag_else_13:
	movl -12(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -12(%ebp)
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, -12(%ebp)
	je ir_tag_else_14
	movl -4(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_else_14:
	movl -4(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_end_14:
	cmpl %ebx, %eax
	jg ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, %ebx
	movl %ebx, -16(%ebp)
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %ebx
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %ebx
	ir_tag16_cmpend:
	movl -4(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag17_cmp
	movl $0, %eax
	jmp ir_tag17_cmpend
	ir_tag17_cmp:
	movl $1, %eax
	ir_tag17_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag18_cmp
	movl $0, %eax
	jmp ir_tag18_cmpend
	ir_tag18_cmp:
	movl $1, %eax
	ir_tag18_cmpend:
	cmpl $0, %eax
	je ir_tag_else_19
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_19
	ir_tag_else_19:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_19
	ir_tag_end_19:
	cmpl $0, %ebx
	je ir_tag_else_20
	pushl %edi
	call project_big
	movl %eax, %eax
	movl -4(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	movl %eax, -16(%ebp)
	jmp ir_tag_end_20
	ir_tag_else_20:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, -16(%ebp)
	jmp ir_tag_end_20
	ir_tag_end_20:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %ebx, -16(%ebp)
	movl %ebx, -16(%ebp)
	movl -16(%ebp), %eax
	pushl %eax
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
	movl -16(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -16(%ebp)
	jmp ir_tag_end_22
	ir_tag_else_22:
	movl -16(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -16(%ebp)
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, -16(%ebp)
	je ir_tag_else_23
	pushl $1
	call inject_int
	movl %eax, %edi
	movl %edi, %edi
	jmp ir_tag_end_23
	ir_tag_else_23:
	pushl $4
	call inject_int
	movl %eax, %edi
	movl %edi, %edi
	jmp ir_tag_end_23
	ir_tag_end_23:
	pushl $2
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %esi
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl %edi
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
	movl %esi, %esi
	movl $0, %eax
	leave
	ret
