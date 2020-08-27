INSTR = [
    "IMM", # set register 0 to IMMediate value
    "MVR", # MV value from one Register to another.
    "MOV", # MOVe from register to value in memory.
    "STR", # SeT Register to value in memory.
    "SPX", # Switch PiXel.
    "DRW", # DRaW scrren buffer.
    "CLS", # CLear Screen.
    "GET", # GET a number.
    "CLL", # CaLL a function.
    "PAU", # PAUse
    "PUT", # PUT a string to the console.
    "ADD", "SUB", "MUL", "DIV", "AND", "COR", "NOT", "CLT", "CGT", "CLE", "CGE",
    "JMP", # JuMP to immediate instruction.
    "CJP", # Conditional JumP (if register 0 is truthy then jump).
]

f = open("test.mec", "r")
data = f.read()
f.close()
