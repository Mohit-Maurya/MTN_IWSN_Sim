function [CH,Sensors]=SelectCH(Sensors,Model,r,deadNum)
    
    CH=[];
    countCHs=0;
    n=Model.n;
    Efs=10*0.0000000001;
    Emp=0.0013*0.000000001;
    for i=1:1:n
        dtobs=Sensors(i).dis2sink;
        Sensors(i).pnew=sqrt(n/(2*pi))*(sqrt(Efs/Emp)*100/(50*(dtobs^2)));
        if(Sensors(i).E>0)          
            temp_rand=rand;     
            if (Sensors(i).G<=0)            
                %Election of Cluster Heads
                %(Sensors(i).pnew/(1-Sensors(i).pnew*mod(r,round(1/Sensors(i).pnew))))*(Sensors(i).E/0.1)
                if(temp_rand<= (Sensors(i).pnew/(1-Sensors(i).pnew*mod(r,round(1/Sensors(i).pnew))))*(Sensors(i).E/0.1) &&  deadNum>10)                    
                    countCHs=countCHs+1; 
                    CH(countCHs).id=i; %#ok                
                    Sensors(i).type='C';
                    Sensors(i).G=round(1/Model.p-1);        
                end
                if(temp_rand<= (Model.p/(1-Model.p*mod(r,round(1/Model.p)))))                    
                   countCHs=countCHs+1; 
                   CH(countCHs).id=i; %#ok                
                   Sensors(i).type='C';
                   Sensors(i).G=round(1/Model.p)-1;        
                end    
            end   
        end 
    end 
end