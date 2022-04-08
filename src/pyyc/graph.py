from x86 import x86IR
from random import choice
import re

class VariableNode():
    def __init__(self, varname):
        self.varname = varname
        self.color = None
        self.saturation_list = set()
        self.edges = []
        # boolean to track whether this has been spilled
        self.spilt = ""
        self.offset = None
    
    def add_edge(self, newEdgeNode):
        self.edges.append(newEdgeNode)
    
    def set_color(self, color):
        self.color = color

class VariableGraph():
    # initialize a variable graph with a list
    # of IR instructions
    def __init__(self, ir):
        self.ir = ir
        self.liveness = ir.liveness
        self.intermediate = ir.intermediate
        self.nodes = {}
        self.colors = ["a", "b", "c", "d", "i", "I"] #register colors
        self.registers = {"eax": "a", "ebx": "b", "ecx": "c", "edx": "d", "esi": "i", "edi": "I", "esp":"s"}
        self.registers_by_color = {"a": "eax", "b": "ebx", "c": "ecx", "d": "edx", "i": "esi", "I": "edi", "s": "esp"}
        for live in ir.liveness:
            if live:
                [self.add_node(var) for var in live]
                
        self.log("# of variables: " + str(len(self.nodes)))
        self.build_interference_graph()

        
    def log(self, log):
        print "VariableGraph:: ", log

    # add a node to the graph by varname
    def add_node(self, varname):
        self.nodes[varname] = VariableNode(varname)

    # add edges from one node to a list of nodes
    def add_edges(self, source, targets):
        if source not in self.nodes: 
            self.add_node(source)
        for target in targets:
            if source == target: continue
            if target not in self.nodes: self.add_node(target)
            if self.nodes[source] in self.nodes[target].edges: continue  #dont re-add edge 
            self.nodes[target].add_edge(self.nodes[source])
            self.nodes[source].add_edge(self.nodes[target])

    # this will opulate the edges for each node in the graph
    caller_saved_registers = ["eax", "ecx", "edx"]
    def build_interference_graph(self):
        for register in self.caller_saved_registers:
            self.add_edges(register, self.caller_saved_registers)
        for i in range(len(self.intermediate)):
            before, after = self.liveness[i], self.liveness[i+1]
            i_list = self.intermediate[i].split()
            if i_list[0] == "movl":
                for live in after:
                    if not live == i_list[1]: 
                        self.add_edges(i_list[2], [live])
            elif i_list[0] in ["addl", "negl", "andl", "orl"]: 
                target = i_list[2] if i_list[0] == "addl" else i_list[1]
                self.add_edges(target, after)
            elif i_list[0] in ["call", "print"]:
                for live in after:
                    self.add_edges(live, self.caller_saved_registers)
            elif i_list[0] == "pushl" or i_list[0] == "cmpl":
                pass
            elif i_list[0] in ["jmp", "jle", "jge", "jg", "jl", "jne", "je"]:
                pass
            elif re.match("[a-z0-9_]*:", i_list[0]):
                pass
            else:
                raise Exception("VariableGraph:: Invalid Instruction: ", i_list[0])
                
    def print_all_edges(self):
        for var in self.nodes.keys():
            self.log(var + ": " + str([(edge.varname, edge.color) for edge in self.nodes[var].edges]))

    def generate_saturation(self):
        # initialize all nodes to be able to have all colors. 
        for v in self.nodes:
            # initialize all other nodes to be able to be colored any color
            if self.nodes[v].color == "ON_STACK":
                continue
            self.nodes[v].saturation_list.update(self.colors)
            
        # register nodes can only be their own color
        for register in self.registers:
            if register in self.nodes:
                self.nodes[register].color = self.registers[register] 
                
    def update_saturation(self):
        # self.log("updating saturation lists..")
        for v in self.nodes:
            if self.nodes[v].color:  # if node is colored
                if self.nodes[v].color == "ON_STACK": continue
                for neighbor in self.nodes[v].edges:   # remove color from all neighbor's saturation list
                    # self.log("neighbor: " + str(neighbor))
                    # self.log("saturation list:" + str(neighbor.saturation_list))
                    neighbor.saturation_list.discard(self.nodes[v].color) 
            
    def get_highest_saturation(self, W):
        # change later with unspillables
        low = float('inf')
        ties = []
        for node in W:
            if self.nodes[node].color == "ON_STACK": continue
            if node.startswith("spill"):
                return node
            if len(self.nodes[node].saturation_list) < low:
                low = len(self.nodes[node].saturation_list)
                ties = []
                ties.append(node)
            if len(self.nodes[node].saturation_list) == low:
                ties.append(node)
        
        return choice(ties)
                     
    def color_graph(self):     
        self.generate_saturation()
        self.update_saturation()
        
        # create set for uncolored nodes
        W = set([])
        for var in self.nodes:
            if self.nodes[var].color != "ON_STACK":
                W.add(var)
        
        # follows DSatur's Algorithm from the textbook
        while W != set([]):
            u = self.get_highest_saturation(W) # 
            s = self.nodes[u].saturation_list
                
            if s != set([]): # assign color:
                self.nodes[u].color = s.pop() # should change this to be lowest.
                # self.log("assigned " + u + " to " + self.registers_by_color[self.nodes[u].color])
            else:
                self.nodes[u].color = "ON_STACK"
                # self.log("assigned " + u + " to " + self.nodes[u].color)
            
            W.remove(u)
            self.update_saturation()

    # returns:
    #   True: IR needs to be updated to have spill code
    #   False: IR does not need any spill code
    def needs_to_spill(self):
        for name, obj in self.nodes.items():
            if obj.color == "ON_STACK" and not obj.spilt:
                return True
        return False

    spill_tmp_cnt = 0
    def add_spill_code(self):
        new_instructions = []
        for i in range(len(self.intermediate)):
            i_list = self.intermediate[i].split()
            cmd = i_list[0]
            left = i_list[1] if len(i_list)>=2 else None
            right = i_list[2] if len(i_list)>=3 else None

            if left and left in self.nodes.keys() and self.nodes[left].color == "ON_STACK":
                new_tmp = "spill" + str(self.spill_tmp_cnt)
                self.spill_tmp_cnt += 1
                self.nodes[left].spilt = new_tmp
                new_instructions.append("movl " + left + " " + new_tmp)
                left = new_tmp

            if right:
                new_instructions.append(cmd + " " + left + " " + right)
            elif left:
                new_instructions.append(cmd + " " + left)
            else:
                new_instructions.append(cmd)
        self.ir.intermediate = new_instructions
        self.ir.liveness_analysis()
        self.intermediate = self.ir.intermediate
        self.liveness = self.ir.liveness
        self.clear_colors()
        self.build_interference_graph()

    def clear_colors(self):
        for node in self.nodes.keys():
            if self.nodes[node].color and self.nodes[node].color != "ON_STACK":
                self.nodes[node].color = None

    def print_variable_assignments(self):
        for node in self.nodes.values():
            if node.color != "ON_STACK":
                self.log("Assigned " + node.varname + " to " + self.registers_by_color[node.color])
            else:
                self.log("Assigned " + node.varname + " to " + node.color)

    def get_ir_with_homes(self):
        homed_ir = []
        current_offset = -4
        for i in self.intermediate:
            i_list = i.split()
            cmd = i_list[0]
            left = i_list[1] if len(i_list)>=2 else None
            right = i_list[2] if len(i_list)>=3 else None

            if left and left in self.nodes.keys():
                if self.nodes[left].color == "ON_STACK":
                    if not self.nodes[left].offset:
                        self.nodes[left].offset = current_offset
                        left = str(current_offset) + "(%ebp)"
                        current_offset -= 4
                    else:
                        left = str(self.nodes[left].offset) + "(%ebp)"
                else:
                    left = "%" + self.registers_by_color[self.nodes[left].color]
            if right and right in self.nodes.keys():
                if self.nodes[right].color == "ON_STACK":
                    if not self.nodes[right].offset:
                        self.nodes[right].offset = current_offset
                        right = str(current_offset) + "(%ebp)"
                        current_offset -= 4
                    else:
                        right = str(self.nodes[right].offset) + "(%ebp)"
                else:
                    right = "%" + self.registers_by_color[self.nodes[right].color]
            elif right and not right.startswith("$") and right not in self.nodes.keys():
                right = left
            
            if right:
                homed_ir.append(cmd + " " + left + ", " + right)
            elif left:
                homed_ir.append(cmd + " " + left)
            else:
                homed_ir.append(cmd)

        self.homed_ir = homed_ir
        return homed_ir

    def print_homed_ir(self):
        self.log("x86 with homes:")
        for line in self.homed_ir:
            self.log("\t" + line)
