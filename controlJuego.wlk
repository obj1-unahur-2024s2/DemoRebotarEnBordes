import wollok.game.*
import personaje.*
object control {

    method inicializar(){
        controlTeclado.inicializar(toni)
        toni.position(controlDeMovimientos.defaultPosition())
        game.addVisual(toni)
        
        (1..game.height()-2).forEach{ value => 
            game.schedule(value * 1000, {
                const enemigo = new Enemigo(position= game.at((0..game.width()-1).anyOne(),value))
                controlDeColisiones.inicializar(enemigo)
                
                if(0.randomUpTo(1) <= 0.5) self.cambiarDireccionDerecha(enemigo, "Evento-" + value)
                else self.cambiarDireccionIzquierda(enemigo, "Evento-" + value)
                game.addVisual(enemigo)
            })    
        }
    }

    method cambiarDireccionIzquierda(unEnemigo, eventName){
        game.onTick((250..500).anyOne(), eventName, {
            controlDeMovimientos.moveteIzquierda(unEnemigo)
             if (self.estaEnElBordeIzquierdo(unEnemigo)){
                game.removeTickEvent(eventName)
                self.cambiarDireccionDerecha(unEnemigo, eventName) 
             }
        })
    }

    method cambiarDireccionDerecha(unEnemigo, eventName){
        game.onTick((250..500).anyOne(), eventName, {
            controlDeMovimientos.moveteDerecha(unEnemigo)
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

object controlDeMovimientos {
    method defaultPosition() {
        return game.at((game.width() -1) / 2, 0)
    }
    method moveteDerecha(unVisual) {
            unVisual.position(unVisual.position().right(1))
    }
    method moveteIzquierda(unVisual) {
        unVisual.position(unVisual.position().left(1))
    }
    method moveteArriba(unVisual){
        unVisual.position(unVisual.position().up(1))
    }
    method moveteAbajo(unVisual){
        unVisual.position(unVisual.position().down(1))
    }
}

object controlTeclado {
    method inicializar(personajeActivo) {
        keyboard.up().onPressDo {
            controlDeMovimientos.moveteArriba(personajeActivo)
        }
        keyboard.down().onPressDo {
            controlDeMovimientos.moveteAbajo(personajeActivo)
        }
        keyboard.left().onPressDo {
            controlDeMovimientos.moveteIzquierda(personajeActivo)
        }
        keyboard.right().onPressDo {
            controlDeMovimientos.moveteDerecha(personajeActivo)
        }
    }
}

object controlDeColisiones {
    method inicializar(enemigo){
        game.onCollideDo(enemigo, {
            personaje => personaje.descontarVida()
            personaje.position(controlDeMovimientos.defaultPosition())
            }
        )       
    }

}