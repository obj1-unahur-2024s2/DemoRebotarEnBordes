object juegoCohetes{

  method iniciar(){
	  game.addVisual(new Cohete())

//  Comentar para ir probando los diferentes Cohetes individualmente
    game.addVisual(new CoheteDistraido())
    game.addVisual(new CohetePausado())
    game.addVisual(new CohetePausado(probabilidad = 90))
    game.addVisual(new CohetePausado(probabilidad = 25))

    game.addVisual(new CoheteAcelerado())
    game.addVisual(new CoheteDiagonal())
    game.addVisual(new CoheteRebotador(position = game.at(5,1)))
    game.addVisual(new CoheteRebotador(position = game.at(1,5),orientacion = right))
  }
}

class Cohete {
  var orientacion = up
  var property position = game.origin()

  method image() = "cohete" + orientacion.descripcion() + ".png"

  method initialize() {
    game.onTick(200,"cohete",{self.desplazarse()})
  }

  method desplazarse() {
    self.avanzar()
    if(self.llego())
       self.girar()
  }

  method avanzar() {
    position = orientacion.adelante(position)
   /* if (orientacion == "U")
      position = position.up(1)
    if (orientacion == "D")
      position = position.down(1)
    if (orientacion == "R")
      position = position.right(1)
    if (orientacion == "L")
      position = position.left(1)*/
  }
  method llego() =
      orientacion.enElBorde(position) 
  //  (position.y() == game.height()-1 and orientacion == "U") or
  //  (position.x() == game.width()-1 and orientacion == "R")
    // falta bajo y izq
  
  method girar() {
    orientacion = orientacion.siguiente()
  /*  if (orientacion == "U")
      orientacion = "R"
    else 
      if (orientacion == "R")
        orientacion = "D"
      */
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

class CoheteDistraido inherits Cohete {
  override method llego() = talvez.seaCierto(10) or super()
}

class CoheteAcelerado inherits Cohete {
  override method avanzar() {
    super()
    super()
  } 
}

class CoheteRebotador inherits Cohete {
  override method girar() {
    orientacion = orientacion.opuesto()
  }
}


class CohetePausado inherits Cohete {
  var property probabilidad = 50
  override method avanzar() {
    if (talvez.seaCierto(probabilidad))
      super()
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

object talvez {
  method seaCierto(porcentaje) = 0.randomUpTo(1)*100 < porcentaje
}