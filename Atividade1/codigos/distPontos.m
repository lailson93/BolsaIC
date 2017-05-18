function dij = distPontos(p1,p2)
%Calcula a distancia entre dois pontos
%p1 = [x1 y1] e p2 = [x2 y2] 
%em um espaco bi-dimensional
%Entradas:
%p1, p2: dois pontos
%Saída:
%d: distancia entre p1 e p2
%Uso:
%d = distPontos(p1, p2)

dij = sqrt((p1(1)-p2(1))^2 + (p1(2)-p2(2))^2);
%dij = hypot(p1,p2);