%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function opens the parallel pool before using 'parfor'.
%
% Note that 'parpool' is introduced in R2013b.
% Thus, in R2013a and earlier, use 'matlabpool' instead.
%
% Tips for using 'parfor':
%    Run separate code in 'parfor' loops.
%    Loop index must be consecutive integers.
%    Reduce the amount of broadcast data.
%    Set 'parfor' iteration = multiple of parallel workers.
%
% Reference:
%    [1] "Parallel computing toolbox user's guide",R2016a.
%    [2] "Introduction to matlab parallel computing toolbox",2015.
%
% Input:
%    N: num. of parallel workers
%
% Output:
%    Null
%
% Example:
%    open_parpool;
%    c = pi; s = 0;
%    x = rand(1,100);
%    tic;
%    parfor k = 1:100         % k - loop var.
%        a = k;               % a - temporary var.
%        s = s+k;             % s - reduction var.
%        if k <= c            % c - broadcast var.
%            a = 3*a-1;
%        end
%        y(k) = x(k)+a;       % y - output sliced var.
%    end                      % x - input sliced var.
%    toc;
%    close_parpool;
%
% https://github.com/yzhang-engr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function open_parpool(N)

% *** check current parallel pool ***
poolobj = gcp('nocreate');
if isempty(poolobj)
    poolsize = 0;
else
    poolsize = poolobj.NumWorkers;
end

% *** open the parallel pool ***
if (nargin == 0)
    if (poolsize == 0)
        N_core = feature('numcores');   % retrieve the number of physical cores
        parpool('local',N_core);        % open a local parallel pool
    else
        fprintf('The parallel pool is still available with %d workers!\n',poolsize);
    end
elseif (nargin == 1)
    if (poolsize == 0)
        try
            parpool('local',N);         % open a local parallel pool
        catch
            fprintf('No so many logical cores available!\n');
        end
    else
        if (N~=poolsize)
            close_parpool;
            open_parpool(N);
        end
    end
end
