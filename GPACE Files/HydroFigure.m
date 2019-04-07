function HydroFigure(HydroMap)
colormap(bone);
[X,Y,HY]=griddata(HydroMap(:,1),HydroMap(:,2),HydroMap(:,3),linspace(min(HydroMap(:,1)),max(HydroMap(:,1)))',linspace(min(HydroMap(:,2)),max(HydroMap(:,2))),'v4');
%     contourf(X1,X2,YX);
%     image(X1,X2,YX);
% handle=pcolor(X,Y,HY);
pcolor(X,Y,HY);
shading interp