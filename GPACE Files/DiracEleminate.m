function returner=DiracEleminate(SourceVector,width,height)
halfwidth=ceil(width/2);
returner=SourceVector;
for i=1:1:(length(SourceVector)-width)
    if abs(SourceVector(i+halfwidth)-SourceVector(i))>=height
        if abs(SourceVector(i+halfwidth)-SourceVector(i+width))>=height
            returner(i+halfwidth)=mean([SourceVector(i+halfwidth-1),SourceVector(i+halfwidth+1)]);
        end
    end
end
for i=1:1:halfwidth
    if abs(SourceVector(i)-SourceVector(halfwidth))>=height
        returner(i)=mean(SourceVector(1:halfwidth));
    end
    if abs(SourceVector(length(SourceVector)-i+1))-SourceVector(halfwidth)>=height
        returner(length(SourceVector)-i+1)=mean(SourceVector(length(SourceVector)-halfwidth:length(SourceVector)));
    end
end