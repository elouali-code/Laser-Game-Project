
#include <stdio.h>
#include "DriverJeuLaser.h"

extern short LeSignal ;
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k); //� changer quand la fonction moduleaaucarr� sera cr��e

int T[64];
int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();


	
	

//============================================================================	

//int vf = DFT_ModuleAuCarre(&LeSignal,1); 
 
for (int i=0;i<64;i++){
    
	T[i]=DFT_ModuleAuCarre(&LeSignal,i); 

}

	
	
while	(1)
	{
	}
}

