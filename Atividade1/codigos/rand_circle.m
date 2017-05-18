function [x y] = rand_circle(x1,y1,rc)
a=2*pi*rand
r=sqrt(rand)
x=(rc*r)*cos(a)+x1
y=(rc*r)*sin(a)+y1
%plot (x,y,'*')
end