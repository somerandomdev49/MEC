#ifndef MEC_H
#define MEC_H
#include <inttypes.h>
typedef uint16_t num_t;
typedef uint8_t byte;
typedef struct { byte t, a, b; } INS;
typedef INS *CPG;

#define INS_ENUM_FOREACH(FUNC) \
    /* set register 0 to IMMediate value */       FUNC(IMM),\
    /* MV value from one Register to another. */  FUNC(MVR),\
    /* MOVe from register to value in memory. */  FUNC(MOV),\
    /* SeT Register to value in memory. */        FUNC(STR),\
    /* Switch PiXel. */                           FUNC(SPX),\
    /* DRaW scrren buffer. */                     FUNC(DRW),\
    /* CLear Screen. */                           FUNC(CLS),\
    /* GET a number. */                           FUNC(GET),\
    /* CaLL a function. */                        FUNC(CLL),\
    /* PAUse */                                   FUNC(PAU),\
    /* PUT a string to the console. */            FUNC(PUT),\
    /* JuMP to immediate instruction. */          FUNC(JMP),\
    /* Conditional JumP (register 0). */          FUNC(CJP),\
    FUNC(ADD), FUNC(SUB), FUNC(MUL), FUNC(DIV), FUNC(AND), FUNC(COR), FUNC(NOT), FUNC(CLT), FUNC(CGT), FUNC(CLE), FUNC(CGE),\
    /* Not used, for length of the enum */        FUNC(LAST_ENUM_ELEMENT)
#define INSTRUCTION_FUNC(var) I_##var
#define TOSTRING_FUNC(var) #var



num_t mk_num(byte a, byte b) { return (a << 8) | (b); }

enum
{
    INS_ENUM_FOREACH(INSTRUCTION_FUNC)
};
#endif//MEC_H
