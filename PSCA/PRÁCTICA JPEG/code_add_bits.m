function dcbin2 = codedc(dc)
%extraido de matlab 14819
   if dc == 0
      dcbin2 = '';
   else
      dcabs=abs(dc);
      dcbin=dec2bin(dcabs);
      dclen=length(dcbin);
      if dc<0
         comp=repmat(49,[1 dclen]);
         dcbin=comp-dcbin;
      else
         comp=repmat(48,[1 dclen]);
         dcbin=dcbin-comp;
      end

      dcbin2='';
      for ii=1:length(dcbin)
         dcbin2=strcat(dcbin2,char(48+dcbin(ii)));
      end
   end

