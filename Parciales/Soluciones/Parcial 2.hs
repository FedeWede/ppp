
---------------funcion1--------------------
funcion1 codigo
	|codigo == "sal1" = 50
	|codigo == "sal2" = 40
	|codigo == "sal3" = 30
	|codigo == "sal4" = 40
	|otherwise = 0

--------------funcion2---------------------
funcion2 [] _ = []
funcion2 (x:xs) tarifa = ((funcion1 x) * tarifa) : (funcion2 xs tarifa)

--------------funcion3---------------------
funcion3 [] _ = 0
funcion3 (x:xs) num = if ((funcion1 x) >= num) then 1 + (funcion3 xs num) else (funcion3 xs num)


-suerte profe :D