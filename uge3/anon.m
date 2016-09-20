%% første forsøg
clear all; close all; clc

f = @(x) sin(2*x).*log(x);
g = @(y) sqrt(y).*cos(y);

x = linspace(0,4*pi);
figure
hold on
plot(x,f(x))
plot(x,g(x))