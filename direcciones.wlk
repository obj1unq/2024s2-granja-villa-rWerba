import wollok.game.*

object derecha {
    method siguiente(direccion) {
        return direccion.right(1)
    }
}

object izquierda {
    method siguiente(direccion) {
        return direccion.left(1)
    }
}

object arriba {
    method siguiente(direccion) {
        return direccion.up(1)
    }
}

object abajo {
    method siguiente(direccion) {
        return direccion.down(1)
    }
}

object tablero {
    method validarDentro(position) {
        if (not self.estaDentro(position)){
            self.error("¡Se terminó el tablero!")
        }
    }

    method estaDentro(position) {
        return position.x().between(0, game.width() -1) and position.y().between(0, game.height() -1)
    }
}