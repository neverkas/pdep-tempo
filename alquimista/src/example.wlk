object alquimista {
	var itemsDeCombate = [] 
	var itemsDeRecoleccion = []
	
	method agregarItemDeCombate(unItem) {
		itemsDeCombate.add(unItem)
	}
	
	method agregarItemDeRecoleccion(unItem) {
		itemsDeRecoleccion.add(unItem)
	}
	
	method tieneCriterio() {
		return self.cantidadDeItemsDeCombateEfectivos() >= itemsDeCombate.size() / 2
	}
	
	method cantidadDeItemsDeCombateEfectivos() {
		return itemsDeCombate.count({unItem => unItem.esEfectivo()})
	}
	
	method esBuenExplorador() {
		return itemsDeRecoleccion.count({unItem => unItem.esDeDiferenteTipo()}) >= 3
	}
	
	method capacidadOfensiva() {
		return itemsDeCombate.sum({unItem => unItem.capacidad()})
	}
	
	method esProfesional() {
		return self.calidadPromedioDeItemsMayorA50() && self.todosLosItemsDeCombateSonEfectivos() && self.esBuenExplorador()
	}
	
	method calidadPromedioDeItemsMayorA50() {
		return self.calidadDeItems() / self.cantidadDeItems() > 50
	}
	
	method calidadDeItems() {
		return self.calidadDeItemsDeCombate() + self.calidadDeItemsDeRecoleccion()
	}
	
	method calidadDeItemsDeCombate() {
		return itemsDeCombate.sum({unItem => unItem.calidad()})
	}
	
	method calidadDeItemsDeRecoleccion() {
		return 30 + 0.1 * itemsDeRecoleccion.size()
	}
	
	method cantidadDeItems() {
		return itemsDeCombate.size() + itemsDeRecoleccion.size()
	}
	
	method todosLosItemsDeCombateSonEfectivos() {
		return itemsDeCombate.all({unItem => unItem.esEfectivo()})
	}
}

object bomba {
	var danio
	var materiales = []
	
	method agregarMaterial(unMaterial) {
		materiales.add(unMaterial)
	}
	
	method danio(nivelDeDanio) {
		danio = nivelDeDanio
	}
	
	method esEfectivo() {
			return danio > 100
	}
	
	method capacidad() {
		return danio / 2
	}
	
	method calidad() {
		return materiales.min({unMaterial => unMaterial.calidad()})
	}
}

object pocion {
	var poderCurativo
	var materiales = []
	
	method agregarMaterial(unMaterial) {
		materiales.add(unMaterial)
	}
	
	method poderCurativo(nivelDeCuracion) {
		poderCurativo = nivelDeCuracion
	}
	
	method esEfectivo() {
		return poderCurativo > 50 && self.tieneAlgunMaterialMistico()
	}
	
	method tieneAlgunMaterialMistico() {
		return materiales.any({unMaterial => unMaterial.esMistico()})
	}
	
	method capacidad() {
		return poderCurativo + 10 * self.cantidadDeMaterialesMisticos()
	}
	
	method cantidadDeMaterialesMisticos() {
		return materiales.count({unMaterial => unMaterial.esMistico()})
	}
	
	method calidad() {
		if (self.tieneAlgunMaterialMistico()) {
			return self.materialesMisticos().find({unMaterial => unMaterial.calidad()})
		} else {
			return materiales.find({unMaterial => unMaterial.calidad()})
		}
	}
	
	method materialesMisticos() {
		return materiales.filter({unMaterial => unMaterial.esMistico()})
	}
}

object debilitador {
	var potencia
	var materiales = []
	
	method agregarMaterial(unMaterial) {
		materiales.add(unMaterial)
	}
	
	method potencia(nivelDePotencia) {
		potencia = nivelDePotencia
	}
	
	method esEfectivo() {
		return potencia > 0 && self.noTieneNingunMaterialMistico()
	}
	
	method noTieneNingunMaterialMistico() {
		return materiales.all({unMaterial => unMaterial.esMistico().negate()})
	}
	
	method capacidad() {
		if (self.tieneAlgunMaterialMistico()) {
			return 12 * self.cantidadDeMateriales()
		} else {
			return 5
		}
	}
	
	method tieneAlgunMaterialMistico() {
		return materiales.any({unMaterial => unMaterial.esMistico()})
	}
	
	method cantidadDeMateriales() {
		return materiales.size()
	}
	
	method calidad() {
		return (self.primerMaterialDeMayorCalidad() + self.segundoMaterialDeMayorCalidad()) / 2
	}
	
	method primerMaterialDeMayorCalidad() {
		return materiales.max({unMaterial => unMaterial.calidad()})
	}
	
	method segundoMaterialDeMayorCalidad() {
		return self.segundoMaterial().calidad()
	}
	
	method segundoMaterial() {
		return (self.materialesOrdenados().get(self.cantidadDeMateriales() - 1))
	}
	
	method materialesOrdenados() {
		return materiales.sortedBy({unMaterial => unMaterial.calidad()})
	}
	
	
}