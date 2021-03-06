from extra_nodes import *
from utils import *

seen_vars = set([])

def check_undefined_type(n):
    
    if isinstance(n, Module):
        check_undefined_type(n.node)
        return n
    
    elif isinstance(n, Stmt):
        for i, line in enumerate(n.nodes):
            if isinstance(line, StaticName):
                if (line.name not in seen_vars) and (line.typ == None):
                    raise Exception("Variable " + line.name + " declared without type")
                else:
                    seen_vars.add(line.name)   
            if isinstance(line, Assign):
                if isinstance(line.nodes[0], StaticAssName):
                    if (line.nodes[0].name not in seen_vars) and (line.nodes[0].typ == None):
                        raise Exception("Variable " + line.nodes[0].name + " declared without type")
                if isinstance(line.nodes[0], Subscript):
                    try:
                        seen_vars.add(line.nodes[0].expr.name)
                    except:
                        pass
                else:
                    seen_vars.add(line.nodes[0].name)                      
    return n
            

def type_pass(n):
    
    if isinstance(n, Module):
        type_pass(n.node)
        return n
    
    elif isinstance(n, Stmt):
        for i, line in enumerate(n.nodes[::-1]):
            if isinstance(line, StaticName):
                for to_replace in n.nodes[-(i+1):]:
                    replace_type(to_replace, line)
                    
            if isinstance(line, Assign):
                if isinstance(line.nodes[0], StaticAssName):
                    for to_replace in n.nodes[-(i+1):]:
                        replace_type(to_replace, line.nodes[0])                
    return n
                
def replace_type(n, newType):
    
    # If we see a name, replace with the type it should be
    if isinstance(n, StaticName) or isinstance(n, StaticAssName):
        if (n.name == newType.name) and (n.typ == None):
            n.typ = newType.typ
            n.subtype = newType.subtype
            n.keytype = newType.keytype
            
    # Otherwise just traverse the tree of the statement
    elif isinstance(n, Printnl):
        replace_type(n.nodes[0], newType)
        return
    elif isinstance(n, Assign):
        replace_type(n.nodes[0], newType)
        replace_type(n.expr, newType)
        return
    elif isinstance(n, Discard):
        replace_type(n.expr, newType)
    elif isinstance_list(n, [Const, Bool]):
        return
    elif isinstance(n, Add):
        replace_type(n.left, newType)
        replace_type(n.right, newType)
        return
    elif isinstance(n, UnarySub):
        replace_type(n.expr, newType)
        return
    elif isinstance(n, CallFunc):
        replace_type(n.node, newType)
        return
    elif isinstance(n, Compare):
        replace_type(n.expr, newType)
        replace_type(n.ops[0][1], newType)
        return
    elif isinstance(n, Or) or isinstance(n, And) or isinstance(n, List):
        for node in n.nodes:
            replace_type(node, newType)
        return
    elif isinstance(n, Not):
        replace_type(n.expr, newType)
        return
    elif isinstance(n, Dict):
        for item in n.items:
            replace_type(item[0], newType)
            replace_type(item[1], newType)
        return
    elif isinstance(n, Subscript):
        replace_type(n.expr, newType)
        for node in n.subs:
            replace_type(node, newType)
        return
    elif isinstance(n, IfExp):
        replace_type(n.test, newType)
        replace_type(n.then, newType)
        replace_type(n.else_, newType)
        return
    else:
        raise Exception("Error in replace_type: unrecognized AST node")
            