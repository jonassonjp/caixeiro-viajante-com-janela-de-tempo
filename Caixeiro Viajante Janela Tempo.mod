/*********************************************
 * OPL 12.10.0.0 Model
 * Author: Jonas Pereira de Andrade Filho
 * Creation Date: 8 de jul de 2020 at 17:06:47
 *********************************************/
 
 //Vertices serão pacientes a serem visitados (incluindo)
int numVert = ...; 

// Variacao dos vertices, incluindo a saida, inciando com 0 (zero)
range Vertices = 0..numVert-1;

// Matriz de deslocamenti (valores em minutos)
int d_tempo[Vertices][Vertices] = ...;

dvar boolean rota[Vertices][Vertices]; //xij

//dvar int T[0..numVert-1];

// Array com janela de tempo inicial
int a[0..numVert-1]=...;
// Array com janela de tempo final
int b[0..numVert-1]=...;

dvar int t[0..numVert-1];

// Valor Big M
int M=...;

// Funcao Objetivo
dexpr float caminho = sum(i in Vertices, j in Vertices: i!=j) d_tempo[i][j]*rota[i][j]; // cij * xij
minimize
  caminho;

//restricoes
subject to
{
 	//usando rotulo para analisar as saidas no gerenciador de problemas, mas consome recursos, so usar se necessario
 	flowing:
 	forall (j in Vertices)
 	  sum (i in Vertices: i!=j) rota[i][j]==1;
 	
 	flowout:
 	forall(i in Vertices)
 	  sum(j in Vertices:i!=j) rota[i][j]==1;
 	
 	forall(i in 0..numVert-1, j in 1..numVert-1)
 	  (t[i]+d_tempo[i][j])-(1-rota[i][j])*M <= t[j];
//		(t[i]+rota[i][j]-t[j])<= M*(1-rota[i][j]); 	
 	
	forall (i in 0..numVert-1)
		a[i]<=t[i]<= b[i];
 	   
} 

