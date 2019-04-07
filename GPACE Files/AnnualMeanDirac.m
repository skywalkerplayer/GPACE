function returner=AnnualMeanDirac(Data,DataType,DataNumber,IfStandardize)
% switch DataType
%     case 'SGP' % 1 station GPS
%     case 'AGP' % all station GPS
%         
%     case 'SW'  % 1 station water
%     case 'AW'  % all station water
% end

returner=AnnualMean(Data,DataType,DataNumber,0);
for i=1:1:length(returner.Ampl)-1
    returner.Ampl(i)=returner.Ampl(i+1)-returner.Ampl(i);
end
returner.Ampl(end)=0;

if IfStandardize==1
    returner.Ampl=Standardize(returner.Ampl);
end