# Practica TDD iOS. IV Bootcamp Mobile KC

## Commit 14: Tests Wad Verdes de chiripa y refactorización Wad. Faltan dos tests

El paso a verde de todos los test de Wad me ha llevado a muchos cambios que no he ido reflejando en diferentes push. Los reflejo aquí:

### Tests de creación de Wad

- testCanCreateWad() -> Banal

### Tests de igualdad

Son cuatro. Mantengo la filosofía original de que dos fajos (Wads) con igual hashValue son iguales. En Bill eso ha cambiado ya que la igualdad ahora icluye también su divisa. Para pasar a verde de chiripa en Wad vuelvo a la consideración original de que hashValue es el número de centimos de euros totales del fajo. Dos fajos son iguales si sus valores en centimos de euro son iguales.

Algunos de estos tests dependen de los tests de multiplicación. Ver más abajo.

Los test propias del Hash los pasó directamente.

### Tests de multiplicacion

Son dos. Para que los pase hice una primera versión de times con un bucle for y, a raíz de la idea de usar un reduce de la práctica, he terminado refactorizando a un map

### Tests de sumas
Empezó como un bucle for, pero no me hizo falta refactorizarlo ni a map, ni a reduce. Dado que la igualdad depende del hash (número de céntimos de euro) basta con hacer un merge de los arrays de self y sum y dar un nuevo Wad.

No obstante esto me llevó a refactorizar el for del HashValue a un reduce.

**A falta de dos tests a verde, hice el primer commit de tests verdes de chiripa**

## Commit 15: Tests verdes de chiripa.

Dejo sólo el test `testTenDollarsNotEqualTenEuros()` en rojo ya que es indicativo de que se necesita un BrokerUnity y prefiero no hacer todas esas modificaciones sin dejar rastro.



