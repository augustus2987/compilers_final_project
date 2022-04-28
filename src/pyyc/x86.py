from compiler.ast import *
from extra_nodes import *
import re
variable_prefix_ir = "ir"
tag_prefix_ir = "ir_tag"

class x86IR:
    tagCnt = 0
    def __init__(self, tree):
        self.tree = tree
        self.intermediate = []
        self.convert_to_ir()
        self.liveness = []

    def log(self, log):
        print "x86IR:: ", log
    
    def get_intermediate(self):
        return self.intermediate
    
    def print_intermediate(self):
        self.log("Intermediate representation:")
        for line in self.intermediate:
            self.log("\t" + str(line))
        
    def convert_to_ir(self):
       nodes = self.tree.node.nodes
       for node in nodes:
           self.add_node_to_ir(node)

    tmpVarCnt = 0
    def add_node_to_ir(self, node):
        if isinstance(node, Assign):
            assignTo = None
            if isinstance(node.nodes[0], AssName) or isinstance(node.nodes[0], Name):
                assignTo = node.nodes[0].name
            elif isinstance(node.nodes[0], Subscript):
                assignTo = "edx" 

            if isinstance(node.expr, CallFunc):
                self.intermediate.append("call %s" % node.expr.node.name)
                self.intermediate.append("pushl eax")
                self.intermediate.append("call inject_int")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Const):
                self.intermediate.append("pushl $%d" % node.expr.value)
                self.intermediate.append("call inject_int")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Bool):
                self.intermediate.append("pushl $%d" % int(node.expr.value))
                self.intermediate.append("call inject_bool")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Name):
                self.intermediate.append("movl %s %s" % (node.expr.name, assignTo))
            elif isinstance(node.expr, Add) or isinstance(node.expr, IntAdd):
                if isinstance(node.expr.left, Const) or isinstance(node.expr.left, Bool):
                    self.intermediate.append("movl $%s %s" % (node.expr.left.value, assignTo))
                else:
                    self.intermediate.append("movl %s %s" % (node.expr.left.name, assignTo))
                if isinstance(node.expr.right, Const) or isinstance(node.expr.right, Bool):
                    self.intermediate.append("addl $%s %s" % (node.expr.right.value, assignTo))
                else:
                    self.intermediate.append("addl %s %s" % (node.expr.right.name, assignTo))
            elif isinstance(node.expr, UnarySub):
                to_negl = None
                if isinstance(node.expr.expr, Const) or isinstance(node.expr.expr, Bool):
                    newVar = variable_prefix_ir + str(self.tmpVarCnt)
                    self.tmpVarCnt += 1
                    self.intermediate.append("movl $" + str(node.expr.expr.value) + " " + newVar)
                    self.intermediate.append("negl " + newVar)
                    self.intermediate.append("pushl " + newVar)
                    self.intermediate.append("call inject_int")
                else:
                    newVar = variable_prefix_ir + str(self.tmpVarCnt)
                    self.tmpVarCnt += 1
                    self.intermediate.append("pushl %s" % node.expr.expr.name)
                    self.intermediate.append("call project_int")
                    self.intermediate.append("negl eax")
                    self.intermediate.append("pushl eax")
                    self.intermediate.append("call inject_int")
                self.intermediate.append("movl %s %s" % ("eax", assignTo))
            # P1:
            elif isinstance(node.expr, And):
                right = ("$"+str(node.expr.nodes[0].value)) if isinstance(node.expr.nodes[0], Const) else node.expr.nodes[0].name
                self.intermediate.append("movl %s %s" % (right, assignTo))
                for exprNode in node.expr.nodes[1:]:
                    left = ("$"+str(exprNode.value)) if isinstance(exprNode, Const) else exprNode.name
                    self.intermediate.append("andl %s %s" % (left, assignTo))
            elif isinstance(node.expr, Or):
                right = ("$"+str(node.expr.nodes[0].value)) if isinstance(node.expr.nodes[0], Const) else node.expr.nodes[0].name
                self.intermediate.append("movl %s %s" % (right, assignTo))
                for exprNode in node.expr.nodes[1:]:
                    left = ("$"+str(exprNode.value)) if isinstance(exprNode, Const) else exprNode.name
                    self.intermediate.append("orl %s %s" % (left, assignTo))
            elif isinstance(node.expr, GetTag):
                push_val = ("$"+str(node.expr.arg.value)) if isinstance(node.expr.arg, Const) else node.expr.arg.name
                self.intermediate.append("pushl %s" % push_val)
                self.intermediate.append("call tag")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Compare):
                tagNum = self.tagCnt
                self.tagCnt += 1
                # cmpl expects arguments backwards
                op_in = {"==": "je", "!=": "jne", "<": "jg", "<=": "jge", ">": "jl", ">=": "jle"}
                expr_val = node.expr.expr.name if isinstance(node.expr.expr, Name) else ("$"+str(node.expr.expr.value))
                ops_val = node.expr.ops[0][1].name if isinstance(node.expr.ops[0][1], Name) else ("$"+str(node.expr.ops[0][1].value))
                if ops_val.startswith("$"):
                    # this is to make sure we never compare with a const on the rhs
                    self.intermediate.append("movl %s eax" % ops_val)
                    self.intermediate.append("cmpl %s eax" % expr_val)
                else:
                    self.intermediate.append("cmpl %s %s" % (expr_val, ops_val))
                compare = node.expr.ops[0][0]
                action_name = tag_prefix_ir + str(tagNum) + "_cmp"
                end_name = tag_prefix_ir + str(tagNum) + "_cmpend"
                self.intermediate.append(op_in[compare] + " " + action_name)
                self.intermediate.append("movl $0 %s" % (assignTo))
                self.intermediate.append("jmp " + end_name)
                self.intermediate.append(action_name + ":")
                self.intermediate.append("movl $1 %s" % (assignTo))
                self.intermediate.append(end_name + ":")
            elif isinstance(node.expr, ProjectTo):
                project_func = {"int": "project_int", "bool": "project_bool", "big": "project_big"}
                push_val = ("$"+str(node.expr.arg.value)) if isinstance(node.expr.arg, Const) else node.expr.arg.name
                self.intermediate.append("pushl %s" % push_val)
                self.intermediate.append("call " + project_func[node.expr.typ])
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, InjectFrom):
                inj_func = {"int": "inject_int", "bool": "inject_bool", "big": "inject_big"} 
                push_val = ("$"+str(node.expr.arg.value)) if isinstance(node.expr.arg, Const) else node.expr.arg.name
                self.intermediate.append("pushl %s" % push_val)
                self.intermediate.append("call " + inj_func[node.expr.typ])
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, CallBigAdd):
                left_val = ("$"+str(node.expr.left.value)) if isinstance(node.expr.left, Const) else node.expr.left.name
                right_val = ("$"+str(node.expr.right.value)) if isinstance(node.expr.left, Const) else node.expr.right.name
                self.intermediate.append("pushl %s" % right_val)
                self.intermediate.append("pushl %s" % left_val)
                self.intermediate.append("call add")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Dict):
                self.intermediate.append("call create_dict")
                self.intermediate.append("pushl eax")
                self.intermediate.append("call inject_big")
                self.intermediate.append("movl eax %s" % (assignTo))
                for i in range(len(node.expr.items)):
                    lhs = node.expr.items[i][0]
                    rhs = node.expr.items[i][1]
                    if isinstance(lhs, Const):
                        self.intermediate.append("pushl $" + str(lhs.value))
                        self.intermediate.append("call inject_int")
                        self.intermediate.append("movl eax ebx")
                    elif isinstance(lhs, Bool):
                        self.intermediate.append("pushl $" + str(lhs.value))
                        self.intermediate.append("call inject_bool")
                        self.intermediate.append("movl eax ebx")
                    else:
                        self.intermediate.append("movl " + lhs.name + " ebx")
                    if isinstance(rhs, Const):
                        self.intermediate.append("pushl $" + str(rhs.value))
                        self.intermediate.append("call inject_int")
                    elif isinstance(rhs, Bool):
                        self.intermediate.append("pushl $" + str(rhs.value))
                        self.intermediate.append("call inject_bool")
                    else:
                        self.intermediate.append("movl " + rhs.name + " eax")
                    self.intermediate.append("pushl eax")
                    self.intermediate.append("pushl ebx")
                    self.intermediate.append("pushl %s" % assignTo) # dict pyobj
                    self.intermediate.append("call set_subscript")
            elif isinstance(node.expr, List):
                self.intermediate.append("pushl $" + str(len(node.expr.nodes)))
                self.intermediate.append("call inject_int")
                self.intermediate.append("pushl eax")
                self.intermediate.append("call create_list")
                self.intermediate.append("pushl eax")
                self.intermediate.append("call inject_big")
                self.intermediate.append("movl eax %s" % (assignTo))
                for i in range(len(node.expr.nodes)):
                    self.intermediate.append("pushl $" + str(i))
                    self.intermediate.append("call inject_int")
                    self.intermediate.append("movl eax ebx")
                    if isinstance(node.expr.nodes[i], Const):
                        self.intermediate.append("pushl $" + str(node.expr.nodes[i].value))
                        self.intermediate.append("call inject_int")
                        self.intermediate.append("pushl eax") # value to put in list
                    elif isinstance(node.expr.nodes[i], Bool):
                        self.intermediate.append("pushl $" + str(node.expr.nodes[i].value))
                        self.intermediate.append("call inject_bool")
                        self.intermediate.append("pushl eax") # value to put in list
                    else:
                        self.intermediate.append("pushl " + node.expr.nodes[i].name) # value to put in list
                    self.intermediate.append("pushl ebx") # list index
                    self.intermediate.append("pushl %s" % assignTo) # list pyobj
                    self.intermediate.append("call set_subscript")
            elif isinstance(node.expr, Subscript):
                if isinstance(node.expr.subs[0], Const):
                    self.intermediate.append("pushl $" + str(node.expr.subs[0].value))
                    self.intermediate.append("call inject_int")
                    self.intermediate.append("pushl eax") # index val
                elif isinstance(node.expr.subs[0], Name):
                    self.intermediate.append("pushl %s" % node.expr.subs[0].name) 
                else:
                    raise Exception("Unsupported subscript type: " + str(node.expr.subs[0]))
                self.intermediate.append("pushl " + str(node.expr.expr.name)) # list/dict
                self.intermediate.append("call get_subscript")
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, BigCompare):
                cmpCall = {"==": "equal", "!=": "not_equal"}
                if node.expr.ops[0][0] not in cmpCall:
                    self.intermediate.append("call call_error")
                    return
                self.intermediate.append("pushl %s" % node.expr.expr.name)
                self.intermediate.append("pushl %s" % node.expr.ops[0][1].name)
                self.intermediate.append("call " + cmpCall[node.expr.ops[0][0]])
                self.intermediate.append("movl eax %s" % (assignTo))
            elif isinstance(node.expr, Not):
                tagNum = self.tagCnt
                self.tagCnt += 1
                else_name = tag_prefix_ir + "_not_notzero_" + str(tagNum)
                end_name = tag_prefix_ir + "_not_end_" + str(tagNum)
                self.intermediate.append("cmpl $0 %s" % node.expr.expr.name)
                self.intermediate.append("je %s" % else_name)
                self.intermediate.append("movl $0 %s" % assignTo)
                self.intermediate.append("jmp %s" % end_name)
                self.intermediate.append(else_name + ":")
                self.intermediate.append("movl $1 %s" % assignTo)
                self.intermediate.append(end_name + ":")
            else:
                raise Exception("x86:: ERROR: Not valid assignment, node: " + str(node.expr.__class__))
            
            if assignTo == "edx":
                if isinstance(node.nodes[0].subs[0], Const):
                    self.intermediate.append("pushl $" + str(node.nodes[0].subs[0].value))
                    self.intermediate.append("call inject_int")
                    self.intermediate.append("pushl edx") # push the value to be assigned
                    self.intermediate.append("pushl eax") # index val
                elif isinstance(node.nodes[0].subs[0], Name):
                    self.intermediate.append("pushl edx") # push the value to be assigned
                    self.intermediate.append("pushl %s" % node.nodes[0].subs[0].name) 
                else:
                    raise Exception("Unsupported subscript type: " + str(node.expr.subs[0]))
                self.intermediate.append("pushl " + str(node.nodes[0].expr.name)) # list/dict
                self.intermediate.append("call set_subscript")

        elif isinstance(node, Printnl):
            to_print = ("$"+str(node.nodes[0].value)) if isinstance(node.nodes[0], Const) else node.nodes[0].name
            self.intermediate.append("pushl %s" % to_print)
            self.intermediate.append("call print_int_nl")
        elif isinstance(node, Let):
            self.add_node_to_ir(Assign([node.var], node.rhs))
            for bodyNode in node.body.nodes:
                self.add_node_to_ir(bodyNode)
        elif isinstance(node, IfExp):
            tagNum = self.tagCnt
            self.tagCnt += 1
            else_name = tag_prefix_ir + "_else_" + str(tagNum)
            end_name = tag_prefix_ir + "_end_" + str(tagNum)
            self.intermediate.append("cmpl $0 %s" % node.test.name if isinstance(node.test, Name) else node.test.value)
            self.intermediate.append("je %s" % else_name)
            for thenNode in node.then.nodes:
                self.add_node_to_ir(thenNode)
            self.intermediate.append("jmp %s" % end_name)
            self.intermediate.append("%s:" % else_name)
            for elseNode in node.else_.nodes:
                self.add_node_to_ir(elseNode)
            self.intermediate.append("jmp %s" % end_name)
            self.intermediate.append("%s:" % end_name)
        elif isinstance(node, PrintBig) or isinstance(node, PrintBool):
            self.intermediate.append("pushl " + str(node.expr.name))
            self.intermediate.append("call print_any")
        else:
            raise Exception("x86:: ERROR: Not valid node: " + str(node.__class__))
            
    

    reserved_names = ["esp", "ebp"]
    def liveness_analysis(self):
        self.liveness = []
        live = set([])
        self.liveness.append(live.copy()) # no live variables after the last instruction
        
        # let's not reverse in place, but rather just iterate through it reversed
        for i, k in enumerate(reversed(self.intermediate)):
            #split up instruction into command, source, and target
            instruction_split = k.split()
            cmd = instruction_split[0]
            left = instruction_split[1] if len(instruction_split)>=2 else None
            right = instruction_split[2] if len(instruction_split)>=3 else None
            if cmd == "movl":
                # writing target
                if right in live: live.remove(right)
                # reading left, ignore if it's a const
                if not left.startswith("$"): 
                    live.add(left)
            elif cmd == "addl" or cmd == "andl" or cmd == "orl": 
                live.add(right)
                if not left.startswith("$"):
                    live.add(left)
            elif cmd == "pushl":
                if not left.startswith("$"):
                    live.add(left)
            elif cmd == "negl": 
                if not left.startswith("$"):
                    live.add(left)
            elif cmd == "call":
                if "eax" in live:
                    live.remove("eax") 
            elif cmd == "cmpl":
                if not left.startswith("$"):
                    live.add(left)
                if not right.startswith("$"):
                    live.add(right)
            elif re.match(r"[a-z0-9_]*:", cmd):
                pass
            elif cmd in ["jmp", "je", "jne", "jg", "jge", "jl", "jle"]:
                pass
            else:
                raise Exception("x86:: ERROR: Not valid command, cmd: " + cmd)
            for reserved in self.reserved_names:
                if reserved in live: live.remove(reserved)
            
            self.liveness.append(live.copy())
                                
        self.liveness.reverse() # make liveness list top to bottom
        
        
    def print_live_and_ir(self):
        self.log("Printing x86 IR and liveness:")
        for i, k in enumerate(self.intermediate):
            self.log("\t\t\t\t" + str(self.liveness[i]))
            self.log("\t" + k)
        self.log("\t\t\t\t" + str(self.liveness[i+1]))
    
