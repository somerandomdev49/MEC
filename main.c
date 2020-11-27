#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum
{
	RG_PC,
	RG_IMM,
	RG_FLG,
	RG_CMP,
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
		printf("%d: %d\n", i, vm->rgs[i]);
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

	switch(NEXT)
	{
	case I_IMM: /* IMM IV */
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
		I_IMM, 0, 2, // imm = 2
		I_MOV, 1, RG_GP0, 1, RG_IMM, // gp0 = imm
		I_IMM, 0, 3, // imm = 3
		I_MOV, 1, RG_GP1, 1, RG_IMM, // gp1 = imm
		I_ADD, RG_GP2, RG_GP1, RG_GP0, // gp2 = gp1 + gp0
		I_IMM, 0, 0, // addr.
		I_MOV, 0, RG_IMM, 1, RG_GP2, // move gp2 to 0x0000.
		I_STT
	};

	vm_t vm;
	vm.mem = malloc(64*sizeof(num_t));
	vm.rgs = malloc(8 *sizeof(num_t));
	memset(vm.mem, 0, 64*sizeof(num_t));
	memset(vm.rgs, 0, 8 *sizeof(num_t));
	vm.buf = ins;
	while(vm.rgs[RG_PC] < sizeof(ins))
		run_instr(&vm);
	return 0;
}
