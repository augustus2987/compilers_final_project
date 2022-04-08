.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $0
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, -4(%ebp)
	pushl $0
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %edi
	pushl $1
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %esi
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $80
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, %esi
	movl -4(%ebp), %eax
	movl %eax, %ebx
	movl %edi, -8(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %edi
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %edi
	ir_tag0_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag1_cmp
	movl $0, %eax
	jmp ir_tag1_cmpend
	ir_tag1_cmp:
	movl $1, %eax
	ir_tag1_cmpend:
	movl %edi, %edi
	orl %eax, %edi
	movl -8(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -12(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -12(%ebp)
	ir_tag2_cmpend:
	movl -8(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag3_cmp
	movl $0, %ecx
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %ecx
	ir_tag3_cmpend:
	movl -12(%ebp), %eax
	movl %eax, %eax
	orl %ecx, %eax
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_5
	ir_tag_else_5:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_5
	ir_tag_end_5:
	cmpl $0, %edi
	je ir_tag_else_6
	pushl %ebx
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
	movl %eax, %edi
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_9
	ir_tag_else_9:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_9
	ir_tag_end_9:
	cmpl $0, %edi
	je ir_tag_else_10
	pushl %ebx
	call project_int
	movl %eax, %edi
	movl %edi, %edi
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %edi
	jmp ir_tag_end_10
	ir_tag_end_10:
	movl -8(%ebp), %eax
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
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
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
	movl -16(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -16(%ebp)
	jmp ir_tag_end_13
	ir_tag_else_13:
	movl -16(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -16(%ebp)
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, -16(%ebp)
	je ir_tag_else_14
	movl -8(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_else_14:
	movl -8(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_end_14:
	movl %edi, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag15_cmp
	movl $0, %edi
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %edi
	ir_tag15_cmpend:
	movl -8(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_18
	ir_tag_else_18:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_18
	ir_tag_end_18:
	cmpl $0, %edi
	je ir_tag_else_19
	pushl %ebx
	call project_big
	movl %eax, %ebx
	movl -8(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	pushl %eax
	pushl %ebx
	call add
	movl %eax, %eax
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
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
	movl %edi, %eax
	movl %edi, %eax
	movl %eax, %ebx
	movl %esi, -20(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag20_cmp
	movl $0, %esi
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %esi
	ir_tag20_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	movl %esi, %esi
	orl %eax, %esi
	movl -20(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag22_cmp
	movl $0, %edi
	jmp ir_tag22_cmpend
	ir_tag22_cmp:
	movl $1, %edi
	ir_tag22_cmpend:
	movl -20(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag23_cmp
	movl $0, %eax
	jmp ir_tag23_cmpend
	ir_tag23_cmp:
	movl $1, %eax
	ir_tag23_cmpend:
	movl %edi, %ecx
	orl %eax, %ecx
	movl %esi, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag24_cmp
	movl $0, %eax
	jmp ir_tag24_cmpend
	ir_tag24_cmp:
	movl $1, %eax
	ir_tag24_cmpend:
	cmpl $0, %eax
	je ir_tag_else_25
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_25
	ir_tag_else_25:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_25
	ir_tag_end_25:
	cmpl $0, %esi
	je ir_tag_else_26
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
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag28_cmp
	movl $0, %eax
	jmp ir_tag28_cmpend
	ir_tag28_cmp:
	movl $1, %eax
	ir_tag28_cmpend:
	cmpl $0, %eax
	je ir_tag_else_29
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_29
	ir_tag_else_29:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_29
	ir_tag_end_29:
	cmpl $0, %esi
	je ir_tag_else_30
	pushl %ebx
	call project_int
	movl %eax, %esi
	movl %esi, %esi
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %esi
	jmp ir_tag_end_30
	ir_tag_end_30:
	movl -20(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag31_cmp
	movl $0, %eax
	jmp ir_tag31_cmpend
	ir_tag31_cmp:
	movl $1, %eax
	ir_tag31_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag32_cmp
	movl $0, %eax
	jmp ir_tag32_cmpend
	ir_tag32_cmp:
	movl $1, %eax
	ir_tag32_cmpend:
	cmpl $0, %eax
	je ir_tag_else_33
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_33
	ir_tag_else_33:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_33
	ir_tag_end_33:
	cmpl $0, %edi
	je ir_tag_else_34
	movl -20(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_else_34:
	movl -20(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_end_34:
	movl %esi, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_26
	ir_tag_else_26:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag35_cmp
	movl $0, %esi
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %esi
	ir_tag35_cmpend:
	movl -20(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag36_cmp
	movl $0, %eax
	jmp ir_tag36_cmpend
	ir_tag36_cmp:
	movl $1, %eax
	ir_tag36_cmpend:
	movl %esi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag37_cmp
	movl $0, %eax
	jmp ir_tag37_cmpend
	ir_tag37_cmp:
	movl $1, %eax
	ir_tag37_cmpend:
	cmpl $0, %eax
	je ir_tag_else_38
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_38
	ir_tag_else_38:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_38
	ir_tag_end_38:
	cmpl $0, %esi
	je ir_tag_else_39
	pushl %ebx
	call project_big
	movl %eax, %ebx
	movl -20(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	pushl %eax
	pushl %ebx
	call add
	movl %eax, %eax
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	movl %eax, %eax
	jmp ir_tag_end_39
	ir_tag_else_39:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_39
	ir_tag_end_39:
	jmp ir_tag_end_26
	ir_tag_end_26:
	movl %esi, %eax
	movl %esi, %eax
	movl %eax, %ebx
	pushl $0
	call inject_int
	movl %eax, %edx
	pushl $0
	call inject_int
	pushl %edx
	pushl %eax
	pushl %ebx
	call set_subscript
	movl $0, %eax
	leave
	ret
