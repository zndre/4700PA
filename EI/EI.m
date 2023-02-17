clear
close all

%size of matrix
nx = 50;
ny = 50; 

%eig
alpha = 0;


%matrix
V = zeros(nx, ny);
G = sparse(nx * ny, nx * ny); 


%setting corner boundary conditions to 1
for i = 0:ny - 1
    if i == 0 || i == ny - 1
        for j = 0:nx - 1
            G(ny * i + j + 1, ny * i + j + 1) = 1;
        end
    else
        G(ny * i + 1, ny * i + 1) = 1;
        G(ny * i + nx, ny * i + nx) = 1;
    end
end

%setting finite difference
for i = 0:ny
    if (0 < i) && (i < ny - 1)
        for j = 0:nx
            if (0 < j) && (j < nx - 1)
                % center
                G(i * ny + j + 1, i * ny + j + 1) = -4 - alpha;
                % right
                G(i * ny + j + 1, i * ny + j + 1 + 1) = 1;
                % left
                G(i * ny + j + 1, i * ny + j - 1 + 1) = 1;
                % below
                G(i * ny + j + 1, i * ny + j + nx + 1) = 1;
                % above
                G(i * ny + j + 1, i * ny + j - nx + 1) = 1;
            end
        end
    end
end


%setting object in range 10:20
for i = 10:20
    if (0 < i) && (i < ny - 1)
        for j = 10:20
            if (0 < j) && (j < nx - 1)
                % center
                G(i * ny + j + 1, i * ny + j + 1) = -2 - alpha;
                % right
                G(i * ny + j + 1, i * ny + j + 1 + 1) = 1;
                % left
                G(i * ny + j + 1, i * ny + j - 1 + 1) = 1;
                % below
                G(i * ny + j + 1, i * ny + j + nx + 1) = 1;
                % above
                G(i * ny + j + 1, i * ny + j - nx + 1) = 1;
            end
        end
    end
end





figure('name', 'Matrix')
spy(G)

nmodes = 20;
[E,D] = eigs(G, nmodes, 'SM');

plot(diag(D), '');

np = ceil(sqrt(nmodes));
figure('name', 'Modes')
for k = 1:nmodes
    M = E(:, k);
    for i = 1:nx
        for j = 1:ny
            n = i + (j -1) * nx;
            V(i, j) = M(n);
        end
        subplot(np, np, k), surf(V, 'LineStyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end
