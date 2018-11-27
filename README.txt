Nume, prenume: Raileanu Ana Arina
Grupa: 324CA
<raileanu.arina1@gmail.com>

			Tema 1 - Postfix
			
La operatiile in forma postfixata ecuatiile sunt de forma: A B O
de unde deducem faptul ca la fiecare intalnire a unui operator trebuie sa
calculam rezultatul operatiei cu termenii A si B si operatorul O.

Ideea care sta in spatele temei este sa parsam sirul de la intrare pe care
il retinem in "expr". Folosind functia strtok separam sirul in subsiruri
in functie de caracterul spatiu si luam fiecare subsir in parte si verificam
daca este operator sau operand. Pentru a face aceasta verificare folosim
functia atoi, si verificam valoarea numarului pe care il returneaza. Daca
rezultatul functiei atoi este 0, inseamna ca fie avem un operator, fie 
cifra 0 si verificam separat acest caz. Astfel, comparam byte[EAX], care este
caracterul din sirul returnat de strok, cu "0" si daca este egal inseamna ca
avem un operand.  In continuare, cu operatorii si operanzii separati, 
punem operanzii in stiva, deoarece urmeaza sa facem o operatie cu ei,
iar daca avem un operator extragem ultimii 2 operanzi din stiva si executam
operatia corespunzatoare cu ei.

Pentru ca strtok returna in EAX adresa de la care incepea subsirul si ne
dorim sa facem o verificare cu caracterul "0" dupa ce folosim functia atoi,
care ne-ar modifica EAX, punem EAX pe stiva de 2 ori inainte de a apela
functia si dupa ce facem verificarea cu valoarea returnata de atoi ii 
refacem valoarea de dinainte.