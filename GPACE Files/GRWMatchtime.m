function [MatchedGRACE, MatchedWater]=GRWMatchtime(GRACE,water)
[SPG,EPG,SPW,EPW]=CommonTimeFind(GRACE.decimalyear,water.time);
SPG=SPG+1;%This dataset only!
MatchedGRACE.decimalyear=GRACE.decimalyear(SPG:EPG);
MatchedGRACE.x=GRACE.x(SPG:EPG);
MatchedGRACE.y=GRACE.y(SPG:EPG);
MatchedGRACE.z=GRACE.z(SPG:EPG);
MatchedWater.time=water.time(SPW:EPW);
MatchedWater.LWE=water.LWE(SPW:EPW);

%Remove corresponding hydrology data for missing GRACE
for i=1:1:length(MatchedGRACE.decimalyear)-1
    if abs(MatchedWater.time(i+1)-MatchedGRACE.decimalyear(i+1))>0.1
        MatchedWater.time=[MatchedWater.time(1:i);MatchedWater.time(i+2:end)];
        MatchedWater.LWE=[MatchedWater.LWE(1:i);MatchedWater.LWE(i+2:end)];
    end
end
MatchedWater.time=[MatchedWater.time(1:end-2);MatchedWater.time(end)];
MatchedWater.LWE=[MatchedWater.LWE(1:end-2);MatchedWater.LWE(end)];