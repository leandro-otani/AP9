jmp	main

main:
	loadn 	r0, #140
	loadn 	r4, #2892    ; R amarelo no meio da tela
	outchar r4, r0		
	jmp 	main