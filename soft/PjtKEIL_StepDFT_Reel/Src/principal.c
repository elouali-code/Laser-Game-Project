
#include <stdio.h>
#include "DriverJeuLaser.h"

extern short LeSignal ;
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k); //� changer quand la fonction moduleaaucarr� sera cr��e

short tabValeurs[64];//signal capt� par l'ADC
int tabResultat[64];
void callback_systick(void){
	Start_DMA1(64); //D�marrage sur 64 �chantillons
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
		
	for(int i=0 ;i<64; i++){	
	  tabResultat[i]=DFT_ModuleAuCarre(tabValeurs,i);
	}
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

//Configuration du Systick 
Systick_Period_ff(360000); // x/(72*10^6)=5ms car fr�quence horloge = 72MHz
Systick_Prio_IT(2,callback_systick); 
SysTick_On;
SysTick_Enable_IT;

//Configuration de l'ADC et DMA
Init_TimingADC_ActiveADC_ff(ADC1, 72); //On veut une periode d'1us donc 72 ticks d'horloge dont fr�quence = 72Mhz
Single_Channel_ADC(ADC1, 2); //2 correpond � la pin d'entr�e PA2
Init_Conversion_On_Trig_Timer_ff(ADC1,TIM2_CC2, 225); //ligne CC2 du timer 2, fr�quence 320 kHz donc 255 ticks d'horloge
Init_ADC1_DMA1(0,tabValeurs); //valeur 0 = remplissage lin�aire de la RAM alors que 1 est un remplissage circulaire
		
	
	
//============================================================================	

//int vf = DFT_ModuleAuCarre(&LeSignal,1); 


	
	
while	(1)
	{
	}
}

