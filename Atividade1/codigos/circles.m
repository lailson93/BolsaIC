function [h, hc] = circles(x,y,r,cmrk)
% CIRCLES   plot 2-D circles, given a set of center coordinates and radii.
%
% Description:
%
%   Plot 2-D circles, given a set of center coordinates and radii. Values
%   can be vectors or matrices, as long as dimensions are consistent. If
%   a marker type (e.g. '+') is also given, circle centers will be marked
%   with it. The function returns a vector of handles for each circle and
%   a handle for all the center markers, if plotted.

assert(size(x)==size(y), 'Mismatching sizes')
assert(size(y)==size(r), 'Mismatching sizes')

if (nargin==4)
    hc = scatter(x,y,[],[],cmrk);
end
axis([min(x-r) max(x+r) min(y-r) max(y+r)], 'equal');

a = linspace(0, 2*pi, 12);
dx = sin(a); dy = cos(a);
hold on
for i=1:numel(x);
    h(i) = line(x(i)+dx*r(i), y(i)+dy*r(i));
end
hold off