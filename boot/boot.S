.code16
.text
.globl _start
.type _start, @function
_start:
	jmp _start
. = _start + 510
.word 0xAA55
