function blankfill(fileID,number)
for i=1:1:number
    fwrite(fileID,' ','char');
end