__asm__(".code16\n");
__asm__("jmpl $0x0000, $main\n");

void print_char()
{
	__asm__(
		"mov $0X0E, %AH;"
		"mov $0X00, %BH;"
		"mov $0X04, %BL;"
		"int $0x10"
		);
}

int main()
{
	char *MSG = "Hello World!";
	int i;

	__asm__(".code16\n");
	__asm__(
			"mov %0, %%SI;"
			:
			:"g"(MSG)
);
	for(i=0;i<12;i++)
	{
		__asm__(
				"mov %0, %%AL;"
				:
				:"g"(MSG[i])
			);
			print_char();	
	}
	return 0;
}

