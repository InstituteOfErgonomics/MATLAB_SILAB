% load('TTC_Data.mat')

minimum_TTC = zeros(20,1);
minTTC_row = 1;

for i = [2 4 6 7 12 15 16 17 18 19 23 24 25 27 28 32 34 37 39 40]
   
    
    VP = TTC_Data(sprintf('VP_%d',i));
    Streckenmeter = VP('Streckenmeter');
    Abstand_roh = VP('LongAbstandStostangenVoraus');
    Abstand = Abstand_roh-50;
    Geschwindigkeit_kmh = VP('Geschwindigkeit');
    Geschwindigkeit = Geschwindigkeit_kmh/3.6;
    
    Start = find(abs(Streckenmeter-8166) < 0.12 ); % abs(Streckenmeter-8166) = Position Hindernis
    
    if size(Start,1) > 1 % Um das richtige Modul zu finden
        Start_row = Start(2,1);
    end
    
    
    Ende = find(abs(Streckenmeter-8333) < 0.12 ); % Position Ende der Situation

    if size(Ende,1) > 1
        Ende_row = Ende(2,1);
    end
    
    if exist('Start_row') == 1 && exist('Ende_row') == 1
    
        Distance = Abstand(Start_row:Ende_row,1);
        Speed = Geschwindigkeit(Start_row:Ende_row,1);

        TTC = zeros(size(Speed,1),1);

        for row = 1:size(Speed,1)
            TTC(row,1) = Distance(row,1)/Speed(row,1);
        end

        minimum_TTC(minTTC_row,1) = min(TTC); %% Matrix mit ausgegebenen minTTCs

        
    end
    
    minimum_TTC(minTTC_row,2) = i;
    
    minTTC_row = minTTC_row +1;
    clearvars -except TTC_Data minimum_TTC minTTC_row Accelerations_Data 
end

csvwrite('minTTC.csv',minimum_TTC); %% Ausgabedatei schreiben