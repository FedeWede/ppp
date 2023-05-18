
% idfun idpeli fecha but_no_vendidas tarifa idsala
funci�n(fun1,peli3,fecha(21,5,2022),[12, 20, 30],200,sal1).
funci�n(fun2,peli1,fecha(21,5,2022),[1, 10],220,sal2).
funci�n(fun3,peli1,fecha(22,5,2022),[2, 12, 14, 20, 23],180,sal3).
funci�n(fun4,peli2,fecha(22,5,2022),[ ],220,sal4).
funci�n(fun5,peli3,fecha(23,5,2022),[20, 21, 25],150,sal1).
funci�n(fun6,peli2,fecha(23,5,2022),[30, 31],180,sal2).
funci�n(fun7,peli2,fecha(24,5,2022),[4, 18, 19, 30, 33],220,sal1).
funci�n(fun8,peli1,fecha(25,5,2022),[ ],300,sal2).
funci�n(fun9,peli2,fecha(25,5,2022),[ ],300,sal3).
funci�n(fun10,peli1,fecha(25,5,2022),[ ],300,sal4).


% idsala descrip tieneproy cantbutacas
sala(sal1,'Sala 1 - 3D - 50',si,50).
sala(sal2,'Sala 2 � com�n - 40',no,40).
sala(sal3,'Sala 3 � com�n - 30',no,30).
sala(sal4,'Sala 4 - 3D - 40',si,40).




% idpeli titulo a�o
pel�cula(peli1,'La Dama y el Vagabundo',1997).
pel�cula(peli2,'100 D�lmatas',2001).
pel�cula(peli3,'Pluto y sus Amigos',2019).
pel�cula(peli4,'Aristoperros',2020).

%reglas

regla1(Peli1,Peli2):-
	(   funci�n(_, Peli1, fecha(25, 5, 2022), _, _, _)), ! ;
	(   funci�n(_, Peli2, fecha(25, 05, 2022), _, _, _)), !.

regla2(ID_fun, Titulo, Descripcion_sala):-
	funci�n(ID_fun, ID_peli, _, _, _, ID_sala), pel�cula(ID_peli, Titulo, _), sala(ID_sala, Descripcion_sala, _, _).

regla3(Num, Lista):-
	findall(ID_Fun, (funci�n(ID_Fun, _, _, Cant_butacas, _, _), length(Cant_butacas, X), X >= Num), Lista).

