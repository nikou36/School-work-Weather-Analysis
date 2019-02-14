cities = ["Seattle","Everett","Tacoma","Spokane","Bellingham","Port Angeles","Winthrop","Leavenworth","Puyallup","Olympia"];
temperature_data = [90,86,79,89,78,69,82,67,75,77];
new_temperature = zeros(1,length(cities));
weights_in = zeros(length(cities),length(cities));%also energy
weights_out = zeros(length(cities),length(cities));%also energy
%reflexive_weight = zeros(1,length(cities));
alpha_in  = 0;
alpha_out = 0;
distance = [0,3,1,2,2,3,1,1,1,2;
            3,0,2,1,2,1,1,3,3,3;
            1,2,0,2,1,2,3,1,2,2;
            2,1,2,0,1,2,3,1,2,2;
            2,2,1,1,0,3,2,1,2,2;
            3,1,2,2,3,0,2,2,1,1;
            1,1,3,3,2,2,0,3,2,1;
            1,3,1,1,1,2,3,0,1,1;
            1,3,2,2,2,1,2,1,0,3;
            2,3,2,2,2,1,1,1,3,0];
fix = 82;
 
 
for m = 1: 100
    debug_sum = 0;
    for i = 1: length(cities) 
        debug_sum = debug_sum + temperature_data(1,i); 
    end    
    aver = debug_sum / length(cities);
    for i = 1:length(cities)
        for j = 1:length(cities)
            if distance(j,i) == 1
                weights_in(j,i) = 1.5 * rand;
            elseif distance(j,i) == 2
                weights_in(j,i) = rand;
            elseif distance(j,i) == 0
                weights_in(j,i) = 2 * rand;
            else
                weights_in(j,i) = 0;
            end
 
        end
    end
 
    new_temperature = zeros(1,length(cities));
    outside = fix + 1.5*rand - 1.5*rand;
    if temperature_data(1,1) > outside
        temperature_data(1,1) = temperature_data(1,1) - rand;
    else
        temperature_data(1,1) = temperature_data(1,1) + rand;
    end 
 for n = 1:length(cities)
 
            sum_out = 0;
            for j = 1:length(cities)
                sum_out = sum_out + weights_in(j,n);
                
            end
            
            test = temperature_data(1,n);
            if  test > aver
                r = 0.1;
            else
                r = -0.1 ;    
            end
            
            for m = 1:length(cities)
        %distance = sqrt((coord(n,1) - coord(m,1))^2 + (coord(n,2) - coord(m,2))^2);
                new_temperature(1,m) = new_temperature(1,m) + r *( temperature_data(1,n) * (weights_in(m,n)/ sum_out)); 
 end
            new_temperature(1,n) = new_temperature(1,n)+(1-r) *temperature_data(1,n);
 
    end
    new_sum = 0;
    for n = 1: length(cities)
        temperature_data(1,n) = new_temperature(1,n);
        new_sum = new_sum+ new_temperature(1,n);
    end
    disp(outside);
    disp(debug_sum);
    disp(new_sum);
    disp(cities);
    disp(temperature_data);
    
    end
