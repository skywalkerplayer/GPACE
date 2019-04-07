function [startpoint1,endpoint1,startpoint2,endpoint2]=CommonTimeFind(Time1,Time2)
global number;
startpoint1=0;
startpoint2=0;
endpoint1=0;
endpoint2=0;
l1=length(Time1);
l2=length(Time2);
if Time1(1)<Time2(1) 
    startpoint2=1;
    i=1;
    found=0;
    while(i<l1&&found==0) %search for GPS startpoint
        if Time1(i)>Time2(1)
            startpoint1=i;
            found=1;
        end
        i=i+1;
    end
else
    startpoint1=1;
    i=1;
    found=0;
    while(i<l2&&found==0) %search for GRACE startpoint
        if Time2(i)>Time1(1)
            startpoint2=i;
            found=1;
        end
        i=i+1;
    end
end

%Find the common end point
if Time1(l1)<Time2(l2) 
    endpoint1=l1;
    i=l2;
    found=0;
    while(i>1&&found==0) %search for GRACE endpoint
        if Time2(i)<Time1(l1)
            endpoint2=i;
            found=1;
        end
        i=i-1;
    end
else
    endpoint2=l2;
    i=l1;
    found=0;
    while(i>1&&found==0) %search for GPS endpoint
        if Time1(i)<Time2(l2)
            endpoint1=i;
            found=1;
        end
        i=i-1;
    end
end