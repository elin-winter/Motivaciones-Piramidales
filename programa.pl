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

cantSeparacion(Nivel1, Nivel2, Cantidad):-
    nivelSuperior(Nivel1, Nivel2), 
    Cantidad is 1.

cantSeparacion(Nivel1, Nivel2, Cantidad):-
    nivelSuperior(Nivel2, Nivel1), 
    Cantidad is 1.

cantSeparacion(Nivel1, Nivel2, Cantidad):-
    nivelSuperior(Nivel1, NivelIntermedio),
    cantSeparacion(NivelIntermedio, Nivel2, CantidadIntermedio),
    Cantidad is CantidadIntermedio + 1.

cantSeparacion(Nivel1, Nivel2, Cantidad):-
    nivelSuperior(Nivel2, NivelIntermedio),
    cantSeparacion(Nivel1, NivelIntermedio, CantidadIntermedio),
    Cantidad is CantidadIntermedio + 1.

% ----------------- Punto 3

tieneNecesidad(carla, alimentacion).
tieneNecesidad(carla, descanso).
tieneNecesidad(carla, empleo).
tieneNecesidad(juan, afecto).
tieneNecesidad(juan, exito).
tieneNecesidad(roberto, amistad).
tieneNecesidad(charly, salud).

% ----------------- Punto 4
necesidadMayorJerarquia(Persona, NecesidadMayor):-
    tieneNecesidad(Persona, _),
    findall(Necesidad, tieneNecesidad(Persona, Necesidad), Necesidades),
    findall(Cantidad, (member(Necesidad, Necesidades), cantNiveles(Necesidad, _, Cantidad)), Cantidades),
    max_list(Cantidades, MaxCantidad),
    member(NecesidadMayor, Necesidades),
    cantNiveles(NecesidadMayor, _, MaxCantidad).

% ----------------- Punto 5
completoNivel(Persona, Nivel):-
    not(tieneNecesidad(Persona, _)),
    Nivel = divino.

completoNivel(Persona, Nivel):-
    tieneNecesidad(Persona, _),
    necesidadMenorJerarquia(Persona, NecesidadMenor),
    necesidad(NecesidadMenor, NivelSuperior),
    nivelSuperior(NivelSuperior, Nivel).

necesidadMenorJerarquia(Persona, NecesidadMenor):-
    tieneNecesidad(Persona, _),
    findall(Necesidad, tieneNecesidad(Persona, Necesidad), Necesidades),
    findall(Cantidad, (member(Necesidad, Necesidades), cantNiveles(Necesidad, _, Cantidad)), Cantidades),
    min_list(Cantidades, MinCantidad),
    member(NecesidadMenor, Necesidades),
    cantNiveles(NecesidadMenor, _, MinCantidad).
    
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
