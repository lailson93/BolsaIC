dRadius = 500;
BS = 0;
BS1 = dRadius;
BS2 = dRadius*exp(j*(2*pi/3));
BS3 = dRadius*exp(-j*(2*pi/3));

figure 1
subplot(1,2,1);
circle (real(BS),imag(BS),dRadius)
circle (real(BS1),imag(BS1),dRadius)
circle (real(BS2),imag(BS2),dRadius)
circle (real(BS3),imag(BS3),dRadius)
title('Posicionamento de ERBs');
axis([-1000 1000 -1000 1000]);
axis equal;




%Posicionamento aleatorio das TMs
subplot(1,2,2);
[a5,b5] = rand_circle(real(BS),imag(BS),dRadius);
tm5 = [a5 b5];
plot(a5,b5,'*'),hold on,
circle (real(BS),imag(BS),dRadius),hold on,

[a1,b1] = rand_circle(real(BS1),imag(BS1),dRadius);
tm1 = [a1 b1];
plot (a1,b1,'*'),hold on,
circle (real(BS1),imag(BS1),dRadius),hold on,

[a2,b2] = rand_circle(real(BS2),imag(BS2),dRadius);
tm2 = [a2 b2];
plot (a2,b2,'*'),hold on,
circle (real(BS2),imag(BS2),dRadius),hold on,

[a3,b3] = rand_circle(real(BS3),imag(BS3),dRadius);
tm3 = [a3 b3];
plot (a3,b3,'*'),hold on,
circle (real(BS3),imag(BS3),dRadius),hold on,

title('Posicionamento aleatório de TMs');
axis([-1000 1000 -1000 1000]);
axis equal;

%calculo ganho de percurso d/o enlace

%calculo da distancia de TM a ERB central em km
d55 = sqrt(power(a5,2)+power(b5,2))/1000;
d51 = sqrt(power(a1,2)+power(b1,2))/1000;
d52 = sqrt(power(a2,2)+power(b2,2))/1000;
d53 = sqrt(power(a3,2)+power(b3,2))/1000;

c1 = [real(BS1) imag(BS1)];
c2 = [real(BS2) imag(BS2)];
c3 = [real(BS3) imag(BS3)];

d15 = distPontos(c1,tm5)/1000;
d11 = distPontos(c1,tm1)/1000;
d12 = distPontos(c1,tm2)/1000;
d13 = distPontos(c1,tm3)/1000;

d25 = distPontos(c2,tm5)/1000;
d21 = distPontos(c2,tm1)/1000;
d22 = distPontos(c2,tm2)/1000;
d23 = distPontos(c2,tm3)/1000;

d35 = distPontos(c3,tm5)/1000;
d31 = distPontos(c3,tm1)/1000;
d32 = distPontos(c3,tm2)/1000;
d33 = distPontos(c3,tm3)/1000;

dij = [d55,d51,d52,d53; d15,d11,d12,d13; d25,d21,d22,d23; d35,d31,d32,d33];
PLij = 128.1 +36.7*log10(dij); %em dB
plij = db2lin(PLij); %linear
gij = 1./plij;

%save(a5,b5,d,pijMedio,gij1LIN)

%p1 = [a5 b5];
%p2 = [0 0];
%d = distPontos(p1,p2);
%d=d/1000;
%pij1 = 128.1 +36.7*log10(d)
%gij1= 1/pij1

%PERDA DE CAMINHO COM SOMBREAMENTO
sigma = 8;
xSigma = sigma*randn(4,4);
PXij = PLij + xSigma; %em dB
pxij = db2lin(PXij); %linead
gxij = 1./pxij;


%DESVANECIMENTO RAPIDO COM DISTRIBUICAO DE RAYLEIGH
desv = 1/sqrt(2);
xij = desv*randn(4,4);
yij = desv*randn(4,4);
hij = xij+yij
ghij = power(abs(hij),2)
gHij = 10*log10(ghij);
%esse ganho é caclulado dessa forma?

%POTENCIA RECEBIDA DA ERBi PELO TMj
PTij = 43; %dBm
pTij = dbm2lin(PTij);
pRij = pTij*gij*gxij*ghij;

%CALCULO DO SINR PARA CADA ENLACE ENTRE ERBi E TMi
PN = -116; %dBm
pN = dbm2lin(PN);
somatorio = 0;
for i=1:4,
	for j=1:4,
		if i!=j,
			somatorio = somatorio + pRij(i,j);
		end
	end
	somatorioPRIJ(i) = somatorio + pN;
	somatorio = 0;
end
yii(1) = pRij(1,1)/somatorioPRIJ(1);
yii(2) = pRij(2,2)/somatorioPRIJ(2);
yii(3) = pRij(3,3)/somatorioPRIJ(3);
yii(4) = pRij(4,4)/somatorioPRIJ(4);