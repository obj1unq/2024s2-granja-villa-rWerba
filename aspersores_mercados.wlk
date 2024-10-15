import cultivos.*
import direcciones.*
import wollok.game.*
import granja.*
import hector.*



class Aspersor{
    const property position = null
    const plantasEnParcela = #{}
    
    //solo lo agrega si hay, si no necesito que no haga nada
    method agregarAParcelaSiHay(_position) {
        if (not granja.plantaEn(_position).isEmpty()){
            plantasEnParcela.add(granja.plantaEn(_position).uniqueElement())
        } 
    }

    
    method image() {
        return "aspersor.png"
    }
    
    method regar() {
       self.definirParcela()
       self.regarParcela()
    }

    method definirParcela() {
        self.actualizarParcela()
        self.setearParcela()
    }

    //Perdon al que tenga que leer esto, se que esta horrible
    // :-(
    method setearParcela() {
        self.agregarAParcelaSiHay(game.at(izquierda.siguiente(self.position()).x(), arriba.siguiente(self.position()).y()))
        self.agregarAParcelaSiHay(game.at(self.position().x(), arriba.siguiente(self.position()).y()))
        self.agregarAParcelaSiHay(game.at(derecha.siguiente(self.position()).x(), arriba.siguiente(self.position()).y()))
        self.agregarAParcelaSiHay(game.at(izquierda.siguiente(self.position()).x(), self.position().y()))
        self.agregarAParcelaSiHay(game.at(derecha.siguiente(self.position()).x(), self.position().y()))
        self.agregarAParcelaSiHay(game.at(izquierda.siguiente(self.position()).x(), abajo.siguiente(self.position()).y()))
        self.agregarAParcelaSiHay(game.at(abajo.siguiente(self.position()).x(), self.position().y()))
        self.agregarAParcelaSiHay(game.at(derecha.siguiente(self.position()).x(), abajo.siguiente(self.position()).y()))
    }

    method actualizarParcela() {
        plantasEnParcela.clear()
    }

    method regarParcela() {
        plantasEnParcela.forEach({planta => planta.crecer()})
    }
}

class Mercado {

    const property position = null
    var property monedas = null
    const property mercaderia = #{}    

    method agregarMercaderia(set) {
    mercaderia.addAll(set)
    }

    method verificarFondos() {
        if (hector.plataPorVender() > monedas){
            self.error("No hay fondos para comprar todo")
        }
    }

    method pagarMonto(set) {
        self.descontarFondos(hector.plataPorVender())
    }

    method descontarFondos(cantidad) {
        monedas -= cantidad
    }

    method realizarTransaccion(set) {
        self.agregarMercaderia(set)
        self.pagarMonto(set)
        hector.cobrar(hector.plataPorVender())
    }

    method image() {
        return "market.png"
    }
  
}