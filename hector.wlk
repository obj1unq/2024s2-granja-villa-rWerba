import aspersores_mercados.*
import wollok.game.*
import direcciones.*
import cultivos.*
import granja.*



object hector {
	var property position = game.at(3,3)
	const property image = "player.png"
	const property plantasParaVenta = #{}
	var property plataEnLaBilletera = 0
	var property mercadoActual = null

	


	method mover(direccion) {
		const siguiente = direccion.siguiente(self.position())
		tablero.validarDentro(siguiente)
		position = direccion.siguiente(position)
	}

	method verificarTablero() {
		
	}

	method sembrarMaiz() {
		self.verificarEspacio(position)
		const maiz = new Maiz(position = position)
		granja.agregarPlanta(maiz)
		game.addVisual(maiz)
	}

	method sembrarTrigo() {
		self.verificarEspacio(position)
	 	const trigo = new Trigo(position = position)
		granja.agregarPlanta(trigo)
		game.addVisual(trigo)
	}

	method sembrarTomaco() {
		self.verificarEspacio(position)
		const tomaco = new Tomaco(position = position)
		granja.agregarPlanta(tomaco)
		game.addVisual(tomaco)
	}

	method verificarEspacio(_position) {
		//pongo >= ya que hector cuenta como un objeto + el potencial objeto que haya en el espacio
		if (game.getObjectsIn(_position).size() >= 2 ){
			self.error("¡Ya hay algo aqui!")
		}
	}

	method regar(_position) {
		self.verificarRegar(_position)
		self.regarAca(_position)
	}

	method regarAca(_position) {
		self.plantaAca(_position).crecer()	
	}

	method plantaAca(_position) {
		return granja.plantaEn(_position).uniqueElement()
	}
	
	method verificarRegar(_position) {
		if (not self.hayPlantasEn(_position)){
			self.error("No hay nada para regar!")
		}
	}	

	method hayPlantasEn(_position) {
		return not granja.plantaEn(_position).isEmpty()
	}

	method cosechar(_position) {
		self.verificarCosechar(_position)
		self.cosecharAca(_position)
	}

	method verificarCosechar(_position) {
		if (not self.hayPlantasEn(_position)){
			self.error("No hay nada para cosechar!")
		}
	}

	method cosecharAca(_position) {
		self.agregarParaVender(self.plantaAca(_position))
		self.plantaAca(_position).cosechar(_position)
	}

	method agregarParaVender(planta) {
		plantasParaVenta.add(planta)
	}

	method venderPlantas() {
		self.verificarMercado(self.position())
		mercadoActual = granja.mercadoEn(self.position()).uniqueElement()
		mercadoActual.verificarFondos()
		plataEnLaBilletera = self.plataPorVender()
		self.cobrar(self.plataPorVender())
		plantasParaVenta.clear()
	}

	//metodo hecho para test
	method vender() {
	    plataEnLaBilletera = self.plataPorVender()
		self.cobrar(self.plataPorVender())
		plantasParaVenta.clear()
	}

	method plataPorVender() {
	  return plantasParaVenta.sum({planta => planta.monedasQueOtorga()})
	}

	method cobrar(monto) {
		plataEnLaBilletera += monto
	}

	method verificarMercado(_position) {
		if (not granja.hayMercadoEn(_position)){
			self.error("Solo puedo vender en un mercado!")
		}
	}

	method decirInformacion() {
		game.say(self, "Tengo $" + plataEnLaBilletera + ". Tambien tengo las siguientes plantas: " + plantasParaVenta)
	}

	method ponerAspersor() {
		self.verificarEspacio(position)
		const aspersor = new Aspersor(position = position)
		game.onTick(1000, "regar_" + self.identity(), {aspersor.regar()})
		granja.agregarAspersor(aspersor)
		game.addVisual(aspersor)
	}
	
}