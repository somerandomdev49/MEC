#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>

typedef uint16_t num_t;
typedef uint8_t byte;
// CPU
typedef struct { num_t pc, regs[16]; } CPU;
typedef struct { num_t w, h; byte *buf; } SCR;
typedef struct { byte t, a, b; } INS;
typedef struct { byte i; char *d; } VAL;
typedef INS *CPG;
num_t mk_num(byte a, byte b) { return (a << 8) | (b); }

enum
{
    I_IMM, // set register 0 to IMMediate value
    I_MVR, // MV value from one Register to another.
    I_MOV, // MOVe from register to value in memory.
    I_STR, // SeT Register to value in memory.
    I_SPX, // Switch PiXel.
    I_DRW, // DRaW scrren buffer.
    I_CLS, // CLear Screen.
    I_GET, // GET a number.
    I_CLL, // CaLL a function.
    I_PAU, // PAUse
    I_PUT, // PUT a string to the console.

    I_ADD, I_SUB, I_MUL, I_DIV, I_AND, I_OR, I_NOT, I_CLT, I_CGT, I_CLE, I_CGE,
    I_JMP, // JuMP to immediate instruction.
    I_CJP, // Conditional JumP (if register SP is truthy then jump).
};

void draw(SCR *scr)
{
    for(num_t y=0;y<scr->h;++y)
    {
	for(num_t x=0;x<scr->w;++x)
	{
	    putchar(scr->buf[x+y*scr->w] ? '*' : ' ');
	}
	putchar('\n');
    }
}

#define instr_op(n, o) case I_##n: cpu->regs[0] = cpu->regs[i.a] o cpu->regs[i.b]; break;
void run(INS *c, num_t *ram, CPU *cpu, SCR *scr, VAL *val)
{
    //printf("CPU INFO:\n\tPC: %d, REG0: %d, REG1: %d\n", cpu->pc, cpu->regs[0], cpu->regs[1]);
    INS i = c[cpu->pc++];
    //printf("INSTRUCTION: %d -> %d, %d\n", i.t, i.a, i.b);
    switch(i.t)
    {
    case I_IMM: cpu->regs[0] = mk_num(i.a, i.b); break;
    case I_MVR: cpu->regs[i.a] = cpu->regs[i.b]; break;
    case I_MOV: ram[i.a] = cpu->regs[i.b];       break;
    case I_STR: cpu->regs[i.a] = ram[i.b];       break;
    case I_SPX: scr->buf[i.a+i.b*scr->w]=!scr->buf[i.a+i.b*scr->w];break;
    case I_DRW: draw(scr);                       break;
    case I_JMP: cpu->pc = mk_num(i.a, i.b);      break;
    case I_CJP: if(cpu->regs[0]) cpu->pc = mk_num(i.a, i.b); break;
    case I_ADD: cpu->regs[0] = cpu->regs[i.a] + cpu->regs[i.b]; break;
    case I_GET: scanf("%d", &cpu->regs[i.a]);    break;
    case I_PAU: system("pause");                 break;
    case I_PUT: printf(val[i.a].d);

    instr_op(SUB, -);
    instr_op(MUL, *);
    instr_op(DIV, /);
    instr_op(AND, &);
    instr_op(CLT, <);
    instr_op(CGT, >);
    instr_op(CLE, <=);
    instr_op(CGE, >=);
    }
}

int main()
{
    SCR s = (SCR){ 10, 10, malloc(10 * 10) };
    for(num_t y=0;y<s.h;++y)
	for(num_t x=0;x<s.w;++x)
	    s.buf[x+y*s.w] = 0;

    CPU cpu;
    cpu.pc = 0;
    VAL val[] =
    {
	(VAL){ 0, "if X < 12 + 34 hen :) else :(\nX: " }
    };
    INS cpg[] =
    {
	(INS){ I_PUT,  0, 0 }, // PUT(V0)
	(INS){ I_GET,  2, 0 }, // R2 = GET
	(INS){ I_IMM, 00,12 }, // R0 = 12
	(INS){ I_MVR,  1, 0 }, // R1 = R0
	(INS){ I_IMM, 00,34 }, // R0 = 34
	(INS){ I_ADD,  0, 1 }, // R0 = R0 + R1
	(INS){ I_MVR,  1, 0 }, // R1 = R0
	(INS){ I_IMM, 00,47 }, // R0 = 48
	(INS){ I_CLT,  2, 1 }, // R0 = R0 < R1
	(INS){ I_CJP, 00,13 }, // R0 ? JMP(13)
	(INS){ I_SPX,  5, 6 }, // PXL(5, 5)
	(INS){ I_SPX,  0, 6 }, // PXL(0, 5)
	(INS){ I_JMP, 00,15 }, // JMP(15)
	(INS){ I_SPX,  0, 4 }, // PXL(0, 3)
	(INS){ I_SPX,  5, 4 }, // PXL(5, 3)

	(INS){ I_SPX,  1, 1 }, // PXL(1, 1)
	(INS){ I_SPX,  1, 2 }, // PXL(1, 2)
	(INS){ I_SPX,  4, 1 }, // PXL(4, 1)
	(INS){ I_SPX,  4, 2 }, // PXL(4, 2)
	(INS){ I_SPX,  1, 5 }, // PXL(1, 5)
	(INS){ I_SPX,  2, 5 }, // PXL(2, 5)
	(INS){ I_SPX,  3, 5 }, // PXL(3, 5)
	(INS){ I_SPX,  4, 5 }, // PXL(4, 5)

	(INS){ I_DRW,  0, 0 }, // DRAW
	(INS){ I_PAU,  0, 0 }, // PAUSE
    };

    while(cpu.pc < ((sizeof cpg) / sizeof(INS)))
    {
	run(cpg, NULL, &cpu, &s, val);
    }
    free(s.buf);
    //printf("R0: %d", cpu.regs[0]);
    return 0;
}

