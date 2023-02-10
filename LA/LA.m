%laplace equation by iteration

clear
close all

nx = 100; 
ny = 100; 
V = zeros(nx, ny); 

%value to converge
converge = 0.1e-5;  

%internal grid points (ie does not touch boundary conditions at edge)
m = 2:nx - 1;
n = 2:ny - 1;

%BC
V(1,:) = 1;        %left boundary 
V(nx,:) = 0;       %Right boundary


%reset matrix
Vc = V;

%set current value to begin iteration
value = 4 * converge;

%count
count = 0; 

while (value > converge)
    %iternation of central point
    V(m, n) = (0.25) * (V(m + 1, n) + V(m - 1, n) + V(m, n + 1) + V(m, n - 1));
 
    %making up for up and down boundary not being caught by jacobi eq
    V(:, 1) = V(:, 2);
    V(:, ny) = V(:, ny - 2);
    
   
    %update converge value
    value = max(abs(V(:) - Vc(:)));

    %update count
    count = count + 1;

    %Defining E
    [Ex, Ey] = gradient(Vc); 
    Ex = -1 .* Ex; 
    Ey = -1 .* Ey; 

    %plotting statement
    if mod(count, 10) == 0
        %plot V
        subplot(1, 3, 1)
        surf(Vc)

        %Plot E (Ex is 0)
        subplot(1, 3, 2)
        quiver(Ex, Ey)

        %imbox
        IM = imboxfilt(Vc, 3);
        subplot(1, 3, 3)
        imshowpair(Vc, IM)


        pause(0.05)
    end
    
    Vc = V;
end