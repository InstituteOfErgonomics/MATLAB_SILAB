%%% 1. Ort der Dateien festlegen %%%
cd('Y:\Dateneingang\Kontrolle_Luis\MATLAB_SILAB') %%% Ort der Dateien festlegen

%%% 2. Dateiort und Probanden in den Dateien ändern! %%%
run('Import_Streckenmeter_Abstand.m') 
run('Import_Geschwindigkeit.m')
run('Import_Beschleunigungen.m')
run('min_TTC.m')
run('Beschleunigungen.m')