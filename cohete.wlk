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

class CohetePausado inherits Cohete {
  var property probabilidad = 50
  override method avanzar() {
    if (talvez.seaCierto(probabilidad))
      super()
   // talvez.hace({super()},probabilidad)
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



/*
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






*/
object talvez {

  method seaCierto(porcentaje) = 0.randomUpTo(1)*100 < porcentaje
 
 // method hace(tarea, porcentaje) {
 //   if (self.seaCierto(porcentaje))
 //     tarea.apply()
 // }
}