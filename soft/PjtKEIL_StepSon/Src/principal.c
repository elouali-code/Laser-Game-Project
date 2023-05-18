

#include "DriverJeuLaser.h"

void CallbackSon(void); //définie en langage d'assemblage
extern void StartSon(void); 
 int bouton =0 ; 
int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

//Configuration timer 4
	Timer_1234_Init_ff(TIM4,6552); 
	Active_IT_Debordement_Timer(TIM4,2, CallbackSon);
	
//Configuration PWM
	PWM_Init_ff (TIM3, 3, 720); // Fréquence de la PWM = PeriodeSonMicroSec / 720
	
	
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
StartSon();

//============================================================================	
	
	
while	(1)
	{
		if(bouton==1){
		  StartSon();
			bouton=0;
		}
	}
}

