.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $3
	call inject_int
	movl %eax, %eax
	movl %eax, %edi
	pushl $3
	call inject_int
	movl %eax, %esi
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
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -4(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -4(%ebp)
	ir_tag2_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag3_cmp
	movl $0, %ecx
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %ecx
	ir_tag3_cmpend:
	movl -4(%ebp), %eax
	movl %eax, %eax
	orl %ecx, %eax
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, -8(%ebp)
	jmp ir_tag_end_10
	ir_tag_end_10:
	pushl %esi
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
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_14
	ir_tag_end_14:
	movl -8(%ebp), %eax
	cmpl %eax, %ecx
	je ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
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
	pushl %esi
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
	movl %eax, %ebx
	pushl %esi
	call project_big
	movl %eax, %eax
	pushl %ebx
	pushl %eax
	call equal
	movl %eax, %eax
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	movl %eax, %eax
	jmp ir_tag_end_20
	ir_tag_else_20:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_20
	ir_tag_end_20:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_23
	ir_tag_else_23:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_23
	ir_tag_end_23:
	cmpl $0, %ebx
	je ir_tag_else_24
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_24
	ir_tag_else_24:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag25_cmp
	movl $0, %eax
	jmp ir_tag25_cmpend
	ir_tag25_cmp:
	movl $1, %eax
	ir_tag25_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag26_cmp
	movl $0, %eax
	jmp ir_tag26_cmpend
	ir_tag26_cmp:
	movl $1, %eax
	ir_tag26_cmpend:
	cmpl $0, %eax
	je ir_tag_else_27
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_27
	ir_tag_else_27:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_27
	ir_tag_end_27:
	cmpl $0, %ebx
	je ir_tag_else_28
	pushl %esi
	call print_any
	jmp ir_tag_end_28
	ir_tag_else_28:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag29_cmp
	movl $0, %eax
	jmp ir_tag29_cmpend
	ir_tag29_cmp:
	movl $1, %eax
	ir_tag29_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag30_cmp
	movl $0, %eax
	jmp ir_tag30_cmpend
	ir_tag30_cmp:
	movl $1, %eax
	ir_tag30_cmpend:
	cmpl $0, %eax
	je ir_tag_else_31
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_31
	ir_tag_else_31:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_31
	ir_tag_end_31:
	cmpl $0, %ebx
	je ir_tag_else_32
	pushl %esi
	call print_any
	jmp ir_tag_end_32
	ir_tag_else_32:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_32
	ir_tag_end_32:
	jmp ir_tag_end_28
	ir_tag_end_28:
	jmp ir_tag_end_24
	ir_tag_end_24:
	movl $0, %eax
	leave
	ret
