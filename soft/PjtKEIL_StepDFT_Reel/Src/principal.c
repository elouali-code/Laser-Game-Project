
#include <stdio.h>
#include "DriverJeuLaser.h"

extern short LeSignal ;
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k); //à changer quand la fonction moduleaaucarré sera créée

short tabValeurs[64];//signal capté par l'ADC
int tabResultat[64];
void callback_systick(void){
	Start_DMA1(64); //Démarrage sur 64 échantillons
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

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

//Configuration du Systick 
Systick_Period_ff(360000); // x/(72*10^6)=5ms car fréquence horloge = 72MHz
Systick_Prio_IT(2,callback_systick); 
SysTick_On;
SysTick_Enable_IT;

//Configuration de l'ADC et DMA
Init_TimingADC_ActiveADC_ff(ADC1, 72); //On veut une periode d'1us donc 72 ticks d'horloge dont fréquence = 72Mhz
Single_Channel_ADC(ADC1, 2); //2 correpond à la pin d'entrée PA2
Init_Conversion_On_Trig_Timer_ff(ADC1,TIM2_CC2, 225); //ligne CC2 du timer 2, fréquence 320 kHz donc 255 ticks d'horloge
Init_ADC1_DMA1(0,tabValeurs); //valeur 0 = remplissage linéaire de la RAM alors que 1 est un remplissage circulaire
		
	
	
//============================================================================	

//int vf = DFT_ModuleAuCarre(&LeSignal,1); 


	
	
while	(1)
	{
	}
}

