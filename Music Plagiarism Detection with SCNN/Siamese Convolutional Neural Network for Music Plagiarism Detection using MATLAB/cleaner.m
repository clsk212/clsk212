
%%%% CLEANER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Normalización del audio
% · Filtrado de ruido mediante los filtros: media movil, mediana y Wiener
%.
%%%% INPUT
% X --------------> Array ---------> Vector de audio
% t --------------> Array ---------> Vector tiempo
%
%%%% OUTPUT:
% X_clean --------> Array ---------> Vector de audio filtrado
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X_clean = cleaner(X,t)
    
    % Normalización del audio:
    X = X / max(abs(X));

    % Filtro media movil (ruido de alta frecuencia)
    X_clean = movmean(X,1000)

    % Filtro mediana (ruido impulsivo)
    X_clean = medfilt1(X_clean,100)

    % Filtro de Wiener (ruido de baja frecuencia y ruido blanco)
    X_clean = wiener2(X_clean)

    % Además se grafica la superposición del audio original y el filtrado:
    figure;
    plot(t,X,'b')
    hold on 
    plot(t,X_clean,'Color',[0.4,0.6,1])
    grid on
    set(gca, 'FontName','Time New Roman','FontSize',12)
    legend('Original','Filtrada')
    title('Filtros de ruido: Media, Mediana y Wiener')
    xlabel('Tiempo (s)')
    ylabel('Amplitud')
    hold off

end








