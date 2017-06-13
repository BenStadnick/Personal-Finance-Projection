function PieChartData = GetPie(start, stop, AccountCell, Checks, Name, EndDate)
%GETPLOT Summary of this function goes here
%   Detailed explanation goes here
    k=0;
    for i=start:stop
        if get(Checks(i,1),'value') == 1
            ThisAssetAmount = transactions(AccountCell{i}, EndDate);
            if ThisAssetAmount ~= 0
                k=k+1;
                AssetAmount(k,1) = ThisAssetAmount(1,end);
                Labels{k} = get(Name(i,1),'string');
            end
        end
     end
if k==0
    AssetAmount = [1];
    Labels = {'No Data Entered'};
end

PieChartData = {AssetAmount, Labels};

end

