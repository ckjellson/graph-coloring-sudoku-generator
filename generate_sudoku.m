function [W,states,coords,u,it] = generate_sudoku(ncols,nu,plotting)
    boxsize = sqrt(ncols);
    nnodes = ncols^2;
    [X,Y] = meshgrid(1:ncols,1:ncols);
    coords = [Y(:) X(:)];

    % Set up adjacency matrix
    W = generate_adjacency_matrix(ncols,boxsize,nnodes);
    
    % Initiate simulation
    states = randi([1,ncols],nnodes,1);
    u = [];
    exps = zeros(nnodes,ncols);
    for i=1:ncols
        exps(:,i) = exp(-nu*W*(states==i));
    end
    pot = 1/2*sum(sum(W.*(states==states')));
    u(1) = pot;
    
    % Run simulation
    it = 2;
    while pot>0 && it<50000
        if plotting==1
            clf('reset');
            colormap jet;
            gplot(W,coords,'b');
            hold on;
            scatter(coords(:,1),coords(:,2),500,states,'.');
            xlim([0,ncols+1]);
            ylim([0,ncols+1]);
            pause(0.00001);
        end
        
        % Update node states stochastically
        nodeid = randi(nnodes);
        P = exps(nodeid,:)./sum(exps(nodeid,:));
        states(nodeid) = find(cumsum(P)>rand(),1);
        
        % Compute potential
        for i=1:ncols
            exps(:,i) = exp(-nu*W*(states==i));
        end
        pot = 1/2*sum(sum(W.*(states==states')));
        u(it) = pot;
        it = it + 1;
        disp(it);
        disp(pot);
    end
end

