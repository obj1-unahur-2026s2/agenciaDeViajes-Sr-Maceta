class Pack {
    const duracion //Numero
    const precio //Numero
    const beneficios //Lista
    const coordinador //Objeto

    method coordinador() = coordinador
    method duracion() = duracion
    method precio() = precio
    method beneficios() = beneficios
    method todoslosBeneficiosVigentes() = 
        self.beneficios().filter({b => b.estaVigente()})
    method costoDeTodosLosBeneficiosVigentes() = 
        self.todoslosBeneficiosVigentes().sum({b => b.costo()})
    method valorFinal() = 
        self.precio() + self.costoDeTodosLosBeneficiosVigentes()
    method esPremium()
}

class PackNacional inherits Pack {
    const provinciaDestino //string
    const actividades //Lista

    method provinciaDestino() = provinciaDestino
    method actividades() = actividades

    override method esPremium() = 
        self.duracion() > 10 &&
        self.elCoordinadorEsAltamenteCalificado(self.coordinador())

    method elCoordinadorEsAltamenteCalificado(unCoordinador) =  
        unCoordinador.esAltamenteCalificado()
}

class PackProvincial inherits PackNacional {
    const cantidadDeCiudadesAVisitar //Numero
    
    method cantidadDeCiudadesAVisitar() = cantidadDeCiudadesAVisitar
    override method esPremium() = 
        self.actividades().size() >= 4 &&
        self.cantidadDeCiudadesAVisitar() > 5 &&
        self.beneficios().size() >= 3
    
    override method valorFinal() {
        if(self.esPremium()){
            return super() + super()*0.05
        }else{
            return super()
        }
    } 
}

class PackInternacional inherits Pack {
    const paisDestino //string
    const cantidadDeEscalas //Numero
    const esLugarDeInteres //Booleano

    method paisDestino() = paisDestino
    method esLugarDeInteres() = esLugarDeInteres
    method cantidadDeEscalas() = cantidadDeEscalas

    override method valorFinal() =
        super() + super()*0.2

    override method esPremium() = 
        self.esLugarDeInteres() &&
        self.duracion() > 20 &&
        self.cantidadDeEscalas() == 0
}

class Coordinador {
    const cantidadDeViajesRealizados //Numero
    const añosDeExperiencia //Numero
    const estaMotivado //Booleano
    var rol //String

    method añosDeExperiencia() = añosDeExperiencia
    method cantidadDeViajesRealizados() = 
        cantidadDeViajesRealizados
    method estaMotivado() = estaMotivado
    method rol() = rol       
    method cambiarRol(nuevoRol) {
        if( nuevoRol == "Guia" ||
            nuevoRol == "Asistente Logistico" ||
            nuevoRol == "Acompañante"){
            rol = nuevoRol
        } else{
            self.error("Rol no permitido")
        }
    }
    method esAltamenteCalificado(){
        if(self.rol() == "Guia"){
            return self.estaMotivado() && 
            self.cantidadDeViajesRealizados() > 20
        }else if(self.rol() == "Asistente Logistico"){
            return self.añosDeExperiencia() == 3 &&
            self.cantidadDeViajesRealizados() > 20
        } else{
            return self.cantidadDeViajesRealizados() > 20
        }
    }
}

class Beneficio {
    const tipo //string
    const costo //Numero
    const estaVigente //Booleano

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente
}