camiseta(amarela).
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).

nome(fabio).
nome(fagner).
nome(felipe).
nome(fernando).
nome(flavio).

item(aspirador).
item(espanador).
item(pano).
item(rodo).
item(vassoura).

idade(8).
idade(10).
idade(12).
idade(14).
idade(16).

suco(laranja).
suco(limao).
suco(maca).
suco(maracuja).
suco(uva).

esporte(basquete).
esporte(futebol).
esporte(handebol).
esporte(natacao).
esporte(volei).

% X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

% X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
% X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

% X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 
    ListaSolucao = [
        irmao(Camiseta1, Nome1, Item1, Idade1, Suco1, Esporte1),
        irmao(Camiseta2, Nome2, Item2, Idade2, Suco2, Esporte2),
        irmao(Camiseta3, Nome3, Item3, Idade3, Suco3, Esporte3),
        irmao(Camiseta4, Nome4, Item4, Idade4, Suco4, Esporte4),
        irmao(Camiseta5, Nome5, Item5, Idade5, Suco5, Esporte5)
    ],

    % Quem escolheu o Pano está em algum lugar entre quem escolheu o Espanador e quem escolheu o Rodo, nessa ordem.
    aDireita(irmao(_, _, pano, _, _, _), irmao(_, _, espanador, _, _, _), ListaSolucao),
    aEsquerda(irmao(_, _, pano, _, _, _), irmao(_, _, rodo, _, _, _), ListaSolucao),

    % Fábio está exatamente à esquerda do irmão que gosta de suco de Uva.
    aoLado(irmao(_, fabio, _, _, _, _), irmao(_, _, _, _, uva, _), ListaSolucao),
    aEsquerda(irmao(_, fabio, _, _, _, _), irmao(_, _, _, _, uva, _), ListaSolucao),

    % O irmão de 14 anos está ao lado do irmão que escolheu o Aspirador.
    aoLado(irmao(_, _, _, 14, _, _), irmao(_, _, aspirador, _, _, _), ListaSolucao),

    % O garoto de camiseta Verde está em algum lugar à esquerda do garoto que gosta de Natação.
    aEsquerda(irmao(verde, _, _, _, _, _), irmao(_, _, _, _, _, natacao), ListaSolucao),

    % O menino de Branco está em algum lugar entre o menino que escolheu a Vassoura e o menino de Verde, nessa ordem.
    aDireita(irmao(branca, _, _, _, _, _), irmao(_, _, vassoura, _, _, _), ListaSolucao),
    aEsquerda(irmao(branca, _, _, _, _, _), irmao(verde, _, _, _, _, _), ListaSolucao),

    % O irmão que gosta de Handebol está ao lado do irmão de camiseta Vermelha.
    aoLado(irmao(_, _, _, _, _, handebol), irmao(vermelha, _, _, _, _, _), ListaSolucao),

    % Quem gosta de suco de Maçã está em algum lugar entre quem tem 16 anos e quem gosta de suco de Laranja, nessa ordem.
    aDireita(irmao(_, _, _, _, maca, _), irmao(_, _, _, 16, _, _), ListaSolucao),
    aEsquerda(irmao(_, _, _, _, maca, _), irmao(_, _, _, _, laranja, _), ListaSolucao),

    % Em uma das pontas está o menino que gosta de Futebol.
    noCanto(irmao(_, _, _, _, _, futebol), ListaSolucao),

    % O irmão mais velho está exatamente à direita do irmão de camiseta Azul.
    aoLado(irmao(_, _, _, 16, _, _), irmao(azul, _, _, _, _, _), ListaSolucao),
    aDireita(irmao(_, _, _, 16, _, _), irmao(azul, _, _, _, _, _), ListaSolucao),

    % O garoto de 14 anos gosta de suco de Maçã.
    member(irmao(_, _, _, 14, maca, _), ListaSolucao),

    % O menino de 12 anos está em algum lugar entre o menino que escolheu o Espanador e o menino que gosta de Basquete, nessa ordem.
    aDireita(irmao(_, _, _, 12, _, _), irmao(_, _, espanador, _, _, _), ListaSolucao),
    aEsquerda(irmao(_, _, _, 12, _, _), irmao(_, _, _, _, _, basquete), ListaSolucao),

    % Fábio está ao lado do irmão que gosta de Vôlei.
    aoLado(irmao(_, fabio, _, _, _, _), irmao(_, _, _, _, _, volei), ListaSolucao),

    % Fágner está em algum lugar à direita do garoto de camiseta Branca.
    aDireita(irmao(_, fagner, _, _, _, _), irmao(branca, _, _, _, _, _), ListaSolucao),

    % O irmão que escolheu o Pano está em algum lugar entre o irmão que gosta de suco de Uva e o irmão que escolheu o Aspirador, nessa ordem.
    aDireita(irmao(_, _, pano, _, _, _), irmao(_, _, _, _, uva, _), ListaSolucao),
    aEsquerda(irmao(_, _, pano, _, _, _), irmao(_, _, aspirador, _, _, _), ListaSolucao),

    % O garoto que gosta de Futebol está exatamente à esquerda do garoto que gosta de suco de Uva.
    aoLado(irmao(_, _, _, _, _, futebol), irmao(_, _, _, _, uva, _), ListaSolucao),
    aEsquerda(irmao(_, _, _, _, _, futebol), irmao(_, _, _, _, uva, _), ListaSolucao),

    % O menino de 10 anos está em algum lugar à direita do menino de camiseta Verde.
    aDireita(irmao(_, _, _, 10, _, _), irmao(verde, _, _, _, _, _), ListaSolucao),

    % O irmão que nasceu primeiro gosta de Basquete.
    member(irmao(_, _, _, 16, _, basquete), ListaSolucao),

    % Flávio está exatamente à direita do irmão que gosta de suco de Maracujá.
    aoLado(irmao(_, flavio, _, _, _, _), irmao(_, _, _, _, maracuja, _), ListaSolucao),
    aDireita(irmao(_, flavio, _, _, _, _), irmao(_, _, _, _, maracuja, _), ListaSolucao),

    % Fernando está em algum lugar à direita do garoto de camiseta Verde.
    aDireita(irmao(_, fernando, _, _, _, _), irmao(verde, _, _, _, _, _), ListaSolucao),

    % Testa todas as combinações...
    camiseta(Camiseta1), camiseta(Camiseta2), camiseta(Camiseta3), camiseta(Camiseta4), camiseta(Camiseta5), 
    todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]), 
    
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),
    
    item(Item1), item(Item2), item(Item3), item(Item4), item(Item5),
    todosDiferentes([Item1, Item2, Item3, Item4, Item5]),
    
    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5),
    todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]),
    
    suco(Suco1), suco(Suco2), suco(Suco3), suco(Suco4), suco(Suco5),
    todosDiferentes([Suco1, Suco2, Suco3, Suco4, Suco5]),

    esporte(Esporte1), esporte(Esporte2), esporte(Esporte3), esporte(Esporte4), esporte(Esporte5),
    todosDiferentes([Esporte1, Esporte2, Esporte3, Esporte4, Esporte5]).
