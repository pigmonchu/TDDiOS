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

Dejo sólo el test `testTenDollarsNotEqualTenEuros()` en rojo ya que es indicativo de que se necesita un UnityBroker y prefiero no hacer todas esas modificaciones sin dejar rastro.

## Commit 16: Simple tests del ejercicio en Verde

El test de igualdad de Wad del ejercicio con cambio 1:1 y los de simpleAdd y simpleMultiplication están en verde, sin embargo mi test de desigualdad 10EUR vs 10USD sigue en rojo. Dado que las sumas y multiplicaciones ya las pasa (aunque sea de chiripa) me queda trabajar los cambios reales y UnityBroker (que no me queda muy claro como usar)

## Commit 17 y siguientes: UnityBroker

Le he estado dando vueltas a UnityBroker y qué papel juega y como no me queda muy claro voy a ver que sale. Mi problema es la igualdad de fajos. Los billetes están claros, cualesquiera billetes cuyas unidades fraccionarias y divisa coincidan, son iguales. Esto implica que 10USD es distinto de 5EUR aún cuando el tipo de cambio sea 2USD:1EUR. Es algo así como los billetes en un monedero: tener un billete de 10USD en Estados Unidos no es lo mismo que tener un billete de 5EUR (este último es una curiosidad o un problema, pero no sirve para pagar nada).

Con el tema de los fajos (Wad) la cosa cambia. Dado que permitimos que un fajo contenga billetes de diferentes divisas y que estamos creando un sistema _Forex_, su valor debe determinarse convirtiéndolas todas ellas en una unidad. A esta unidad le voy a llamar patrón y la va a fijar UnityBroker.

Esto me lleva a otra cosa, yo puedo crear un billete de 30 Monopolys y no debería pasar nada, pero de cara a los Wads, debería permitirme incluirlos pero que no afectara al valor final del fajo, es decir, si una unidad no es reconocida por UnityBroker su valor en un Wad es 0 unidades patron.

En definitiva UnityBroker tiene las funciones de determinar 

1. Que billetes son _legales_
2. 	El tipo de cambio entre ellos

Como son dos funciones prefiero crear dos objetos. Uno que será la autoridad de cambio `ChangeAuthority` y otro que será realmente el broker de conversión a divisa patrón `UnityBroker`.

Además UnityBroker debiera formar parte de Wad, es decir, Wad debería estar compuesto de Bills y tener un UnityBroker. Entiendo que este UnityBroker debiera ser estático (el mismo para todas las instancias), que iría informando las distintas divisas alimentandose del ChangeAuthority.

Las tareas para pasar el test 10EUR != 10USD son entonces:

- Creación de un protocolo `Rater` (Ya está hecho)
- Creación de un objeto ChangeAuthority, aquí como un Mock que sustituya la consulta real
- Creación de un objeto UnityBroker e integración el Wad de forma estática. A la hora de calcular HashValue de Wad UnityBroker determinará el número total de unidad fraccionaria de la divisa patrón. Si no conoce la unidad a convertir la pedirá a ChangeAuthority, y si es desconocida su valor será nulo.

## Commit 22

Como quiero reducir la funcionalidad de la autoridad de cambio al mínimo pero participa del protocolo Rater, provoco el error si se invoca `rate(from: to:)`

## Commit 23

Cambio el tesd de igualdad de Wad para el nuevo tipo de cambio determinado por AuthorityChange. Ahora deben pasar esos dos test el de igualdad y el de desigualdad entre 10EUR y 10USD.

Finalmente la solución que he encontrado para que pase esos dos tests es transformar AuthorityChange en un protocolo, forzar que Money no pida Broker para la funcion reduced sino cualquier objeto que cumpla el protocolo Rater. Así ahora UnityBroker cumplirá ambos protocolos Rater (servirá para cambios en protocolo Money) y ChangeAuthority (establece los tipos de cambio). Tengo la sensación de que me he complicado la vida, pero no se me ocurre de otra forma.

Esto ha llevado a reescribir todos los tests de BrokerUnity... Y aquí es donde creo que no he hecho TDD, para poder convertir entre divisas el código que se me ha ocurrido ha implicado cambios profundos y al final he tenido que cambiar 4 tests que pasaba para un objeto que ya no existe. No sé si los tests han dirigido el desarrollo, o el diseño de mi cabeza ha dirigido los test...¿?

# Conclusión y entrega
La faena ahora sería pensar como utilizar Interactors y managers para poder incluir una api de tasas de intercambio (por ejemplo http://fixer.io/). Y después construir una app con su pantalla y botones para que se pueda utilizar desde el móvil. Pero esto es más bien una tarea SOME DAY MAYBE