import wollok.game.*

object enemigo {
    const property image = "enemigo"
    var property position = game.origin()

    method moveteDerecha() {
        position = position.right(1)
    }

    method moveteIquierda() {
        position = position.left(1)
    }

    method estoyBordeDerecho()= position.x() == game.width() - 1
    method estoyBordeIzquierdo()= position.x() == 0


}