function W = generate_adjacency_matrix(ncols,boxsize,nnodes)
    W = zeros(nnodes,nnodes);
    for i=1:ncols
        for j=1:ncols
            % Rows
            for xx=1:ncols
                if xx~=j
                    W(sub2ind([ncols,ncols],i,j), sub2ind([ncols,ncols],i,xx)) = 1;
                end
            end
            for yy=1:ncols
                if yy~=i
                    W(sub2ind([ncols,ncols],i,j), sub2ind([ncols,ncols],yy,j)) = 1;
                end
            end
            % Boxes
            xbox = ceil(j/boxsize);
            ybox = ceil(i/boxsize);
            for yy=ybox*boxsize-(boxsize-1):ybox*boxsize
                for xx=xbox*boxsize-(boxsize-1):xbox*boxsize
                    if xx~=j && yy~=i
                        W(sub2ind([ncols,ncols],i,j), sub2ind([ncols,ncols],yy,xx)) = 1;
                        W(sub2ind([ncols,ncols],yy,xx), sub2ind([ncols,ncols],i,j)) = 1;
                    end
                end
            end
        end
    end
end

