from compiler.ast import *
from extra_nodes import *

# NAMES now have a type attribute
# CONSTS now have a type
# ASSNAMEs now have a type

## LEXER 
tokens = (
    'PRINT',
    'CONST',
    'PLUS',
    'ASSIGN',
    'VARNAME',
    'INPUT',
    'UNARYSUB',
    'LPAREN',
    'RPAREN',
    'LSBRACK',
    'RSBRACK',
    'LCBRACK',
    'RCBRACK',
    'EQEQ',
    'OR',
    'AND',
    'NOT',
    'IF',
    'IS',
    'ELSE',
    'COLON',
    'COMMA',
    'NOTEQ',
    'TRUE',
    'FALSE',
    'INTTYPE',
    'BOOLTYPE',
    'LISTTYPE',
    'DICTTYPE'
)

reserved = {
    'input': 'INPUT',
    'print': 'PRINT',
    'if': 'IF',
    'is': 'IS',
    'else': 'ELSE',
    'or': 'OR',
    'and': 'AND',
    'not': 'NOT', 
    'True': 'TRUE',
    'False': 'FALSE',
    'INT': 'INTTYPE',
    'BOOL': 'BOOLTYPE',
    'LIST': 'LISTTYPE',
    'DICT': 'DICTTYPE'
}

t_INTTYPE = r'INT'
t_BOOLTYPE= r'BOOL'
t_LISTTYPE = r'LIST'
t_DICTTYPE = r'DICT'

# token regex:
t_PRINT = r'print'
def t_CONST(t):
    r'\d+'
    try:
        t.value = int(t.value)
    except ValueError:
        print "integer value too large", t.value
        t.value = 0
    return t
t_PLUS = r'\+'
t_ASSIGN = r'='
def t_VARNAME(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value, 'VARNAME')
    return t
t_INPUT = 'input'
t_UNARYSUB = r'-'
t_LPAREN  = r'\('
t_RPAREN  = r'\)'

t_ignore = ' \t'
def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")
    # t.lexer.skip(t.value.count("\n"))

def t_error(t):
    print "Illegal character '%s'" % t.value[0]
    t.lexer.skip(1)
    
# need to get the comment regex working.
def t_comment(t):
    r'\#'
    t.lexer.lineno += 1
    
# P1
t_LSBRACK = r'\['
t_RSBRACK = r'\]'
t_LCBRACK = r'\{'
t_RCBRACK = r'\}'
t_EQEQ    = r'=='
t_OR      = r'or'
t_AND     = r'and'
t_NOT     = r'not'
t_IF      = r'if'
t_IS      = r'is'
t_ELSE    = r'else'
t_COLON   = r':'
t_COMMA   = r','
t_NOTEQ   = r'!='
t_TRUE    = r'True'
t_FALSE   = r'False'

import ply.lex as lex
lex.lex()


precedence = (
    ('nonassoc', 'PRINT', 'VARNAME'),
    ('left', 'PLUS', 'AND', 'OR', 'COLON', 'NOTEQ', 'EQEQ'),
    ('right', 'UNARYSUB', 'NOT', 'COMMA', 'INTTYPE', 'BOOLTYPE', 'LISTTYPE', 'DICTTYPE')
)  
    
# ===========================
#            P0
# ===========================

def p_print_statement(t):
    'statement : PRINT expression'
    t[0] = Printnl([t[2]], None)
    
def p_discard_statement(t):
    'statement : expression'
    t[0] = Discard(t[1])
    
# ===========================
#   FINAL PROJECT PARSING
# ===========================
    
def p_type_int(t):
    'vartype : INTTYPE'
    t[0] = "INT_TYPE"
    
def p_type_bool(t):
    'vartype : BOOLTYPE'
    t[0] = "BOOL_TYPE"
    
def p_type_list(t):
    'vartype : LISTTYPE'
    t[0] = "LIST_TYPE"
    
def p_type_dict(t):
    'vartype : DICTTYPE'
    t[0] = "DICT_TYPE"
    
def p_typedef_int_bool(t):
    'typedef : vartype VARNAME'
    t[0] = StaticName(t[2], t[1])
    
def p_typedef_list(t):
    'typedef : vartype VARNAME LSBRACK vartype RSBRACK'
    t[0] = StaticName(t[2], t[1], t[4])
    
def p_typedef_dict(t):
    'typedef : vartype VARNAME LSBRACK vartype COMMA vartype RSBRACK'
    t[0] = StaticName(t[2], t[1], t[4], t[6])

def p_typedef_statement(t):
    'statement : typedef'
    t[0] = t[1]
       
def p_typedef_assign(t):
    'statement : typedef ASSIGN expression'
    t[0] = Assign([StaticAssName(t[1].name, t[1].typ, t[1].subtype, t[1].keytype)], t[3])

def p_assign_statement(t):
    'statement : VARNAME ASSIGN expression'
    t[0] = Assign([StaticAssName(t[1])], t[3])

def p_varname_expression(t):
    'expression : VARNAME'
    #t[0] = Name(t[1])
    t[0] = StaticName(t[1])
    
# ===============================
    
def p_int_expression(t):
    'expression : CONST'
    t[0] = Const(t[1])
    
def p_unarysub_expression(t):
    'expression : UNARYSUB expression'
    t[0] = UnarySub(t[2])

def p_plus_expression(t):
    'expression : expression PLUS expression'
    t[0] = Add((t[1], t[3]))

def p_group_expression(t):
    'expression : LPAREN expression RPAREN '
    t[0] = t[2]
    
def p_callfunc_expression(t):
    'expression : INPUT LPAREN RPAREN'
    t[0] = CallFunc(Name(t[1]), [], None, None)

def p_error(t):
    print "Syntax error at '%s'" %t.value

    
# P1
def p_key_datum(t):
    'key_datum : expression COLON expression'
    t[0] = t[1], t[3]

def p_subscription(t):
    'subscription : expression LSBRACK expression RSBRACK'
    t[0] = Subscript(t[1], 'OP_APPLY', [t[3]])

def p_true_expression(t):
    'expression : TRUE'
    t[0] = Name("True")
    
def p_false_expression(t):
    'expression : FALSE'
    t[0] = Name("False")    
    
def p_not_expression(t):
    'expression : NOT expression'
    t[0] = Not(t[2])

def p_and_expression(t):
    'expression : expression AND expression'
    t[0] = And([t[1], t[3]])
    
def p_or_expression(t):
    'expression : expression OR expression'
    t[0] = Or([t[1], t[3]])
    
def p_eqeq_expression(t):
    'expression : expression EQEQ expression'
    t[0] = Compare(t[1], ['==', t[3]])
        
def p_noteq_expression(t):
    'expression : expression NOTEQ expression'
    t[0] = Compare(t[1], ['!=', t[3]])

def p_conditional_expression(t):
    'expression : expression IF expression ELSE expression'
    t[0] = IfExp(t[3], t[1], t[5])
        
def p_list_expression(t):
    'expression : LSBRACK expr_list RSBRACK'
    t[0] = t[2]
    
def p_dict_expression(t):
    'expression : LCBRACK key_datum_list RCBRACK'
    t[0] = t[2]

def p_subscription_expression(t):
    'expression : subscription'
    t[0] = t[1]
    
def p_is_expression(t):
    'expression : expression IS expression'
    t[0] = Compare(t[1], ['is', t[3]])
        
def p_expr_list(t):
    'expr_list : expression'
    t[0] = List([t[1]])

def p_append_to_list(t):
    'expr_list : expression COMMA expr_list'
    a = []
    a.append(t[1])
    for n in t[3].nodes:
        a.append(n)
    t[0] = List(a)

def p_keydatum_list(t):
    'key_datum_list : key_datum'
    t[0] = Dict([t[1]])
    
def p_keydatum_list_appendto_list(t):
    'key_datum_list : key_datum COMMA key_datum_list'
    a = []
    a.append(t[1])
    for n in t[3].items:
        a.append(n)
    t[0] = Dict(a)

# def p_target_identifier(t):
#     'target : identifier'
#     t[0] = t[1]
    
    
def p_target_subscription(t):
    'target : subscription'
    t[1].flags = 'OP_ASSIGN'
    t[0] = t[1]
    
def p_target_statement(t):
    'statement : target ASSIGN expression'
    t[0] = Assign([t[1]], t[3])


import ply.yacc as yacc
parser = yacc.yacc(debug=True)


def log(log):
    print "Parser:: ", log

def get_ast(filename):
    # tree = parser.parseFile(filename) ## call our own parse function 
    # tree = None
    # with open(filename) as f:
    #     raw = f.read()
    #     tree = parser.parse(raw, debug=False)
    nodes = []
    with open(filename) as f:
        for line in f:
            line = line.split("#")[0]
            if line.strip():
                nodes.append(parser.parse(line))
    tree = Module(None, Stmt(nodes))
#     log("AST from parser:")
#     for line in tree.node.nodes:
#         log("\t" + str(line))
    return tree
