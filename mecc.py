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
    "JMP", # JuMP to immediate instruction.
    "CJP", # Conditional JumP (if register 0 is truthy then jump).
    "ADD", "SUB", "MUL", "DIV", "AND", "COR", "NOT", "CLT", "CGT", "CLE", "CGE",
]

print(INSTR.index("JMP"))

f = open("test.mec", "r")

vals = []
inst = []

import shlex
i = -1
for line in f.readlines():
    i += 1
    line = line.strip()
    if len(line) == 0: continue
    if line[0] == ';': continue
    print(str(i) + " |", line)

    toks = shlex.split(line)
    if toks[0] == "VAL":
        vals.append(toks[1])
        continue
    if toks[0] not in INSTR:
        print("Unknown instruction: '" + toks[0] + "'")
    
    args = []
    if len(toks) < 2:
        args = []
    if len(toks) == 2:
        args.append(int(toks[1]))
    if len(toks) == 3:
        args.append(int(toks[1]))
        args.append(int(toks[2]))
    inst.append({ "name": INSTR.index(toks[0]), "args": args})
print(vals)
print(inst)        
f.close()

bin_out = bytearray([])
bin_out.extend(len(vals).to_bytes(length=2, byteorder="big"))
for val in vals:
    for c in val:
        bin_out.append(ord(c))
    bin_out.append(0)
for ins in inst:
    bin_out.append(ins["name"])
    if len(ins["args"]) == 0:
        bin_out.append(0)
        bin_out.append(0)
    if len(ins["args"]) == 1:
        bin_out.extend(ins["args"][0].to_bytes(length=2, byteorder="big"))
    if len(ins["args"]) == 2:
        bin_out.append(ins["args"][0])
        bin_out.append(ins["args"][1])

out = open("out.mecc", "bw")
out.write(bin_out)
out.close()
