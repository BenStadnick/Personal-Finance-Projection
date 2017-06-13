function AccountCell = UpdateAccounts(n, AccountCell, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType, RecurrenceRate, RecurrenceType, PaymentAmount, PayYear, PayMonth, PayDay)
%UPDATEACCOUNTS Summary of this function goes here
%   Detailed explanation goes here
    for i=1:n
        switch get(IntType(i,1),'Value')
            case 1
                InterestType = 'day';
            case 2
                InterestType = 'month';
            case 3
                InterestType = 'year';
        end

            switch get(RecurrenceType(i,1),'Value')
            case 1
            RecurrType = 'day';
            case 2
            RecurrType = 'month';
            case 3
            RecurrType = 'year';
            end
        %Update the account
                AccountCell{i,1} = UpdateAccount(AccountCell{i,1}, str2double(get(Amount(i,1),'string')), str2double(get(BeginYear(i,1),'string')),...
                    str2double(get(BeginMonth(i,1),'string')), str2double(get(BeginDay(i,1),'string')), str2double(get(EndYear(i,1),'string')),...
                    str2double(get(EndMonth(i,1),'string')), str2double(get(EndDay(i,1),'string')), str2double(get(InterestRate(i,1),'string')),...
                    InterestType, str2double(get(RecurrenceRate(i,1),'string')), RecurrType,...
                    str2double(get(PaymentAmount(i,1),'string')), str2double(get(PayYear(i,1),'string')), str2double(get(PayMonth(i,1),'string')),...
                    str2double(get(PayDay(i,1),'string')));
    end
    end


