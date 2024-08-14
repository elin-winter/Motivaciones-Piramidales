% ----------------- Base de Conocimientos ---------------------

% ----------------- Punto 1
necesidad(respiracion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(reproduccion, fisiologico).
necesidad(integridadFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).
necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).
necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).
necesidad(proposito, autorrealizacion).
necesidad(papasFritas, autorrealizacion).
necesidad(buenaAlmohada, divino).
necesidad(vacaciones, divino).

nivelSuperior(divino, autorrealizacion).
nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).

% ----------------- Punto 2

cantNiveles(Necesidad1, Necesidad2, Cantidad):-
    necesidad(Necesidad1, Nivel1),
    necesidad(Necesidad2, Nivel2),
    cantSeparacion(Nivel1, Nivel2, Cantidad).

cantSeparacion(N, N, 0).
cantSeparacion(MenorNivel, MayorNivel, Cant):-
    nivelSuperior(MayorNivel, Intermedio),
    cantSeparacion(MenorNivel, Intermedio, CantIntermedio),
    Cant is CantIntermedio + 1.

% ----------------- Punto 3

tieneNecesidad(carla, alimentacion).
tieneNecesidad(carla, descanso).
tieneNecesidad(carla, empleo).
tieneNecesidad(juan, afecto).
tieneNecesidad(juan, exito).
tieneNecesidad(camila, alimentacion).
tieneNecesidad(camila, descanso).
tieneNecesidad(roberto, amistad).
tieneNecesidad(manuel, libertad).
tieneNecesidad(charly, afecto).

% ----------------- Punto 4

necesidadMayorJerarquia(Persona, Max):-
    tieneNecesidad(Persona, Max),
    not((tieneNecesidad(Persona, Otra), 
        mayorNivel(Otra, Max))).

mayorNivel(Max,Menor):-
    cantNiveles(Menor, Max, Cant),
    Cant > 0.

% ----------------- Punto 5
completoNivel(Persona, Nivel):-
    not(tieneNecesidad(Persona, _)),
    Nivel = divino.

completoNivel(Persona, Nivel):-
    necesidad(_, Nivel),
    tieneNecesidad(Persona, NMin),
    necesidad(NMin, NivelMin),
    not(cantSeparacion(NivelMin, Nivel, _)).

% ----------------- Punto 6

teoriaCiertaParticular(Persona):-
    tieneNecesidad(Persona, Necesidad),
    forall(tieneNecesidad(Persona, OtraNecesidad), mismoNivel(Necesidad, OtraNecesidad)).

mismoNivel(Necesidad1, Necesidad2):-
    cantNiveles(Necesidad1, Necesidad2, 0).

teoriaCiertaTodos:-
    forall(tieneNecesidad(Persona, _), teoriaCiertaParticular(Persona)).

teoriaCiertaMayoria:-
    findall(Persona, 
        (tieneNecesidad(Persona, _), teoriaCiertaParticular(Persona)),
        PersonasCiertas),
    findall(Persona, 
        not((tieneNecesidad(Persona, _), teoriaCiertaParticular(Persona))), 
        PersonasFalso),
    
    length(PersonasCiertas, CantPersonasCiertas),
    length(PersonasFalso, CantPersonasFalso),
    CantPersonasCiertas > CantPersonasFalso.

% ----------------- Punto 7
% ????
