--------------Trabajo Practico 2------------


----------1-------------------


crecimientoPorAnio:: Integer -> Integer
crecimientoPorAnio x
	|0<x&& x<12=24-2*x
	|x==12=1
	|x>12=0
	|otherwise = error "edad invalida"


-----------2---------------


crecimientoEntre:: Integer -> Integer -> Integer
crecimientoEntre x y 
	|x==y = crecimientoPorAnio x
	|x<y = crecimientoEntre (x+1) y + crecimientoPorAnio x
	|x>y = error "La edad actual es mayor que la edad futura"


------------3----------------


alturasEnUnAnio:: Integer -> [Integer] -> [Integer]
alturasEnUnAnio edad [] = [] 
alturasEnUnAnio edad (x:xs) = (x + crecimientoPorAnio edad):(alturasEnUnAnio edad xs)


-----------4------------------


alturaEnEdades:: Integer -> Integer -> [Integer]-> [Integer]
alturaEnEdades altura edadAhora [] = []
alturaEnEdades altura edadAhora (x:xs) = if x == edadAhora then (altura):(alturaEnEdades altura edadAhora xs) else (altura + crecimientoEntre edadAhora x):(alturaEnEdades altura edadAhora xs)


------------5------------------


alturasPara:: [(Integer,Integer)]->[Integer] -> [Integer]
alturasPara [] [] = []
alturasPara ((edad, altura):xs) (y:ys) 
	|length xs == length ys = (altura + (crecimientoEntre edad (edad+y))):(alturasPara xs ys)
	|otherwise = error "Formato incorrecto"
