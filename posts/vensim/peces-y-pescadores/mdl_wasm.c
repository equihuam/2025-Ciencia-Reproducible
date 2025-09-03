/*(Tue Sep  2 17:01:25 2025) From Peces_y_pescadores.mdl - C equations for the model */

#define _VDFX
#define VDFX

#pragma warning (disable : 4101) //Turn off warning for unreferenced local variable
#pragma warning (disable : 4005) //Turn off warnings for macro redefinition
#pragma warning (disable : 4305) //Turn off warnings for truncation from 'double' to 'REAL'

#define setpos(a) VGV->lastpos = a 
#define setposF(a) VGV->lastpos = a 

#define WASM
#define _WASM

typedef unsigned char charutf8;
#define __GLOB_VARS WASM_GLOB_VARS

#define NUM_VARS 29
#define NUM_LEVELS 4
#define NUM_DELAYS 0
#define NUM_AUX 25
#define NUM_LOOKUPS 2
#define NUM_STRINGS 0



#define NUM_DATA_FILES 0
charutf8 *strDataFiles[NUM_DATA_FILES] = { 
};

charutf8 *strVarNames[NUM_VARS] = { 
"Time" 	/*0*/
, "balance financiero total" 	/*1*/
, "Flota pesquera" 	/*2*/
, "Peces" 	/*3*/
, "área" 	/*4*/
, "balance anual" 	/*5*/
, "balance financiero inicial total" 	/*6*/
, "cantidad de peces muertos" 	/*7*/
, "cantidad de peces nuevos" 	/*8*/
, "Cantidad inicial de peces" 	/*9*/
, "capacidad de carga" 	/*10*/
, "captura por barco" 	/*11*/
, "captura total anual" 	/*12*/
, "costo de operar un barco" 	/*13*/
, "costo de un barco" 	/*14*/
, "costos" 	/*15*/
, "densidad" 	/*16*/
, "FINAL TIME" 	/*17*/
, "ganancias" 	/*18*/
, "ganancias anuales" 	/*19*/
, "INITIAL TIME" 	/*20*/
, "inversión en nuevos barcos" 	/*21*/
, "mortalidad" 	/*22*/
, "nuevos barcos construidos" 	/*23*/
, "Número inicial de barcos" 	/*24*/
, "precio del pescado" 	/*25*/
, "SAVEPER" 	/*26*/
, "tasa de natalidad de peces" 	/*27*/
, "TIME STEP" 	/*28*/
};

int nTypesVector[NUM_VARS] = { 
15	/*0*/
, 8	/*1*/
, 8	/*2*/
, 8	/*3*/
, 23	/*4*/
, 17	/*5*/
, 23	/*6*/
, 17	/*7*/
, 17	/*8*/
, 23	/*9*/
, 23	/*10*/
, 17	/*11*/
, 17	/*12*/
, 23	/*13*/
, 23	/*14*/
, 17	/*15*/
, 17	/*16*/
, 23	/*17*/
, 17	/*18*/
, 17	/*19*/
, 23	/*20*/
, 23	/*21*/
, 17	/*22*/
, 17	/*23*/
, 23	/*24*/
, 23	/*25*/
, 17	/*26*/
, 23	/*27*/
, 23	/*28*/
};

unsigned short nBitSwitchVector[NUM_VARS] = { 
32	/*0*/
, 32	/*1*/
, 32	/*2*/
, 32	/*3*/
, 32	/*4*/
, 32	/*5*/
, 32	/*6*/
, 32	/*7*/
, 32	/*8*/
, 32	/*9*/
, 32	/*10*/
, 33	/*11*/
, 32	/*12*/
, 32	/*13*/
, 32	/*14*/
, 32	/*15*/
, 32	/*16*/
, 32	/*17*/
, 32	/*18*/
, 32	/*19*/
, 32	/*20*/
, 32	/*21*/
, 33	/*22*/
, 32	/*23*/
, 32	/*24*/
, 32	/*25*/
, 32	/*26*/
, 32	/*27*/
, 32	/*28*/
};


typedef struct pair_long_int { long nVarIndex; int nFuncType; }pair_long_int;
pair_long_int structFuncIndexData[] = { 
{-1, -1}};
charutf8 *strLookupNames[NUM_LOOKUPS] = { 
"#captura por barco#" 	/*0*/
, "#mortalidad#" 	/*1*/
};

charutf8 *strStringNames = 0; 
#include "C:\Users\Public\Vensim\COMP\wasm\mdl_wasm.h"

COMPREAL temp0 ; 
COMPREAL temp1 ; 
COMPREAL temp2 ; 
COMPREAL temp3 ; 
COMPREAL temp4 ; 
COMPREAL temp5 ; 
COMPREAL temp6 ; 
COMPREAL temp7 ; 
COMPREAL temp8 ; 
COMPREAL temp9 ; 
COMPREAL temp10 ; 
COMPREAL temp11 ; 
COMPREAL temp12 ; 
COMPREAL temp13 ; 
COMPREAL temp14 ; 
COMPREAL temp15 ; 
COMPREAL temp16 ; 
COMPREAL temp17 ; 
COMPREAL temp18 ; 
COMPREAL temp19 ; 
COMPREAL temp20 ; 
COMPREAL temp21 ; 
COMPREAL temp22 ; 
COMPREAL temp23 ; 
COMPREAL temp24 ; 
COMPREAL temp25 ; 
COMPREAL temp26 ; 
COMPREAL temp27 ; 
COMPREAL temp28 ; 
COMPREAL temp29 ; 
COMPREAL temp30 ; 
COMPREAL temp31 ; 
COMPREAL temp32 ; 
COMPREAL temp33 ; 
COMPREAL temp34 ; 
COMPREAL temp35 ; 
COMPREAL temp36 ; 
COMPREAL temp37 ; 
COMPREAL temp38 ; 
COMPREAL temp39 ; 
COMPREAL temp40 ; 
COMPREAL temp41 ; 
COMPREAL temp42 ; 
COMPREAL temp43 ; 
COMPREAL temp44 ; 
COMPREAL temp45 ; 
COMPREAL temp46 ; 
COMPREAL temp47 ; 
COMPREAL temp48 ; 
COMPREAL temp49 ; 
COMPREAL temp50 ; 
COMPREAL temp51 ; 
COMPREAL temp52 ; 
COMPREAL temp53 ; 
COMPREAL temp54 ; 
COMPREAL temp55 ; 
COMPREAL temp56 ; 
COMPREAL temp57 ; 
COMPREAL temp58 ; 
COMPREAL temp59 ; 
COMPREAL temp60 ; 
COMPREAL temp61 ; 
COMPREAL temp62 ; 
COMPREAL temp63 ; 
COMPREAL temp64 ; 
COMPREAL temp65 ; 
COMPREAL temp66 ; 
COMPREAL temp67 ; 
COMPREAL temp68 ; 
COMPREAL temp69 ; 
COMPREAL temp70 ; 
COMPREAL temp71 ; 
COMPREAL temp72 ; 
COMPREAL temp73 ; 
COMPREAL temp74 ; 
COMPREAL temp75 ; 
COMPREAL temp76 ; 
COMPREAL temp77 ; 
COMPREAL temp78 ; 
COMPREAL temp79 ; 
COMPREAL temp80 ; 
COMPREAL temp81 ; 
COMPREAL temp82 ; 
COMPREAL temp83 ; 
COMPREAL temp84 ; 
COMPREAL temp85 ; 
COMPREAL temp86 ; 
COMPREAL temp87 ; 
COMPREAL temp88 ; 
COMPREAL temp89 ; 
COMPREAL temp90 ; 
COMPREAL temp91 ; 
COMPREAL temp92 ; 
COMPREAL temp93 ; 
COMPREAL temp94 ; 
COMPREAL temp95 ; 
COMPREAL temp96 ; 
COMPREAL temp97 ; 
COMPREAL temp98 ; 
COMPREAL temp99 ; 
COMPREAL temp100 ; 
COMPREAL temp101 ; 
COMPREAL temp102 ; 
COMPREAL temp103 ; 
COMPREAL temp104 ; 
COMPREAL temp105 ; 
COMPREAL temp106 ; 
COMPREAL temp107 ; 
COMPREAL temp108 ; 
COMPREAL temp109 ; 
COMPREAL temp110 ; 
COMPREAL temp111 ; 
COMPREAL temp112 ; 
COMPREAL temp113 ; 
COMPREAL temp114 ; 
COMPREAL temp115 ; 
COMPREAL temp116 ; 
COMPREAL temp117 ; 
COMPREAL temp118 ; 
COMPREAL temp119 ; 
COMPREAL temp120 ; 
COMPREAL temp121 ; 
COMPREAL temp122 ; 
COMPREAL temp123 ; 
COMPREAL temp124 ; 
COMPREAL temp125 ; 
COMPREAL temp126 ; 
COMPREAL temp127 ; 
COMPREAL temp128 ; 
COMPREAL temp129 ; 
COMPREAL temp130 ; 
COMPREAL temp131 ; 

int sumind0 ; 
int forind0 ; 

int sumind1 ; 
int forind1 ; 

int sumind2 ; 
int forind2 ; 

int sumind3 ; 
int forind3 ; 

int sumind4 ; 
int forind4 ; 

int sumind5 ; 
int forind5 ; 

int sumind6 ; 
int forind6 ; 

int sumind7 ; 
int forind7 ; 

int simultid ; 
void InitConstants()
{
SetConstant ( 4, "área", 100);
SetConstant ( 6, "balance financiero inicial total", 0);
SetConstant ( 9, "Cantidad inicial de peces", 1000);
SetConstant ( 10, "capacidad de carga", 1200);
SetConstant ( 13, "costo de operar un barco", 250);
SetConstant ( 14, "costo de un barco", 300);
SetConstant ( 17, "FINAL TIME", 1986);
SetConstant ( 20, "INITIAL TIME", 1970);
SetConstant ( 21, "inversión en nuevos barcos", 0.2);
SetConstant ( 24, "Número inicial de barcos", 10);
SetConstant ( 25, "precio del pescado", 20);
SetConstant ( 27, "tasa de natalidad de peces", 6);
SetConstant ( 28, "TIME STEP", 0.25);
{
	// #captura por barco#
	REAL fxVals[13];
	REAL fyVals[13];
	fxVals[0] = 0;
	fyVals[0] = 0;
	fxVals[1] = 1;
	fyVals[1] = 5;
	fxVals[2] = 2;
	fyVals[2] = 10.38;
	fxVals[3] = 3;
	fyVals[3] = 15.88;
	fxVals[4] = 4;
	fyVals[4] = 20.25;
	fxVals[5] = 5;
	fyVals[5] = 22.13;
	fxVals[6] = 6;
	fyVals[6] = 23.25;
	fxVals[7] = 7;
	fyVals[7] = 23.75;
	fxVals[8] = 8;
	fyVals[8] = 24.25;
	fxVals[9] = 9;
	fyVals[9] = 24.63;
	fxVals[10] = 10;
	fyVals[10] = 25;
	fxVals[11] = 11;
	fyVals[11] = 25.35;
	fxVals[12] = 12;
	fyVals[12] = 25.48;
	SetLookup(0, "#captura por barco#", 13, fxVals, fyVals);
}
{
	// #mortalidad#
	REAL fxVals[11];
	REAL fyVals[11];
	fxVals[0] = 0;
	fyVals[0] = 5.22;
	fxVals[1] = 0.1;
	fyVals[1] = 5.225;
	fxVals[2] = 0.2;
	fyVals[2] = 5.23;
	fxVals[3] = 0.3;
	fyVals[3] = 5.24;
	fxVals[4] = 0.4;
	fyVals[4] = 5.255;
	fxVals[5] = 0.5;
	fyVals[5] = 5.29;
	fxVals[6] = 0.6;
	fyVals[6] = 5.345;
	fxVals[7] = 0.7;
	fyVals[7] = 5.45;
	fxVals[8] = 0.8;
	fyVals[8] = 5.665;
	fxVals[9] = 0.9;
	fyVals[9] = 5.94;
	fxVals[10] = 1;
	fyVals[10] = 6;
	SetLookup(1, "#mortalidad#", 11, fxVals, fyVals);
}
}

long Get_NUM_VARS() { return NUM_VARS; }
long Get_NUM_LEVELS() { return NUM_LEVELS; }
long Get_NUM_DELAYS() { return NUM_DELAYS; }
long Get_NUM_AUX() { return NUM_AUX; }
long Get_NUM_LOOKUPS() { return NUM_LOOKUPS; }
long Get_NUM_STRINGS() { return NUM_STRINGS; }
long Get_NUM_DATA_FILES() { return NUM_DATA_FILES; }
charutf8 *Get_VarName(long nIndex) { return strVarNames[nIndex]; }
charutf8 *Get_LookupName(long nIndex) { return strLookupNames[nIndex]; }
int Get_VarType(long nIndex) { return nTypesVector[nIndex]; }
unsigned short Get_VarBitSwitch(long nIndex) { return nBitSwitchVector[nIndex]; }
int Get_VarFuncIndex(long nIndex)	{
long nCount = 0;
while (structFuncIndexData[nCount].nVarIndex != -1)
{
if (nIndex == structFuncIndexData[nCount].nVarIndex)
return structFuncIndexData[nCount].nFuncType;
else if (structFuncIndexData[nCount].nVarIndex > nIndex)
return -1;
nCount++;
}
return -1;
}
charutf8 *Get_DataFileName(long nIndex) { return strDataFiles[nIndex]; }
void SetupDIMS(){
CreateDIMS(1);
SetDIM_INFO(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1);
};
#ifndef LINKEXTERN
#endif
unsigned char *mdl_desc()
{
return("(Tue Sep  2 17:01:25 2025) From Peces_y_pescadores.mdl") ;
}

/* compute the model rates */
void mdl_func0(__GLOB_VARS *VGV)
{double temp[10];
VGV->RATE[0] = 1.0 ;/* this is time */
/* balance financiero total */
 {
  setpos( 1) ;
  VGV->RATE[1] = VGV->LEVEL[19] ;
} /* balance financiero total */

/* Flota pesquera */
 {
  setpos( 2) ;
  VGV->RATE[2] = VGV->LEVEL[23] ;
} /* Flota pesquera */

/* Peces */
 {
  setpos( 3) ;
  VGV->RATE[3] = VGV->LEVEL[8]-(VGV->LEVEL[7]+VGV->LEVEL[12]) ;
} /* Peces */

} /* comp_rate */

/* compute the delays */
void mdl_func1(__GLOB_VARS *VGV)
{double temp[10];
} /* comp_delay */

/* initialize time */
void mdl_func2(__GLOB_VARS *VGV)
{ double temp[10]; 
vec_arglist_init(VGV);
VGV->LEVEL[0] = VGV->LEVEL[20] ;
} /* init_time */

/* initialize time step */
void mdl_func3(__GLOB_VARS *VGV)
{double temp[10];
/* a constant no need to do anything */
} /* init_tstep */

/* State variable initial value computation*/
void mdl_func4(__GLOB_VARS *VGV)
{double temp[10];
/* balance financiero total */
 {
  setpos( 1) ;
  VGV->LEVEL[1] = VGV->LEVEL[6] ;
}
/* Flota pesquera */
 {
  setpos( 2) ;
  VGV->LEVEL[2] = VGV->LEVEL[24] ;
}
/* Peces */
 {
  setpos( 3) ;
  VGV->LEVEL[3] = 1000.000000 ;
}
} /* comp_init */

/* State variable re-initial value computation*/
void mdl_func5(__GLOB_VARS *VGV)
{double temp[10];
} /* comp_reinit */

/*  Active Time Step Equation */
void mdl_func6(__GLOB_VARS *VGV)
{double temp[10];
} /* comp_tstep */
/*  Auxiliary variable equations*/
void mdl_func7(__GLOB_VARS *VGV)
{double temp[10];
/* densidad */
 {
  setpos( 16) ;
  VGV->LEVEL[16] = VGV->LEVEL[3]/VGV->LEVEL[4] ;
}
/* captura por barco */
 {
  setpos( 11) ;
  VGV->LEVEL[11] = TABLE(&VGV->TAB[0],VGV->LEVEL[16]) ;
}
/* captura total anual */
 {
  setpos( 12) ;
  VGV->LEVEL[12] = VGV->LEVEL[2]*VGV->LEVEL[11] ;
}
/* ganancias */
 {
  setpos( 18) ;
  VGV->LEVEL[18] = VGV->LEVEL[25]*VGV->LEVEL[12] ;
}
/* costos */
 {
  setpos( 15) ;
  VGV->LEVEL[15] = VGV->LEVEL[2]*VGV->LEVEL[13] ;
}
/* balance anual */
 {
  setpos( 5) ;
  VGV->LEVEL[5] = VGV->LEVEL[18]-VGV->LEVEL[15] ;
}
/* mortalidad */
 {
  setpos( 22) ;
  VGV->LEVEL[22] = TABLE(&VGV->TAB[1],VGV->LEVEL[3]/VGV->LEVEL[10]
) ;
}
/* cantidad de peces muertos */
 {
  setpos( 7) ;
  VGV->LEVEL[7] = VGV->LEVEL[22]*VGV->LEVEL[3] ;
}
/* cantidad de peces nuevos */
 {
  setpos( 8) ;
  VGV->LEVEL[8] = VGV->LEVEL[3]*VGV->LEVEL[27] ;
}
/* ganancias anuales */
 {
  setpos( 19) ;
  VGV->LEVEL[19] = VGV->LEVEL[5] ;
}
/* nuevos barcos construidos */
 {
  setpos( 23) ;
  VGV->LEVEL[23] = MAX(0,VGV->LEVEL[5]*VGV->LEVEL[21]/VGV->LEVEL[14
]) ;
}
/* SAVEPER */
 {
  setpos( 26) ;
  VGV->LEVEL[26] = VGV->LEVEL[28] ;
}
} /* comp_aux */
int execute_curloop(__GLOB_VARS *VGV) {return(0);}
static void vec_arglist_init(__GLOB_VARS *VGV)
{
}
void VEFCC comp_rate(__GLOB_VARS *VGV)
{
mdl_func0(VGV);
}

void VEFCC comp_delay(__GLOB_VARS *VGV)
{
mdl_func1(VGV);
}

void VEFCC init_time(__GLOB_VARS *VGV)
{
mdl_func2(VGV);
}

void VEFCC init_tstep(__GLOB_VARS *VGV)
{
mdl_func3(VGV);
}

void VEFCC comp_init(__GLOB_VARS *VGV)
{
mdl_func4(VGV);
}

void VEFCC comp_reinit(__GLOB_VARS *VGV)
{
mdl_func5(VGV);
}

void VEFCC comp_tstep(__GLOB_VARS *VGV)
{
mdl_func6(VGV);
}

void VEFCC comp_aux(__GLOB_VARS *VGV)
{
mdl_func7(VGV);
}

