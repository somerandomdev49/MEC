#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "itoa.h"

enum
{
	CMP_ALW = 0xff, // Always
	CMP_NVR = 0x00, // Never
	CMP_EQL = 1, // Equal
	CMP_LST = 2, // Less Than
	CMP_GRT = 4, // Greater Than
	CMP_NEQ = 8, // Not Equal
	CMP_LTE = 16, // Less Than or Equal
	CMP_GRE = 32, // Greater Than or Equal
	CMP_AND = 64, // And
	CMP_XOR = 128, // Xor
	CMP_COR = 256, // Or
};

enum
{
	RG_PC, // Program Counter
	RG_IMM,
	RG_FLG, // Flag
	RG_SCL, // Special
	RG_GP0,
	RG_GP1,
	RG_GP2,
	RG_GP3,
};

enum
{
	I_ADD,
	I_SUB,
	I_MUL,
	I_DIV,
	I_IMM,
	I_MOV,
	I_STT,
	I_JMP,
	I_CMP,
};

char *i_str[] =
{
	"ADD", "SUB", "MUL", "DIV",
	"IMM", "MOV", "STT", "JMP",
	"CMP"
};

typedef uint16_t num_t;
typedef struct
{
	char *buf;
	num_t *rgs; // x8
	num_t *mem; // x64
} vm_t;


void display_state(vm_t *vm)
{
	printf("rgs:\n");
	for(int i=0;i<8;i++)
		if(i == 2)
		{
			char buffer[17];
			itoa(vm->rgs[i], buffer, 2);
			printf("2: %s\n", buffer);
		}
		else
		{
			printf("%d: %d\n", i, vm->rgs[i]);
		}
	printf("mem:\n");
	for(int i=0;i<8;i++)
	{
		for(int j=0;j<8;j++)
		{
			num_t val = vm->mem[i*8+j];
			/**/ if(val < 10) printf("%d   ", val);
			else if(val < 100) printf("%d  ", val);
			else if(val < 1000) printf("%d ", val);
			else                 printf("%d", val);
		}
		printf("\n");
	}
}


// printf("%d <- %d + %d = %d\n", dr, r1, r2, r1 + r2);


void run_instr(vm_t *vm)
{
#define NEXT (vm->buf[vm->rgs[RG_PC]++])
#define NEXT_NUM ((NEXT<<8)|(NEXT))
	printf(
		"Run instruction@%d: %d %s\n",
		vm->rgs[RG_PC],
		vm->buf[vm->rgs[RG_PC]],
		i_str[vm->buf[vm->rgs[RG_PC]]]
	);
	switch(NEXT)
	{
	case I_IMM: /* IMM [IV] */
		vm->rgs[RG_IMM] =  NEXT_NUM; break;
	case I_ADD: /* ADD DR R1 R2 */
	{
		char dr = NEXT, r1 = vm->rgs[NEXT], r2 = vm->rgs[NEXT];
		vm->rgs[dr] = r1 + r2;
	} break;
	case I_SUB: /* SUB DR R1 R2 */
	{
		char dr = NEXT, r1 = vm->rgs[NEXT], r2 = vm->rgs[NEXT];
		vm->rgs[dr] = r1 - r2;
	} break;
	case I_MUL: /* MUL DR R1 R2 */
	{
		char dr = NEXT, r1 = vm->rgs[NEXT], r2 = vm->rgs[NEXT];
		vm->rgs[dr] = r1 * r2;
	} break;
	case I_DIV: /* DIV DR R1 R2 */
	{
		char dr = NEXT, r1 = vm->rgs[NEXT], r2 = vm->rgs[NEXT];
		vm->rgs[dr] = r1 / r2;
	} break;
	case I_MOV: /* MOV MD DR MS SR */
	{
		char md = NEXT, dr = NEXT, ms = NEXT, sr = NEXT;
		if((md ) & (!ms)) vm->rgs[dr]          = vm->mem[vm->rgs[sr]];
		if((!md) & (!ms)) vm->mem[vm->rgs[dr]] = vm->mem[vm->rgs[sr]];
		if((md ) & ( ms)) vm->rgs[dr]          = vm->rgs[sr];
		if((!md) & ( ms)) vm->mem[vm->rgs[dr]] = vm->rgs[sr];
	} break;
	case I_STT: /* STT */
		display_state(vm);
		break;
	case I_JMP: /* JMP FL RM [DR]|DR */
		if(vm->rgs[RG_FLG] & NEXT)
		{
			if(!NEXT) vm->rgs[RG_PC] = NEXT_NUM;
			else      vm->rgs[RG_PC] = vm->rgs[NEXT];

		}
		else
		{
			if(!NEXT) NEXT_NUM;
			else NEXT;
		} break;
	case I_CMP: /* CMP M1 [R1]|R1 M2 [R2]|R2  */
	{
		num_t v1 = NEXT ? vm->rgs[NEXT] : NEXT_NUM;
		num_t v2 = NEXT ? vm->rgs[NEXT] : NEXT_NUM;
		if(v1 == v2) vm->rgs[RG_FLG] |= CMP_EQL;
		if(v1 != v2) vm->rgs[RG_FLG] |= CMP_NEQ;
		if(v1 >= v2) vm->rgs[RG_FLG] |= CMP_GRE;
		if(v1 <= v2) vm->rgs[RG_FLG] |= CMP_LTE;
		if(v1 && v2) vm->rgs[RG_FLG] |= CMP_AND;
		if(v1 || v2) vm->rgs[RG_FLG] |= CMP_COR;
		if(v1 >  v2) vm->rgs[RG_FLG] |= CMP_GRT;
		if(v1 <  v2) vm->rgs[RG_FLG] |= CMP_LST;
		if(v1 ^  v2) vm->rgs[RG_FLG] |= CMP_XOR;
	} break;
	default:
	{
		printf("Unknown command: %d", vm->buf[vm->rgs[RG_PC]-1]);
		exit(1);
	} break;
	}
}

int main()
{
	char ins[] =
	{
		I_IMM, 0, 1, // imm = 2
		I_MOV, 1, RG_GP0, 1, RG_IMM, // gp0 = imm

		I_IMM, 0, 3, // imm = 3
		I_MOV, 1, RG_GP1, 1, RG_IMM, // 15!; gp1 = imm

		I_ADD, RG_GP2, RG_GP1, RG_GP0, // gp2 = gp1 + gp0

		I_IMM, 0, 0, // addr.
		I_MOV, 0, RG_IMM, 1, RG_GP2, // move gp2 to 0x0000.
		I_STT, // display state

		I_CMP, 1, RG_GP2, 0, 0, 6,   // compare gp2, 6
		I_STT,
		I_JMP, CMP_LST, 0, 0, 49,  // 40!; if gp2 < 6, jmp 47

		I_IMM, 0, 1, // imm = 1
		I_JMP, CMP_ALW, 0, 0, 52,  // jmp 50
		I_IMM, 0, 0, // imm = 0
		I_MOV, 1, RG_SCL, 1, RG_IMM, // return code = imm
	};

	vm_t vm;
	vm.mem = malloc(64*sizeof(num_t));
	vm.rgs = malloc(8 *sizeof(num_t));
	memset(vm.mem, 0, 64*sizeof(num_t));
	memset(vm.rgs, 0, 8 *sizeof(num_t));
	vm.buf = ins;
	while(vm.rgs[RG_PC] < sizeof(ins))
		run_instr(&vm);
	return vm.rgs[RG_SCL];
}
