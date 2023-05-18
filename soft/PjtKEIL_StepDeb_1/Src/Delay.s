	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0 ; adresse
	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000 ; valeur


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	export VarTime
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime ; r0=VarTime(VarTime est une adresse) 		  
						  
		ldr r1,=TimeValue ; r1=TimeValue (TimeValue est une valeur)
		str r1,[r0] ; TimeValue est stockée dans l'adresse stockée dans R0, c'est-à-dire dans VarTime
		
BoucleTempo	
		ldr r1,[r0] ; r1 = *r0     r1 = VarTime en C    				
						
		subs r1,#1 ; r1 = r1 - 1
		str  r1,[r0] ; *r0 = r1     VarTime = r1 en C
		bne	 BoucleTempo ; boucle while
			
		bx lr ; on retourne à l'adresse stockée dans le registre lr
		endp
		
		
	END	