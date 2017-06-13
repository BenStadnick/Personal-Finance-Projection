classdef Account < handle
    %TRANSACTION can be an asset, income or expenditure
    % Ben Stadnick
    
    properties % All public properties
        Amount
        BeginDate
        EndDate
        Recurrence
        InterestRate
        InterestType
        Payment
        PayDate
    end %End of properties
    
    methods
        % Initiate a new Account
        function Account = Account(Amount, BeginDate, EndDate, InterestRate, InterestType, Recurrence, Payment, PayDate)
            Account.Amount = Amount;
            %Input as a date vector [Year, Month, BDay]
            Account.BeginDate=BeginDate; 
            Account.EndDate=EndDate; 
            %Recurrence = [increment value, increment type] where increment 
            %value = scalar and type = 'day', 'week', 'month' or 'year'
            Account.Recurrence = Recurrence; 
            % Nominal yearly interest
            Account.InterestRate = InterestRate;
            % Interest type can be compound 'month' or 'year'
            Account.InterestType = InterestType;
            Account.Payment = Payment;
            Account.PayDate = PayDate;
        end
        
        % Change individual class properties. No tests for proper inpunt!
        % are done, be careful
        function NewAmount(Account, Amount)
            Account.Amount = Amount;
        end
        function NewBeginDate(Account, BeginDate)
            Account.BeginDate = BeginDate;
        end
        function NewEndDate(Account, EndDate)
            Account.EndDate = EndDate;
        end
        function NewRecurrence(Account, Recurrence)
            Account.Recurrence = Recurrence;
        end
        function NewInterestRate(Account, InterestRate)
            Account.InterestRate = InterestRate;
        end
        function NewInterestType(Account, InterestType)
            Account.InterestType = InterestType;
        end
        
        %Update all properties
        function Account = UpdateAccount(Account, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType, RecurrenceRate, RecurrenceType, Payment, PayYear, PayMonth, PayDay)
        
            Account.Amount = Amount;
        	Account.BeginDate = [BeginYear BeginMonth BeginDay];
        	Account.EndDate = [EndYear EndMonth EndDay];
            %Set up Recurrence cell
            Recurrence = cell([1,2]);
            Recurrence{1} = RecurrenceRate;
            Recurrence{2} = RecurrenceType;
            Account.Recurrence = Recurrence;
            %Interest
            Account.InterestRate = InterestRate;
        	Account.InterestType = IntType;
            Account.Payment = Payment;
            Account.PayDate = [PayYear PayMonth PayDay];
        end
        
        %Create array with time vs payments for remaining transactions
        function Amount = transactions(Account, EndDate)
            %Check if EndDate input is greater than account period
            A = datenum(Account.EndDate);
            B = datenum(EndDate);
            if B >= A
                PayEnd = Account.EndDate;
            else
                PayEnd = EndDate;
            end
            
            % Set payment period
            C = datenum(date);
            PayDay = datenum(Account.PayDate);
            if Account.Recurrence{1} > 0
                while datenum(PayDay) <= C
                    PayDay = addtodate(PayDay, Account.Recurrence{1}, Account.Recurrence{2});
                end
            end
            % Initiate amount array
            Amount = zeros(1,daysact(date, datestr([EndDate 0 0 0])));
            Amount(1,1) = Account.Amount;
            
            %Set interest and accurement dates
            CDay = datevec(date);
            if strcmp(Account.InterestType, 'day')
                interest = (1+Account.InterestRate)^(1/365)-1;
                IntDay = datenum([CDay(1), CDay(2), CDay(3)+1]); 
            elseif strcmp(Account.InterestType, 'month')
                interest = (1+Account.InterestRate)^(1/12)-1;
                IntDay = datenum([CDay(1), CDay(2), eomday(CDay(1), CDay(2))]);
            elseif strcmp(Account.InterestType, 'year')
                interest = Account.InterestRate;
                IntDay = datenum([CDay(1), 12, eomday(CDay(1), 12)]);
            end
            
            %For loop to create array by running through each day
            for i=2:daysact(date, datestr([PayEnd 0 0 0]))
                Amount(1,i) = Amount(1,i-1);
                
                %Check if a payment is due and process
                if addtodate(C,i-1,'day') == PayDay
                    Amount(1,i) = Amount(1,i-1) + Account.Payment;
                    PayDay = addtodate(PayDay, Account.Recurrence{1}, Account.Recurrence{2});
                end
                
                %Check if interest is accured and process
                if addtodate(C,i-1,'day') == IntDay
                    Amount(1,i) = Amount(1,i-1) + Amount(1,i-1)*interest;
                    IntDay = addtodate(IntDay, 1, Account.InterestType);
                end
            end
        end
                
    end%End of methods
    
end

