import wollok.game.*
import personaje.*
object control {
    const property enemigos = [
        new Enemigo(position= game.at((0..game.width()-1).anyOne(),1)),
        new Enemigo(position= game.at((0..game.width()-1).anyOne(),3)),
        new Enemigo(position= game.at((0..game.width()-1).anyOne(),5)),
        new Enemigo(position= game.at((0..game.width()-1).anyOne(),7))
    ]

    method inicializar(){

        enemigos.forEach{ enemigo => 
            game.addVisual(enemigo)
            game.schedule(250, {
                self.cambiarDireccionDerecha(enemigo, "Evento-En-y-" + enemigo.position().y())
            })    
        }
    }

    method cambiarDireccionIzquierda(unEnemigo, eventName){
        game.onTick((250..750).anyOne(), eventName, {
            unEnemigo.moveteIquierda()
             if (self.estaEnElBordeIzquierdo(unEnemigo)){
                game.removeTickEvent(eventName)
                self.cambiarDireccionDerecha(unEnemigo, eventName) 
             }
        })
    }

    method cambiarDireccionDerecha(unEnemigo, eventName){
        game.onTick((250..750).anyOne(), eventName, {
            unEnemigo.moveteDerecha()
            if (self.estaEnElBordeDerecho(unEnemigo)){
                game.removeTickEvent(eventName)
                self.cambiarDireccionIzquierda(unEnemigo, eventName)
            }
        })
    }

    method estaEnElBordeDerecho(unEnemigo)= 
        unEnemigo.position().x() == game.width() - 1
    method estaEnElBordeIzquierdo(unEnemigo)= 
        unEnemigo.position().x() == 0
}