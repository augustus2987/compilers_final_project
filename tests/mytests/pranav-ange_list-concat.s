.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	subl $2000, %esp

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
	pushl $1
	call inject_int
	pushl %eax
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
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $3
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %esi
	call set_subscript
	movl %esi, %esi
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
	pushl $4
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $5
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $2
	call inject_int
	movl %eax, %ebx
	pushl $6
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, -4(%ebp)
	movl %esi, %esi
	movl -4(%ebp), %eax
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
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag2_cmp
	movl $0, -8(%ebp)
	jmp ir_tag2_cmpend
	ir_tag2_cmp:
	movl $1, -8(%ebp)
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
	movl -8(%ebp), %eax
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
	movl %eax, %edi
	pushl %edi
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
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_22
	ir_tag_else_22:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_22
	ir_tag_end_22:
	cmpl $0, %ebx
	je ir_tag_else_23
	pushl %edi
	call project_int
	movl %eax, %eax
	pushl %eax
	call print_int_nl
	jmp ir_tag_end_23
	ir_tag_else_23:
	pushl %edi
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
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_26
	ir_tag_else_26:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_26
	ir_tag_end_26:
	cmpl $0, %ebx
	je ir_tag_else_27
	pushl %edi
	call print_any
	jmp ir_tag_end_27
	ir_tag_else_27:
	pushl %edi
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
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_30
	ir_tag_else_30:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_30
	ir_tag_end_30:
	cmpl $0, %ebx
	je ir_tag_else_31
	pushl %edi
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
	movl %esi, %esi
	movl -4(%ebp), %eax
	movl %eax, %edi
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag32_cmp
	movl $0, %ebx
	jmp ir_tag32_cmpend
	ir_tag32_cmp:
	movl $1, %ebx
	ir_tag32_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag33_cmp
	movl $0, %eax
	jmp ir_tag33_cmpend
	ir_tag33_cmp:
	movl $1, %eax
	ir_tag33_cmpend:
	movl %ebx, %ebx
	orl %eax, %ebx
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag34_cmp
	movl $0, -16(%ebp)
	jmp ir_tag34_cmpend
	ir_tag34_cmp:
	movl $1, -16(%ebp)
	ir_tag34_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag35_cmp
	movl $0, %ecx
	jmp ir_tag35_cmpend
	ir_tag35_cmp:
	movl $1, %ecx
	ir_tag35_cmpend:
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
	call tag
	movl %eax, %eax
	cmpl $0, %eax
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
	call project_int
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_42
	ir_tag_else_42:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_42
	ir_tag_end_42:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag43_cmp
	movl $0, %eax
	jmp ir_tag43_cmpend
	ir_tag43_cmp:
	movl $1, %eax
	ir_tag43_cmpend:
	pushl %eax
	call inject_bool
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	pushl %eax
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
	movl -20(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -20(%ebp)
	jmp ir_tag_end_45
	ir_tag_else_45:
	movl -20(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -20(%ebp)
	jmp ir_tag_end_45
	ir_tag_end_45:
	cmpl $0, -20(%ebp)
	je ir_tag_else_46
	pushl %edi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_46
	ir_tag_else_46:
	pushl %edi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_46
	ir_tag_end_46:
	movl %ebx, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_38
	ir_tag_else_38:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag47_cmp
	movl $0, %ebx
	jmp ir_tag47_cmpend
	ir_tag47_cmp:
	movl $1, %ebx
	ir_tag47_cmpend:
	pushl %edi
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag48_cmp
	movl $0, %eax
	jmp ir_tag48_cmpend
	ir_tag48_cmp:
	movl $1, %eax
	ir_tag48_cmpend:
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	jmp ir_tag_end_51
	ir_tag_else_51:
	call call_error
	pushl %eax
	call inject_int
	movl %eax, %eax
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_51
	ir_tag_end_51:
	jmp ir_tag_end_38
	ir_tag_end_38:
	movl %ebx, %eax
	movl %ebx, %eax
	movl %eax, %eax
	call create_dict
	pushl %eax
	call inject_big
	movl %eax, %edi
	pushl $1
	call inject_int
	movl %eax, %ebx
	pushl $2
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	pushl $3
	call inject_int
	movl %eax, %ebx
	pushl $4
	call inject_int
	pushl %eax
	pushl %ebx
	pushl %edi
	call set_subscript
	movl %edi, %edi
	movl %esi, -24(%ebp)
	pushl $2
	call inject_int
	pushl %eax
	movl -4(%ebp), %eax
	pushl %eax
	call get_subscript
	movl %eax, %esi
	pushl $1
	call inject_int
	pushl %eax
	call create_list
	pushl %eax
	call inject_big
	movl %eax, -28(%ebp)
	pushl $0
	call inject_int
	movl %eax, %ebx
	pushl %esi
	pushl %ebx
	movl -28(%ebp), %eax
	pushl %eax
	call set_subscript
	movl -28(%ebp), %eax
	movl %eax, %esi
	movl -24(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag52_cmp
	movl $0, %ebx
	jmp ir_tag52_cmpend
	ir_tag52_cmp:
	movl $1, %ebx
	ir_tag52_cmpend:
	movl -24(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag53_cmp
	movl $0, %eax
	jmp ir_tag53_cmpend
	ir_tag53_cmp:
	movl $1, %eax
	ir_tag53_cmpend:
	movl %ebx, -32(%ebp)
	orl %eax, -32(%ebp)
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag54_cmp
	movl $0, %ebx
	jmp ir_tag54_cmpend
	ir_tag54_cmp:
	movl $1, %ebx
	ir_tag54_cmpend:
	pushl %esi
	call tag
	movl %eax, %eax
	cmpl $1, %eax
	je ir_tag55_cmp
	movl $0, %eax
	jmp ir_tag55_cmpend
	ir_tag55_cmp:
	movl $1, %eax
	ir_tag55_cmpend:
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
	je ir_tag56_cmp
	movl $0, %eax
	jmp ir_tag56_cmpend
	ir_tag56_cmp:
	movl $1, %eax
	ir_tag56_cmpend:
	cmpl $0, %eax
	je ir_tag_else_57
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_57
	ir_tag_else_57:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_57
	ir_tag_end_57:
	cmpl $0, %ebx
	je ir_tag_else_58
	movl -24(%ebp), %eax
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
	movl %eax, %ebx
	pushl %ebx
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
	pushl %ebx
	call project_int
	movl %eax, %ebx
	jmp ir_tag_end_61
	ir_tag_else_61:
	pushl %ebx
	call project_bool
	movl %eax, %ebx
	jmp ir_tag_end_61
	ir_tag_end_61:
	cmpl $0, %ebx
	je ir_tag_else_62
	movl -24(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, %ebx
	movl %ebx, %ebx
	jmp ir_tag_end_62
	ir_tag_else_62:
	movl -24(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, %eax
	movl %eax, %ebx
	jmp ir_tag_end_62
	ir_tag_end_62:
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
	pushl %eax
	call inject_bool
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $0, %eax
	je ir_tag64_cmp
	movl $0, %eax
	jmp ir_tag64_cmpend
	ir_tag64_cmp:
	movl $1, %eax
	ir_tag64_cmpend:
	cmpl $0, %eax
	je ir_tag_else_65
	movl -36(%ebp), %eax
	pushl %eax
	call project_int
	movl %eax, -36(%ebp)
	jmp ir_tag_end_65
	ir_tag_else_65:
	movl -36(%ebp), %eax
	pushl %eax
	call project_bool
	movl %eax, -36(%ebp)
	jmp ir_tag_end_65
	ir_tag_end_65:
	cmpl $0, -36(%ebp)
	je ir_tag_else_66
	pushl %esi
	call project_int
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_66
	ir_tag_else_66:
	pushl %esi
	call project_bool
	movl %eax, %eax
	movl %eax, %eax
	jmp ir_tag_end_66
	ir_tag_end_66:
	movl %ebx, %ecx
	addl %eax, %ecx
	pushl %ecx
	call inject_int
	movl %eax, %eax
	movl %eax, %ebx
	movl %ebx, %eax
	jmp ir_tag_end_58
	ir_tag_else_58:
	movl -24(%ebp), %eax
	pushl %eax
	call tag
	movl %eax, %eax
	cmpl $3, %eax
	je ir_tag67_cmp
	movl $0, %ebx
	jmp ir_tag67_cmpend
	ir_tag67_cmp:
	movl $1, %ebx
	ir_tag67_cmpend:
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
	movl %ebx, %ecx
	andl %eax, %ecx
	pushl %ecx
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
	movl -24(%ebp), %eax
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
	jmp ir_tag_end_58
	ir_tag_end_58:
	movl %ebx, -28(%ebp)
	movl %ebx, -28(%ebp)
	movl -28(%ebp), %eax
	movl %eax, %edx
	pushl $7
	call inject_int
	pushl %edx
	pushl %eax
	pushl %edi
	call set_subscript
	movl %edi, %esi
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
	movl $0, %eax
	leave
	ret
