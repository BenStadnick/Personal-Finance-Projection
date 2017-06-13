function AccountCell = CreateAccounts(n)
%CREATEACCOUNTS Summary of this function goes here
%   Detailed explanation goes here
        AccountCell = cell([n,1]);
        Recurrence = cell([1,2]);
        Recurrence{1} = 0;
        Recurrence{2} = 'day';
        for i=1:n
          	AccountCell{i,1} = Account(0, [2017 1 1], [2017 1 1], 0, 'month', Recurrence, 0, [2017 1 1]);
        end
        
          
    end

