                                                                                                                                                        
%%%% FEATURE_EXTRACTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% · Extracción de las características:
%       - Envolvente de la amplitud
%       - Root Mean Square Energy
%       - Zero Crossing Rate
%       - Información estadística
%       - Espectro de frecuencias
%       - Espectrograma
%       - Periodograma
%       - Histograma
%       - Espectro de MEL
%       - Coeficientes Cepstrales de MEL (MFCC)
%
%%%% INPUT:
%
%   - X_clean ----> Array -----> Vector de audio
%   - t ----------> Array -----> Vector tiempo
%   - fs ---------> Int -------> Sampling Rate (Hz)
%   - N ----------> Int -------> Longitud de X_clean
%   - filepath ---> String ----> Path con las características jpg
%
%%%% OUTPUT:
%
% ** Extrae las características y las guarda en formato jpg.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function feature_extraction(X_clean,t,fs,N,filepath)

    % Graficar señal en el Dominio Temporal
    sg = plot(t,X_clean);
    grid on;
    set(gca, 'FontName','Time New Roman','FontSize',12);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    title('Señal Filtrada Dominio Temporal');

    saveas(sg,fullfile(filepath,'original signal'),'jpg');
    
    % Envolvente de la amplitud
    [up,~] = envelope(X_clean);
    hold on
    en = plot(t,up,'linewidth',0.5,'Color','r');
    set(gca, 'FontName','Time New Roman','FontSize',12)
    xlabel('Tiempo (s)')
    ylabel('Amplitud')
    legend('audio','up')
    title('Envolvente de la Amplitud')
    hold off
    saveas(en,fullfile(filepath,'envolvente_amplitud'),'jpg')
    

    % Root Mean Square Energy (RMSE):
    figure;
    rms = envelope(X_clean,512,'rms');
    rmse = plot(t,rms,'Color','r');
    set(gca, 'FontName','Time New Roman','FontSize',12);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    title('RMSE');

    saveas(rmse,fullfile(filepath,'root_mean_square_energy'),'jpg');

    
    % Zero crossing rate
    win = fs*0.01;
    rate_features = zerocrossrate(X_clean, WindowLength=win,Method="comparison");
    zero = plot(rate_features,'Color','r');
    title('Zero Crossing Rate')

    saveas(zero,fullfile(filepath,'zero_crossing_rate'),'jpg')
    
    % Dominio de Frecuencia
    X_fft = fft(X_clean);
    X_shiffft = fftshift(fft(X_clean));
    ff = linspace(-fs/2,fs/2,length(X_fft));
    ff_2 = linspace(-fs/2,fs/2,length(X_shiffft));
    mag_X = abs(X_fft);
    mag_X_2 = abs(X_shiffft);
    
    figure();
    frec = plot(ff, mag_X);
    title('Espectro de frecuencias de la señal');
    xlabel('Frecuency (Hz)');
    ylabel('Amplitud');
    grid on, grid minor; % cuadricula

    saveas(frec,fullfile(filepath,'espectro_frecuencias'),'jpg');
    
    esp = plot(ff_2, mag_X_2/max(mag_X_2));
    title('Espectro de frecuencias de la señal');
    xlabel('Frecuency (Hz)');
    ylabel('Amplitud');
    grid on, grid minor; % cuadricula
    saveas(esp,fullfile(filepath,'espectro_frecuencias_2'),'jpg');

    % Poner exponente 3
    ax = gca;
    ax.XAxis.Exponent = 3;
    
    % Espectrograma
    h=figure();
    spectrogram(X_clean,1024, 512, 1024,fs,'yaxis'); 
    title('Espectrograma de la señal')
    saveas(h, fullfile(filepath,'espectrograma'),'jpg')
    
    % Periodograma
    p = figure();
    w = hanning(N,'periodic');
    periodogram(X_clean,w,N,fs,'power');
    [x,f] = periodogram(X_clean,w,N,fs,'power');
    x = 20*log10(sqrt(x)*sqrt(2));

    saveas(p, fullfile(filepath,'periodograma'),'jpg');
    
    % Plot semilog
    semi = figure();
    semilogx(f,x);
    title('Semilog');

    saveas(semi, fullfile(filepath,'semilog'),'jpg');
    
    % Plot histograma
    hist = figure();
    histogram(X_clean);
    title('Hist os audio signal');

    saveas(hist, fullfile(filepath,'histograma'),'jpg');
    
    % Espectrograma de MEL:
    mel = figure();
    melSpectrogram(X_clean,fs,'Window',hann(2048,"periodic"),'OverlapLength',1024,'FFTLength',4096,'NumBands',64,'FrequencyRange',[62.5,8e3]);
    %coefs = melSpectrogram(X_clean,fs);

    saveas(mel, fullfile(filepath,'espectrograma_mel'),'jpg');

    % Centroide espectral:
    %cent = figure();
    %spectralCentroid(X_clean);
    %title('Centroide espectral')
    %ylabel('Centroide (Hz)')

    %saveas(cent,fullfile(filepath,'centroide_espectral'),'jpg'

end
