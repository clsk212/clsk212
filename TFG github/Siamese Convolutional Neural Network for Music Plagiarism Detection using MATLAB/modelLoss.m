%%%% MODELLOSS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   · Cálculo de pérdida a partir de la probabilidad predecida y el valor
%     real mediante la fórmula: 
%      
%        loss = -t·log(y)-(1-t)log(1-y), y es la prediccion, t€{0,1}
%
%%%% INPUT:
%
%   - net --------------> dlnetwork --------> Arquitectura de la red CNN
%   - fcParams ---------> Array ------------> Parámetros de la capa fc
%   - X1 ---------------> Array ------------> Imagen 1
%   - X2 ---------------> Array ------------> Imagen 2
%   - pairLabels -------> Array ------------> Etiquetas de plagio
%
%%%% OUTPUT:
%
%   - loss -------------> Double -----------> Pérdida media se la muestra
%   - gradientsSubnet --> Array ------------> Gradientes de la red
%   - gradientsParams --> Array ------------> Gradientes de los parámetros
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [loss,gradientsSubnet,gradientsParams] = modelLoss(net,fcParams,X1,X2,pairLabels)

    % Obtención de la probabilidad de plagio 
    Y = forwardSiamese(net,fcParams,X1,X2);
    
    % Cálculo binario de la pérdida cross-entropy media de la muestra
    loss = binarycrossentropy(Y,pairLabels);
    
    % Cálculo de los gradientes respecto a los parámetros de aprendizaje
    [gradientsSubnet,gradientsParams] = dlgradient(loss,net.Learnables,fcParams);

end
