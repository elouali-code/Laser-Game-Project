	PRESERVE8
	THUMB   
		
	include Driver/DriverJeuLaser.inc
	
	export CallbackSon
	export StartSon
	import Son 
	import LongueurSon
	export SortieSon
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
SortieSon dcw 0
Index dcd LongueurSon
	

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

CallbackSon  ; corps de la fonction Callback
				push {LR}
				push {r4-r7}
				ldr r0, =Son ; L'adresse du tableau de sons est stockée dans r0
				ldr r1, =Index ; L'adresse de l'index de table est stockée dans r1
				ldr r2, [r1] ; L'index actuel est stocké dans r2
				ldr r3, =LongueurSon ; L'adresse de la taille du tableau est stockée dans r3-
				ldr r4, [r3] ; La valeur de la taille du tableau est stockée dans r4
				
				cmp r2, r4 ; on vérifie qu'on n'est pas à la fin du tableau
				beq fin
				
				ldr r5, =SortieSon ; L'adresse de sortie est stockée dans r5
				ldrsh r6, [r0, r2, lsl #1] ; La valeur de l'échantillon pointée par l'index est stockée dans r6
				mov r7, #720 ; Mise à l'échelle
				mul r6, r7
				asr r6, #16
				add r6, #360

				mov r0, r6				
				add r2, r2, #1 ; Incrémentation de l'index

				str r2, [r1] ; la nouvelle valeur de l'index est envoyée dans index
				str r6, [r5] ; la valeur de l'échantillon est stockée dans SortieSon
				bl PWM_Set_Value_TIM3_Ch3 ; Mise à jour du rapport cyclique dans le cas de l'utilisation de la PWM
				
fin				pop {r4-r7}
				pop {LR}
				bx LR
				
StartSon  ; corps de la fonction StartSon
				ldr r1, =Index ; L'adresse de l'index de table est stockée dans r1
				mov r2, #0  ; Mise à 0
				str r2, [r1] ;  La nouvelle valeur de l'index (0) est envoyée dans index
				bx LR
		        

	END	
		
; 8. Signal PWM à l'état haut (3,3V) si CompValue est supérieure au Compteur
; Signal PWM à l'état bas (0V) si CompValue est inférieur au Compteur

;15. Fc = 1/(2*pi*RC). On choisit R=1,8 kOhms et on trouve après calcul C=22,1 nF