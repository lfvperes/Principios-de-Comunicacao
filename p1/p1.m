%%
% SEL0360 - Principios de Comunicacao
% Trabalho 1 (P1)
% LUIS FILIPE VASCONCELOS PERES
% 10310641
%
% Este e outros scripts que escrevi podem ser encontrados
% na minha pagina do GitHub:
% https://github.com/lfvperes/
%%
clear all; close all; clc;
fc = 20e3;          % frequencia de portadora:  20kHz
fm = 0.4e3;         % frequencia de modulacao:  400Hz
mi = 0.5;           % indice de modulacao:      50%
[onda_AM, t, V_env, V_filtro] = onda(fc, fm, mi);

opengl software;
f1 = figure;
plot(t, onda_AM, 'r');
hold on;
plot(t, V_env, 'g');
hold on;
plot(t, V_filtro, 'b');
legend('Onda de entrada','Detector de envoltoria', 'Filtro passa-alta');
xlabel('Tempo [s]');
ylabel('Amplitude');
grid on;

f2 = figure;
plot(t, onda_AM, 'r');
hold on;
plot(t, V_env, 'g');
hold on;
plot(t, V_filtro, 'b');
legend('Onda de entrada','Detector de envoltoria', 'Filtro passa-alta');
xlabel('Tempo [s]');
ylabel('Amplitude');
xlim([3e-3 8e-3]);
ylim([-2 2]);
grid on;

saveas(f1, 'sem-zoom', 'png');
saveas(f2, 'com-zoom', 'png');

function [onda, t, V_env, V_filtro] = onda(f_c, f_m, m_i)
      
    % item (a) 
    fs = 160000;                    % Taxa de amostragem
    dT = 1/fs;                      % Periodo de amostragem
    
    t = linspace(0,.1,.1/dT);   % Vetor tempo
    onda = (1 + m_i * cos(2 * pi * t * f_m)).* cos(2 * pi * t * f_c); % Equacao da onda
    
    % item (b): Criar o detector de envoltoria
    V_env = zeros(1, length(onda)); % Vetor de zeros
    for k = 2:length(onda)     
        if (onda(k) > (V_env(k - 1)))         
            V_env(k) = onda(k);     
        else 
            V_env(k) = V_env(k - 1) - 0.023 * V_env(k - 1);     
        end 
    end     
    
    % item (c): Criar o filtro passa-alta
    V_filtro = zeros(1, length(onda)); % Vetor de zeros
    RC = .001; 
    beta = RC / (RC + dT);   
    for k = 2:length(onda)     
        V_filtro(k) = beta * V_filtro(k - 1) + beta * (V_env(k) - V_env(k - 1));      
    end 
end