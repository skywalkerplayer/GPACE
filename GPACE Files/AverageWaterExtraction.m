function outputer=AverageWaterExtraction(water,DataNumber,mode)
if mode==1
    minY=9999;
    maxY=0;
    for i=1:1:DataNumber
        if water.time(i)<minY
            minY=water.time(i);
        end
        if water.time(i)>maxY
            maxY=water.time(i);
        end
    end
    outputer.year=(minY:1:maxY);
    outputer.water=zeros(1,length(outputer.year));
    