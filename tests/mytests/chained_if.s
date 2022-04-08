.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_int
	movl %eax, -4(%ebp)
	pushl $3
	call inject_int
	movl %eax, %ebx
	movl %ebx, %ebx
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
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
	movl %edi, -12(%ebp)
	orl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, %edi
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, %edi
	ir_tag2_cmpend:
	movl -8(%ebp), %eax
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
	movl %edi, %ecx
	orl %eax, %ecx
	movl -12(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
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
	cmpl %edi, %eax
	jg ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, %edi
	movl %edi, -20(%ebp)
	jmp ir_tag_end_6
	ir_tag_else_6:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag16_cmp
	movl $0, %edi
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %edi
	ir_tag16_cmpend:
	movl -8(%ebp), %eax
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
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_19
	ir_tag_else_19:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_19
	ir_tag_end_19:
	cmpl $0, %edi
	je ir_tag_else_20
	pushl %ebx
	call project_big
	movl %eax, %eax
	movl -8(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	movl %eax, -20(%ebp)
	jmp ir_tag_end_20
	ir_tag_else_20:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, -20(%ebp)
	jmp ir_tag_end_20
	ir_tag_end_20:
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %edi, -20(%ebp)
	movl %edi, -20(%ebp)
	movl -20(%ebp), %eax
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
	movl -20(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -20(%ebp)
	jmp ir_tag_end_22
	ir_tag_else_22:
	movl -20(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -20(%ebp)
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, -20(%ebp)
	je ir_tag_else_23
	movl -4(%ebp), %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_23
	ir_tag_else_23:
	movl %ebx, %ebx
	movl -4(%ebp), %eax
	movl %eax, %edi
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag24_cmp
	movl $0, -24(%ebp)
	jmp ir_tag24_cmpend
	ir_tag24_cmp:
	movl $1, -24(%ebp)
	ir_tag24_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag25_cmp
	movl $0, %ecx
	jmp ir_tag25_cmpend
	ir_tag25_cmp:
	movl $1, %ecx
	ir_tag25_cmpend:
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	orl %ecx, -28(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag26_cmp
	movl $0, -32(%ebp)
	jmp ir_tag26_cmpend
	ir_tag26_cmp:
	movl $1, -32(%ebp)
	ir_tag26_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag27_cmp
	movl $0, %edx
	jmp ir_tag27_cmpend
	ir_tag27_cmp:
	movl $1, %edx
	ir_tag27_cmpend:
	movl -32(%ebp), %eax
	movl %eax, %ecx
	orl %edx, %ecx
	movl -28(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	pushl %eax
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
	movl -36(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -36(%ebp)
	jmp ir_tag_end_29
	ir_tag_else_29:
	movl -36(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -36(%ebp)
	jmp ir_tag_end_29
	ir_tag_end_29:
	cmpl $0, -36(%ebp)
	je ir_tag_else_30
	pushl %ebx
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
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	pushl %eax
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
	movl -40(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -40(%ebp)
	jmp ir_tag_end_33
	ir_tag_else_33:
	movl -40(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -40(%ebp)
	jmp ir_tag_end_33
	ir_tag_end_33:
	cmpl $0, -40(%ebp)
	je ir_tag_else_34
	pushl %ebx
	call project_int
	movl %eax, -44(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -44(%ebp)
	jmp ir_tag_end_34
	ir_tag_else_34:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, -44(%ebp)
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
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	pushl %eax
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
	movl -48(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -48(%ebp)
	jmp ir_tag_end_37
	ir_tag_else_37:
	movl -48(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -48(%ebp)
	jmp ir_tag_end_37
	ir_tag_end_37:
	cmpl $0, -48(%ebp)
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
	movl -44(%ebp), %eax
	cmpl %eax, %ecx
	jg ir_tag39_cmp
	movl $0, %eax
	jmp ir_tag39_cmpend
	ir_tag39_cmp:
	movl $1, %eax
	ir_tag39_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -52(%ebp)
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag40_cmp
	movl $0, -60(%ebp)
	jmp ir_tag40_cmpend
	ir_tag40_cmp:
	movl $1, -60(%ebp)
	ir_tag40_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag41_cmp
	movl $0, %ecx
	jmp ir_tag41_cmpend
	ir_tag41_cmp:
	movl $1, %ecx
	ir_tag41_cmpend:
	movl -60(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, -64(%ebp)
	movl -64(%ebp), %eax
	pushl %eax
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
	movl -64(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -64(%ebp)
	jmp ir_tag_end_43
	ir_tag_else_43:
	movl -64(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -64(%ebp)
	jmp ir_tag_end_43
	ir_tag_end_43:
	cmpl $0, -64(%ebp)
	je ir_tag_else_44
	pushl %ebx
	call project_big
	movl %eax, %eax
	pushl %edi
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, -56(%ebp)
	movl -56(%ebp), %eax
	movl %eax, %eax
	movl %eax, -52(%ebp)
	jmp ir_tag_end_44
	ir_tag_else_44:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, -52(%ebp)
	jmp ir_tag_end_44
	ir_tag_end_44:
	jmp ir_tag_end_30
	ir_tag_end_30:
	movl -56(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	pushl %eax
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
	movl -52(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -52(%ebp)
	jmp ir_tag_end_46
	ir_tag_else_46:
	movl -52(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -52(%ebp)
	jmp ir_tag_end_46
	ir_tag_end_46:
	cmpl $0, -52(%ebp)
	je ir_tag_else_47
	movl %ebx, %ebx
	movl -4(%ebp), %eax
	movl %eax, -68(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag48_cmp
	movl $0, %edi
	jmp ir_tag48_cmpend
	ir_tag48_cmp:
	movl $1, %edi
	ir_tag48_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag49_cmp
	movl $0, %eax
	jmp ir_tag49_cmpend
	ir_tag49_cmp:
	movl $1, %eax
	ir_tag49_cmpend:
	movl %edi, %edi
	orl %eax, %edi
	movl -68(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag50_cmp
	movl $0, -72(%ebp)
	jmp ir_tag50_cmpend
	ir_tag50_cmp:
	movl $1, -72(%ebp)
	ir_tag50_cmpend:
	movl -68(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag51_cmp
	movl $0, %ecx
	jmp ir_tag51_cmpend
	ir_tag51_cmp:
	movl $1, %ecx
	ir_tag51_cmpend:
	movl -72(%ebp), %eax
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
	je ir_tag52_cmp
	movl $0, %eax
	jmp ir_tag52_cmpend
	ir_tag52_cmp:
	movl $1, %eax
	ir_tag52_cmpend:
	cmpl $0, %eax
	je ir_tag_else_53
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_53
	ir_tag_else_53:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_53
	ir_tag_end_53:
	cmpl $0, %edi
	je ir_tag_else_54
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag55_cmp
	movl $0, %eax
	jmp ir_tag55_cmpend
	ir_tag55_cmp:
	movl $1, %eax
	ir_tag55_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag56_cmp
	movl $0, %eax
	jmp ir_tag56_cmpend
	ir_tag56_cmp:
	movl $1, %eax
	ir_tag56_cmpend:
	cmpl $0, %eax
	je ir_tag_else_57
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_57
	ir_tag_else_57:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_57
	ir_tag_end_57:
	cmpl $0, %edi
	je ir_tag_else_58
	pushl %ebx
	call project_int
	movl %eax, %edi
	movl %edi, %edi
	jmp ir_tag_end_58
	ir_tag_else_58:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %edi
	jmp ir_tag_end_58
	ir_tag_end_58:
	movl -68(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag59_cmp
	movl $0, %eax
	jmp ir_tag59_cmpend
	ir_tag59_cmp:
	movl $1, %eax
	ir_tag59_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag60_cmp
	movl $0, %eax
	jmp ir_tag60_cmpend
	ir_tag60_cmp:
	movl $1, %eax
	ir_tag60_cmpend:
	cmpl $0, %eax
	je ir_tag_else_61
	movl -76(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -76(%ebp)
	jmp ir_tag_end_61
	ir_tag_else_61:
	movl -76(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -76(%ebp)
	jmp ir_tag_end_61
	ir_tag_end_61:
	cmpl $0, -76(%ebp)
	je ir_tag_else_62
	movl -68(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_62
	ir_tag_else_62:
	movl -68(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_62
	ir_tag_end_62:
	cmpl %edi, %eax
	jl ir_tag63_cmp
	movl $0, %eax
	jmp ir_tag63_cmpend
	ir_tag63_cmp:
	movl $1, %eax
	ir_tag63_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	jmp ir_tag_end_54
	ir_tag_else_54:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag64_cmp
	movl $0, %edi
	jmp ir_tag64_cmpend
	ir_tag64_cmp:
	movl $1, %edi
	ir_tag64_cmpend:
	movl -68(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag65_cmp
	movl $0, %eax
	jmp ir_tag65_cmpend
	ir_tag65_cmp:
	movl $1, %eax
	ir_tag65_cmpend:
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag66_cmp
	movl $0, %eax
	jmp ir_tag66_cmpend
	ir_tag66_cmp:
	movl $1, %eax
	ir_tag66_cmpend:
	cmpl $0, %eax
	je ir_tag_else_67
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_67
	ir_tag_else_67:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_67
	ir_tag_end_67:
	cmpl $0, %edi
	je ir_tag_else_68
	pushl %ebx
	call project_big
	movl %eax, %eax
	movl -68(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	movl %eax, %eax
	jmp ir_tag_end_68
	ir_tag_else_68:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_68
	ir_tag_end_68:
	jmp ir_tag_end_54
	ir_tag_end_54:
	movl %edi, %eax
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_47
	ir_tag_else_47:
	movl %ebx, %ebx
	movl -4(%ebp), %eax
	movl %eax, -80(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag69_cmp
	movl $0, %edi
	jmp ir_tag69_cmpend
	ir_tag69_cmp:
	movl $1, %edi
	ir_tag69_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag70_cmp
	movl $0, %eax
	jmp ir_tag70_cmpend
	ir_tag70_cmp:
	movl $1, %eax
	ir_tag70_cmpend:
	movl %edi, %edi
	orl %eax, %edi
	movl -80(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag71_cmp
	movl $0, -84(%ebp)
	jmp ir_tag71_cmpend
	ir_tag71_cmp:
	movl $1, -84(%ebp)
	ir_tag71_cmpend:
	movl -80(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag72_cmp
	movl $0, %ecx
	jmp ir_tag72_cmpend
	ir_tag72_cmp:
	movl $1, %ecx
	ir_tag72_cmpend:
	movl -84(%ebp), %eax
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
	je ir_tag73_cmp
	movl $0, %eax
	jmp ir_tag73_cmpend
	ir_tag73_cmp:
	movl $1, %eax
	ir_tag73_cmpend:
	cmpl $0, %eax
	je ir_tag_else_74
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_74
	ir_tag_else_74:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_74
	ir_tag_end_74:
	cmpl $0, %edi
	je ir_tag_else_75
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag76_cmp
	movl $0, %eax
	jmp ir_tag76_cmpend
	ir_tag76_cmp:
	movl $1, %eax
	ir_tag76_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag77_cmp
	movl $0, %eax
	jmp ir_tag77_cmpend
	ir_tag77_cmp:
	movl $1, %eax
	ir_tag77_cmpend:
	cmpl $0, %eax
	je ir_tag_else_78
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_78
	ir_tag_else_78:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_78
	ir_tag_end_78:
	cmpl $0, %edi
	je ir_tag_else_79
	pushl %ebx
	call project_int
	movl %eax, -88(%ebp)
	movl -88(%ebp), %eax
	movl %eax, -88(%ebp)
	jmp ir_tag_end_79
	ir_tag_else_79:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, -88(%ebp)
	jmp ir_tag_end_79
	ir_tag_end_79:
	movl -80(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag80_cmp
	movl $0, %eax
	jmp ir_tag80_cmpend
	ir_tag80_cmp:
	movl $1, %eax
	ir_tag80_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag81_cmp
	movl $0, %eax
	jmp ir_tag81_cmpend
	ir_tag81_cmp:
	movl $1, %eax
	ir_tag81_cmpend:
	cmpl $0, %eax
	je ir_tag_else_82
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_82
	ir_tag_else_82:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_82
	ir_tag_end_82:
	cmpl $0, %edi
	je ir_tag_else_83
	movl -80(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_83
	ir_tag_else_83:
	movl -80(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_83
	ir_tag_end_83:
	movl -88(%ebp), %eax
	cmpl %eax, %ecx
	jg ir_tag84_cmp
	movl $0, %eax
	jmp ir_tag84_cmpend
	ir_tag84_cmp:
	movl $1, %eax
	ir_tag84_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -92(%ebp)
	movl -92(%ebp), %eax
	movl %eax, %edi
	movl %edi, -92(%ebp)
	jmp ir_tag_end_75
	ir_tag_else_75:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag85_cmp
	movl $0, %edi
	jmp ir_tag85_cmpend
	ir_tag85_cmp:
	movl $1, %edi
	ir_tag85_cmpend:
	movl -80(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag86_cmp
	movl $0, %eax
	jmp ir_tag86_cmpend
	ir_tag86_cmp:
	movl $1, %eax
	ir_tag86_cmpend:
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_88
	ir_tag_else_88:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_88
	ir_tag_end_88:
	cmpl $0, %edi
	je ir_tag_else_89
	pushl %ebx
	call project_big
	movl %eax, %eax
	movl -80(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	movl %eax, -92(%ebp)
	jmp ir_tag_end_89
	ir_tag_else_89:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, -92(%ebp)
	jmp ir_tag_end_89
	ir_tag_end_89:
	jmp ir_tag_end_75
	ir_tag_end_75:
	movl %edi, -92(%ebp)
	movl %edi, -92(%ebp)
	movl -92(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag90_cmp
	movl $0, %eax
	jmp ir_tag90_cmpend
	ir_tag90_cmp:
	movl $1, %eax
	ir_tag90_cmpend:
	cmpl $0, %eax
	je ir_tag_else_91
	movl -92(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -92(%ebp)
	jmp ir_tag_end_91
	ir_tag_else_91:
	movl -92(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -92(%ebp)
	jmp ir_tag_end_91
	ir_tag_end_91:
	cmpl $0, -92(%ebp)
	je ir_tag_else_92
	movl %ebx, %ebx
	movl -4(%ebp), %eax
	movl %eax, -96(%ebp)
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag93_cmp
	movl $0, %edi
	jmp ir_tag93_cmpend
	ir_tag93_cmp:
	movl $1, %edi
	ir_tag93_cmpend:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag94_cmp
	movl $0, %eax
	jmp ir_tag94_cmpend
	ir_tag94_cmp:
	movl $1, %eax
	ir_tag94_cmpend:
	movl %edi, -100(%ebp)
	orl %eax, -100(%ebp)
	movl -96(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag95_cmp
	movl $0, %edi
	jmp ir_tag95_cmpend
	ir_tag95_cmp:
	movl $1, %edi
	ir_tag95_cmpend:
	movl -96(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag96_cmp
	movl $0, %eax
	jmp ir_tag96_cmpend
	ir_tag96_cmp:
	movl $1, %eax
	ir_tag96_cmpend:
	movl %edi, %ecx
	orl %eax, %ecx
	movl -100(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag97_cmp
	movl $0, %eax
	jmp ir_tag97_cmpend
	ir_tag97_cmp:
	movl $1, %eax
	ir_tag97_cmpend:
	cmpl $0, %eax
	je ir_tag_else_98
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_98
	ir_tag_else_98:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_98
	ir_tag_end_98:
	cmpl $0, %edi
	je ir_tag_else_99
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag100_cmp
	movl $0, %eax
	jmp ir_tag100_cmpend
	ir_tag100_cmp:
	movl $1, %eax
	ir_tag100_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag101_cmp
	movl $0, %eax
	jmp ir_tag101_cmpend
	ir_tag101_cmp:
	movl $1, %eax
	ir_tag101_cmpend:
	cmpl $0, %eax
	je ir_tag_else_102
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_102
	ir_tag_else_102:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_102
	ir_tag_end_102:
	cmpl $0, %edi
	je ir_tag_else_103
	pushl %ebx
	call project_int
	movl %eax, %edi
	movl %edi, %edi
	jmp ir_tag_end_103
	ir_tag_else_103:
	pushl %ebx
	call project_bool
	movl %eax, %eax
	movl %eax, %edi
	jmp ir_tag_end_103
	ir_tag_end_103:
	movl -96(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag104_cmp
	movl $0, %eax
	jmp ir_tag104_cmpend
	ir_tag104_cmp:
	movl $1, %eax
	ir_tag104_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -104(%ebp)
	movl -104(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag105_cmp
	movl $0, %eax
	jmp ir_tag105_cmpend
	ir_tag105_cmp:
	movl $1, %eax
	ir_tag105_cmpend:
	cmpl $0, %eax
	je ir_tag_else_106
	movl -104(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -104(%ebp)
	jmp ir_tag_end_106
	ir_tag_else_106:
	movl -104(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -104(%ebp)
	jmp ir_tag_end_106
	ir_tag_end_106:
	cmpl $0, -104(%ebp)
	je ir_tag_else_107
	movl -96(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_107
	ir_tag_else_107:
	movl -96(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_107
	ir_tag_end_107:
	cmpl %edi, %eax
	jl ir_tag108_cmp
	movl $0, %eax
	jmp ir_tag108_cmpend
	ir_tag108_cmp:
	movl $1, %eax
	ir_tag108_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	jmp ir_tag_end_99
	ir_tag_else_99:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag109_cmp
	movl $0, %edi
	jmp ir_tag109_cmpend
	ir_tag109_cmp:
	movl $1, %edi
	ir_tag109_cmpend:
	movl -96(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag110_cmp
	movl $0, %eax
	jmp ir_tag110_cmpend
	ir_tag110_cmp:
	movl $1, %eax
	ir_tag110_cmpend:
	movl %edi, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %edi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag111_cmp
	movl $0, %eax
	jmp ir_tag111_cmpend
	ir_tag111_cmp:
	movl $1, %eax
	ir_tag111_cmpend:
	cmpl $0, %eax
	je ir_tag_else_112
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_112
	ir_tag_else_112:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_112
	ir_tag_end_112:
	cmpl $0, %edi
	je ir_tag_else_113
	pushl %ebx
	call project_big
	movl %eax, %eax
	movl -96(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %eax
	call call_error
	pushl %esi
	call inject_bool
	movl %eax, %eax
	movl %eax, %edi
	movl %edi, %eax
	movl %eax, %eax
	jmp ir_tag_end_113
	ir_tag_else_113:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_113
	ir_tag_end_113:
	jmp ir_tag_end_99
	ir_tag_end_99:
	movl %edi, %eax
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_92
	ir_tag_else_92:
	movl %ebx, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_92
	ir_tag_end_92:
	jmp ir_tag_end_47
	ir_tag_end_47:
	jmp ir_tag_end_23
	ir_tag_end_23:
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag114_cmp
	movl $0, %eax
	jmp ir_tag114_cmpend
	ir_tag114_cmp:
	movl $1, %eax
	ir_tag114_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag115_cmp
	movl $0, %eax
	jmp ir_tag115_cmpend
	ir_tag115_cmp:
	movl $1, %eax
	ir_tag115_cmpend:
	cmpl $0, %eax
	je ir_tag_else_116
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_116
	ir_tag_else_116:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_116
	ir_tag_end_116:
	cmpl $0, %ebx
	je ir_tag_else_117
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_117
	ir_tag_else_117:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag118_cmp
	movl $0, %eax
	jmp ir_tag118_cmpend
	ir_tag118_cmp:
	movl $1, %eax
	ir_tag118_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag119_cmp
	movl $0, %eax
	jmp ir_tag119_cmpend
	ir_tag119_cmp:
	movl $1, %eax
	ir_tag119_cmpend:
	cmpl $0, %eax
	je ir_tag_else_120
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_120
	ir_tag_else_120:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_120
	ir_tag_end_120:
	cmpl $0, %ebx
	je ir_tag_else_121
	pushl %esi
	call print_any
	jmp ir_tag_end_121
	ir_tag_else_121:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag122_cmp
	movl $0, %eax
	jmp ir_tag122_cmpend
	ir_tag122_cmp:
	movl $1, %eax
	ir_tag122_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag123_cmp
	movl $0, %eax
	jmp ir_tag123_cmpend
	ir_tag123_cmp:
	movl $1, %eax
	ir_tag123_cmpend:
	cmpl $0, %eax
	je ir_tag_else_124
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_124
	ir_tag_else_124:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_124
	ir_tag_end_124:
	cmpl $0, %ebx
	je ir_tag_else_125
	pushl %esi
	call print_any
	jmp ir_tag_end_125
	ir_tag_else_125:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_125
	ir_tag_end_125:
	jmp ir_tag_end_121
	ir_tag_end_121:
	jmp ir_tag_end_117
	ir_tag_end_117:
	movl $0, %eax
	leave
	ret
