function [  ] = GUI(  )
%GUITEST Sets up GUI for personal financing program
%Ben Stadnick 12/27/2014

%Declare working figure and maximize
fh = figure('toolbar','figure');
% Toolbar for Open and Print buttons
%set(fh,'toolbar','figure');
%set(fh,'menubar','figure'); only adds top menu bar

%Maximize the figure window
maxfig(fh,1) % maximizes the figure window of figure fh

%Open axis ah
ah = axes('Parent',fh,'Position',[.05 .05 .38 .5]);
xlabel('Date (Days)');
ylabel('Assets');

%Create Pie Chart
PieChart = axes('Parent',fh,'Position',[0 .6 .25 .38]);
axes(PieChart)
pie([1 1 1])

%Add update plot botton and plot end date entries
updatePB = uicontrol(fh,'Style','pushbutton','String','Update Plot','Position',[630 450 80 25], 'Callback', @UpdatePBCallback);
PlotEndYear = uicontrol(fh,'Style','edit','String','2016','Position',[630 475 35 20]);
PlotEndMonth = uicontrol(fh,'Style','edit','String','1','Position',[665 475 20 20]);
PlotEndDay = uicontrol(fh,'Style','edit','String','1','Position',[685 475 20 20]);
uicontrol(fh,'Style','text','String','Plot End Date','Position',[630 495 80 15]);

%Add pie control
PieSelect = uicontrol(fh,'Style','popupmenu','String',{'Incomes','Expenditures','Assets'},'Value',1,'Position',[630 530 80 20]);
uicontrol(fh,'Style','text','String','Pie Select','Position',[630 550 80 15]);
PieEndYear = uicontrol(fh,'Style','edit','String','2016','Position',[630 570 35 20]);
PieEndMonth = uicontrol(fh,'Style','edit','String','1','Position',[665 570 20 20]);
PieEndDay = uicontrol(fh,'Style','edit','String','1','Position',[685 570 20 20]);
uicontrol(fh,'Style','text','String','Pie Date','Position',[630 590 80 15]);
updatePie = uicontrol(fh,'Style','pushbutton','String','Update Pie','Position',[630 605 80 25], 'Callback', @UpdatePieCallback);

%Create and set panel locations
LeftSide = 0.45;
IncomePanel = uipanel('Parent',fh,'Title','Income','Position',[LeftSide .76 1-LeftSide .24]);
ExpensePanel = uipanel('Parent',fh,'Title','Expenpenditures','Position',[LeftSide .41 1-LeftSide .34]);
AssetsPanel = uipanel('Parent',fh,'Title','Assets','Position',[LeftSide .02 1-LeftSide .37]);

%create load and save buttons
SaveData = uicontrol(fh,'Style','pushbutton','String','Save Data','Position',[630 700 80 25], 'Callback', @SaveDataCallback);
LoadData = uicontrol(fh,'Style','pushbutton','String','Load Data','Position',[550 700 80 25], 'Callback', @LoadDataCallback);
DataLocation = uicontrol(fh,'Style','edit','String','AccountsData.mat','Position',[550 730 160 20]);

%%
%Create Income Panel inputs
IL=6;
for i=1:IL
    %Checkboxes
    Check(i,1) = uicontrol(IncomePanel,'Style','checkbox','Value',0,'Position',[5 25*i-20 20 20]);
    %Nameboxes
    Name(i,1) = uicontrol(IncomePanel,'Style','edit','String','','Position',[20 25*i-20 135 20]);
    %Amount
    Amount(i,1) = uicontrol(IncomePanel,'Style','edit','String','0','Position',[170 25*i-20 70 20]);
    %Begin Date
    BeginYear(i,1) = uicontrol(IncomePanel,'Style','edit','String','2017','Position',[250 25*i-20 35 20]);
    BeginMonth(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[285 25*i-20 20 20]);
    BeginDay(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[305 25*i-20 20 20]);
    %End Date
    EndYear(i,1) = uicontrol(IncomePanel,'Style','edit','String','2018','Position',[340 25*i-20 35 20]);
    EndMonth(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[375 25*i-20 20 20]);
    EndDay(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[395 25*i-20 20 20]);
    %Interest
    InterestRate(i,1) = uicontrol(IncomePanel,'Style','edit','String','0','Position',[430 25*i-20 50 20]);
    IntType(i,1) = uicontrol(IncomePanel,'Style','popupmenu','String',{'day', 'month','year'},'Value',2,'Position',[470 25*i-20 60 20]);
    %Payment
    RecurrenceRate(i,1) = uicontrol(IncomePanel,'Style','edit','String','0','Position',[560 25*i-20 50 20]);
    RecurrenceType(i,1) = uicontrol(IncomePanel,'Style','popupmenu','String',{'day','month','year'},'Value',1,'Position',[615 25*i-20 60 20]);
    PaymentAmount(i,1) = uicontrol(IncomePanel,'Style','edit','String','0','Position',[680 25*i-20 50 20]);
    PayYear(i,1) = uicontrol(IncomePanel,'Style','edit','String','2014','Position',[745 25*i-20 35 20]);
    PayMonth(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[780 25*i-20 20 20]);
    PayDay(i,1) = uicontrol(IncomePanel,'Style','edit','String','1','Position',[800 25*i-20 20 20]);
end
%Create Labels for Income Panel
uicontrol(IncomePanel,'Style','text','String','Income Name','Position',[10 25*IL 100 20]);
uicontrol(IncomePanel,'Style','text','String','Amount','Position',[170 25*IL 55 20]);  
uicontrol(IncomePanel,'Style','text','String','Begin Date','Position',[250 25*IL 55 20]);   
uicontrol(IncomePanel,'Style','text','String','End Date','Position',[340 25*IL 55 20]);  
uicontrol(IncomePanel,'Style','text','String','Interest Rate','Position',[430 25*IL 75 20]);  
uicontrol(IncomePanel,'Style','text','String','Pay Recurrense','Position',[560 25*IL 80 20]);  
uicontrol(IncomePanel,'Style','text','String','Amount','Position',[680 25*IL 45 20]);  
uicontrol(IncomePanel,'Style','text','String','Pay Date','Position',[745 25*IL 55 20]);  

%Create Expense Panel inputs
EL=9;
for i=1:EL
    p = IL+i;
    %Checkboxes
    Check(p,1) = uicontrol(ExpensePanel,'Style','checkbox','Value',0,'Position',[5 25*i-20 20 20]);
    %Nameboxes
    Name(p,1) = uicontrol(ExpensePanel,'Style','edit','String','','Position',[20 25*i-20 135 20]);
    %Amount
    Amount(p,1) = uicontrol(ExpensePanel,'Style','edit','String','0','Position',[170 25*i-20 70 20]);
    %Begin Date
    BeginYear(p,1) = uicontrol(ExpensePanel,'Style','edit','String','2017','Position',[250 25*i-20 35 20]);
    BeginMonth(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[285 25*i-20 20 20]);
    BeginDay(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[305 25*i-20 20 20]);
    %End Date
    EndYear(p,1) = uicontrol(ExpensePanel,'Style','edit','String','2018','Position',[340 25*i-20 35 20]);
    EndMonth(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[375 25*i-20 20 20]);
    EndDay(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[395 25*i-20 20 20]);
    %Interest
    InterestRate(p,1) = uicontrol(ExpensePanel,'Style','edit','String','0','Position',[430 25*i-20 50 20]);
    IntType(p,1) = uicontrol(ExpensePanel,'Style','popupmenu','String',{'day', 'month','year'},'Value',2,'Position',[470 25*i-20 60 20]);
    %Payment
    RecurrenceRate(p,1) = uicontrol(ExpensePanel,'Style','edit','String','0','Position',[560 25*i-20 50 20]);
    RecurrenceType(p,1) = uicontrol(ExpensePanel,'Style','popupmenu','String',{'day','month','year'},'Value',1,'Position',[615 25*i-20 60 20]);
    PaymentAmount(p,1) = uicontrol(ExpensePanel,'Style','edit','String','0','Position',[680 25*i-20 50 20]);
    PayYear(p,1) = uicontrol(ExpensePanel,'Style','edit','String','2014','Position',[745 25*i-20 35 20]);
    PayMonth(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[780 25*i-20 20 20]);
    PayDay(p,1) = uicontrol(ExpensePanel,'Style','edit','String','1','Position',[800 25*i-20 20 20]);
end
%%Create Labels for Expenses Panel
uicontrol(ExpensePanel,'Style','text','String','Expenditure Name','Position',[10 25*EL 100 20]);
uicontrol(ExpensePanel,'Style','text','String','Amount','Position',[170 25*EL 55 20]);  
uicontrol(ExpensePanel,'Style','text','String','Begin Date','Position',[250 25*EL 55 20]);   
uicontrol(ExpensePanel,'Style','text','String','End Date','Position',[340 25*EL 55 20]);  
uicontrol(ExpensePanel,'Style','text','String','Interest Rate','Position',[430 25*EL 75 20]);  
uicontrol(ExpensePanel,'Style','text','String','Pay Recurrense','Position',[560 25*EL 80 20]);  
uicontrol(ExpensePanel,'Style','text','String','Amount','Position',[680 25*EL 45 20]);  
uicontrol(ExpensePanel,'Style','text','String','Pay Date','Position',[745 25*EL 55 20]);  

%Create Assets Panel inputs
AL=10;
for i=1:AL
    p=IL+EL+i;
    %Checkboxes
    Check(p,1) = uicontrol(AssetsPanel,'Style','checkbox','Value',0,'Position',[5 25*i-20 20 20]);
    %Nameboxes
    Name(p,1) = uicontrol(AssetsPanel,'Style','edit','String','','Position',[20 25*i-20 135 20]);
    %Amount
    Amount(p,1) = uicontrol(AssetsPanel,'Style','edit','String','0','Position',[170 25*i-20 70 20]);
    %Begin Date
    BeginYear(p,1) = uicontrol(AssetsPanel,'Style','edit','String','2017','Position',[250 25*i-20 35 20]);
    BeginMonth(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[285 25*i-20 20 20]);
    BeginDay(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[305 25*i-20 20 20]);
    %End Date
    EndYear(p,1) = uicontrol(AssetsPanel,'Style','edit','String','2018','Position',[340 25*i-20 35 20]);
    EndMonth(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[375 25*i-20 20 20]);
    EndDay(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[395 25*i-20 20 20]);
    %Interest
    InterestRate(p,1) = uicontrol(AssetsPanel,'Style','edit','String','0','Position',[430 25*i-20 50 20]);
    IntType(p,1) = uicontrol(AssetsPanel,'Style','popupmenu','String',{'day' 'month','year'},'Value',2,'Position',[470 25*i-20 60 20]);
    %Payment
    RecurrenceRate(p,1) = uicontrol(AssetsPanel,'Style','edit','String','0','Position',[560 25*i-20 50 20]);
    RecurrenceType(p,1) = uicontrol(AssetsPanel,'Style','popupmenu','String',{'day','month','year'},'Value',1,'Position',[615 25*i-20 60 20]);
    PaymentAmount(p,1) = uicontrol(AssetsPanel,'Style','edit','String','0','Position',[680 25*i-20 50 20]);
    PayYear(p,1) = uicontrol(AssetsPanel,'Style','edit','String','2014','Position',[745 25*i-20 35 20]);
    PayMonth(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[780 25*i-20 20 20]);
    PayDay(p,1) = uicontrol(AssetsPanel,'Style','edit','String','1','Position',[800 25*i-20 20 20]);
end
%%Create Labels for Assets Panel
uicontrol(AssetsPanel,'Style','text','String','Asset Name','Position',[10 25*AL 100 20]);
uicontrol(AssetsPanel,'Style','text','String','Amount','Position',[170 25*AL 55 20]);  
uicontrol(AssetsPanel,'Style','text','String','Begin Date','Position',[250 25*AL 55 20]);   
uicontrol(AssetsPanel,'Style','text','String','End Date','Position',[340 25*AL 55 20]);  
uicontrol(AssetsPanel,'Style','text','String','Intrest Rate','Position',[420 25*AL 75 20]);  
uicontrol(AssetsPanel,'Style','text','String','Pay Recurrense','Position',[560 25*AL 80 20]);  
uicontrol(AssetsPanel,'Style','text','String','Amount','Position',[680 25*AL 45 20]);  
uicontrol(AssetsPanel,'Style','text','String','Pay Date','Position',[745 25*AL 55 20]);  
%%
%This call will create new accounts
AccountCell = CreateAccounts(IL+EL+AL);

%AccountCell = LoadAccountCell(IL+EL+AL);

%Callback function for UpdatePB. Updates AccountCell and plots selected accounts
function UpdatePBCallback(ObjH, EventData)
% ObjH is the button handle
    %This call will update the accounts based on user inputs
    AccountCell = UpdateAccounts(IL+EL+AL, AccountCell, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType,...
    RecurrenceRate, RecurrenceType, PaymentAmount, PayYear, PayMonth, PayDay);
    %Update plot
    axes(ah);
    cla(ah);
    Y = GetPlot(1, IL+EL+AL, AccountCell, Check, [str2double(get(PlotEndYear,'string')) str2double(get(PlotEndMonth,'string')) str2double(get(PlotEndDay,'string'))]);
    %Create dates array
    Dates = datenum(date) + linspace(0,length(Y),length(Y));
    %Plot and axis labels
    plot(Dates,Y);
    %Choose date format
    if length(Y) < 180;
        dateformat = 'dd-mmm';
    elseif length(Y) < 1200;
        dateformat = 'yyyy-mmm';
    else
        dateformat = 'yyyy';
    end
    %Set axis labels
    datetick('x', dateformat, 'keepticks', 'keeplimits');
    xlim([Dates(1) Dates(end)]);
    xlabel('Date');
    ylabel('Assets ($)');
end

%Callback function for UpdatePie. Updates AccountCell and pie plots selected accounts
function UpdatePieCallback(ObjH, EventData)
% ObjH is the button handle
    %This call will update the accounts based on user inputs
    AccountCell = UpdateAccounts(IL+EL+AL, AccountCell, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType,...
    RecurrenceRate, RecurrenceType, PaymentAmount, PayYear, PayMonth, PayDay);
    %Update pie chart
    axes(PieChart);
    switch get(PieSelect,'value')
        case 1 %Income
            start = 1;
            stop = IL;
        case 2 %Expenses
            start = IL+1;
            stop = IL+EL;
        case 3 %Assets
            start = IL+EL+1;
            stop = IL+EL+AL;
    end
    %Get data needed for pie chart. GetPie returns a 2 cell array including account amounts in cell 1 and account names in 2
    PieChartData = GetPie(start, stop, AccountCell, Check, Name,[str2double(get(PlotEndYear,'string')) str2double(get(PlotEndMonth,'string')) str2double(get(PlotEndDay,'string'))]);
    %Plot pie chart
    pie(abs(PieChartData{1}))
    %Add legend
    legend(PieChartData{2},'Position',[.23 .6 .12 .03*length(PieChartData{2})]);

end

%Callback function for SaveData. Updates AccountCell then saves to file
function SaveDataCallback(ObjH, EventData)
    %This call will update the accounts based on user inputs
    AccountCell = UpdateAccounts(IL+EL+AL, AccountCell, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType,...
    RecurrenceRate, RecurrenceType, PaymentAmount, PayYear, PayMonth, PayDay);
    %Write account names and check values to cell structures
    n = IL+EL+AL;
    AccountNamesCell = cell(n,1);
    AccountCheckCell = cell(n,1);
    for i=1:n
        AccountNamesCell{i,1} = get(Name(i,1), 'string');
        AccountCheckCell{i,1} = get(Check(i,1), 'Value');
    end
    %Save to file
    save(get(DataLocation,'string'), 'AccountCell', 'AccountCheckCell', 'AccountNamesCell')
end

%Load function
function NewAccountCell = LoadDataCallback(ObjH, EventData)
        n = IL+EL+AL;
        %Load in Cell data to structures
        New = load(get(DataLocation,'string'));
        %Save accounts data
        NewAccountCell = New.AccountCell;
        %Set user inputs to values in AccountCell
        for i=1:n
            set(Check(i,1), 'Value', New.AccountCheckCell{i,1});
            %Nameboxes
            set(Name(i,1),'string', New.AccountNamesCell{i,1});
            %Amount
            set(Amount(i,1), 'string', num2str(New.AccountCell{i}.Amount));
            %Begin Date
            set(BeginYear(i,1), 'string', num2str(New.AccountCell{i}.BeginDate(1,1)));
            set(BeginMonth(i,1), 'string', num2str(New.AccountCell{i}.BeginDate(1,2)));
            set(BeginDay(i,1), 'string', num2str(New.AccountCell{i}.BeginDate(1,3)));
            %End Date
            set(EndYear(i,1), 'string', num2str(New.AccountCell{i}.EndDate(1,1)));
            set(EndMonth(i,1), 'string', num2str(New.AccountCell{i}.EndDate(1,2)));
            set(EndDay(i,1), 'string', num2str(New.AccountCell{i}.EndDate(1,3)));
            %Interest
            set(InterestRate(i,1), 'string', num2str(New.AccountCell{i}.InterestRate));
            %Find the interest type and set it
            switch New.AccountCell{i}.InterestType
                case 'day'
                    set(IntType(i,1), 'Value', 1);
                case 'month'
                    set(IntType(i,1), 'Value', 2);
                case 'year'
                    set(IntType(i,1), 'Value', 3);
            end
            %Payment
            
            set(RecurrenceRate(i,1), 'string', num2str(New.AccountCell{i}.Recurrence{1}));
            %Find the recurrence type and set it
            switch New.AccountCell{i}.Recurrence{2}
                case 'day'
                    set(RecurrenceType(i,1), 'Value', 1);
                case 'month'
                    set(RecurrenceType(i,1), 'Value', 2);
                case 'year'
                    set(RecurrenceType(i,1), 'Value', 3);
            end
            set(PaymentAmount(i,1), 'string', num2str(New.AccountCell{i}.Payment));
            set(PayYear(i,1), 'string', num2str(New.AccountCell{i}.PayDate(1,1)));
            set(PayMonth(i,1), 'string', num2str(New.AccountCell{i}.PayDate(1,2)));
            set(PayDay(i,1), 'string', num2str(New.AccountCell{i}.PayDate(1,3)));
        end
    end

%This call will update the accounts based on user input
%AccountCell = UpdateAccounts(IL+EL+AL, AccountCell, Amount, BeginYear, BeginMonth, BeginDay, EndYear, EndMonth, EndDay, InterestRate, IntType,...
%    RecurrenceRate, RecurrenceType, PaymentAmount, PayYear, PayMonth, PayDay);
end

