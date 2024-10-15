import hector.*
import cultivos.*
import wollok.game.*
import direcciones.*
import aspersores_mercados.*





//No hago una clase porque vamos a usar una grana unica
object granja {
    const property plantas = #{}
    const property aspersores = #{}
    const property mercados = #{}


    method agregarPlanta(planta) {
        plantas.add(planta)
    }

    method agregarAspersor(aspersor) {
        aspersores.add(aspersor)
    }

    method quitarPlanta(planta) {
        plantas.remove(planta)
    }

    method plantaEn(posicion) {
        return plantas.filter({ planta => planta.position() == posicion })
    }

    method validarPlantaDir(dir) {
        if (not self.estaLibre(dir)){
            hector.error("No se puede regar un tomaco cuando arriba hay otra planta!")
        }
    }

    method estaLibre(dir) {
        return game.getObjectsIn(dir).size() == 0
    }
  
    method agregarMercado(mercado) {
        mercados.add(mercado)
    }

    method agregarMercaderia(setProductos) {
        mercados.agregarMercaderia(setProductos).addAll()
    }

    method hayMercadoEn(_position) {
        return not self.mercadoEn(_position).isEmpty()
    }

    method mercadoEn(posicion ) {
        return mercados.filter({ mercado => mercado.position() == posicion})
    }
}