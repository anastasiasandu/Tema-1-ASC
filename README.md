# Tema-1-ASC
 CERINTA 1 <br />
Fie dat ca input un sir hexa, se cere sa se afiseze la standard output instructiunea assembly de
executat.<br />
De exemplu, pentru inputul A78801C00A7890EC04, se va afisa la standard output x 1 let x
-14 div. <br />
Pentru codificarea operanzilor avem urmatoarea structura: <br />
- Codificarea este pe 12 biti (1.5 Bytes); <br />
- semnificatia bitilor este urmatoarea: <br />
– primul bit, b0 este intotdeauna egal cu 1;<br />
– urmatorii 2 biti identifica ce tip are operandul: daca avem 00, atunci operandul este
numar, iar daca avem 01, atunci operandul este variabila; <br />
– daca am avut identificatorul de numar, 00, atunci b3 este bit-ul de semn: 0 inseamna ca
numarul este considerat pozitiv, respectiv 1 inseamna ca numarul este considerat negativ.
Daca am avut identificatorul 01, atunci bit-ul b3 de semn va fi considerat 0; <br />
– operandul poate fi, dupa caz, asa cum am vazut: sau numar pozitiv (de la 0 la 255), sau
numar negativ (tot de la 0 la 255, dar cu semn schimbat), sau o variabila - variabilele sunt
formate doar dintr-o singura litera. De exemplu, daca avem in codificarea operandului
01111000, 1111000 este, de fapt, 120 in baza 10, care corespunde codului ASCII pentru x.
Astfel, o codificare completa pe 12 biti 1 01 0 01111000 inseamna ca operandul curent
este variabila x. Daca am fi avut aceeasi reprezentare in operand, dar cu alt cod de
identificator, de exemplu 00, 1 00 0 01111000, ar fi fost numarul intreg 120, iar daca
aveam bitul de semn 1, 1 00 1 01111000, ar fi fost numarul intreg -120. <br />
Ramane doar sa codificam operatiile. Ele vor respecta o structura similara - un bit initial 1, un
identificator, si un cod de operatie aplicata pana la lungimea de 12 biti: <br />
Avem urmatoarele codificari: <br />
Operatie Codificare <br />
let 000000000 <br />
add 000000001 <br />
sub 000000010 <br />
mul 000000011 <br />
div 000000100 <br />
Identificatorul este, in acest caz, 10 (cei doi biti care precizeaza identificatorul). Astfel, reprezentarea unei operatii add ar fi 1 10 000000001.
Pentru claritate, vom prezenta identificatorii in urmatorul tabel: <br />
Identificator Semnificatie <br />
00 numar intreg <br />
01 variabila <br />
10 operatie  <br />
     CERINTA 2  <br />
Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat, se 
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, in instructiune
nu exista variabile, ea fiind formata doar din numere intregi si operatii. <br />
De exemplu, poate fi data instructiunea 2 10 mul 5 div 7 6 sub add. Rezultatul trebuie sa
fie conform urmatorului algoritm: <br />
• se adauga 2 pe stiva; <br />
• se adauga 10 pe stiva; <br />
• se identifica operatia mul, se aplica inmultirea dintre 2 si 10, se obtine 20, se elimina 2 si 10
de pe stiva si se pastreaza doar 20; <br />
• se adauga 5 pe stiva; <br />
• se identifica div - actioneaza ca 20 div 5, iar rezultatul este 4; se elimina 20 si 5 de pe stiva,
si se pastreaza doar 4; <br />
• se adauga 7 pe stiva; <br />
• se adauga 6 pe stiva; <br />
• se identifica sub - se calculeaza diferenta dintre 7 si 6, se obtine 1, se elimina 7 si 6 de pe stiva,
si se adauga pe stiva valoarea 1. Atentie! in acest moment, pe stiva avem 4 (la baza) si 1 in
varf, intrucat sub este operatie binara si a lucrat doar cu argumentele 7 si 6, dar nu si cu 4
care era deja la baza stivei. <br />
• se identifica add - se calculeaza suma dintre 1 si 4, se obtine 5, se elimina 1 si 4 de pe stiva, se
adauga 5; <br />
• am terminat de parcurs sirul, iar rezultatul obtinut este, acum, situat in varful stivei. Rezultatul acestui calcul este 5.
Important! Se cere evaluarea doar pe unsigned! Se garanteaza ca toate operatiile vor fi pe unsigned. <br />
      CERINTA 3  <br />
Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat. Se
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, spre deosebire
de cerinta 2, se folosesc variabile introduse prin let. <br />
Un exemplu de input poate fi x 1 let 2 x add y 3 let x y add mul. <br />
Evaluarea va fi facuta astfel: <br />
• se adauga x si 1 pe stiva, este gasit let, si se intelege de acum ca x = 1 in toata expresia
aritmetica; sunt eliminati x si 1 de pe stiva; <br />
• se adauga 2 si 1 pe stiva (deoarece acel x este = 1 de acum); <br />
• se intalneste add, se calculeaza suma 3, se elimina 2 si 1 de pe stiva si se pastreaza doar 3; <br />
• se adauga y si 3 pe stiva, este gasit let, si se intelege de acum ca y = 3 in toata expresia
aritmetica; sunt eliminati y si 3 de pe stiva; <br />
• se adauga 1 si 3 pe stiva (x, respectiv y); <br />
• se efectueaza adunarea, rezultatul va fi 4, se elimina 1 si 3 de pe stiva, se adauga 4; <br />
• este identificat mul, iar pe stiva aveam deja 3 (de la a treia bulinuta din explicatia curenta) si
4, de la bulinuta anterioara, si se calculeaza rezultatul, 12, se elimina apoi 3 si 4 de pe stiva si
se adauga 12; <br />
• nu mai sunt elemente in sir, deci rezultatul final este 12. <br />
Exact ca la cerinta a doua, se garanteaza ca toate operatiile vor fi aplicate pe unsigned. <br />
    CERINTA 4  <br />
Pentru aceasta cerinta, vom introduce operatii simple de lucru cu matrice. O matrice poate fi
reprezentata in forma : <br />
nrLinii nrColoane nrLinii*nrColoane_elemente <br />
Operatiile pe care le putem utiliza pe matrice sunt: <br />
• add - adunam toate elementele din matrice cu valoarea operandului; <br />
• sub - scadem din toate elementele din matrice valoarea operandului; <br />
• mul - inmultim toate elementele din matrice cu valoarea operandului; <br />
• div - impartim toate elementele din matrice la valoarea operandului; <br />
• rot90d - rotim matricea la 90 de grade spre dreapta; <br />
x 2 3 1 2 3 4 5 6 let x -2 add <br />
In acest caz, matricea x este o matrice de 2 linii x 3 coloane, care are urmatoarea forma: <br />
1 2 3 <br />
4 5 6 <br />
Se aplica o adunare cu -2 pe toate elementele matricei: <br />
-1 0 1 <br />
2 3 4 <br />
Ca output, la standard output se va afisa reprezentarea acestei matrice in forma in care e introdusa
in operatie: numarul de linii, numarul de coloane, respectiv elementele matricei, de la stanga la
dreapta si de sus in jos. In acest caz, outputul va fi 2 3 -1 0 1 2 3 4. <br />
