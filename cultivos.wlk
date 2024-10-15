import wollok.game.*
import hector.*
import direcciones.*
import granja.*



//MAIZ
class Maiz {
	var property estado = maizBebe
	const property position = null
	const precio = 150
	
	method crecer() {
		estado = maizAdulto
	}

	method cosechar(_position) {
		self.verificarCosecha()
		self.cosecharAca(_position)
	}

	method cosecharAca(_position) {
		game.removeVisual(self.plantaAca(_position))
		granja.quitarPlanta(self.plantaAca(_position))
	}

	method plantaAca(_position) {
		return granja.plantaEn(_position).uniqueElement()
	}

	method verificarCosecha() {
		if (not self.esAdulto()){
			self.error("A este maiz le falta crecer!")
		}
	}

	method esAdulto() {
		return estado == maizAdulto
	}

	method image() {
		return estado.image()
	}

	method monedasQueOtorga() {
		return precio
	}
}

object maizBebe {

	method image() {
		return "corn_baby.png"
	}
  
}

object maizAdulto {

	method image() {
		return "corn_adult.png"
	}
}


//TRIGO
class Trigo {

	const property position = null
	var property etapaEvolucion = 0



	method cosechar(_position) {
		self.verificarCosecha()
		self.cosecharAca(_position)
	}

	method cosecharAca(_position) {
		game.removeVisual(self.plantaAca(_position))
		granja.quitarPlanta(self.plantaAca(_position))
	}

	method plantaAca(_position) {
		return granja.plantaEn(_position).uniqueElement()
	}

	method verificarCosecha() {
		if (etapaEvolucion < 2 ){
			self.error("A este trigo le falta crecer!")
		}
	}

	method crecer() {
		self.verificarEtapa()
		etapaEvolucion += 1
	}

	method verificarEtapa() {
		if (etapaEvolucion == 3){
			//-1 para que al sumaerle 1 vuelva a 0
			etapaEvolucion = -1
		}
	}

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_" + etapaEvolucion + ".png"
	}

	method monedasQueOtorga() {
		return (etapaEvolucion - 1) * 100
	}
	
}


//TOMACO
class Tomaco {

	var property position = null
	var property estado = tomacoBaby
	const precio = 80


	method cosechar(_position) {
		self.cosecharAca(_position)
	}

	method cosecharAca(_position) {
		game.removeVisual(self.plantaAca(_position))
		granja.quitarPlanta(self.plantaAca(_position))
	}

	method plantaAca(_position) {
		return granja.plantaEn(_position).uniqueElement()
	}


	method crecer() {
		const siguiente = arriba.siguiente(self.position())
		//si llega arriba no hace nada
		tablero.validarDentro(siguiente)
		granja.validarPlantaDir(siguiente)
		estado = tomacoAdulto
		position = arriba.siguiente(position)
		
	}

	method image() {
		return estado.image()
	}

	method monedasQueOtorga() {
		return precio
	}
}

object tomacoBaby {
	method image() {
		return "tomaco_baby.png"
	}
}

object tomacoAdulto {
	method image() {
		return "tomaco.png"
	}
}