% hechos.

% obras
obra_artistica(ob1, 'El Lago de los Cisnes', dir1, 1877).
obra_artistica(ob2, 'Rincón de Luz', dir2, 1995).
obra_artistica(ob3, 'Floricienta', dir2, 2004).

% directores
director(dir1, 'Victoria', 'Carreras', 10).
director(dir2, 'Cris', 'Morena', 30).
director(dir3, 'Arturo', 'Puig', 25).

% funciones
funcion(fun1, ob1, fecha(18, 05, 2022), hora(18, 0), 1).
funcion(fun2, ob1, fecha(18, 05, 2022), hora(22, 0), 1).
funcion(fun3, ob2, fecha(18, 05, 2022), hora(16, 30), 2).
funcion(fun4, ob2, fecha(18, 05, 2022), hora(21, 30), 2).
funcion(fun5, ob1, fecha(19, 05, 2022), hora(18, 0), 1).
funcion(fun6, ob1, fecha(19, 05, 2022), hora(21, 0), 1).
funcion(fun7, ob1, fecha(20, 05, 2022), hora(18, 30), 1).
funcion(fun8, ob2, fecha(20, 05, 2022), hora(21, 0), 2).
funcion(fun9, ob1, fecha(21, 05, 2022), hora(18, 0), 1).
funcion(fun10, ob1, fecha(21, 05, 2022), hora(22, 0), 1).

% entradas
entrada(en1, fun1, 500, no, platea(1)).
entrada(en2, fun1, 500, si, platea(3)).
entrada(en3,fun1, 500, no, platea(79)).
entrada(en4, fun1, 500, si, platea(99)).
entrada(en5, fun1, 200, si, vip('A', no)).
entrada(en6, fun1, 200, si,  vip('B', si)).
entrada(en7, fun2, 500, no, platea(9)).
entrada(en8, fun2, 500, si, platea(55)).
entrada(en9, fun2, 500, si, platea(59)).
entrada(en10, fun2, 300, no,  vip('A', si)).
entrada(en11, fun2, 700, si,  vip('F', no)).
entrada(en12, fun3, 500, si, platea(99)).
entrada(en13, fun3, 500, no,  vip('B', si)).
entrada(en14, fun3, 500, si, platea(11)).
entrada(en15, fun3, 200, si,  vip('C', si)).
entrada(en16, fun4, 500, si, platea(51)).
entrada(en17, fun4, 500, si,  vip('A', no)).
entrada(en18, fun4, 500, no, platea(1)).
entrada(en19, fun4, 200, si,  vip('F' ,si)).
entrada(en20, fun4, 500, si, platea(5)).


% palcos
palco('A', 'Primero izquierda', ['A1', 'A2', 'A3', 'A4']).
palco('B' ,'Segundo izquierda', ['B1', 'B2']).
palco('C', 'Central arriba', ['C1', 'C2', 'C3', 'C4', 'C5', 'C6']).
palco('D', 'Central abajo', []).
palco('E', 'Primero derecha', ['E1', 'E2']).
palco('F' ,'Segundo derecha', ['F1', 'F2', 'F3']).


% reglas.

% punto 1
datos_entrada(Codigo_entrada, Dia, Mes, Año, Hora_inicio, Min_inicio, Titulo, Nom_director, Ap_director ):-
    entrada(Codigo_entrada, Codigo_fun, _, _, _),
    funcion(Codigo_fun, Codigo_ob, fecha(Dia, Mes, Año), hora(Hora_inicio, Min_inicio), _),
    obra_artistica(Codigo_ob, Titulo, Cod_director, _),
    director(Cod_director, Nom_director, Ap_director, _),

    % print
    write('Fecha: '), write(Dia), write('/'), write(Mes), write('/'), write(Año), nl,
    write('Hora: '), write(Hora_inicio), write(':'), write(Min_inicio), nl,
    write('Titulo: '), write(Titulo), nl,
    write('Dirigida por: '), write(Nom_director), write(' '), write(Ap_director), nl, fail.

% punto 2
existe_entrada_vendida_butaca_entre(X, Y):-
    % elige la primer butaca con la condición "vendida" en "si" y la muestra.
    (entrada(_, _, _, si, platea(Butaca)),
    (Butaca >= X), (Butaca =< Y),
    write('La butaca '), write(Butaca), write(' está vendida'), !);

    % si no hay butacas vendidas en el rango, mostrar mensaje
    (write('No hay butacas vendidas entre esos números'), !).

% punto 3
importe_final_entrada(Codigo, Importe_final):-
    % calculo de precio para entradas de platea entre el asiento 1 y el 49
    ((entrada(Codigo, _, Importe_basico, si, platea(Butaca)),
    (Butaca >= 1, Butaca =< 49, Importe_final is Importe_basico * 1.25));

    % calculo de precio para entradas de platea entre el asiento 50 y 99
    (entrada(Codigo, _, Importe_basico, si, platea(Butaca)),
    (Butaca >= 50, Butaca =< 99, Importe_final is Importe_basico * 1.10)));

    % calculo de precio para entradas VIP con catering
    ((entrada(Codigo, _, Importe_basico, si, vip(Palco, Catering)),
    palco(Palco, _, Asientos), length(Asientos, Cantidad),
    (Catering = si, Importe_final is Importe_basico * 1.3 * Cantidad));

    % calculo de precio para entradas VIP sin catering
    ((entrada(Codigo, _, Importe_basico, si, vip(Palco, Catering)),
    palco(Palco, _, Asientos), length(Asientos, Cantidad),
    (Catering = no, Importe_final is Importe_basico * Cantidad)))).

% regla para sumar listas
sum([],0).
sum([X|Xs],S):-sum(Xs,S2),S is S2+X.

% punto 4
importe_total_funcion(Codigo_fun, Importe_total):-
    % encuentra todas las entradas de un codigo, las pone en una lista suma la lista con regla sum
    findall(Importe_final,(entrada(Codigo_ent,Codigo_fun,_,_,_), importe_final_entrada(Codigo_ent,Importe_final)),L),
    sum(L,Importe_total).

% punto 5
importe_total_recaudado_obra(Codigo_obra, Importe_total):-
    % igual a la anterior, pero esta vez sumando todas las funciones de una obra.
    findall(Importe_funcion,(obra_artistica(Codigo_obra, _, _, _), funcion(Codigo_funcion, Codigo_obra,_, _, _), importe_total_funcion(Codigo_funcion,Importe_funcion)),L),
    sum(L,Importe_total).

% punto 6
recaudacion_total_por_obra_de_director(Codigo_director, Lista_tuplas):-
    % encuentra todas las funciones de un director y devuelve tuplas con el título de cada obra y el dinero recaudado por esa obra.
    findall((Titulo_obra, Importe_obra), (obra_artistica(Codigo_obra, Titulo_obra, Codigo_director, _), importe_total_recaudado_obra(Codigo_obra, Importe_obra)), Lista_tuplas).
