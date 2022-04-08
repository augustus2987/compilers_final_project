.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

	pushl $0
	call inject_bool
	movl %eax, %ebx
	pushl $1
	call inject_bool
	movl %eax, %eax
	movl %ebx, %edi
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
	movl %eax, %eax
	orl %ecx, %eax
	cmpl $0, %eax
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
	movl %eax, %esi
	pushl %esi
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
	pushl %esi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_38
	ir_tag_else_38:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag39_cmp
	movl $0, %eax
	jmp ir_tag39_cmpend
	ir_tag39_cmp:
	movl $1, %eax
	ir_tag39_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, %ebx
	pushl %ebx
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag40_cmp
	movl $0, %eax
	jmp ir_tag40_cmpend
	ir_tag40_cmp:
	movl $1, %eax
	ir_tag40_cmpend:
	cmpl $0, %eax
	je ir_tag_else_41
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_41
	ir_tag_else_41:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_41
	ir_tag_end_41:
	cmpl $0, %ebx
	je ir_tag_else_42
	pushl %esi
	call print_any
	jmp ir_tag_end_42
	ir_tag_else_42:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag43_cmp
	movl $0, %eax
	jmp ir_tag43_cmpend
	ir_tag43_cmp:
	movl $1, %eax
	ir_tag43_cmpend:
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
	pushl %esi
	call print_any
	jmp ir_tag_end_46
	ir_tag_else_46:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_46
	ir_tag_end_46:
	jmp ir_tag_end_42
	ir_tag_end_42:
	jmp ir_tag_end_38
	ir_tag_end_38:
	movl $0, %eax
	leave
	ret
