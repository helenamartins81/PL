%{
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap


%%

^:[A-Za-z_]+([0-9]{4})? //nomes

:temMae : // nome da mãe
:temPai : // nome do pai    


\#.*            {;}

[.*|\n]         {;}
				
(.|\n)			{;}

%%





