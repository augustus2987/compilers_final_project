.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $1
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, -4(%ebp)
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $1
	call inject_int
	pushl %eax
	pushl %ebx
	movl -4(%ebp), %eax
	pushl %eax
	call set_subscript
	pushl $1
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %edi
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	call create_dict
	pushl %eax
	call inject_big
	movl %eax, %esi
	pushl $1
	call inject_int
	movl %eax, %ebx
	movl -4(%ebp), %eax
	movl %eax, %eax
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	movl %edi, %eax
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, -8(%ebp)
	pushl $1
	call inject_int
	pushl %eax
	movl -8(%ebp), %eax
	pushl %eax
	call get_subscript
	movl %eax, %eax
	movl %eax, %esi
	pushl $2
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, %edi
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, %edi
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
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -12(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -12(%ebp)
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
	movl -12(%ebp), %eax
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
	addl %eax, %ecx
	pushl %ecx
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
	movl %ebx, %edi
	movl %ebx, %eax
	movl %eax, %edx
	pushl $1
	call inject_int
	pushl %edx
	pushl %eax
	movl -8(%ebp), %eax
	pushl %eax
	call set_subscript
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
	pushl $1
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, %edi
	pushl $2
	call inject_int
	pushl %eax
	movl -8(%ebp), %eax
	pushl %eax
	call get_subscript
	movl %eax, %eax
	movl %eax, %esi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag20_cmp
	movl $0, %ebx
	jmp ir_tag20_cmpend
	ir_tag20_cmp:
	movl $1, %ebx
	ir_tag20_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag21_cmp
	movl $0, %eax
	jmp ir_tag21_cmpend
	ir_tag21_cmp:
	movl $1, %eax
	ir_tag21_cmpend:
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag22_cmp
	movl $0, -20(%ebp)
	jmp ir_tag22_cmpend
	ir_tag22_cmp:
	movl $1, -20(%ebp)
	ir_tag22_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag23_cmp
	movl $0, %ecx
	jmp ir_tag23_cmpend
	ir_tag23_cmp:
	movl $1, %ecx
	ir_tag23_cmpend:
	movl -20(%ebp), %eax
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
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_30
	ir_tag_end_30:
	pushl %esi
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
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
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
	movl -24(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -24(%ebp)
	jmp ir_tag_end_33
	ir_tag_else_33:
	movl -24(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -24(%ebp)
	jmp ir_tag_end_33
	ir_tag_end_33:
	cmpl $0, -24(%ebp)
	je ir_tag_else_34
	pushl %esi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_else_34:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_34
	ir_tag_end_34:
	movl %ebx, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_26
	ir_tag_else_26:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag35_cmp
	movl $0, %ebx
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %ebx
	ir_tag35_cmpend:
	pushl %esi
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
	pushl %edi
	call project_big
	movl %eax, %ebx
	pushl %esi
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
	movl %ebx, %esi
	movl %esi, %edi
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
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, -28(%ebp)
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag40_cmp
	movl $0, %ebx
	jmp ir_tag40_cmpend
	ir_tag40_cmp:
	movl $1, %ebx
	ir_tag40_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag41_cmp
	movl $0, %eax
	jmp ir_tag41_cmpend
	ir_tag41_cmp:
	movl $1, %eax
	ir_tag41_cmpend:
	movl %ebx, %esi
	orl %eax, %esi
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag42_cmp
	movl $0, %ebx
	jmp ir_tag42_cmpend
	ir_tag42_cmp:
	movl $1, %ebx
	ir_tag42_cmpend:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag43_cmp
	movl $0, %eax
	jmp ir_tag43_cmpend
	ir_tag43_cmp:
	movl $1, %eax
	ir_tag43_cmpend:
	movl %ebx, %ecx
	orl %eax, %ecx
	movl %esi, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag44_cmp
	movl $0, %eax
	jmp ir_tag44_cmpend
	ir_tag44_cmp:
	movl $1, %eax
	ir_tag44_cmpend:
	cmpl $0, %eax
	je ir_tag_else_45
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_45
	ir_tag_else_45:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_45
	ir_tag_end_45:
	cmpl $0, %ebx
	je ir_tag_else_46
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag47_cmp
	movl $0, %eax
	jmp ir_tag47_cmpend
	ir_tag47_cmp:
	movl $1, %eax
	ir_tag47_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag48_cmp
	movl $0, %eax
	jmp ir_tag48_cmpend
	ir_tag48_cmp:
	movl $1, %eax
	ir_tag48_cmpend:
	cmpl $0, %eax
	je ir_tag_else_49
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_49
	ir_tag_else_49:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_49
	ir_tag_end_49:
	cmpl $0, %ebx
	je ir_tag_else_50
	pushl %edi
	call project_int
	movl %eax, %esi
	movl %esi, %esi
	jmp ir_tag_end_50
	ir_tag_else_50:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %esi
	jmp ir_tag_end_50
	ir_tag_end_50:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag51_cmp
	movl $0, %eax
	jmp ir_tag51_cmpend
	ir_tag51_cmp:
	movl $1, %eax
	ir_tag51_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_53
	ir_tag_else_53:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_53
	ir_tag_end_53:
	cmpl $0, %ebx
	je ir_tag_else_54
	movl -28(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_54
	ir_tag_else_54:
	movl -28(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_54
	ir_tag_end_54:
	movl %esi, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_46
	ir_tag_else_46:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag55_cmp
	movl $0, %ebx
	jmp ir_tag55_cmpend
	ir_tag55_cmp:
	movl $1, %ebx
	ir_tag55_cmpend:
	movl -28(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag56_cmp
	movl $0, %eax
	jmp ir_tag56_cmpend
	ir_tag56_cmp:
	movl $1, %eax
	ir_tag56_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	pushl %edi
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
	movl %eax, %ebx
	movl %ebx, %eax
	movl %eax, %eax
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
	jmp ir_tag_end_46
	ir_tag_end_46:
	movl %ebx, %esi
	movl %ebx, %esi
	movl %esi, %edx
	pushl $2
	call inject_int
	pushl %edx
	pushl %eax
	movl -8(%ebp), %eax
	pushl %eax
	call set_subscript
	movl -8(%ebp), %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag60_cmp
	movl $0, %eax
	jmp ir_tag60_cmpend
	ir_tag60_cmp:
	movl $1, %eax
	ir_tag60_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag61_cmp
	movl $0, %eax
	jmp ir_tag61_cmpend
	ir_tag61_cmp:
	movl $1, %eax
	ir_tag61_cmpend:
	cmpl $0, %eax
	je ir_tag_else_62
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_62
	ir_tag_else_62:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_62
	ir_tag_end_62:
	cmpl $0, %ebx
	je ir_tag_else_63
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_63
	ir_tag_else_63:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag64_cmp
	movl $0, %eax
	jmp ir_tag64_cmpend
	ir_tag64_cmp:
	movl $1, %eax
	ir_tag64_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag65_cmp
	movl $0, %eax
	jmp ir_tag65_cmpend
	ir_tag65_cmp:
	movl $1, %eax
	ir_tag65_cmpend:
	cmpl $0, %eax
	je ir_tag_else_66
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_66
	ir_tag_else_66:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_66
	ir_tag_end_66:
	cmpl $0, %ebx
	je ir_tag_else_67
	pushl %esi
	call print_any
	jmp ir_tag_end_67
	ir_tag_else_67:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag68_cmp
	movl $0, %eax
	jmp ir_tag68_cmpend
	ir_tag68_cmp:
	movl $1, %eax
	ir_tag68_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag69_cmp
	movl $0, %eax
	jmp ir_tag69_cmpend
	ir_tag69_cmp:
	movl $1, %eax
	ir_tag69_cmpend:
	cmpl $0, %eax
	je ir_tag_else_70
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_70
	ir_tag_else_70:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_70
	ir_tag_end_70:
	cmpl $0, %ebx
	je ir_tag_else_71
	pushl %esi
	call print_any
	jmp ir_tag_end_71
	ir_tag_else_71:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_71
	ir_tag_end_71:
	jmp ir_tag_end_67
	ir_tag_end_67:
	jmp ir_tag_end_63
	ir_tag_end_63:
	pushl $1
	call inject_int
	pushl %eax
	movl -8(%ebp), %eax
	pushl %eax
	call get_subscript
	movl %eax, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag72_cmp
	movl $0, %eax
	jmp ir_tag72_cmpend
	ir_tag72_cmp:
	movl $1, %eax
	ir_tag72_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_74
	ir_tag_else_74:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_74
	ir_tag_end_74:
	cmpl $0, %ebx
	je ir_tag_else_75
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_75
	ir_tag_else_75:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag76_cmp
	movl $0, %eax
	jmp ir_tag76_cmpend
	ir_tag76_cmp:
	movl $1, %eax
	ir_tag76_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_78
	ir_tag_else_78:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_78
	ir_tag_end_78:
	cmpl $0, %ebx
	je ir_tag_else_79
	pushl %esi
	call print_any
	jmp ir_tag_end_79
	ir_tag_else_79:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag80_cmp
	movl $0, %eax
	jmp ir_tag80_cmpend
	ir_tag80_cmp:
	movl $1, %eax
	ir_tag80_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_82
	ir_tag_else_82:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_82
	ir_tag_end_82:
	cmpl $0, %ebx
	je ir_tag_else_83
	pushl %esi
	call print_any
	jmp ir_tag_end_83
	ir_tag_else_83:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_83
	ir_tag_end_83:
	jmp ir_tag_end_79
	ir_tag_end_79:
	jmp ir_tag_end_75
	ir_tag_end_75:
	pushl $7
	call inject_int
	movl %eax, %edi
	pushl $3
	call inject_int
	movl %eax, %esi
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag84_cmp
	movl $0, %ebx
	jmp ir_tag84_cmpend
	ir_tag84_cmp:
	movl $1, %ebx
	ir_tag84_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag85_cmp
	movl $0, %eax
	jmp ir_tag85_cmpend
	ir_tag85_cmp:
	movl $1, %eax
	ir_tag85_cmpend:
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag86_cmp
	movl $0, -32(%ebp)
	jmp ir_tag86_cmpend
	ir_tag86_cmp:
	movl $1, -32(%ebp)
	ir_tag86_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag87_cmp
	movl $0, %ecx
	jmp ir_tag87_cmpend
	ir_tag87_cmp:
	movl $1, %ecx
	ir_tag87_cmpend:
	movl -32(%ebp), %eax
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
	je ir_tag88_cmp
	movl $0, %eax
	jmp ir_tag88_cmpend
	ir_tag88_cmp:
	movl $1, %eax
	ir_tag88_cmpend:
	cmpl $0, %eax
	je ir_tag_else_89
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_89
	ir_tag_else_89:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_89
	ir_tag_end_89:
	cmpl $0, %ebx
	je ir_tag_else_90
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag91_cmp
	movl $0, %eax
	jmp ir_tag91_cmpend
	ir_tag91_cmp:
	movl $1, %eax
	ir_tag91_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag92_cmp
	movl $0, %eax
	jmp ir_tag92_cmpend
	ir_tag92_cmp:
	movl $1, %eax
	ir_tag92_cmpend:
	cmpl $0, %eax
	je ir_tag_else_93
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_93
	ir_tag_else_93:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_93
	ir_tag_end_93:
	cmpl $0, %ebx
	je ir_tag_else_94
	pushl %edi
	call project_int
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_94
	ir_tag_else_94:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_94
	ir_tag_end_94:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag95_cmp
	movl $0, %eax
	jmp ir_tag95_cmpend
	ir_tag95_cmp:
	movl $1, %eax
	ir_tag95_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag96_cmp
	movl $0, %eax
	jmp ir_tag96_cmpend
	ir_tag96_cmp:
	movl $1, %eax
	ir_tag96_cmpend:
	cmpl $0, %eax
	je ir_tag_else_97
	movl -36(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -36(%ebp)
	jmp ir_tag_end_97
	ir_tag_else_97:
	movl -36(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -36(%ebp)
	jmp ir_tag_end_97
	ir_tag_end_97:
	cmpl $0, -36(%ebp)
	je ir_tag_else_98
	pushl %esi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_98
	ir_tag_else_98:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_98
	ir_tag_end_98:
	movl %ebx, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_90
	ir_tag_else_90:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag99_cmp
	movl $0, %ebx
	jmp ir_tag99_cmpend
	ir_tag99_cmp:
	movl $1, %ebx
	ir_tag99_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag100_cmp
	movl $0, %eax
	jmp ir_tag100_cmpend
	ir_tag100_cmp:
	movl $1, %eax
	ir_tag100_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_102
	ir_tag_else_102:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_102
	ir_tag_end_102:
	cmpl $0, %ebx
	je ir_tag_else_103
	pushl %edi
	call project_big
	movl %eax, %ebx
	pushl %esi
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
	jmp ir_tag_end_103
	ir_tag_else_103:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_103
	ir_tag_end_103:
	jmp ir_tag_end_90
	ir_tag_end_90:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %ebx
	pushl %ebx
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_106
	ir_tag_else_106:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_106
	ir_tag_end_106:
	cmpl $0, %esi
	je ir_tag_else_107
	pushl %ebx
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_107
	ir_tag_else_107:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag108_cmp
	movl $0, %eax
	jmp ir_tag108_cmpend
	ir_tag108_cmp:
	movl $1, %eax
	ir_tag108_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag109_cmp
	movl $0, %eax
	jmp ir_tag109_cmpend
	ir_tag109_cmp:
	movl $1, %eax
	ir_tag109_cmpend:
	cmpl $0, %eax
	je ir_tag_else_110
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_110
	ir_tag_else_110:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_110
	ir_tag_end_110:
	cmpl $0, %esi
	je ir_tag_else_111
	pushl %ebx
	call print_any
	jmp ir_tag_end_111
	ir_tag_else_111:
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag112_cmp
	movl $0, %eax
	jmp ir_tag112_cmpend
	ir_tag112_cmp:
	movl $1, %eax
	ir_tag112_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag113_cmp
	movl $0, %eax
	jmp ir_tag113_cmpend
	ir_tag113_cmp:
	movl $1, %eax
	ir_tag113_cmpend:
	cmpl $0, %eax
	je ir_tag_else_114
	pushl %esi
	call project_int
	movl %eax, %esi
	jmp ir_tag_end_114
	ir_tag_else_114:
	pushl %esi
	call project_bool
	movl %eax, %esi
	jmp ir_tag_end_114
	ir_tag_end_114:
	cmpl $0, %esi
	je ir_tag_else_115
	pushl %ebx
	call print_any
	jmp ir_tag_end_115
	ir_tag_else_115:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_115
	ir_tag_end_115:
	jmp ir_tag_end_111
	ir_tag_end_111:
	jmp ir_tag_end_107
	ir_tag_end_107:
	movl $7, %eax
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	pushl %eax
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	pushl %eax
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	pushl %eax
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	pushl %eax
	call project_int
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag116_cmp
	movl $0, %eax
	jmp ir_tag116_cmpend
	ir_tag116_cmp:
	movl $1, %eax
	ir_tag116_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag117_cmp
	movl $0, %eax
	jmp ir_tag117_cmpend
	ir_tag117_cmp:
	movl $1, %eax
	ir_tag117_cmpend:
	cmpl $0, %eax
	je ir_tag_else_118
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_118
	ir_tag_else_118:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_118
	ir_tag_end_118:
	cmpl $0, %ebx
	je ir_tag_else_119
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_119
	ir_tag_else_119:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag120_cmp
	movl $0, %eax
	jmp ir_tag120_cmpend
	ir_tag120_cmp:
	movl $1, %eax
	ir_tag120_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag121_cmp
	movl $0, %eax
	jmp ir_tag121_cmpend
	ir_tag121_cmp:
	movl $1, %eax
	ir_tag121_cmpend:
	cmpl $0, %eax
	je ir_tag_else_122
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_122
	ir_tag_else_122:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_122
	ir_tag_end_122:
	cmpl $0, %ebx
	je ir_tag_else_123
	pushl %esi
	call print_any
	jmp ir_tag_end_123
	ir_tag_else_123:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag124_cmp
	movl $0, %eax
	jmp ir_tag124_cmpend
	ir_tag124_cmp:
	movl $1, %eax
	ir_tag124_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag125_cmp
	movl $0, %eax
	jmp ir_tag125_cmpend
	ir_tag125_cmp:
	movl $1, %eax
	ir_tag125_cmpend:
	cmpl $0, %eax
	je ir_tag_else_126
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_126
	ir_tag_else_126:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_126
	ir_tag_end_126:
	cmpl $0, %ebx
	je ir_tag_else_127
	pushl %esi
	call print_any
	jmp ir_tag_end_127
	ir_tag_else_127:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_127
	ir_tag_end_127:
	jmp ir_tag_end_123
	ir_tag_end_123:
	jmp ir_tag_end_119
	ir_tag_end_119:
	call input
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	call input
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %edi
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag128_cmp
	movl $0, %eax
	jmp ir_tag128_cmpend
	ir_tag128_cmp:
	movl $1, %eax
	ir_tag128_cmpend:
	cmpl $0, %eax
	je ir_tag_else_129
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_129
	ir_tag_else_129:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_129
	ir_tag_end_129:
	cmpl $0, %ebx
	je ir_tag_else_130
	call input
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, -40(%ebp)
	movl $7, %eax
	negl %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %esi
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag131_cmp
	movl $0, %ebx
	jmp ir_tag131_cmpend
	ir_tag131_cmp:
	movl $1, %ebx
	ir_tag131_cmpend:
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag132_cmp
	movl $0, %eax
	jmp ir_tag132_cmpend
	ir_tag132_cmp:
	movl $1, %eax
	ir_tag132_cmpend:
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag133_cmp
	movl $0, -44(%ebp)
	jmp ir_tag133_cmpend
	ir_tag133_cmp:
	movl $1, -44(%ebp)
	ir_tag133_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag134_cmp
	movl $0, %ecx
	jmp ir_tag134_cmpend
	ir_tag134_cmp:
	movl $1, %ecx
	ir_tag134_cmpend:
	movl -44(%ebp), %eax
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
	je ir_tag135_cmp
	movl $0, %eax
	jmp ir_tag135_cmpend
	ir_tag135_cmp:
	movl $1, %eax
	ir_tag135_cmpend:
	cmpl $0, %eax
	je ir_tag_else_136
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_136
	ir_tag_else_136:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_136
	ir_tag_end_136:
	cmpl $0, %ebx
	je ir_tag_else_137
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag138_cmp
	movl $0, %eax
	jmp ir_tag138_cmpend
	ir_tag138_cmp:
	movl $1, %eax
	ir_tag138_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag139_cmp
	movl $0, %eax
	jmp ir_tag139_cmpend
	ir_tag139_cmp:
	movl $1, %eax
	ir_tag139_cmpend:
	cmpl $0, %eax
	je ir_tag_else_140
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_140
	ir_tag_else_140:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_140
	ir_tag_end_140:
	cmpl $0, %ebx
	je ir_tag_else_141
	movl -40(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -48(%ebp)
	jmp ir_tag_end_141
	ir_tag_else_141:
	movl -40(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, -48(%ebp)
	jmp ir_tag_end_141
	ir_tag_end_141:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag142_cmp
	movl $0, %eax
	jmp ir_tag142_cmpend
	ir_tag142_cmp:
	movl $1, %eax
	ir_tag142_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag143_cmp
	movl $0, %eax
	jmp ir_tag143_cmpend
	ir_tag143_cmp:
	movl $1, %eax
	ir_tag143_cmpend:
	cmpl $0, %eax
	je ir_tag_else_144
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_144
	ir_tag_else_144:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_144
	ir_tag_end_144:
	cmpl $0, %ebx
	je ir_tag_else_145
	pushl %esi
	call project_int
	movl %eax, %ecx
	movl %ecx, %ecx
	jmp ir_tag_end_145
	ir_tag_else_145:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %ecx
	jmp ir_tag_end_145
	ir_tag_end_145:
	movl -48(%ebp), %eax
	movl %eax, %eax
	addl %ecx, %eax
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_137
	ir_tag_else_137:
	movl -40(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag146_cmp
	movl $0, %ebx
	jmp ir_tag146_cmpend
	ir_tag146_cmp:
	movl $1, %ebx
	ir_tag146_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag147_cmp
	movl $0, %eax
	jmp ir_tag147_cmpend
	ir_tag147_cmp:
	movl $1, %eax
	ir_tag147_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag148_cmp
	movl $0, %eax
	jmp ir_tag148_cmpend
	ir_tag148_cmp:
	movl $1, %eax
	ir_tag148_cmpend:
	cmpl $0, %eax
	je ir_tag_else_149
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_149
	ir_tag_else_149:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_149
	ir_tag_end_149:
	cmpl $0, %ebx
	je ir_tag_else_150
	movl -40(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %ebx
	pushl %esi
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
	jmp ir_tag_end_150
	ir_tag_else_150:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_150
	ir_tag_end_150:
	jmp ir_tag_end_137
	ir_tag_end_137:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, -52(%ebp)
	pushl $3
	call inject_int
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag151_cmp
	movl $0, %ebx
	jmp ir_tag151_cmpend
	ir_tag151_cmp:
	movl $1, %ebx
	ir_tag151_cmpend:
	movl -52(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag152_cmp
	movl $0, %eax
	jmp ir_tag152_cmpend
	ir_tag152_cmp:
	movl $1, %eax
	ir_tag152_cmpend:
	movl %ebx, %ebx
	orl %eax, %ebx
	movl -56(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag153_cmp
	movl $0, %esi
	jmp ir_tag153_cmpend
	ir_tag153_cmp:
	movl $1, %esi
	ir_tag153_cmpend:
	movl -56(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag154_cmp
	movl $0, %eax
	jmp ir_tag154_cmpend
	ir_tag154_cmp:
	movl $1, %eax
	ir_tag154_cmpend:
	movl %esi, %ecx
	orl %eax, %ecx
	movl %ebx, %eax
	andl %ecx, %eax
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag155_cmp
	movl $0, %eax
	jmp ir_tag155_cmpend
	ir_tag155_cmp:
	movl $1, %eax
	ir_tag155_cmpend:
	cmpl $0, %eax
	je ir_tag_else_156
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_156
	ir_tag_else_156:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_156
	ir_tag_end_156:
	cmpl $0, %ebx
	je ir_tag_else_157
	movl -52(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag158_cmp
	movl $0, %eax
	jmp ir_tag158_cmpend
	ir_tag158_cmp:
	movl $1, %eax
	ir_tag158_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag159_cmp
	movl $0, %eax
	jmp ir_tag159_cmpend
	ir_tag159_cmp:
	movl $1, %eax
	ir_tag159_cmpend:
	cmpl $0, %eax
	je ir_tag_else_160
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_160
	ir_tag_else_160:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_160
	ir_tag_end_160:
	cmpl $0, %ebx
	je ir_tag_else_161
	movl -52(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %esi
	movl %esi, %esi
	jmp ir_tag_end_161
	ir_tag_else_161:
	movl -52(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %esi
	jmp ir_tag_end_161
	ir_tag_end_161:
	movl -56(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag162_cmp
	movl $0, %eax
	jmp ir_tag162_cmpend
	ir_tag162_cmp:
	movl $1, %eax
	ir_tag162_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag163_cmp
	movl $0, %eax
	jmp ir_tag163_cmpend
	ir_tag163_cmp:
	movl $1, %eax
	ir_tag163_cmpend:
	cmpl $0, %eax
	je ir_tag_else_164
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_164
	ir_tag_else_164:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_164
	ir_tag_end_164:
	cmpl $0, %ebx
	je ir_tag_else_165
	movl -56(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_165
	ir_tag_else_165:
	movl -56(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_165
	ir_tag_end_165:
	movl %esi, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_157
	ir_tag_else_157:
	movl -52(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag166_cmp
	movl $0, %ebx
	jmp ir_tag166_cmpend
	ir_tag166_cmp:
	movl $1, %ebx
	ir_tag166_cmpend:
	movl -56(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag167_cmp
	movl $0, %eax
	jmp ir_tag167_cmpend
	ir_tag167_cmp:
	movl $1, %eax
	ir_tag167_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag168_cmp
	movl $0, %eax
	jmp ir_tag168_cmpend
	ir_tag168_cmp:
	movl $1, %eax
	ir_tag168_cmpend:
	cmpl $0, %eax
	je ir_tag_else_169
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_169
	ir_tag_else_169:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_169
	ir_tag_end_169:
	cmpl $0, %ebx
	je ir_tag_else_170
	movl -52(%ebp), %eax
	pushl %eax
	call project_big
	movl %eax, %ebx
	movl -56(%ebp), %eax
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
	movl %eax, %ebx
	movl %ebx, %eax
	movl %eax, %eax
	jmp ir_tag_end_170
	ir_tag_else_170:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_170
	ir_tag_end_170:
	jmp ir_tag_end_157
	ir_tag_end_157:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %eax
	jmp ir_tag_end_130
	ir_tag_else_130:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag171_cmp
	movl $0, %eax
	jmp ir_tag171_cmpend
	ir_tag171_cmp:
	movl $1, %eax
	ir_tag171_cmpend:
	cmpl $0, %eax
	je ir_tag_else_172
	pushl %edi
	call project_int
	movl %eax, %edi
	jmp ir_tag_end_172
	ir_tag_else_172:
	pushl %edi
	call project_bool
	movl %eax, %edi
	jmp ir_tag_end_172
	ir_tag_end_172:
	cmpl $0, %edi
	je ir_tag_else_173
	pushl $7
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_173
	ir_tag_else_173:
	call input
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_173
	ir_tag_end_173:
	jmp ir_tag_end_130
	ir_tag_end_130:
	movl %eax, %esi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag174_cmp
	movl $0, %eax
	jmp ir_tag174_cmpend
	ir_tag174_cmp:
	movl $1, %eax
	ir_tag174_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag175_cmp
	movl $0, %eax
	jmp ir_tag175_cmpend
	ir_tag175_cmp:
	movl $1, %eax
	ir_tag175_cmpend:
	cmpl $0, %eax
	je ir_tag_else_176
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_176
	ir_tag_else_176:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_176
	ir_tag_end_176:
	cmpl $0, %ebx
	je ir_tag_else_177
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_177
	ir_tag_else_177:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag178_cmp
	movl $0, %eax
	jmp ir_tag178_cmpend
	ir_tag178_cmp:
	movl $1, %eax
	ir_tag178_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag179_cmp
	movl $0, %eax
	jmp ir_tag179_cmpend
	ir_tag179_cmp:
	movl $1, %eax
	ir_tag179_cmpend:
	cmpl $0, %eax
	je ir_tag_else_180
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_180
	ir_tag_else_180:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_180
	ir_tag_end_180:
	cmpl $0, %ebx
	je ir_tag_else_181
	pushl %esi
	call print_any
	jmp ir_tag_end_181
	ir_tag_else_181:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag182_cmp
	movl $0, %eax
	jmp ir_tag182_cmpend
	ir_tag182_cmp:
	movl $1, %eax
	ir_tag182_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag183_cmp
	movl $0, %eax
	jmp ir_tag183_cmpend
	ir_tag183_cmp:
	movl $1, %eax
	ir_tag183_cmpend:
	cmpl $0, %eax
	je ir_tag_else_184
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_184
	ir_tag_else_184:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_184
	ir_tag_end_184:
	cmpl $0, %ebx
	je ir_tag_else_185
	pushl %esi
	call print_any
	jmp ir_tag_end_185
	ir_tag_else_185:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_185
	ir_tag_end_185:
	jmp ir_tag_end_181
	ir_tag_end_181:
	jmp ir_tag_end_177
	ir_tag_end_177:
	movl $0, %eax
	leave
	ret
