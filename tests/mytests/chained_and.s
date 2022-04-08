.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_bool
	movl %eax, %esi
	pushl $1
	call inject_bool
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
	movl %ebx, -4(%ebp)
	orl %eax, -4(%ebp)
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
	movl -4(%ebp), %eax
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
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_10
	ir_tag_else_10:
	pushl %esi
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
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
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
	movl -8(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -8(%ebp)
	jmp ir_tag_end_13
	ir_tag_else_13:
	movl -8(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -8(%ebp)
	jmp ir_tag_end_13
	ir_tag_end_13:
	cmpl $0, -8(%ebp)
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
	movl %ebx, %ecx
	andl %eax, %ecx
	cmpl $0, %ecx
	je ir_tag15_cmp
	movl $0, %eax
	jmp ir_tag15_cmpend
	ir_tag15_cmp:
	movl $1, %eax
	ir_tag15_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag16_cmp
	movl $0, %eax
	jmp ir_tag16_cmpend
	ir_tag16_cmp:
	movl $1, %eax
	ir_tag16_cmpend:
	cmpl $0, %eax
	je ir_tag_else_17
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_17
	ir_tag_else_17:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_17
	ir_tag_end_17:
	cmpl $0, %ebx
	je ir_tag_else_18
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag19_cmp
	movl $0, %eax
	jmp ir_tag19_cmpend
	ir_tag19_cmp:
	movl $1, %eax
	ir_tag19_cmpend:
	pushl %eax
	call inject_bool
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
	cmpl $0, %eax
	je ir_tag_else_21
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_21
	ir_tag_else_21:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_21
	ir_tag_end_21:
	cmpl $0, %ebx
	je ir_tag_else_22
	pushl %esi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_22
	ir_tag_else_22:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, %eax
	je ir_tag23_cmp
	movl $0, %eax
	jmp ir_tag23_cmpend
	ir_tag23_cmp:
	movl $1, %eax
	ir_tag23_cmpend:
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
	movl %esi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_26
	ir_tag_else_26:
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_26
	ir_tag_end_26:
	jmp ir_tag_end_18
	ir_tag_else_18:
	pushl %edi
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
	pushl %edi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_30
	ir_tag_end_30:
	cmpl $0, %eax
	jne ir_tag31_cmp
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
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_else_34:
	movl %esi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_end_34:
	jmp ir_tag_end_18
	ir_tag_end_18:
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_6
	ir_tag_else_6:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_6
	ir_tag_end_6:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %ebx
	pushl $0
	call inject_bool
	movl %eax, %edi
	pushl $0
	call inject_bool
	movl %eax, -12(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag35_cmp
	movl $0, %esi
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %esi
	ir_tag35_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag36_cmp
	movl $0, %eax
	jmp ir_tag36_cmpend
	ir_tag36_cmp:
	movl $1, %eax
	ir_tag36_cmpend:
	movl %esi, %esi
	orl %eax, %esi
	movl -12(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag37_cmp
	movl $0, -16(%ebp)
	jmp ir_tag37_cmpend
	ir_tag37_cmp:
	movl $1, -16(%ebp)
	ir_tag37_cmpend:
	movl -12(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag38_cmp
	movl $0, %ecx
	jmp ir_tag38_cmpend
	ir_tag38_cmp:
	movl $1, %ecx
	ir_tag38_cmpend:
	movl -16(%ebp), %eax
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
	je ir_tag39_cmp
	movl $0, %eax
	jmp ir_tag39_cmpend
	ir_tag39_cmp:
	movl $1, %eax
	ir_tag39_cmpend:
	cmpl $0, %eax
	je ir_tag_else_40
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_40
	ir_tag_else_40:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_40
	ir_tag_end_40:
	cmpl $0, %esi
	je ir_tag_else_41
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag42_cmp
	movl $0, %eax
	jmp ir_tag42_cmpend
	ir_tag42_cmp:
	movl $1, %eax
	ir_tag42_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag43_cmp
	movl $0, %eax
	jmp ir_tag43_cmpend
	ir_tag43_cmp:
	movl $1, %eax
	ir_tag43_cmpend:
	cmpl $0, %eax
	je ir_tag_else_44
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_44
	ir_tag_else_44:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_44
	ir_tag_end_44:
	cmpl $0, %esi
	je ir_tag_else_45
	pushl %edi
	call project_int
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -20(%ebp)
	jmp ir_tag_end_45
	ir_tag_else_45:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, -20(%ebp)
	jmp ir_tag_end_45
	ir_tag_end_45:
	movl -12(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag46_cmp
	movl $0, %eax
	jmp ir_tag46_cmpend
	ir_tag46_cmp:
	movl $1, %eax
	ir_tag46_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag47_cmp
	movl $0, %eax
	jmp ir_tag47_cmpend
	ir_tag47_cmp:
	movl $1, %eax
	ir_tag47_cmpend:
	cmpl $0, %eax
	je ir_tag_else_48
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_48
	ir_tag_else_48:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_48
	ir_tag_end_48:
	cmpl $0, %esi
	je ir_tag_else_49
	movl -12(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_49
	ir_tag_else_49:
	movl -12(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_49
	ir_tag_end_49:
	movl -20(%ebp), %eax
	movl %eax, %eax
	andl %ecx, %eax
	cmpl $0, %eax
	je ir_tag50_cmp
	movl $0, %eax
	jmp ir_tag50_cmpend
	ir_tag50_cmp:
	movl $1, %eax
	ir_tag50_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag51_cmp
	movl $0, %eax
	jmp ir_tag51_cmpend
	ir_tag51_cmp:
	movl $1, %eax
	ir_tag51_cmpend:
	cmpl $0, %eax
	je ir_tag_else_52
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_52
	ir_tag_else_52:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_52
	ir_tag_end_52:
	cmpl $0, %esi
	je ir_tag_else_53
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag54_cmp
	movl $0, %eax
	jmp ir_tag54_cmpend
	ir_tag54_cmp:
	movl $1, %eax
	ir_tag54_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag55_cmp
	movl $0, %eax
	jmp ir_tag55_cmpend
	ir_tag55_cmp:
	movl $1, %eax
	ir_tag55_cmpend:
	cmpl $0, %eax
	je ir_tag_else_56
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_56
	ir_tag_else_56:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_56
	ir_tag_end_56:
	cmpl $0, %esi
	je ir_tag_else_57
	pushl %edi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_57
	ir_tag_else_57:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_57
	ir_tag_end_57:
	cmpl $0, %eax
	je ir_tag58_cmp
	movl $0, %eax
	jmp ir_tag58_cmpend
	ir_tag58_cmp:
	movl $1, %eax
	ir_tag58_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag59_cmp
	movl $0, %eax
	jmp ir_tag59_cmpend
	ir_tag59_cmp:
	movl $1, %eax
	ir_tag59_cmpend:
	cmpl $0, %eax
	je ir_tag_else_60
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_60
	ir_tag_else_60:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_60
	ir_tag_end_60:
	cmpl $0, %esi
	je ir_tag_else_61
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_61
	ir_tag_else_61:
	movl -12(%ebp), %eax
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_61
	ir_tag_end_61:
	jmp ir_tag_end_53
	ir_tag_else_53:
	movl -12(%ebp), %eax
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
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag63_cmp
	movl $0, %eax
	jmp ir_tag63_cmpend
	ir_tag63_cmp:
	movl $1, %eax
	ir_tag63_cmpend:
	cmpl $0, %eax
	je ir_tag_else_64
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_64
	ir_tag_else_64:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_64
	ir_tag_end_64:
	cmpl $0, %esi
	je ir_tag_else_65
	movl -12(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_65
	ir_tag_else_65:
	movl -12(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_65
	ir_tag_end_65:
	cmpl $0, %eax
	jne ir_tag66_cmp
	movl $0, %eax
	jmp ir_tag66_cmpend
	ir_tag66_cmp:
	movl $1, %eax
	ir_tag66_cmpend:
	pushl %eax
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
	movl -12(%ebp), %eax
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_69
	ir_tag_else_69:
	movl %edi, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_69
	ir_tag_end_69:
	jmp ir_tag_end_53
	ir_tag_end_53:
	movl %eax, %esi
	movl %esi, %eax
	jmp ir_tag_end_41
	ir_tag_else_41:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_41
	ir_tag_end_41:
	movl %esi, %eax
	movl %esi, %eax
	movl %eax, %edi
	movl %ebx, %ebx
	pushl %ebx
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_72
	ir_tag_else_72:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_72
	ir_tag_end_72:
	cmpl $0, %esi
	je ir_tag_else_73
	pushl %ebx
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_73
	ir_tag_else_73:
	pushl %ebx
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_76
	ir_tag_else_76:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_76
	ir_tag_end_76:
	cmpl $0, %esi
	je ir_tag_else_77
	pushl %ebx
	call print_any
	jmp ir_tag_end_77
	ir_tag_else_77:
	pushl %ebx
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_80
	ir_tag_else_80:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_80
	ir_tag_end_80:
	cmpl $0, %esi
	je ir_tag_else_81
	pushl %ebx
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
	movl %edi, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_85
	ir_tag_else_85:
	pushl %esi
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
	pushl %esi
	call print_any
	jmp ir_tag_end_89
	ir_tag_else_89:
	pushl %esi
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
	pushl %esi
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
	movl $0, %eax
	leave
	ret