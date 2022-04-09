# Practica 1 de Arduino

Autores: Juan Carlos Alcalde Díaz y Pablo Morales Gómez

Asignatura: Creando Interfaces de Usuario

Curso: 4º


## Introducción

En esta práctica hemos creado un sencillo código que nos permite, usando para ello una función senoidal, variar la frecuencia de parpadeo de un led de la **placa de Arduino Uno**. Esta oscilará (al igual que la función) entre una frecuencia mínima y máxima que se podrán definir al comienzo del código.


## Desarrollo

Para crear el parpadeo hacemos uso de la función *delay*, esta mantendrá la luz encendida la mitad del tiempo que indica la variable *freq* del programa y apagada la mitad restante. Para el cálculo de *freq* empleamos la función *millis*, que nos devuelve el tiempo transcurrido desde el comienzo de la ejecución de la aplicación, cuyo valor retornado es transformado a segundos he introducido dentro de una función seno.

En esta función dividimos el valor entre 2 para aumentar el periodo de la onda y de esta forma que las modificaciones de la frecuencia se produzcan con menor brusquedad. El valor devuelto es trasladado para que se encuentre entre 0 y 1, consiguiendo así poder ajustarlo con facilidad entre la frecuencia máxima y mínima previamente definida.
