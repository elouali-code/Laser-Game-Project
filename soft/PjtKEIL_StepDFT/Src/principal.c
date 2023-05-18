
#include <stdio.h>
#include "DriverJeuLaser.h"

extern short LeSignal ;
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k); //à changer quand la fonction moduleaaucarré sera créée

int T[64];
int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
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

