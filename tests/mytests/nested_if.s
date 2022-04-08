.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $3
	call inject_int
	movl %eax, -4(%ebp)
	call input
	pushl %eax
	call inject_int
	movl %eax, %edi
	movl %edi, -8(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edi
	movl -12(%ebp), %eax
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
	movl -12(%ebp), %eax
	pushl %eax
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
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -16(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -16(%ebp)
	ir_tag2_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag3_cmp
	movl $0, %ecx
	jmp ir_tag3_cmpend
	ir_tag3_cmp:
	movl $1, %ecx
	ir_tag3_cmpend:
	movl -16(%ebp), %eax
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
	movl -12(%ebp), %eax
	pushl %eax
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
	movl -12(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_10
	ir_tag_else_10:
	movl -12(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_10
	ir_tag_end_10:
	pushl %edi
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
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
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
	movl -20(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -20(%ebp)
	jmp ir_tag_end_13
	ir_tag_else_13:
	movl -20(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -20(%ebp)
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, -20(%ebp)
	je ir_tag_else_14
	pushl %edi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_14
	ir_tag_end_14:
	cmpl %ebx, %eax
	je ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, %ebx
	movl %ebx, -24(%ebp)
	jmp ir_tag_end_6
	ir_tag_else_6:
	movl -12(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %ebx
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %ebx
	ir_tag16_cmpend:
	pushl %edi
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
	movl -12(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %ebx
	pushl %edi
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
	movl %eax, -24(%ebp)
	jmp ir_tag_end_20
	ir_tag_else_20:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, -24(%ebp)
	jmp ir_tag_end_20
	ir_tag_end_20:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %ebx, -24(%ebp)
	movl %ebx, -24(%ebp)
	movl -24(%ebp), %eax
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
	movl -24(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -24(%ebp)
	jmp ir_tag_end_22
	ir_tag_else_22:
	movl -24(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -24(%ebp)
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, -24(%ebp)
	je ir_tag_else_23
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
	pushl $1
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, %edi
	jmp ir_tag_end_23
	ir_tag_else_23:
	movl -4(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -8(%ebp), %eax
	movl %eax, %edi
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag24_cmp
	movl $0, %ebx
	jmp ir_tag24_cmpend
	ir_tag24_cmp:
	movl $1, %ebx
	ir_tag24_cmpend:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag25_cmp
	movl $0, %eax
	jmp ir_tag25_cmpend
	ir_tag25_cmp:
	movl $1, %eax
	ir_tag25_cmpend:
	movl %ebx, -32(%ebp)
	orl %eax, -32(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag26_cmp
	movl $0, %ebx
	jmp ir_tag26_cmpend
	ir_tag26_cmp:
	movl $1, %ebx
	ir_tag26_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag27_cmp
	movl $0, %eax
	jmp ir_tag27_cmpend
	ir_tag27_cmp:
	movl $1, %eax
	ir_tag27_cmpend:
	movl %ebx, %ecx
	orl %eax, %ecx
	movl -32(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_29
	ir_tag_else_29:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_29
	ir_tag_end_29:
	cmpl $0, %ebx
	je ir_tag_else_30
	movl -28(%ebp), %eax
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
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_33
	ir_tag_else_33:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_33
	ir_tag_end_33:
	cmpl $0, %ebx
	je ir_tag_else_34
	movl -28(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -36(%ebp)
	jmp ir_tag_end_34
	ir_tag_else_34:
	movl -28(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, -36(%ebp)
	jmp ir_tag_end_34
	ir_tag_end_34:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag35_cmp
	movl $0, %eax
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %eax
	ir_tag35_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag36_cmp
	movl $0, %eax
	jmp ir_tag36_cmpend
	ir_tag36_cmp:
	movl $1, %eax
	ir_tag36_cmpend:
	cmpl $0, %eax
	je ir_tag_else_37
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_37
	ir_tag_else_37:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_37
	ir_tag_end_37:
	cmpl $0, %ebx
	je ir_tag_else_38
	pushl %edi
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_38
	ir_tag_else_38:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_38
	ir_tag_end_38:
	movl -36(%ebp), %eax
	cmpl %eax, %ecx
	jg ir_tag39_cmp
	movl $0, %eax
	jmp ir_tag39_cmpend
	ir_tag39_cmp:
	movl $1, %eax
	ir_tag39_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	movl %ebx, -40(%ebp)
	movl -40(%ebp), %eax
	movl %eax, %ebx
	jmp ir_tag_end_30
	ir_tag_else_30:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag40_cmp
	movl $0, %ebx
	jmp ir_tag40_cmpend
	ir_tag40_cmp:
	movl $1, %ebx
	ir_tag40_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag41_cmp
	movl $0, %eax
	jmp ir_tag41_cmpend
	ir_tag41_cmp:
	movl $1, %eax
	ir_tag41_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag42_cmp
	movl $0, %eax
	jmp ir_tag42_cmpend
	ir_tag42_cmp:
	movl $1, %eax
	ir_tag42_cmpend:
	cmpl $0, %eax
	je ir_tag_else_43
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_43
	ir_tag_else_43:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_43
	ir_tag_end_43:
	cmpl $0, %ebx
	je ir_tag_else_44
	movl -28(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	pushl %edi
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_44
	ir_tag_else_44:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_44
	ir_tag_end_44:
	jmp ir_tag_end_30
	ir_tag_end_30:
	movl -40(%ebp), %eax
	movl %eax, %ebx
	movl -40(%ebp), %eax
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag45_cmp
	movl $0, %eax
	jmp ir_tag45_cmpend
	ir_tag45_cmp:
	movl $1, %eax
	ir_tag45_cmpend:
	cmpl $0, %eax
	je ir_tag_else_46
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_46
	ir_tag_else_46:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_46
	ir_tag_end_46:
	cmpl $0, %ebx
	je ir_tag_else_47
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
	movl %esi, %esi
	movl %esi, %edi
	jmp ir_tag_end_47
	ir_tag_else_47:
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
	pushl $7
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $8
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $9
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, %esi
	movl %esi, %edi
	jmp ir_tag_end_47
	ir_tag_end_47:
	jmp ir_tag_end_23
	ir_tag_end_23:
	movl %edi, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag48_cmp
	movl $0, %eax
	jmp ir_tag48_cmpend
	ir_tag48_cmp:
	movl $1, %eax
	ir_tag48_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag49_cmp
	movl $0, %eax
	jmp ir_tag49_cmpend
	ir_tag49_cmp:
	movl $1, %eax
	ir_tag49_cmpend:
	cmpl $0, %eax
	je ir_tag_else_50
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_50
	ir_tag_else_50:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_50
	ir_tag_end_50:
	cmpl $0, %ebx
	je ir_tag_else_51
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_51
	ir_tag_else_51:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag52_cmp
	movl $0, %eax
	jmp ir_tag52_cmpend
	ir_tag52_cmp:
	movl $1, %eax
	ir_tag52_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag53_cmp
	movl $0, %eax
	jmp ir_tag53_cmpend
	ir_tag53_cmp:
	movl $1, %eax
	ir_tag53_cmpend:
	cmpl $0, %eax
	je ir_tag_else_54
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_54
	ir_tag_else_54:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_54
	ir_tag_end_54:
	cmpl $0, %ebx
	je ir_tag_else_55
	pushl %esi
	call print_any
	jmp ir_tag_end_55
	ir_tag_else_55:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag56_cmp
	movl $0, %eax
	jmp ir_tag56_cmpend
	ir_tag56_cmp:
	movl $1, %eax
	ir_tag56_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag57_cmp
	movl $0, %eax
	jmp ir_tag57_cmpend
	ir_tag57_cmp:
	movl $1, %eax
	ir_tag57_cmpend:
	cmpl $0, %eax
	je ir_tag_else_58
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_58
	ir_tag_else_58:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_58
	ir_tag_end_58:
	cmpl $0, %ebx
	je ir_tag_else_59
	pushl %esi
	call print_any
	jmp ir_tag_end_59
	ir_tag_else_59:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_59
	ir_tag_end_59:
	jmp ir_tag_end_55
	ir_tag_end_55:
	jmp ir_tag_end_51
	ir_tag_end_51:
	movl $0, %eax
	leave
	ret
