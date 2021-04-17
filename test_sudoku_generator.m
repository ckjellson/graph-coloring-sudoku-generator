%% Graph coloring Sudoku generator example
clc;
clear;

% Set sudoku size
ncols = 9;      % Must be a squared number
nu = 4;         % Choose ncols=4 -> nu=3, ncols=9 -> nu=4, ncols=16 -> nu=6
plotting = 0;   % Plots

%% Run graph coloring sudoku generation
[W,states,coords,u,iters] = generate_sudoku(ncols,nu,plotting);

%% Plot final distribution
colormap jet;
figure(1);
gplot(W,coords,'b');
hold on;
scatter(coords(:,1),coords(:,2),1000,states,'.');
xlim([0,ncols+1]);
ylim([0,ncols+1]);

%% Plot potential
figure(2);
plot(1:iters-1,u);
xlabel('Iteration');
ylabel('Potential');

%% Plot sudoku
figure(3);
for i=1:ncols+1
    if mod(i-1,sqrt(ncols))==0
        plot([i i],[1 ncols+1],'k','linewidth',3);
        hold on;
        plot([1 ncols+1],[i i],'k','linewidth',3);
    else
        plot([i i],[1 ncols+1],'k');
        hold on;
        plot([1 ncols+1],[i i],'k');
    end
end
for i=1:ncols^2
    text(coords(i,1)+0.3,coords(i,2)+0.5,num2str(states(i)),'FontSize',20,'Color','k');
end
xlim([0,ncols+2]);
ylim([0,ncols+2]);