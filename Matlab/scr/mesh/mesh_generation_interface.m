function [Edge,E2edge,E2size,E2E,E2bound,normal,K] = mesh_generation_interface(prec,simulation,real,mod)

s1 = simulation(1);
s2 = simulation(2);

i1 = real(1);
i2 = real(2);

if (mod == "regular")
    Edge = linspace(s1,s2,prec+1);
elseif (mod == "random")
    Edge = [s1 , sort(rand(1,prec-1)) , s2];
else
    error("last argument must be regular or random");
end

ed1 = 1; ed2 = prec + 1;
while (i1 >= Edge(ed1+1)) 
    ed1 = ed1 + 1;
end
while (i2 <= Edge(ed2-1))
    ed2 = ed2 -1;
end

Edge = Edge(ed1:ed2);

K = length(Edge)-1;

% element to edge matching array
E2edge = zeros(K,2);
for i = 1:K
    E2edge(i,:) = [i , i+1];
end
% Storage method [left right]

% element to edge matching array
E2E = zeros(K,2);
for i = 1:K
    E2E(i,:) = [i-1 , i+1];
end
% Storage method [left right]


% normal vector
normal = [-1,1]; % [left normal, right normal]

% elemet size array
E2size = zeros(1,K);
for i = 1:K
    E2size(i) = abs(Edge(E2edge(i,2)) - Edge(E2edge(i,1)));
end

E2bound = zeros(K,2);
E2bound(1,1) = 1;
E2bound(end,end) = 1;

end
