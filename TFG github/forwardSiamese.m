%%%% FORWARDSIAMESE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   · Cálculo de la probabilidad de plagio de un par
%
%%%% INPUT:
%
%   - net ---------> dlNetwork ------> Arquitectura de la red CNN
%   - fcParams ----> Array ----------> Parámetros de la fc
%   - X1 ----------> Array ----------> Imagen 1
%   - X2 ----------> Array ----------> Imagen 2
%
%%%% OUTPUT:
%
%   - Y -----------> Double ---------> Probabilidad de plagio €[0,1]
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Y = forwardSiamese(net,fcParams,X1,X2)
   
    % Obtención de los vectores característicos de las dos imágenes
    % utilizando una misma arquitectura de red (red siamesa)
    Y1 = forward(net,X1);
    Y1 = sigmoid(Y1);
    Y2 = forward(net,X2);
    Y2 = sigmoid(Y2);
    
    % Resta de los vectores característicos
    Y = abs(Y1 - Y2);
    
    % Operación fully connect
    Y = fullyconnect(Y,fcParams.FcWeights,fcParams.FcBias);
    
    % Conversión de la probabilidad al intervalo [0,1]
    Y = sigmoid(Y);

end