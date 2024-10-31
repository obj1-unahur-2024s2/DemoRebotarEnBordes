import wollok.game.*
import personaje.*
object control {
    method cambiarDireccionIzquierda(unEnemigo){
        game.onTick(500, "izquierda", {
            unEnemigo.moveteIquierda()
             if (unEnemigo.estoyBordeIzquierdo()){
                game.removeTickEvent("izquierda")
                self.cambiarDireccionDerecha(unEnemigo)
             }
        })
    }

    method cambiarDireccionDerecha(unEnemigo){
        game.onTick(500, "derecha", {
            unEnemigo.moveteDerecha()
            if (unEnemigo.estoyBordeDerecho()){
                game.removeTickEvent("derecha")
                self.cambiarDireccionIzquierda(unEnemigo)
            }
        })
    }
}