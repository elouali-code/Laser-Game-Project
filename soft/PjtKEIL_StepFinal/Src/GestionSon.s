	PRESERVE8
	THUMB   
		
	include Driver/DriverJeuLaser.inc
	
	export CallbackSon
	export StartSon
	import Son 
	import LongueurSon
	export SortieSon
; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
SortieSon dcw 0
Index dcd LongueurSon
	

	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; �crire le code ici		

CallbackSon  ; corps de la fonction Callback
				push {LR}
				push {r4-r7}
				ldr r0, =Son ; L'adresse du tableau de sons est stock�e dans r0
				ldr r1, =Index ; L'adresse de l'index de table est stock�e dans r1
				ldr r2, [r1] ; L'index actuel est stock� dans r2
				ldr r3, =LongueurSon ; L'adresse de la taille du tableau est stock�e dans r3-
				ldr r4, [r3] ; La valeur de la taille du tableau est stock�e dans r4
				
				cmp r2, r4 ; on v�rifie qu'on n'est pas � la fin du tableau
				beq fin
				
				ldr r5, =SortieSon ; L'adresse de sortie est stock�e dans r5
				ldrsh r6, [r0, r2, lsl #1] ; La valeur de l'�chantillon point�e par l'index est stock�e dans r6
				mov r7, #720 ; Mise � l'�chelle
				mul r6, r7
				asr r6, #16
				add r6, #360

				mov r0, r6				
				add r2, r2, #1 ; Incr�mentation de l'index

				str r2, [r1] ; la nouvelle valeur de l'index est envoy�e dans index
				str r6, [r5] ; la valeur de l'�chantillon est stock�e dans SortieSon
				bl PWM_Set_Value_TIM3_Ch3 ; Mise � jour du rapport cyclique dans le cas de l'utilisation de la PWM
				
fin				pop {r4-r7}
				pop {LR}
				bx LR
				
StartSon  ; corps de la fonction StartSon
				ldr r1, =Index ; L'adresse de l'index de table est stock�e dans r1
				mov r2, #0  ; Mise � 0
				str r2, [r1] ;  La nouvelle valeur de l'index (0) est envoy�e dans index
				bx LR
		        

	END	
		
; 8. Signal PWM � l'�tat haut (3,3V) si CompValue est sup�rieure au Compteur
; Signal PWM � l'�tat bas (0V) si CompValue est inf�rieur au Compteur

;15. Fc = 1/(2*pi*RC). On choisit R=1,8 kOhms et on trouve apr�s calcul C=22,1 nF