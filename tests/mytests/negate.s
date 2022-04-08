.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	call input
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	pushl %esi
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, -4(%ebp)
	movl %esi, %esi
	pushl %esi
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %edi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag0_cmp
	movl $0, %ebx
	jmp ir_tag0_cmpend
	ir_tag0_cmp:
	movl $1, %ebx
	ir_tag0_cmpend:
	pushl %esi
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
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, %ebx
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %ebx
	ir_tag2_cmpend:
	pushl %edi
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
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -12(%ebp)
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, -12(%ebp)
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
	pushl %edi
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_14
	ir_tag_else_14:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_14
	ir_tag_end_14:
	movl -12(%ebp), %eax
	movl %eax, %eax
	addl %ecx, %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag15_cmp
	movl $0, %ebx
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %ebx
	ir_tag15_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	call project_big
	movl %eax, %ebx
	pushl %edi
	call project_big
	movl %eax, %eax
	pushl %eax
	pushl %ebx
	call add
	movl %eax, %eax
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
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
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, -16(%ebp)
	pushl %esi
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %edi
	movl -16(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag20_cmp
	movl $0, %ebx
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %ebx
	ir_tag20_cmpend:
	movl -16(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	movl %ebx, -20(%ebp)
	orl %eax, -20(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag22_cmp
	movl $0, %ebx
	jmp ir_tag22_cmpend
	ir_tag22_cmp:
	movl $1, %ebx
	ir_tag22_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag23_cmp
	movl $0, %eax
	jmp ir_tag23_cmpend
	ir_tag23_cmp:
	movl $1, %eax
	ir_tag23_cmpend:
	movl %ebx, %ecx
	orl %eax, %ecx
	movl -20(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_25
	ir_tag_else_25:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_25
	ir_tag_end_25:
	cmpl $0, %ebx
	je ir_tag_else_26
	movl -16(%ebp), %eax
	pushl %eax
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
	movl -16(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -24(%ebp)
	jmp ir_tag_end_30
	ir_tag_else_30:
	movl -16(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, -24(%ebp)
	jmp ir_tag_end_30
	ir_tag_end_30:
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_34
	ir_tag_else_34:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_34
	ir_tag_end_34:
	movl -24(%ebp), %eax
	movl %eax, %eax
	addl %ecx, %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_26
	ir_tag_else_26:
	movl -16(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag35_cmp
	movl $0, %ebx
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %ebx
	ir_tag35_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag36_cmp
	movl $0, %eax
	jmp ir_tag36_cmpend
	ir_tag36_cmp:
	movl $1, %eax
	ir_tag36_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_38
	ir_tag_else_38:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_38
	ir_tag_end_38:
	cmpl $0, %ebx
	je ir_tag_else_39
	movl -16(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %ebx
	pushl %edi
	call project_big
	movl %eax, %eax
	pushl %eax
	pushl %ebx
	call add
	movl %eax, %eax
	pushl %eax
	call inject_big
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
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
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %edi
	movl %esi, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag40_cmp
	movl $0, %eax
	jmp ir_tag40_cmpend
	ir_tag40_cmp:
	movl $1, %eax
	ir_tag40_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag41_cmp
	movl $0, %eax
	jmp ir_tag41_cmpend
	ir_tag41_cmp:
	movl $1, %eax
	ir_tag41_cmpend:
	cmpl $0, %eax
	je ir_tag_else_42
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_42
	ir_tag_else_42:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_42
	ir_tag_end_42:
	cmpl $0, %ebx
	je ir_tag_else_43
	pushl %esi
	call project_int
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag_not_notzero_44
	movl $0, %eax
	jmp ir_tag_not_end_44
	ir_tag_not_notzero_44:
	movl $1, %eax
	ir_tag_not_end_44:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_43
	ir_tag_else_43:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag45_cmp
	movl $0, %eax
	jmp ir_tag45_cmpend
	ir_tag45_cmp:
	movl $1, %eax
	ir_tag45_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag46_cmp
	movl $0, %eax
	jmp ir_tag46_cmpend
	ir_tag46_cmp:
	movl $1, %eax
	ir_tag46_cmpend:
	cmpl $0, %eax
	je ir_tag_else_47
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_47
	ir_tag_else_47:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_47
	ir_tag_end_47:
	cmpl $0, %ebx
	je ir_tag_else_48
	pushl %esi
	call project_bool
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag_not_notzero_49
	movl $0, %eax
	jmp ir_tag_not_end_49
	ir_tag_not_notzero_49:
	movl $1, %eax
	ir_tag_not_end_49:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	movl %eax, %eax
	jmp ir_tag_end_48
	ir_tag_else_48:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_48
	ir_tag_end_48:
	jmp ir_tag_end_43
	ir_tag_end_43:
	movl %ebx, %eax
	movl %eax, %ebx
	pushl %esi
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, -28(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag50_cmp
	movl $0, %esi
	jmp ir_tag50_cmpend
	ir_tag50_cmp:
	movl $1, %esi
	ir_tag50_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag51_cmp
	movl $0, %eax
	jmp ir_tag51_cmpend
	ir_tag51_cmp:
	movl $1, %eax
	ir_tag51_cmpend:
	movl %esi, %esi
	orl %eax, %esi
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag52_cmp
	movl $0, -32(%ebp)
	jmp ir_tag52_cmpend
	ir_tag52_cmp:
	movl $1, -32(%ebp)
	ir_tag52_cmpend:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag53_cmp
	movl $0, %ecx
	jmp ir_tag53_cmpend
	ir_tag53_cmp:
	movl $1, %ecx
	ir_tag53_cmpend:
	movl -32(%ebp), %eax
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
	je ir_tag54_cmp
	movl $0, %eax
	jmp ir_tag54_cmpend
	ir_tag54_cmp:
	movl $1, %eax
	ir_tag54_cmpend:
	cmpl $0, %eax
	je ir_tag_else_55
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_55
	ir_tag_else_55:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_55
	ir_tag_end_55:
	cmpl $0, %esi
	je ir_tag_else_56
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
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag58_cmp
	movl $0, %eax
	jmp ir_tag58_cmpend
	ir_tag58_cmp:
	movl $1, %eax
	ir_tag58_cmpend:
	cmpl $0, %eax
	je ir_tag_else_59
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_59
	ir_tag_else_59:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_59
	ir_tag_end_59:
	cmpl $0, %esi
	je ir_tag_else_60
	pushl %ebx
	call project_int
	movl %eax, %esi
	movl %esi, %esi
	jmp ir_tag_end_60
	ir_tag_else_60:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %esi
	jmp ir_tag_end_60
	ir_tag_end_60:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag61_cmp
	movl $0, %eax
	jmp ir_tag61_cmpend
	ir_tag61_cmp:
	movl $1, %eax
	ir_tag61_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag62_cmp
	movl $0, %eax
	jmp ir_tag62_cmpend
	ir_tag62_cmp:
	movl $1, %eax
	ir_tag62_cmpend:
	cmpl $0, %eax
	je ir_tag_else_63
	movl -36(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -36(%ebp)
	jmp ir_tag_end_63
	ir_tag_else_63:
	movl -36(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -36(%ebp)
	jmp ir_tag_end_63
	ir_tag_end_63:
	cmpl $0, -36(%ebp)
	je ir_tag_else_64
	movl -28(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_64
	ir_tag_else_64:
	movl -28(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_64
	ir_tag_end_64:
	movl %esi, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_56
	ir_tag_else_56:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag65_cmp
	movl $0, %esi
	jmp ir_tag65_cmpend
	ir_tag65_cmp:
	movl $1, %esi
	ir_tag65_cmpend:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag66_cmp
	movl $0, %eax
	jmp ir_tag66_cmpend
	ir_tag66_cmp:
	movl $1, %eax
	ir_tag66_cmpend:
	movl %esi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag67_cmp
	movl $0, %eax
	jmp ir_tag67_cmpend
	ir_tag67_cmp:
	movl $1, %eax
	ir_tag67_cmpend:
	cmpl $0, %eax
	je ir_tag_else_68
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_68
	ir_tag_else_68:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_68
	ir_tag_end_68:
	cmpl $0, %esi
	je ir_tag_else_69
	pushl %ebx
	call project_big
	movl %eax, %ebx
	movl -28(%ebp), %eax
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
	jmp ir_tag_end_69
	ir_tag_else_69:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_69
	ir_tag_end_69:
	jmp ir_tag_end_56
	ir_tag_end_56:
	movl %esi, %eax
	movl %esi, %eax
	movl %eax, %esi
	movl -4(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag70_cmp
	movl $0, %eax
	jmp ir_tag70_cmpend
	ir_tag70_cmp:
	movl $1, %eax
	ir_tag70_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag71_cmp
	movl $0, %eax
	jmp ir_tag71_cmpend
	ir_tag71_cmp:
	movl $1, %eax
	ir_tag71_cmpend:
	cmpl $0, %eax
	je ir_tag_else_72
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_72
	ir_tag_else_72:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_72
	ir_tag_end_72:
	cmpl $0, %ebx
	je ir_tag_else_73
	movl -40(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_73
	ir_tag_else_73:
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag74_cmp
	movl $0, %eax
	jmp ir_tag74_cmpend
	ir_tag74_cmp:
	movl $1, %eax
	ir_tag74_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag75_cmp
	movl $0, %eax
	jmp ir_tag75_cmpend
	ir_tag75_cmp:
	movl $1, %eax
	ir_tag75_cmpend:
	cmpl $0, %eax
	je ir_tag_else_76
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_76
	ir_tag_else_76:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_76
	ir_tag_end_76:
	cmpl $0, %ebx
	je ir_tag_else_77
	movl -40(%ebp), %eax
	pushl %eax
	call print_any
	jmp ir_tag_end_77
	ir_tag_else_77:
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag78_cmp
	movl $0, %eax
	jmp ir_tag78_cmpend
	ir_tag78_cmp:
	movl $1, %eax
	ir_tag78_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag79_cmp
	movl $0, %eax
	jmp ir_tag79_cmpend
	ir_tag79_cmp:
	movl $1, %eax
	ir_tag79_cmpend:
	cmpl $0, %eax
	je ir_tag_else_80
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_80
	ir_tag_else_80:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_80
	ir_tag_end_80:
	cmpl $0, %ebx
	je ir_tag_else_81
	movl -40(%ebp), %eax
	pushl %eax
	call print_any
	jmp ir_tag_end_81
	ir_tag_else_81:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_81
	ir_tag_end_81:
	jmp ir_tag_end_77
	ir_tag_end_77:
	jmp ir_tag_end_73
	ir_tag_end_73:
	movl %edi, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag82_cmp
	movl $0, %eax
	jmp ir_tag82_cmpend
	ir_tag82_cmp:
	movl $1, %eax
	ir_tag82_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag83_cmp
	movl $0, %eax
	jmp ir_tag83_cmpend
	ir_tag83_cmp:
	movl $1, %eax
	ir_tag83_cmpend:
	cmpl $0, %eax
	je ir_tag_else_84
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_84
	ir_tag_else_84:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_84
	ir_tag_end_84:
	cmpl $0, %ebx
	je ir_tag_else_85
	pushl %edi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_85
	ir_tag_else_85:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag86_cmp
	movl $0, %eax
	jmp ir_tag86_cmpend
	ir_tag86_cmp:
	movl $1, %eax
	ir_tag86_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag87_cmp
	movl $0, %eax
	jmp ir_tag87_cmpend
	ir_tag87_cmp:
	movl $1, %eax
	ir_tag87_cmpend:
	cmpl $0, %eax
	je ir_tag_else_88
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_88
	ir_tag_else_88:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_88
	ir_tag_end_88:
	cmpl $0, %ebx
	je ir_tag_else_89
	pushl %edi
	call print_any
	jmp ir_tag_end_89
	ir_tag_else_89:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag90_cmp
	movl $0, %eax
	jmp ir_tag90_cmpend
	ir_tag90_cmp:
	movl $1, %eax
	ir_tag90_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag91_cmp
	movl $0, %eax
	jmp ir_tag91_cmpend
	ir_tag91_cmp:
	movl $1, %eax
	ir_tag91_cmpend:
	cmpl $0, %eax
	je ir_tag_else_92
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_92
	ir_tag_else_92:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_92
	ir_tag_end_92:
	cmpl $0, %ebx
	je ir_tag_else_93
	pushl %edi
	call print_any
	jmp ir_tag_end_93
	ir_tag_else_93:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_93
	ir_tag_end_93:
	jmp ir_tag_end_89
	ir_tag_end_89:
	jmp ir_tag_end_85
	ir_tag_end_85:
	movl %esi, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag94_cmp
	movl $0, %eax
	jmp ir_tag94_cmpend
	ir_tag94_cmp:
	movl $1, %eax
	ir_tag94_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag95_cmp
	movl $0, %eax
	jmp ir_tag95_cmpend
	ir_tag95_cmp:
	movl $1, %eax
	ir_tag95_cmpend:
	cmpl $0, %eax
	je ir_tag_else_96
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_96
	ir_tag_else_96:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_96
	ir_tag_end_96:
	cmpl $0, %ebx
	je ir_tag_else_97
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_97
	ir_tag_else_97:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag98_cmp
	movl $0, %eax
	jmp ir_tag98_cmpend
	ir_tag98_cmp:
	movl $1, %eax
	ir_tag98_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag99_cmp
	movl $0, %eax
	jmp ir_tag99_cmpend
	ir_tag99_cmp:
	movl $1, %eax
	ir_tag99_cmpend:
	cmpl $0, %eax
	je ir_tag_else_100
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_100
	ir_tag_else_100:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_100
	ir_tag_end_100:
	cmpl $0, %ebx
	je ir_tag_else_101
	pushl %esi
	call print_any
	jmp ir_tag_end_101
	ir_tag_else_101:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag102_cmp
	movl $0, %eax
	jmp ir_tag102_cmpend
	ir_tag102_cmp:
	movl $1, %eax
	ir_tag102_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag103_cmp
	movl $0, %eax
	jmp ir_tag103_cmpend
	ir_tag103_cmp:
	movl $1, %eax
	ir_tag103_cmpend:
	cmpl $0, %eax
	je ir_tag_else_104
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_104
	ir_tag_else_104:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_104
	ir_tag_end_104:
	cmpl $0, %ebx
	je ir_tag_else_105
	pushl %esi
	call print_any
	jmp ir_tag_end_105
	ir_tag_else_105:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_105
	ir_tag_end_105:
	jmp ir_tag_end_101
	ir_tag_end_101:
	jmp ir_tag_end_97
	ir_tag_end_97:
	movl $0, %eax
	leave
	ret
