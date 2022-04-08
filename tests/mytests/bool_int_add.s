.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_bool
	movl %eax, %edi
	pushl $3
	call inject_int
	movl %eax, %ebx
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
	movl %esi, %esi
	orl %eax, %esi
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -4(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -4(%ebp)
	ir_tag2_cmpend:
	pushl %ebx
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
	movl %esi, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_14
	ir_tag_end_14:
	movl -8(%ebp), %eax
	movl %eax, %eax
	addl %ecx, %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag15_cmp
	movl $0, %esi
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %esi
	ir_tag15_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	movl %esi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_18
	ir_tag_else_18:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_18
	ir_tag_end_18:
	cmpl $0, %esi
	je ir_tag_else_19
	pushl %edi
	call project_big
	movl %eax, %esi
	pushl %ebx
	call project_big
	movl %eax, %eax
	pushl %eax
	pushl %esi
	call add
	movl %eax, %eax
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	movl %eax, %eax
	jmp ir_tag_end_19
	ir_tag_else_19:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_19
	ir_tag_end_19:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %esi, %eax
	movl %esi, %eax
	movl %eax, %eax
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag20_cmp
	movl $0, %eax
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %eax
	ir_tag20_cmpend:
	pushl %eax
	call inject_bool
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
	cmpl $0, %eax
	je ir_tag_else_22
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_22
	ir_tag_else_22:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, %esi
	je ir_tag_else_23
	pushl %ebx
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_23
	ir_tag_else_23:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag24_cmp
	movl $0, %eax
	jmp ir_tag24_cmpend
	ir_tag24_cmp:
	movl $1, %eax
	ir_tag24_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag25_cmp
	movl $0, %eax
	jmp ir_tag25_cmpend
	ir_tag25_cmp:
	movl $1, %eax
	ir_tag25_cmpend:
	cmpl $0, %eax
	je ir_tag_else_26
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_26
	ir_tag_else_26:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_26
	ir_tag_end_26:
	cmpl $0, %esi
	je ir_tag_else_27
	pushl %ebx
	call print_any
	jmp ir_tag_end_27
	ir_tag_else_27:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag28_cmp
	movl $0, %eax
	jmp ir_tag28_cmpend
	ir_tag28_cmp:
	movl $1, %eax
	ir_tag28_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag29_cmp
	movl $0, %eax
	jmp ir_tag29_cmpend
	ir_tag29_cmp:
	movl $1, %eax
	ir_tag29_cmpend:
	cmpl $0, %eax
	je ir_tag_else_30
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_30
	ir_tag_end_30:
	cmpl $0, %esi
	je ir_tag_else_31
	pushl %ebx
	call print_any
	jmp ir_tag_end_31
	ir_tag_else_31:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_31
	ir_tag_end_31:
	jmp ir_tag_end_27
	ir_tag_end_27:
	jmp ir_tag_end_23
	ir_tag_end_23:
	movl $0, %eax
	leave
	ret
