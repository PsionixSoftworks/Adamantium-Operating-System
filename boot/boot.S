# We need to start from 16-bit Real Mode:
.code16
.globl _start
.section .text
.type _start, @function

# Entry point of our bootloader:
_start:
	# Initial setup:
	cli
	movw %cs, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss
	xorw %sp, %sp
	sti
	cld

	# Initialize Text Mode:
	movw $0x03, %ax
	int $0x10

	# Print the startup message:
	mov $StartupMsg, %si
	call Print
1:	hlt			# Halt loop. Necessary to keep system halted.
	jmp 1b

# Create print function so we know what's going on:
Print:
	lodsb
	or %al, %al
	jz .done
	movb $0x0E, %ah
	int $0x10
	jmp Print
.done:
	ret

# Bootloader messages go here:
StartupMsg: .asciz "Starting bootloader...\r\n"
. = _start + 510
.word 0xAA55
