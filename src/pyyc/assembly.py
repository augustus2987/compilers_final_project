import sys
import compiler
from compiler.ast import * 
import uuid

variables = {}
offset = 0
def get_variables(ast):
    global variables, offset
    if isinstance(ast, Module):
        variables = {}
        get_variables(ast.node)
        return variables
    elif isinstance(ast, Stmt):
        [get_variables(x) for x in ast.nodes]
        return
    elif isinstance(ast, Printnl):
        for node in ast.nodes:
            get_variables(node)
        return 
    elif isinstance(ast, Assign):
        for node in ast.nodes:
            get_variables(node)
        get_variables(ast.expr)
        return
    elif isinstance(ast, AssName):
        if ast.name not in variables:
            offset -= 4
            variables[ast.name] = {"offset": offset}
        return
    elif isinstance(ast, Discard):
        get_variables(ast.expr)
        return
    elif isinstance(ast, Const):
        return
    elif isinstance(ast, Name):
        # if ast.name not in variables:
        #     variables.append(ast.name)
        return 
    elif isinstance(ast, Add):
        get_variables(ast.left)
        get_variables(ast.right)
        return
    elif isinstance(ast, UnarySub):
        get_variables(ast.expr)
        return
    elif isinstance(ast, CallFunc):
        get_variables(ast.node)
        return
    else:
        print ast.__class__
        raise Exception("Error in get_variables: unrecognized AST node")

"""
The following two functions are using the skeleton of the code from
the textbook
"""
def write_file_prologue(file, num_variables):
    file.write(".globl main\n")
    file.write("main:\n")
    file.write("\tpushl %ebp\n")
    file.write("\tmovl %esp, %ebp\n")
    # allocate space for number of variables
    file.write("\tsubl $" + str(num_variables * 4) + ", %esp\n")
    file.write("\n")
def write_file_epilogue(file):
    file.write("\tmovl $0, %eax\n")
    file.write("\tleave\n")
    file.write("\tret\n")

def write_file_content(file, tree, variables):
    nodes = tree.node.nodes
    for node in nodes:
       node_to_assembly(file, node, variables) 
    

def node_to_assembly(file, node, variables):
    if isinstance(node, Assign):
        if isinstance(node.expr, CallFunc):
            file.write("\tcall " + node.expr.node.name + "\n")
            file.write("\tmovl %eax, " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
        elif isinstance(node.expr, Const):
            file.write("\tmovl $" + str(node.expr.value) + ", " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
        elif isinstance(node.expr, Name):
            file.write("\tmovl " + str(variables[node.expr.name]["offset"]) + "(%ebp), %eax\n")
            file.write("\tmovl %eax, " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
        elif isinstance(node.expr, Add):
            # set eax to be the left node
            if isinstance(node.expr.left, Const):
                file.write("\tmovl $" + str(node.expr.left.value) + ", %eax\n")
            elif isinstance(node.expr.left, Name):
                file.write("\tmovl " + str(variables[node.expr.left.name]["offset"]) + "(%ebp), %eax\n")
            else:
                print "Not flattened!"
                sys.exit(1)

            # set ebx to be the right node
            if isinstance(node.expr.right, Const):
                file.write("\tmovl $" + str(node.expr.right.value) + ", %ebx\n")
            elif isinstance(node.expr.right, Name):
                file.write("\tmovl " + str(variables[node.expr.right.name]["offset"]) + "(%ebp), %ebx\n")
            else:
                print "Not flattened!"
                sys.exit(1)
            
            # add ebx to eax and put it in the proper location
            file.write("\taddl %ebx, %eax\n")
            file.write("\tmovl %eax, " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
        if isinstance(node.expr, UnarySub):
            # set eax to be what we want to operate on
            if isinstance(node.expr.expr, Const):
                file.write("\tmovl $" + str(node.expr.expr.value) + ", %eax\n")
            elif isinstance(node.expr.expr, Name):
                file.write("\tmovl " + str(variables[node.expr.expr.name]["offset"]) + "(%ebp), %eax\n")
            else:
                print "Not flattened!"
                sys.exit(1)
            file.write("\tnegl %eax\n")
            file.write("\tmovl %eax, " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
    if isinstance(node, Printnl):
        # push argument for print onto the stack, depending on if it's a Const or variable (Name)
        if isinstance(node.nodes[0], Const):
            file.write("\tpushl $" + str(node.nodes[0].value) + "\n")
        elif isinstance(node.nodes[0], Name):
            file.write("\tpushl " + str(variables[node.nodes[0].name]["offset"]) + "(%ebp)\n")
        else:
            print("Not flattened!")
            sys.exit(1)
        file.write("\tcall print_int_nl\n")
        file.write("\taddl $4, %esp\n")

    file.write("\n")

def write_homed_ir(file, homed_ir):
    for line in homed_ir:
        file.write("\t" + line + "\n")
