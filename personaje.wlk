import wollok.game.*

class Enemigo {
    const property image = "enemigo"
    var property position 

    method moveteDerecha() {
        position = position.right(1)
    }

    method moveteIquierda() {
        position = position.left(1)
    }


}