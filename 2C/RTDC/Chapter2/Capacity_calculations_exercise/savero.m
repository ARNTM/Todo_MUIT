function savero(nombre)

% $$$ if isdir('figuras')==0          
% $$$           mkdir('figuras')                
% $$$ else
% $$$           cd figuras
% $$$ end

saveas(gcf, nombre, 'fig')
%print([nombre '.eps'], '-depsc')
% cd ..
%   s.Bounds = 'tight';
s.Bounds = 'Loose';
s.FontName='Helvetica-Light';
 s.Format = 'eps'; %I needed this to make it work but maybe you wont.
 hgexport(gcf,strcat(nombre,'.eps'),s);

% $$$  %% cambiamos la letra con la que se guarda
% $$$     l = textread(strcat(nombre,'.eps'),'%s', 'delimiter', '\n');
% $$$     d=char(l(5));
% $$$     dd=d(end:-1:1);
% $$$     p1=strfind(dd,' ');
% $$$ in=1;
% $$$ l = regexprep(l,char(d(end-p1+2:end)),'Helvetica');
% $$$     fid=fopen(strcat(nombre,'.eps'), 'w');
% $$$     for jj=1:length(l)
% $$$         fprintf (fid, '%s\n', l{jj});
% $$$     end
% $$$     fclose (fid);
% $$$  %% --- fin del cambio de letra   
% $$$ 
% $$$ % $$$ cd ..
