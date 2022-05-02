from compiler.ast import * 
from extra_nodes import *

printParse = True
printTypeCheck = True
printExplicate = True
printFlatten = True
printx86IR = True
printVariableAssignment = False

supported_nodes = [Module,
    Stmt,
    Printnl,
    Assign,
    AssName,
    Discard,
    Const,
    Name,
    Add,
    UnarySub,
    CallFunc,
    Compare,
    Or,
    And,
    Not,
    List,
    Dict,
    Subscript,
    IfExp,
    GetTag,
    InjectFrom,
    ProjectTo,
    Let,
    IntAdd,
    CallBigAdd,
    BigCompare,
    PrintBool,
    PrintBig,
    Bool
]

indent = 0
def pprint(tree, prefix=""):
    global indent
    if isinstance(tree, Module):
        pprint(tree.node, prefix)
    elif isinstance(tree, Stmt):
        for stmt in tree.nodes:
            pprint(stmt, prefix)
    elif tree.__class__ in supported_nodes:
        print(prefix + ("| "*indent) + tree.__class__.__name__ + "(")
        indent += 1
        for child in tree.getChildren():
            pprint(child, prefix)
        indent -= 1
        print(prefix + ("| "*indent) + ")")
    else:
        print(prefix + ("| "*indent) + str(tree))
    
def project_consts(tree):
    if isinstance(tree, Module):
        tree.node = project_consts(tree.node)
        return tree
    elif isinstance(tree, Stmt) or isinstance(tree, Printnl) or isinstance(tree, And) or isinstance(tree, Or) or isinstance(tree, List):
        for i in range(len(tree.nodes)):
            tree.nodes[i] = project_consts(tree.nodes[i])
        return tree
    elif isinstance(tree, Assign):
        tree.expr = project_consts(tree.expr)
        for i in range(len(tree.nodes)):
            tree.nodes[i] = project_consts(tree.nodes[i])
        return tree
    elif isinstance(tree, AssName):
        return tree
    elif isinstance(tree, Discard) or isinstance(tree, UnarySub) or isinstance(tree, Not):
        tree.expr = project_consts(tree.expr)
        return tree
    elif isinstance(tree, Const):
        return InjectFrom("int", tree)
    elif isinstance(tree, Name):
        return tree
    elif isinstance(tree, Add) or isinstance(tree, IntAdd) or isinstance(tree, CallBigAdd):
        tree.left = project_consts(tree.left)
        tree.right = project_consts(tree.right)
        return tree
    elif isinstance(tree, CallFunc):
        return tree
    elif isinstance(tree, Compare):
        tree.expr = project_consts(tree.expr)
        for i in range(len(tree.ops)):
            tree.ops[i] = (tree.ops[i][0], project_consts(tree.ops[i][1]))
        return tree
    elif isinstance(tree, Dict):
        for i in range(len(tree.items)):
            tree.items[i][0] = project_consts(tree.items[i][0])
            tree.items[i][1] = project_consts(tree.items[i][1])
        return tree
    elif isinstance(tree, Subscript):
        tree.expr = project_consts(tree.expr)
        for i in range(len(tree.subs)):
            tree.subs[i] = project_consts(tree.subs[i])
        return tree
    elif isinstance(tree, IfExp):
        tree.test = project_consts(tree.test)
        tree.then = project_consts(tree.then)
        tree.else_ = project_consts(tree.else_)
        return tree
    elif isinstance(tree, GetTag) or isinstance(tree, InjectFrom) or isinstance(tree, ProjectTo):
        tree.arg = project_consts(tree.arg)
        return tree
    elif isinstance(tree, Let):
        tree.rhs = project_consts(tree.rhs)
        tree.body = project_consts(tree.body)
        return tree
    else:
        raise Exception("Unsupported node: " + str(tree))

def isinstance_list(n, li):
    for l in li:
        if isinstance(n, l):
            return True
    return False

types = {
    List: "LIST_TYPE",
    Dict: "DICT_TYPE",
    Const: "INT_TYPE",
    Bool: "BOOL_TYPE",
}
inject_from_types = {
    "int": "INT_TYPE",
    "bool": "BOOL_TYPE",
    "big": "LIST_TYPE",
}
def get_type(n):
    if isinstance_list(n, [StaticAssName, StaticName]):
        return n.typ
    elif isinstance_list(n, types.keys()):
        for typ in types.keys():
            if isinstance(n, typ):
                return types[typ]
    elif isinstance(n, InjectFrom):
        return inject_from_types[n.typ]
    else:
        raise Exception("Error in get_type, unrecognized node: " + str(n))

def need_to_project(n):
    if isinstance_list(n, [Const, Bool]):
        return False
    else:
        return True
