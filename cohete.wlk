class Cohete {
  var orientacion = up
  var property position = game.origin()

  method image() = "cohete" + orientacion.descripcion() + ".png"

  method initialize() {
    game.onTick(200,"cohete",{self.desplazarse()})
  }
  method desplazarse(){
    self.avanzar()
    if (self.llego())
      self.girar()
  }
  method llego() = orientacion.enElBorde(position)

  method girar() {
    orientacion = orientacion.siguiente()
  }
  method avanzar() {
    position = orientacion.adelante(position)
  }

}

class CoheteDistraido inherits Cohete {
  override method llego() = talvez.seaCierto(10) or super()
}

class CohetePausado inherits Cohete {
  var property probabilidad = 50
  override method avanzar() {
    if (talvez.seaCierto(probabilidad))
      super()
   // talvez.hace({super()},probabilidad)
  }
}

class CoheteRebotador inherits Cohete {
  override method girar() {
    orientacion = orientacion.opuesto()
 //  (1..3).anyOne().times{x=> super()}
  } 
}


class CoheteAcelerado inherits Cohete {
  override method avanzar() {
    super()
    super()
 //  (1..3).anyOne().times{x=> super()}
  } 
}


class CoheteDiagonal inherits Cohete{

  override method avanzar() {
    super()
    position = orientacion.siguiente().adelante(position)
  }

  override method llego() = super() or orientacion.siguiente().enElBorde(position)

  override method girar() {
    super()
    if (orientacion.enElBorde(position)){
      super()
      super()
    }
  }
}

object up{
  method descripcion() = "U"
  method siguiente() = right
  method opuesto() = down
  method adelante(position) = position.up(1)
  method enElBorde(position) = position.y() >= game.height()-1
}

object right{
  method descripcion() = "R"
  method siguiente() = down
  method opuesto() = left
  method adelante(position) = position.right(1)
  method enElBorde(position) = position.x() >= game.width()-1
}

object down{
  method descripcion() = "D"
  method siguiente() = left
  method opuesto() = up
  method adelante(position) = position.down(1)
  method enElBorde(position) = position.y() <= 0
}

object left{
  method descripcion() = "L"
  method siguiente() = up
  method opuesto() = right
  method adelante(position) = position.left(1)
  method enElBorde(position) = position.x() <= 0
}

object talvez {

  method seaCierto(porcentaje) = 0.randomUpTo(1)*100 < porcentaje
 
 // method hace(tarea, porcentaje) {
 //   if (self.seaCierto(porcentaje))
 //     tarea.apply()
 // }
}