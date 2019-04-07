function DandM()
global SecondaryPathSet;
global datas;
global number;
global ThisdataPri;
global ThisdataSec;
if SecondaryPathSet==1
    ThisdataPri.decimalyear=datas{number}.decimalyear;
    ThisdataPri.deltax=detrend(datas{number}.deltax);
    ThisdataPri.deltay=detrend(datas{number}.deltay);
    ThisdataPri.deltaz=detrend(datas{number}.deltaz);
    ThisdataPri.x=detrend(datas{number}.x);
    ThisdataPri.y=detrend(datas{number}.y);
    ThisdataPri.z=detrend(datas{number}.z);
    ThisdataSec.decimalyear=ThisdataSec.decimalyear;
    ThisdataSec.deltax=detrend(ThisdataSec.deltax);
    ThisdataSec.deltay=detrend(ThisdataSec.deltay);
    ThisdataSec.deltaz=detrend(ThisdataSec.deltaz);
    ThisdataSec.x=detrend(ThisdataSec.x);
    ThisdataSec.y=detrend(ThisdataSec.y);
    ThisdataSec.z=detrend(ThisdataSec.z);
    [ThisdataPri, ThisdataSec]=StackTime(ThisdataPri,ThisdataSec,1);
    ThisdataPri.stationame=datas{number}.stationame;
end