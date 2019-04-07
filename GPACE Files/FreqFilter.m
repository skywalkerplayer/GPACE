function returner=FreqFilter(TimeSequence,LowFreq,HighFreq)
if LowFreq==0
    LowFreq=0.0000001;
end
filt=fir1(96,[LowFreq/4,HighFreq/4],'bandpass');
returner=filter(filt,1,TimeSequence);