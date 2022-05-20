clear

%% DATA
N = 5;
output_degree = 2;
input_degree = 2;

% tr = traffic matrix (lambda^sd = traffic from s to d)
tr = [ 0  0 20  0  0;
       0  0 10 10  0;
       0  0  0 10 10;
      10  0  0  0 10;
       0 10  0  0  0];

%% VARIABLES DEFINITION
% Vector dimensions
size_b =  N*(N-1);            % number of bij variables
size_l = (N*(N-1))^2;         % number of lambda_ij^sd variables
size_x = size_b + size_l + 1; % total number of variables
   
% Objective function
f = [zeros(size_x-1,1); 1];

% Vector of variables x (example for N=5 nodes)
% elements   1 to  20 b12 b13 ... b1N b21 b23 ... b2N ... bNN-1        N*(N-1) values
% elements  21 to 420 l_12^12 l_13^12 ... l_1N^12 .....  lNN-1^NN-1   (N*(N-1))^2 values
% element  421        lmax                                             1 value

% Initialize variables
b = zeros(2*N+size_b+size_l,1);
A = zeros(2*N+size_b+size_l,size_x);
beq = zeros(N*size_b,1);
Aeq = zeros(N*size_b,size_x);

%% UPPER AND LOWER BOUNDS FOR ALL THE VARIABLES
lb = zeros(size_x,1);
ub = [ones(size_b,1); Inf*ones(size_l+1,1)];

%% INEQUALITIES - OUTPUT DEGREE CONSTRAINTS

outgoing=reshape(1:N*(N-1),N-1,N)';
% outgoing represents all the lightpaths going out from node i
% b12 b13 b14 ... b1N  for i = 1
% b21 b23 b24 ... b2N  for i = 2

for i = 1:N,
    row = i;
    A(row,outgoing(i,:)) = ones(1,N-1);
    b(row,1) = output_degree;
end
last_row_ineq = N;

%% INEQUALITIES - INPUT DEGREE CONSTRAINTS

incoming = reshape(1:N*(N-1),N,N-1);
for i=1:N-1,
    incoming(:,i)=[incoming(N+1-i:N,i); incoming(1:N-i,i)];
end
% incoming represents all the lightpaths coming into node i
% b21 b31 b41 ... bN1  for i = 1
% b12 b32 b42 ... bN2  for i = 2

for i=1:N,
    row = last_row_ineq + i;
    A(row,incoming(i,:)) = ones(1,N-1);
    b(row,1) = input_degree;
end
last_row_ineq = 2*N;

%% INEQUALITIES - TOTAL FLOW ON A LP
% Total traffic in a lightpath less than congestion (l_max)
% or 
% Total traffic in a lightpath minus lmax less than 0
% l_12^12 + l_12^13 + l_12^14 .... + l_12N-1Nx(21)^- l_max <=0

for ij = 1:size_b,
    row = last_row_ineq + ij;
    A(row,size_b+ij:size_b:size_l+ij) = ones(1,size_b);
    A(row,size_x) = -1;
    b(row,1) = 0;
end
last_row_ineq = 2*N + size_b;

% Obtain l^sd traffic values from traffic matrix removing diagonal values
lsd=[];
for s = 1:N,
    for d = 1:N;
        if s == d,
        else
            lsd = [lsd; tr(s,d)];
        end
    end
end

% The traffic from node s to node d travelling along lightpath ij (if it exists) must be
% always less than total traffic form s to node d
% l_ij^sd < l^sd* b_ij 
% or
% l_ij^sd - l^sd* b_ij < 0

for sd=1:size_b,
    for ij=1:size_b,
        row = last_row_ineq + ij;
        A(row,size_b*sd+ij) = 1;
        A(row,ij) = -lsd(sd);
        b(row) = 0;
    end
    last_row_ineq = last_row_ineq + size_b;
end

%% EQUALITIES - FLOW CONSERVATION AT EACH NODE

% For each node i:
% (total sd traffic incoming to node i) minus (total sd traffic outgoing to node i)
%         equal to            0 if node i is neither s-source nor d-destination
%                             sd traffic if node i is d-destination
%                             -sd traffic if node i is s-source

coef = zeros(N,size_b);
for Node = 1:N,
    coef(Node,incoming(Node,:)) =  tr([1:Node-1 Node+1:N],Node);
    coef(Node,outgoing(Node,:)) = -tr(Node,[1:Node-1 Node+1:N]);    
end

for Node = 1:N,
    for sd = 1:size_b,
        row = size_b*(Node-1)+sd;
        Aeq(row,size_b*sd+incoming(Node,:)) = ones(1,N-1);     % incoming traffic
        Aeq(row,size_b*sd+outgoing(Node,:)) = -1*ones(1,N-1);  % -outgoing traffic
        beq(row,1) = coef(Node,sd);                            %  
    end
end

%% LP PROBLEM SOLUTION
intcon=1:N*(N-1);
[x,fval,exitflag] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub)