import sys
import compiler
from compiler.ast import * 
from extra_nodes import *
from utils import *
import uuid


INT_TAG = 0     
BOOL_TAG = 1   
BIG_TAG = 3

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

    elif isinstance_list(n, [AssName, Const, CallFunc, Bool]):
        """
        (no operation)
        """
        return n
    
    elif isinstance(n, Printnl):
        return static_print_helper(n)

    elif isinstance(n, Add):
        return add_helper(n, new_explicate_name())
    
    elif isinstance(n, Compare):
        return compare_helper(n, new_explicate_name())

    elif isinstance(n, Not):
        return not_helper(n, new_explicate_name())
    
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


def print_helper(node):
    expr, exprName = explicate_pass(node.nodes[0]), new_explicate_name()
    if_int = if_int_single(exprName)
    int_then = Printnl(
        [ProjectTo('int', exprName)], None
    )
    if_bool = if_bool_single(exprName)
    bool_then = PrintBool(
        exprName
    )
    if_big = if_big_single(exprName)
    big_then = PrintBig(
        exprName
    )
    else_bool = IfExp(
        InjectFrom('bool', if_big),
        big_then,
        CallFunc(Name('call_error'), [], None, None)
    )
    else_int = IfExp(
        InjectFrom('bool', if_bool),
        bool_then,
        else_bool
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
        None
    )

def static_print_helper(node):
    typ = get_type(node.nodes[0])
    if typ == "INT_TYPE":
        return Printnl([node.nodes[0]], None)
    elif typ == "BOOL_TYPE":
        return PrintBool(node.nodes[0])
    elif typ in ["DICT_TYPE", "LIST_TYPE"]:
        return PrintBig(node.nodes[0])
    elif typ == "NO_TYPE":
        raise Exception("Error in static_print_helper: no type for node: " + str(node))
    else:
        raise Exception("Error in static_print_helper: unknown type: " + typ)


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

def add_helper(node, result):
    left, leftName = explicate_pass(node.left), new_explicate_name()
    right, rightName = explicate_pass(node.right), new_explicate_name()
    if_little = if_little_tree(leftName, rightName)
    little_then = Assign([result],
        InjectFrom('int',
            Add((
                little_conditional_project(leftName),
                little_conditional_project(rightName)
            ))
        )
    )
    if_big = if_big_tree(leftName, rightName)
    big_then = Assign([result],
        InjectFrom('big',
            CallBigAdd(
                ProjectTo('big', leftName),
                ProjectTo('big', rightName)
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