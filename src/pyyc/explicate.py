import sys
import compiler
from compiler.ast import * 
from extra_nodes import *
from utils import *
import uuid


INT_TAG = 0     
BOOL_TAG = 1   
BIG_TAG = 3

type_project = {
    "INT_TYPE": "int",
    "BOOL_TYPE": "bool",
    "LIST_TYPE": "big",
    "DICT_TYPE": "big",
}

variable_prefix  = "var" #= str(uuid.uuid4())
variable_prefix_user_defined = "user"# str(uuid.uuid4())

def log(msg):
    print("explicate:: " + str(msg))

def print_explicated(tree):
    for node in tree.node.nodes:
        log(node)

def explicate_pass(n):
    global tmpCnt
    if isinstance(n, Module):
        return Module(None, explicate_pass(n.node))
    
    elif isinstance(n, Stmt):
        for i in range(len(n.nodes)):
            n.nodes[i] = explicate_pass(n.nodes[i])
        return n
    
    elif isinstance_list(n, [Assign, Discard, UnarySub]):
        """
        expr
        """
        n.expr = explicate_pass(n.expr)
        return n

    elif isinstance_list(n, [AssName, Const, CallFunc, Bool, StaticAssName, StaticName, Name]):
        """
        (no operation)
        """
        return n
    
    elif isinstance(n, Printnl):
        return static_print_helper(n)

    elif isinstance(n, Add):
        return static_add_helper(n)
    
    elif isinstance(n, Compare):
        return static_compare_helper(n)

    elif isinstance(n, Not):
        return static_not_helper(n)
    
    elif isinstance(n, Or) or isinstance(n, And):
        op = Or if isinstance(n, Or) else And
        to_ret = None
        last_name = new_explicate_name()
        to_ret = or_and_helper(n.nodes[0], n.nodes[1], last_name, op)
        if len(n.nodes) > 2:
            for i in range(2, len(n.nodes)-1):
                new_name = new_explicate_name()
                to_ret = or_and_helper(last_name, n.nodes[i], last_name, op)
                last_name = new_name
        return to_ret
    
    elif isinstance(n, List):
        for i in range(len(n.nodes)):
            n.nodes[i] = explicate_pass(n.nodes[i])
        return n
    
    elif isinstance(n, Dict):
        for i in range(len(n.items)):
            n.items[i] = (explicate_pass(n.items[i][0]), explicate_pass(n.items[i][1]))
        return n
    
    elif isinstance(n, Subscript):
        for i in range(len(n.subs)):
            n.subs[i] = explicate_pass(n.subs[i])
        return n
    
    elif isinstance(n, IfExp):
        n.test = explicate_pass(n.test)
        n.then = explicate_pass(n.then)
        n.else_ = explicate_pass(n.else_)
        return n    
    elif isinstance(n, InjectFrom):
        n.arg = explicate_pass(n.arg)
        return n
    else:
        raise Exception("Error in explicate_pass: unrecognized AST node: " + str(n))
            
explTmpCnt = 0
explicate_prefix = "expl"
def new_explicate_name():
    global explTmpCnt, explicate_prefix
    explTmpCnt += 1
    return Name(explicate_prefix + "_" + str(explTmpCnt-1))

def is_helper(node, result):
    left, leftName = explicate_pass(node.expr), new_explicate_name()
    right, rightName = explicate_pass(node.ops[0][1]), new_explicate_name()
    if_little = if_little_tree(leftName, rightName)
    little_then = Assign([result],
        IfExp(
            InjectFrom('bool', Compare(GetTag(leftName), [('==', GetTag(rightName))])),
            InjectFrom('bool',
                Compare(
                    little_conditional_project(leftName),
                    [("==", little_conditional_project(rightName))],
                )
            ),
            Bool(0)
        )
    )
    if_big = if_big_tree(leftName, rightName)
    big_then = Assign([result],
        InjectFrom('bool',
            Compare(
                left,
                [("==", right)],
            )
        )
    )
    else_int = IfExp(
        InjectFrom('bool', if_big),
        big_then,
        CallFunc(Name('call_error'), [], None, None)
    )
    toplevel_if = IfExp(
        InjectFrom('bool', if_little),
        little_then,
        else_int
    )
    return Let(
        leftName,
        left,
        Let(
            rightName,
            right,
            toplevel_if,
            result.name
        ),
        result.name
    )

def static_compare_helper(node):
    if node.ops[0][0] == "is":
        return is_helper(node, node.nodes[0])
    left = explicate_pass(node.expr)
    right = explicate_pass(node.ops[0][1])
    l_type = get_type(left)
    r_type = get_type(right)
    if type_project[l_type] != type_project[r_type]:
        return Bool(0)
    use_left = ProjectTo(type_project[l_type], left) if need_to_project(left) else left
    use_right = ProjectTo(type_project[r_type], right) if need_to_project(right) else right
    cmp_node = BigCompare if type_project[l_type] == "big" else Compare
    return InjectFrom(
        'bool',
        cmp_node(
            use_left,
            [(node.ops[0][0], use_right)]
        )
    )

def compare_helper(node, result):
    if node.ops[0][0] == 'is':
        return is_helper(node, result)
    left, leftName = explicate_pass(node.expr), new_explicate_name()
    right, rightName = explicate_pass(node.ops[0][1]), new_explicate_name()
    if_little = if_little_tree(leftName, rightName)
    little_then = Assign([result],
        InjectFrom('bool',
            Compare(
                little_conditional_project(leftName),
                [(node.ops[0][0], little_conditional_project(rightName))],
            )
        )
    )
    if_big = if_big_tree(leftName, rightName)
    big_then = Assign([result],
        InjectFrom('bool',
            BigCompare(
                ProjectTo('big', leftName),
                [(node.ops[0][0], ProjectTo('big', rightName))],
            )
        )
    )
    else_int = IfExp(
        InjectFrom('bool', if_big),
        big_then,
        CallFunc(Name('call_error'), [], None, None)
    )
    toplevel_if = IfExp(
        InjectFrom('bool', if_little),
        little_then,
        else_int
    )
    return Let(
        leftName,
        left,
        Let(
            rightName,
            right,
            toplevel_if,
            result.name
        ),
        result.name
    )

def static_not_helper(node):
    expr = explicate_pass(node.expr)
    typ = get_type(expr)
    if typ == "INT_TYPE":
        return InjectFrom('bool',
            Not(ProjectTo('int', expr))
        )
    elif typ == "BOOL_TYPE":
        return InjectFrom('bool',
            Not(ProjectTo('bool', expr))
        )
    elif typ in ["DICT_TYPE", "LIST_TYPE"]:
        return InjectFrom('bool',
            Not(IsTrue(expr))
        )
    elif typ == "NO_TYPE":
        raise Exception("Error in static_not_helper: no type for node: " + str(node))
    else:
        raise Exception("Error in static_not_helper: unknown type: " + str(typ))

def not_helper(node, result):
    expr, exprName = explicate_pass(node.expr), new_explicate_name()
    if_int = if_int_single(exprName)
    int_then = Assign([result],
        InjectFrom('bool',
            Not(ProjectTo('int', exprName))
        )
    )
    if_bool = if_bool_single(exprName)
    bool_then = Assign([result],
        InjectFrom('bool',
            Not(ProjectTo('bool', exprName))
        )
    )
    else_int = IfExp(
        InjectFrom('bool', if_bool),
        bool_then,
        CallFunc(Name('call_error'), [], None, None)
    )
    toplevel_if = IfExp(
        InjectFrom('bool', if_int),
        int_then,
        else_int
    )
    return Let(
        exprName,
        expr,
        toplevel_if,
        result.name
    )

def static_print_helper(node):
    expr = explicate_pass(node.nodes[0])
    typ = get_type(expr)
    if typ == "INT_TYPE":
        return Printnl([ProjectTo('int', expr)], None) if need_to_project(expr) else Printnl(['int', expr], None)
    elif typ == "BOOL_TYPE":
        # return PrintBool(ProjectTo('bool', expr)) if need_to_project(expr) else PrintBool('bool', expr)
        return PrintBool(expr)
    elif typ in ["DICT_TYPE", "LIST_TYPE"]:
        return PrintBig(expr)
    elif typ == "NO_TYPE":
        raise Exception("Error in static_print_helper: no type for node: " + str(node))
    else:
        raise Exception("Error in static_print_helper: unknown type: " + str(typ))

def static_or_and_helper(left, right, result, op):
    left = explicate_pass(left)
    right = explicate_pass(right)
    l_type = get_type(left)
    r_type = get_type(right)
    if l_type in ["INT_TYPE", "BOOL_TYPE"]:
        use_left = ProjectTo(type_project[l_type], left) if need_to_project(left) else left
    else:
        use_left = IsTrue(left)
    if r_type in ["INT_TYPE", "BOOL_TYPE"]:
        use_right = ProjectTo(type_project[l_type], left) if need_to_project(left) else left
    else:
        use_right = IsTrue(left)
    return Assign([result],
        InjectFrom(
            'bool',
            op([use_left, use_right])
        )
    )


def or_and_helper(left, right, result, op):
    left, leftName = explicate_pass(left), new_explicate_name()
    right, rightName = explicate_pass(right), new_explicate_name()
    if_little = if_little_tree(leftName, rightName)
    little_then = Assign([result],
        inject_conditionally(leftName, rightName, op,
            op([
                little_conditional_project(leftName),
                little_conditional_project(rightName)
            ])
        )
    )
    toplevel_if = IfExp(
        InjectFrom('bool', if_little),
        little_then,
        CallFunc(Name('call_error'), [], None, None)
    )
    return Let(
        leftName,
        left,
        Let(
            rightName,
            right,
            toplevel_if,
            result.name
        ),
        result.name
    )

# [lhs, rhs]: [InjectFrom type, addition node]
type_additions = {
    ("INT_TYPE", "INT_TYPE"): ('int', Add),
    ("BOOL_TYPE", "INT_TYPE"): ('int', Add),
    ("INT_TYPE", "BOOL_TYPE"): ('int', Add),
    ("LIST_TYPE", "LIST_TYPE"): ('big', CallBigAdd)
}
def static_add_helper(node):
    left = explicate_pass(node.left)
    right = explicate_pass(node.right)
    l_type = get_type(left)
    r_type = get_type(right)
    if (l_type, r_type) not in type_additions.keys():
        raise Exception("Error in static_add_helper: invalid types in addition: " + str(l_type) + " + " + str(r_type))
    inject_from, use_node = type_additions[(l_type, r_type)]
    use_left = ProjectTo(type_project[l_type], left) if need_to_project(left) else left
    use_right = ProjectTo(type_project[r_type], right) if need_to_project(right) else right
    return InjectFrom(
        inject_from,
        use_node((use_left, use_right))
    )

def if_int_tree(left, right):
    return And([
        Compare(Const(INT_TAG), [('==', GetTag(left))]),
        Compare(Const(INT_TAG), [('==', GetTag(right))])
    ])

def if_int_single(expr):
    return Compare(
        Const(INT_TAG),
        [('==', GetTag(expr))]
    )

def if_bool_single(expr):
    return Compare(
        Const(BOOL_TAG),
        [('==', GetTag(expr))]
    )

def if_big_single(expr):
    return Compare(
        Const(BIG_TAG),
        [('==', GetTag(expr))]
    )

def if_bool_tree(left, right):
    return And([
        Compare(Const(BOOL_TAG), [('==', GetTag(left))]),
        Compare(Const(BOOL_TAG), [('==', GetTag(right))])
    ])

def if_little_tree(left, right):
    return Or([
        if_int_tree(left, right),
        if_bool_tree(left, right),
    ])

def if_little_tree(left, right):
    return And([
        Or([
            Compare(Const(INT_TAG), [('==', GetTag(left))]),
            Compare(Const(BOOL_TAG), [('==', GetTag(left))])
        ]),
        Or([
            Compare(Const(INT_TAG), [('==', GetTag(right))]),
            Compare(Const(BOOL_TAG), [('==', GetTag(right))])
        ])
    ])

def little_conditional_project(expr):
    return IfExp(
        InjectFrom('bool', Compare(Const(INT_TAG), [('==', GetTag(expr))])),
        ProjectTo('int', expr),
        ProjectTo('bool', expr)
    )

def if_big_tree(left, right):
    return And([
        Compare(Const(BIG_TAG), [('==', GetTag(left))]),
        Compare(Const(BIG_TAG), [('==', GetTag(right))])
    ])

def inject_conditionally(left, right, op, tree):
    if op == And: return and_conditional_project(left, right, tree)
    if op == Or: return or_conditional_project(left, right, tree)

def or_conditional_project(left, right, tree):
    return IfExp(
        InjectFrom('bool', Compare(Const(0), [("==", tree)])),
        IfExp(
            InjectFrom('bool', Compare(Const(0), [('==', little_conditional_project(right))])),
            right,
            left
        ),
        IfExp(
            InjectFrom('bool', Compare(Const(0), [('!=', little_conditional_project(left))])),
            left,
            right
        )
    )

def and_conditional_project(left, right, tree):
    return IfExp(
        InjectFrom('bool', Compare(Const(0), [("==", tree)])),
        IfExp(
            InjectFrom('bool', Compare(Const(0), [('==', little_conditional_project(left))])),
            left,
            right
        ),
        IfExp(
            InjectFrom('bool', Compare(Const(0), [('!=', little_conditional_project(right))])),
            right,
            left
        )
    )