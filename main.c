#include <stdlib.h>
#include <stdio.h>
#include "mec.h"

// CPU
typedef struct { num_t pc, regs[16]; } CPU;
typedef struct { num_t w, h; byte *buf; } SCR;
typedef struct { byte i; char *d; } VAL;

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

void flush_stdin()
{
    int c;
    do {
        c = getchar();
    } while(c != '\n' && c != EOF);
}

int fpeek(FILE *stream)
{
    int c;

    c = fgetc(stream);
    ungetc(c, stream);

    return c;
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
    case I_GET: scanf("%hd", &cpu->regs[i.a]); break;
    case I_PAU: puts("Press [Enter]"); flush_stdin(); getchar();break;
    case I_PUT: printf("%s", val[i.a].d);       break;

    instr_op(SUB, -);
    instr_op(MUL, *);
    instr_op(DIV, /);
    instr_op(AND, &);
    instr_op(COR, |);
    instr_op(CLT, <);
    instr_op(CGT, >);
    instr_op(CLE, <=);
    instr_op(CGE, >=);
    }
}

byte read_byte(FILE *in) { byte x = getc(in); printf("reading a byte %d, next %d\n", x, fpeek(in)); return x; }
num_t read_num(FILE *in) { return mk_num(read_byte(in), read_byte(in)); }
char *read_str(FILE *in)
{
    puts("reading a string...");
    num_t size = 0;
    char *s = malloc(size), c;
    while((c=read_byte(in)) != '\0' && c != EOF)
    {
        printf("reading a character: '%c' %d\n", c, c);
        s = realloc(s, ++size);
        s[size-1] = c;
    } 
    return s;
}

void read(FILE *in, VAL *val[], int *val_count, INS *ins[], int *ins_count)
{
    puts("reading...");
    *val_count = read_num(in);
    printf("value count: %d\n", *val_count);
    *val = malloc(*val_count * sizeof(VAL));
    puts("reading values:");
    for(int i=0;i<*val_count;++i) *val[i] = (VAL){ i, read_str(in) };
    *ins_count = read_num(in);
    printf("instruction count: %d, (%lu bytes per INS -> %lu bytes total)\n", *ins_count, sizeof(INS), *ins_count * sizeof(INS));
    *ins = malloc(9); // (*ins_count) * sizeof(INS)
    //printf("%d", (*ins)[1].t);
    puts("reading instructions:");
    for(int i=0;i<*ins_count;++i)
    {
        printf("reading ins #%d\n", i);
        printf("Next byte: %d\n", fpeek(in));
        (*ins)[i] = (INS){ 0, 0, 0 };
        puts("reading byte t");
        (*ins)[i].t = read_byte(in);
        puts("reading byte a");
        (*ins)[i].a = read_byte(in);
        puts("reading byte b");
        (*ins)[i].b = read_byte(in);
        puts("done reading ins.");
    }
}

int main()
{
    FILE *in = fopen("out.mecc", "r");

    VAL *val; int val_size;
    INS *cpg; int cpg_size;
    read(in, &val, &val_size, &cpg, &cpg_size);
    fclose(in);

    SCR s = (SCR){ 10, 10, malloc(10 * 10) };
    for(num_t y=0;y<s.h;++y)
	for(num_t x=0;x<s.w;++x)
	    s.buf[x+y*s.w] = 0;

    CPU cpu;
    cpu.pc = 0;

    // VAL val[] =
    // {
	//     (VAL){ 0, "if X < 12 + 34 hen :) else :(\nX: " }
    // };
    // INS cpg[] =
    // {
    //     (INS){ I_PUT,  0, 0 }, // PUT(V0)
    //     (INS){ I_GET,  2, 0 }, // R2 = GET
    //     (INS){ I_IMM, 00,12 }, // R0 = 12
    //     (INS){ I_MVR,  1, 0 }, // R1 = R0
    //     (INS){ I_IMM, 00,34 }, // R0 = 34
    //     (INS){ I_ADD,  0, 1 }, // R0 = R0 + R1
    //     (INS){ I_MVR,  1, 0 }, // R1 = R0
    //     (INS){ I_IMM, 00,47 }, // R0 = 48
    //     (INS){ I_CLT,  2, 1 }, // R0 = R0 < R1
    //     (INS){ I_CJP, 00,13 }, // R0 ? JMP(13)
    //     (INS){ I_SPX,  5, 6 }, // PXL(5, 5)
    //     (INS){ I_SPX,  0, 6 }, // PXL(0, 5)
    //     (INS){ I_JMP, 00,15 }, // JMP(15)
    //     (INS){ I_SPX,  0, 4 }, // PXL(0, 3)
    //     (INS){ I_SPX,  5, 4 }, // PXL(5, 3)

    //     (INS){ I_SPX,  1, 1 }, // PXL(1, 1)
    //     (INS){ I_SPX,  1, 2 }, // PXL(1, 2)
    //     (INS){ I_SPX,  4, 1 }, // PXL(4, 1)
    //     (INS){ I_SPX,  4, 2 }, // PXL(4, 2)
    //     (INS){ I_SPX,  1, 5 }, // PXL(1, 5)
    //     (INS){ I_SPX,  2, 5 }, // PXL(2, 5)
    //     (INS){ I_SPX,  3, 5 }, // PXL(3, 5)
    //     (INS){ I_SPX,  4, 5 }, // PXL(4, 5)

    //     (INS){ I_DRW,  0, 0 }, // DRAW
    //     (INS){ I_PAU,  0, 0 }, // PAUSE
    // };

    while(cpu.pc < cpg_size)
    {
	    run(cpg, NULL, &cpu, &s, val);
    }
    free(s.buf);
    free(cpg);
    free(val);
    //printf("R0: %d", cpu.regs[0]);
    return 0;
}

