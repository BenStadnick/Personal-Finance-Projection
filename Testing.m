function [  ] = Testing(  )
%TESTING Summary of this function goes here
%   Detailed explanation goes here
%Initiate account variables
Amount = 100;

BeginYear = 2014; BeginMonth=11; BeginDay = 10;
BeginDate = [BeginYear BeginMonth BeginDay];

EndYear = 2015; EndMonth=11; EndDay = 12;
EndDate = [EndYear EndMonth EndDay];

Recurrence = cell([1,2]);
Recurrence{1} = 1;
Recurrence{2} = 'month';

% Create Account
Test = Account(Amount, BeginDate, EndDate,  0.01,'month', Recurrence,-10, BeginDate);

%create amount array
yeah = transactions(Test, [2016 11 EndDay]);
plot(yeah)

end

