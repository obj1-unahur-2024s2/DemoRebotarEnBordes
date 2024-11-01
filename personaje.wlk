
import controlJuego.controlDeMovimientos;
class Enemigo {
    const property image = "enemigo.png"
    const property movimiento = controlDeMovimientos
    var property position 
}

object toni {
    var vidas = 3
    const property image = "toni.png"
    const property movimiento = controlDeMovimientos
    var property position = controlDeMovimientos.defaultPosition() 
    method descontarVida(){
        vidas -= 1
    }
    method vidas()= vidas
    method aunEstoyVivo() = vidas > 0

}