import sys
from compiler.ast import *
from extra_nodes import *
from utils import *
from explicate import explicate_prefix, INT_TAG
import uuid

variable_prefix  = "var" #= str(uuid.uuid4())
variable_prefix_user_defined = "user"# str(uuid.uuid4())

def num_nodes(n):
    if isinstance(n, Module):
        return 1 + num_nodes(n.node)
    elif isinstance(n, Stmt):
        return 1 + sum([num_nodes(x) for x in n.nodes])
    elif isinstance(n, Printnl):
        return 1 + num_nodes(n.nodes[0])
    elif isinstance(n, Assign):
        return 1 + num_nodes(n.nodes[0]) + num_nodes(n.expr)
    elif isinstance(n, AssName):
        return 1
    elif isinstance(n, Discard):
        return 1 + num_nodes(n.expr)
    elif isinstance(n, Const):
        return 1
    elif isinstance(n, Name):
        return 1
    elif isinstance(n, Add):
        return 1 + num_nodes(n.left) + num_nodes(n.right)
    elif isinstance(n, UnarySub):
        return 1 + num_nodes(n.expr)
    elif isinstance(n, CallFunc):
        return 1 + num_nodes(n.node)
    elif isinstance(n, Compare):
        return 1 + num_nodes(self.expr) + num_nodes(self.ops[1])
    elif isinstance(n, Or):
        return 3 # guarenteed to contain two lower nodes in P1
    elif isinstance(n, And):
        return 3
    elif isinstance(n, Not):
        return 1
    elif isinstance(n, List):
        return 1 + sum([num_nodes(x) for x in n.nodes])
    elif isinstance(n, Dict):
        return 1 + sum([num_nodes(x) for x in n.nodes])
    elif isinstance(n, Subscript):
        pass
    elif isinstance(n, IfExp):
        pass
    elif isinstance(n, GetTag):
        pass
    elif isinstance(n, InjectFrom):
        pass
    elif isinstance(n, ProjectTo):
        pass
    elif isinstance(n, Let):
        pass
    else:
        print "Type of node: ", n
        raise Exception("Error in num_nodes: unrecognized AST node")

def check_all_supported(tree):
    supported = False
    if not tree or isinstance(tree, str) or isinstance(tree, int):
        return
    for nodeType in supported_nodes:
        if isinstance(tree, nodeType): supported = True
    if not supported:
        raise Exception("Error: unsupported node type: " + str(tree.__class__))

    if tree.getChildren():
        for node in tree.getChildren():
            check_all_supported(node)

const_nodes = [Name, Const, Bool]
def is_var_const(node):
    for nodeType in const_nodes:
        if isinstance(node, nodeType):
            return True
    return False

# exersize 1.3:
# flatten P_0 program to equivalent P_0 program that contains
# no complex expressions
tmpCnt = 0
def flatten_ast(ast):
    global tmpCnt
    if isinstance(ast, Module):
        return Module(None, flatten_ast(ast.node))
    elif isinstance(ast, Stmt):
        nodes = []
        [nodes.extend(flatten_ast(x)) for x in ast.nodes]
        return Stmt([i for i in nodes if i != None])

    elif isinstance(ast, Printnl):
        nodes = []
        if not is_var_const(ast.nodes[0]):
            cnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.nodes[0])]
            ast.nodes[0] = Name(variable_prefix + "_" + str(cnt))
        nodes.append(ast)
        return nodes
    elif isinstance(ast, Assign):
        nodes = []
        if not is_var_const(ast.expr):
            cnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(cnt))
        if isinstance(ast.nodes[0], Subscript):
            if not is_var_const(ast.nodes[0].expr):
                cnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.nodes[0].expr)]
                ast.nodes[0].expr = Name(variable_prefix + "_" + str(cnt))
                tmpCnt += 1
            for i in range(len(ast.nodes[0].subs)):
                if not is_var_const(ast.nodes[0].subs[i]):
                    cnt = tmpCnt
                    [nodes.append(x) for x in flatten_ast(ast.nodes[0].subs[i])]
                    ast.nodes[0].subs[i] = Name(variable_prefix + "_" + str(cnt))
                    tmpCnt += 1
        nodes.append(ast)
        return nodes
    elif isinstance(ast, Discard):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.expr):
            cnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(cnt))
        nodes.append(Assign([Name(variable_prefix + "_" + str(cnt))], ast.expr))
        return nodes
    elif isinstance_list(ast, [AssName, StaticAssName]):
        return ast
    elif isinstance(ast, Const):
        cnt = tmpCnt
        return [Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast)]
    elif isinstance(ast, Bool):
        cnt = tmpCnt
        return [Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast)]
    elif isinstance(ast, Name):
        cnt = tmpCnt
        return [Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast)]
    elif isinstance(ast, StaticName):
        cnt = tmpCnt
        return [Assign([StaticAssName(variable_prefix + "_" + str(cnt), ast.typ)], ast)]
    elif isinstance(ast, Add):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.left):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.left)]
            ast.left = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        if not is_var_const(ast.right):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.right)]
            ast.right = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, UnarySub):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.expr):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(thisCnt))
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, CallFunc):
        nodes = [Assign([AssName(variable_prefix + "_" + str(tmpCnt), 'OP-ASSIGN')], ast)]
        return nodes

    # P1:
    elif isinstance(ast, Compare) or isinstance(ast, BigCompare):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.expr):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        for i in range(len(ast.ops)):
            if not is_var_const(ast.ops[i][1]):
                thisCnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.ops[i][1])]
                ast.ops[i] = (ast.ops[i][0], Name(variable_prefix + "_" + str(thisCnt)))
                tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes

    elif isinstance(ast, Or) or isinstance(ast, And) or isinstance(ast, List):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        for i in range(len(ast.nodes)):
            if not is_var_const(ast.nodes[i]):
                thisCnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.nodes[i])]
                ast.nodes[i] = Name(variable_prefix + "_" + str(thisCnt))
                tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes

    elif isinstance(ast, Not):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.expr):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, Dict):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        for i in range(len(ast.items)):
            tupleLeft, tupleRight = ast.items[i]
            if not is_var_const(ast.items[i][0]):
                thisCnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.items[i][0])]
                tupleLeft = Name(variable_prefix + "_" + str(thisCnt))
                tmpCnt += 1
            if not is_var_const(ast.items[i][1]):
                thisCnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.items[i][1])]
                tupleRight = Name(variable_prefix + "_" + str(thisCnt))
                tmpCnt += 1
            ast.items[i] = (tupleLeft, tupleRight)
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, Subscript):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.expr):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        for i in range(len(ast.subs)):
            if not is_var_const(ast.subs[i]):
                thisCnt = tmpCnt
                [nodes.append(x) for x in flatten_ast(ast.subs[i])]
                ast.subs[i] = Name(variable_prefix + "_" + str(thisCnt))
                tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, IfExp):
        cnt = tmpCnt
        ast.then = Stmt(flatten_ast(ast.then))
        if isinstance(ast.then.nodes[-1], Assign):
            ast.then.nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], Name(ast.then.nodes[-1].nodes[0].name)))
        elif isinstance(ast.then.nodes[-1], IfExp):
            ast.then.nodes[-1].then.nodes.append(
                Assign(
                    [AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')],
                    Name(ast.then.nodes[-1].then.nodes[-1].nodes[0].name)
                )
            )
            ast.then.nodes[-1].else_.nodes.append(
                Assign(
                    [AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')],
                    Name(ast.then.nodes[-1].else_.nodes[-1].nodes[0].name)
                )
            )
        ast.else_ = Stmt(flatten_ast(ast.else_))
        if isinstance(ast.else_.nodes[-1], Assign):
            ast.else_.nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], Name(ast.else_.nodes[-1].nodes[0].name)))
        elif isinstance(ast.else_.nodes[-1], IfExp):
            if isinstance(ast.else_.nodes[-1].then.nodes[-1], Assign):
                ast.else_.nodes[-1].then.nodes.append(
                    Assign(
                        [AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')],
                        Name(ast.else_.nodes[-1].then.nodes[-1].nodes[0].name)
                    )
                )
            if isinstance(ast.else_.nodes[-1].else_.nodes[-1], Assign):
                ast.else_.nodes[-1].else_.nodes.append(
                    Assign(
                        [AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')],
                        Name(ast.else_.nodes[-1].else_.nodes[-1].nodes[0].name)
                    )
                )
        tmpCnt += 1
        nodes = []
        if not isinstance(ast.test, Name):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.test)]
            ast.test = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        # this is essentially an explication::
        tag = tmpCnt
        nodes.append(Assign([AssName(variable_prefix + "_" + str(tag), 'OP-ASSIGN')], GetTag(ast.test)))
        nodes.append(Assign([AssName(variable_prefix + "_" + str(tag), 'OP-ASSIGN')], Compare(Const(INT_TAG), [("==", Name(variable_prefix + "_" + str(tag)))])))
        nodes.append(IfExp(Name(variable_prefix + "_" + str(tag)),
                                Stmt([Assign([AssName(ast.test.name, 'OP-ASSIGN')], ProjectTo('int', ast.test))]),
                                Stmt([Assign([AssName(ast.test.name, 'OP-ASSIGN')], ProjectTo('bool', ast.test))])
                        )
                    )
        tmpCnt += 1
        nodes.append(ast)
        return nodes
    elif isinstance(ast, GetTag):
        return [Assign([AssName(variable_prefix + "_" + str(tmpCnt), 'OP-ASSIGN')], ast)]
    elif isinstance(ast, InjectFrom):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.arg):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.arg)]
            ast.arg = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes

    elif isinstance(ast, ProjectTo):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.arg):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.arg)]
            ast.arg = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, Let):
        cnt = tmpCnt
        nodes = []
        if not is_var_const(ast.rhs):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.rhs)]
            ast.rhs = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        ast.body = Stmt(flatten_ast(ast.body))
        nodes.append(ast)
        if ast.resultName is not None:
            nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], Name(ast.resultName)))
        return nodes
    elif isinstance(ast, IntAdd) or isinstance(ast, CallBigAdd):
        cnt = tmpCnt
        tmpCnt += 1
        nodes = []
        if not is_var_const(ast.left):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.left)]
            ast.left = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        if not is_var_const(ast.right):
            thisCnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.right)]
            ast.right = Name(variable_prefix + "_" + str(thisCnt))
            tmpCnt += 1
        nodes.append(Assign([AssName(variable_prefix + "_" + str(cnt), 'OP-ASSIGN')], ast))
        return nodes
    elif isinstance(ast, PrintBool) or isinstance(ast, PrintBig):
        nodes = []
        if not is_var_const(ast.expr):
            cnt = tmpCnt
            [nodes.append(x) for x in flatten_ast(ast.expr)]
            ast.expr = Name(variable_prefix + "_" + str(cnt))
        nodes.append(ast)
        return nodes
    else:
        raise Exception("Error in flatten_ast: unrecognized AST node: " + str(ast))

# function to convert all user-defined names to have the
# variable prefix that we use for our flattened tmp variables
# this function assumes that the AST is flat
def unqiueify_names(tree):
    if isinstance(tree, Module):
        return Module(None, unqiueify_names(tree.node))
    elif isinstance(tree, Stmt) or isinstance(tree, Printnl):
        for i in range(len(tree.nodes)):
            tree.nodes[i] = unqiueify_names(tree.nodes[i])
        return tree
    elif isinstance(tree, Printnl):
        for i in range(len(tree.nodes)):
            tree.nodes[i] = unqiueify_names(tree.nodes[i])
        return tree
    elif isinstance(tree, Assign):
        tree.expr = unqiueify_names(tree.expr)
        for i in range(len(tree.nodes)):
            tree.nodes[i] = unqiueify_names(tree.nodes[i])
        return tree
    elif isinstance(tree, Discard):
        tree.expr = unqiueify_names(tree.expr)
        return tree

    elif isinstance_list(tree, [AssName, StaticAssName]):
        if not tree.name.startswith(variable_prefix) and not tree.name.startswith(explicate_prefix) and not tree.name.startswith(variable_prefix_user_defined):
            tree.name = variable_prefix_user_defined + "_" + tree.name
        return tree
    elif isinstance(tree, Const) or isinstance(tree, Bool):
        return tree
    elif isinstance_list(tree, [Name, StaticName]):
        if isinstance(tree.name, str):
            if not tree.name.startswith(variable_prefix) and not tree.name.startswith(explicate_prefix) and not tree.name.startswith(variable_prefix_user_defined):
                tree.name = variable_prefix_user_defined + "_" + tree.name
        elif isinstance(tree.name, AssName):
            tree.name = unqiueify_names(tree.name)
        return tree
    elif isinstance(tree, Add) or isinstance(tree, IntAdd) or isinstance(tree, CallBigAdd):
        tree.left = unqiueify_names(tree.left)
        tree.right = unqiueify_names(tree.right)
        return tree
    elif isinstance(tree, UnarySub) or isinstance(tree, PrintBool) or isinstance(tree, PrintBig) or isinstance(tree, Not):
        tree.expr = unqiueify_names(tree.expr)
        return tree
    elif isinstance(tree, CallFunc):
        # we don't need callfunc args yet but if we do we can uncomment this
        # for i in range(len(tree.args)):
        #     tree.args[i] = unqiueify_names(tree.args[i])
        return tree
    # P1
    elif isinstance(tree, Compare) or isinstance(tree, BigCompare):
        tree.expr = unqiueify_names(tree.expr)
        for i in range(len(tree.ops)):
            tree.ops[i] = (tree.ops[i][0], unqiueify_names(tree.ops[i][1]))
        return tree
    elif isinstance(tree, IfExp):
        tree.test = unqiueify_names(tree.test)
        tree.then = unqiueify_names(tree.then)
        tree.else_ = unqiueify_names(tree.else_)
        return tree
    elif isinstance(tree, Subscript):
        tree.expr = unqiueify_names(tree.expr)
        for i in range(len(tree.subs)):
            tree.subs[i] = unqiueify_names(tree.subs[i])
        return tree
    elif isinstance(tree, GetTag):
        return tree
    elif isinstance(tree, InjectFrom):
        return tree
    elif isinstance(tree, ProjectTo):
        return tree
    elif isinstance(tree, Let):
        tree.rhs = unqiueify_names(tree.rhs)
        tree.body = unqiueify_names(tree.body)
        return tree
    elif isinstance(tree, And) or isinstance(tree, Or) or isinstance(tree, List):
        for i in range(len(tree.nodes)):
            tree.nodes[i] = unqiueify_names(tree.nodes[i])
        return tree
    elif isinstance(tree, Dict):
        for i in range(len(tree.items)):
            tree.items[i] = (unqiueify_names(tree.items[i][0]), unqiueify_names(tree.items[i][1]))
        return tree
    else:
        raise Exception("Error in unqiueify_names: unrecognized AST node %s" % tree.__class__)

def log(log):
    print "Flatten:: " + log

def print_flattened(flattened_tree):
    log("Flattened AST tree:")
    for line in flattened_tree.node.nodes:
        log("\t" + str(line))

indentCnt = 1
def print_flattened_pretty(tree):
    global indentCnt
    if isinstance(tree, Module):
        log("Flattened AST tree:")
        print_flattened_pretty(tree.node)
    if isinstance(tree, Stmt):
        for node in tree.nodes:
            if isinstance(node, IfExp):
                log("  " * indentCnt + "IfExp(" + str(node.test) )
                indentCnt += 1
                print_flattened_pretty(node.then)
                log("  " * (indentCnt-1) + "Else("  )
                print_flattened_pretty(node.else_)
                indentCnt -= 1
                log("  " * indentCnt + ")")
            elif isinstance(node, Let):
                log("  " * indentCnt + "Let(" + str(node.var) + ", " + str(node.rhs))
                indentCnt += 1
                print_flattened_pretty(node.body)
                log("  " * indentCnt + "Result: " + str(node.resultName))
                indentCnt -= 1
                log("  " * indentCnt + ")")
            else:
                log("  " * indentCnt + str(node))
