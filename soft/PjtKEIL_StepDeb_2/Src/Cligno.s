	PRESERVE8
	THUMB   
		
	include Driver/DriverJeuLaser.inc
	
	export timer_callback
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
FlagCligno dcd 0

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici

timer_callback  
				push {LR}
				ldr r1, =FlagCligno
				ldr r1,[r1]
				MOV r0, #1 
				CMP r1, #0
				BEQ si_zero ;boucle si =1 
				BL GPIOB_Set
				MOV r1, #0
				B fin
			
si_zero			BL GPIOB_Clear
				MOV r1, #1
			
fin	     		ldr r2, =FlagCligno
                str r1, [r2]
				pop {LR}
				BX LR
			
			END	