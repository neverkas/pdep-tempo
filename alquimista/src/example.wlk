object alquimista {
	var itemsDeCombate = [bomba,pocion] 
	var itemsDeRecoleccion = []
	
	method tieneCriterio() {
		return itemsDeCombate.filter({item=>item.esEfectivo()}).size() >= (itemsDeCombate.size() / 2)
	}
 	
 	method esBuenExplorador() {
 		return itemsDeRecoleccion.asSet().size() > 3
 	}
 	
	method agregarItemDeCombate(unItem) {
		itemsDeCombate.add(unItem)
	}
	
	method agregarItemDeRecoleccion(unItem) {
		itemsDeRecoleccion.add(unItem)
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
	
	method itemsDeCombate() {
		return itemsDeCombate
	}
	
	method itemsDeRecoleccion(){
		return itemsDeRecoleccion
	}
}

object bomba {
	var danio = 200
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
	var poderCurativo = 20
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
	var potencia = 10
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