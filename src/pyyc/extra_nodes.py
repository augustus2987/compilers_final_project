import compiler
from compiler.ast import * 


# ==================================
#         STATIC TYPE NODES
# ==================================

class StaticName(Node):
    def __init__(self, name, typ = None, subtype = None, keytype = None):
        self.name = name
        self.typ = typ
        self.subtype = subtype
        self.keytype = keytype

    def getChildren(self):
        return self.name,

    def __repr__(self):
        if not self.typ:
            return "StaticName(" + self.name + ", NO_TYPE)"
        elif not self.subtype:
            return "StaticName(" + self.name + ", " + self.typ + ")"
        elif not self.keytype:
            return "StaticName(" + self.name + ", " + self.typ + ", " + self.subtype + ")"
        else:
            return "StaticName(" + self.name + ", " + self.typ + ", " + self.subtype + ", " + self.keytype + ")"
    
class StaticAssName(Node):
    def __init__(self, name, typ = None, subtype = None, keytype = None):
        self.name = name
        self.typ = typ
        self.subtype = subtype
        self.keytype = keytype
    def __repr__(self):
        if not self.typ:
            return "StaticAssName(" + self.name + ", NO_TYPE)"
        elif not self.subtype:
            return "StaticAssName(" + self.name + ", " + self.typ + ")"
        elif not self.keytype:
            return "StaticAssName(" + self.name + ", " + self.typ + ", " + self.subtype + ")"
        else:
            return "StaticAssName(" + self.name + ", " + self.typ + ", " + self.subtype + ", " + self.keytype + ")"

# ==================================

class GetTag(Node):
    def __init__(self, arg):
        self.arg = arg
    
    def getChildren(self):
        return tuple([self.arg])

    def __repr__(self):
        return "GetTag(" + str(self.arg) + ")"
        
class InjectFrom(Node):
    def __init__(self, typ, arg):
        self.typ = typ
        self.arg = arg

    def getChildren(self):
        return tuple([self.typ, self.arg])
    
    def __repr__(self):
        return "InjectFrom(" + str(self.typ) + ", " + str(self.arg) + ")"
        
class ProjectTo(Node):
    def __init__(self, typ, arg):
        self.typ = typ
        self.arg = arg

    def getChildren(self):
        return tuple([self.typ, self.arg])

    def __repr__(self):
        return "ProjectTo(" + self.typ + ", " + str(self.arg) + ")"
        
class Let(Node):
    def __init__(self, var, rhs, body, resultName):
        self.var = var
        self.rhs = rhs
        self.body = body
        self.resultName = resultName

    def getChildren(self):
        children = []
        children.append(self.var)
        children.extend([self.rhs, self.body, self.resultName])
        return tuple(children)
    
    def __repr__(self):
        return "Let(" + str(self.var) + ", " + str(self.rhs) + ", " + str(self.body) + ")"

class IntAdd(Node):
    def __init__(self, left, right):
        self.left = left
        self.right = right
    
    def getChildren(self):
        children = []
        children.extend(self.left.getChildren())
        children.extend(self.right.getChildren())
        return tuple(children)

    def __repr__(self):
        return "IntAdd(" + str(self.left) + ", " + str(self.right) + ")"

class CallBigAdd(Node):
    def __init__(self, leftright):
        self.left = leftright[0]
        self.right = leftright[1]
    
    def getChildren(self):
        children = []
        print("connor:: getchildren: " + str(self.left))
        children.extend(self.left.getChildren())
        children.extend(self.right.getChildren())
        return tuple(children)

    def __repr__(self):
        return "CallBigAdd(" + str(self.left) + ", " + str(self.right) + ")"

class BigCompare(Node):
    def __init__(self, expr, ops):
        self.expr = expr
        self.ops = ops
    
    def getChildren(self):
        children = []
        children.extend(self.expr.getChildren())
        for op in self.ops:
            children.extend(op[1].getChildren())
        return tuple(children)

    def __repr__(self):
        return "BigCompare(" + str(self.expr) + ", " + str(self.ops) + ")"

class PrintBool(Node):
    def __init__(self, expr):
        self.expr = expr
    
    def getChildren(self):
        return tuple([self.expr])
    
    def __repr__(self):
        return "PrintBool(" + str(self.expr) + ")"

class PrintBig(Node):
    def __init__(self, expr):
        self.expr = expr
    
    def getChildren(self):
        return tuple([self.expr])
    
    def __repr__(self):
        return "PrintBig(" + str(self.expr) + ")"

class Bool(Node):
    def __init__(self, value):
        self.value = value
    
    def getChildren(self):
        return tuple([])
    
    def __repr__(self):
        val = "True" if self.value else "False"
        return "Bool(" + val + ")"

class IsTrue(Node):
    def __init__(self, expr):
        self.expr = expr

    def getChildren(self):
        return tuple([self.expr])
    
    def __repr__(self):
        return "IsTrue(" + str(self.expr) + ")"