clc,clear

H = [1 0 1 0 1 0 1 0; 1 0 0 1 0 1 0 1; 0 1 1 0 0 1 1 0; 0 1 0 1 1 0 0 1];
r = [-2.5467 0.2358 -1.3929 -3.0287 -1.8290 -1.1768 -1.9434 -0.1152];
sigma = 1;

[LLR, c, m] = LDPC(H,r,sigma)

% Hzeros = isinf(1./H);
% 
% LLR_channel = -2*r/sigma;
% 
% LLRvc_channel = H.*LLR_channel;
% 
% LLRcv = H;
% LLRcv(Hzeros) = NaN*ones(length(H(Hzeros)),1);
% LLRcv = LLRcv * 0;
% LLRcv = LLRvc_channel + LLRcv;
% while(true)
%     
%     
%     Hnan = isnan(LLRcv);
%     parity_check = LLRcv;
%     parity_check(Hnan) = ones(length(LLRcv(Hnan)),1);
%     ssigns = prod(parity_check');
%     snotnull = find(ssigns<=0);
%     
%     if(isempty(snotnull)) 
%         LLRcheck = sum(LLRcv_sum);
%         LLR = LLR_channel + LLRcheck;
%         break; 
%     end
%     
%     LLRcv_tanh = tanh(LLRcv/2);
%     Hnan = isnan(LLRcv_tanh);
%     LLRcv_prod = LLRcv_tanh;
%     LLRcv_prod(Hnan) = ones(length(LLRcv_tanh(Hnan)),1);
%     ssigns = prod(LLRcv_prod');
%     LLRcv_prod = H.*((prod(LLRcv_prod')'./LLRcv_prod));
%     LLRcv_prod(Hzeros) = 0*NaN*ones(length(H(Hzeros)),1);
%     
%     LLRcv = 2*atanh(LLRcv_prod);
%     LLRcv_sum = LLRcv;
%     LLRcv_sum(Hzeros) = 0*ones(length(H(Hzeros)),1);
%     LLRcv_sum = H.*(sum(LLRcv_sum)-LLRcv_sum);
%     
%     LLRcv = LLRvc_channel + LLRcv_sum;
%     LLRcv(Hzeros) = NaN*ones(length(H(Hzeros)),1);
% 
% end
% 
% c = ones(1,length(r));
% c(find(LLR>=0)) = 0;
% 
% m = c*H';


