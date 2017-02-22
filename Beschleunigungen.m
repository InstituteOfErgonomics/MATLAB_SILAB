%load('Accelerations_Data.mat');
%load('TTC_Data.mat');

Accelerations = zeros(20,1);
Beschl_row = 1;

for i = [2 4 6 7 12 15 16 17 18 19 23 24 25 27 28 32 34 37 39 40]
   
    
    VP_beschl = Accelerations_Data(sprintf('VP_%d',i));
    VP_strecke = TTC_Data(sprintf('VP_%d',i));
    
    Streckenmeter = VP_strecke('Streckenmeter');
    longitudinal = VP_beschl('Beschl_longitudinal');
    lateral = VP_beschl('Beschl_lateral');
    
    Start = find(abs(Streckenmeter-8166) < 0.12 );
    
    if size(Start,1) > 1
        Start_row = Start(2,1);
    end
    
    
    Ende = find(abs(Streckenmeter-8333) < 0.12 );

    if size(Ende,1) > 1
        Ende_row = Ende(size(Ende,1)-1,1);
    end
    
    if exist('Start_row') == 1 && exist('Ende_row') == 1
    
        Beschl_laengs = longitudinal(Start_row:Ende_row,1);
        Beschl_quer = lateral(Start_row:Ende_row,1);

        Accelerations(Beschl_row,1) = min(Beschl_laengs);
        Accelerations(Beschl_row,2) = min(Beschl_quer);
        Accelerations(Beschl_row,3) = max(Beschl_quer);
        
    end
    
    
    Beschl_row = Beschl_row +1;
    clearvars -except TTC_Data Accelerations Accelerations_Data Beschl_row
end

csvwrite('Beschleunigungen.csv',Accelerations); %% Ausgabedatei schreiben