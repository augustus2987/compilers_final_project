import sys
import compiler
from compiler.ast import * 
import ply.lex as lex

from flatten import *
from assembly import *
from parse import *
from x86 import x86IR
from graph import VariableGraph
from explicate import *
from utils import *
from extra_nodes import *
from typecheck import *

def print_compiler_module_ast():
    print "AST created by the Compiler Module:" # compare our ast to correct ast
    realtree = compiler.parseFile(str(sys.argv[1])) 
    for line in realtree.node.nodes:
        print line

if __name__ == "__main__":   
    # ensure we're being passed a python file
    if len(sys.argv) < 2:
        print "Usage: python flatten.py <python file>"
        sys.exit(1)
    if not sys.argv[1].endswith(".py"):
        print "Not a python file!"
        sys.exit(1)

    # get AST 
#     tree = get_ast(str(sys.argv[1])) 
    #tree = compiler.parseFile(str(sys.argv[1])) 
    tree = get_ast(str(sys.argv[1]))
    if printParse:
        
        print("\ncompiler:: base tree:")
        for n in tree.node.nodes:
            print("compiler::\t" + str(n))
        print ""
            
    
    tree = type_pass(tree)        
    if printTypeCheck:
        print("compiler:: type checked tree")
        for n in tree.node.nodes:
            print("compiler::\t" + str(n))
        print ""
    
    #explicate pass   
    t = explicate_pass(tree) 
    # print_explicated(t)
    if printExplicate:
        print("explicate:: Explicated Tree:")
        if "--pprint" in sys.argv:
            pprint(t, "explicate:: ")
        else:
            print(t)
        
        
    check_all_supported(t)
    # flatten AST
    flattened_tree = flatten_ast(tree)
    flattened_tree = unqiueify_names(flattened_tree)
    
    # print flattened ast tree
    if printFlatten:
        if "--pprint" in sys.argv:
            print_flattened_pretty(flattened_tree)
        else:
            print_flattened(flattened_tree)

    ir = x86IR(flattened_tree)
    if printx86IR:
        ir.print_intermediate()
    ir.liveness_analysis()
    # ir.print_live_and_ir()
    

    graph = VariableGraph(ir)
    graph.color_graph()
    tries = 0
    while graph.needs_to_spill():
        graph.add_spill_code()
        # graph.ir.print_live_and_ir()
        graph.color_graph()
        tries += 1
        if tries >= 100:
            print("Too many tries, last variable assignments:")
            if printVariableAssignment:
                graph.print_variable_assignments()
            raise Exception("Too many tries to color, probably in inf loop")
    # graph.print_variable_assignments()
    # graph.print_all_edges()
    homed_ir = graph.get_ir_with_homes()
    # graph.print_homed_ir()

    # # get all variables in our flattened tree
    # variables = get_variables(flattened_tree)
    # # print "Compile:: Variables: ", len(variables)
    # num_variables = len(variables)

    # create file to write flattened tree to    
    basename = sys.argv[1].split(".")[0]
    assemblyFile = basename + ".s"
    file = open(assemblyFile, "w")

    write_file_prologue(file, 500)
    # write_file_content(file, flattened_tree, variables)
    write_homed_ir(file, homed_ir)
    write_file_epilogue(file)

    file.close()
