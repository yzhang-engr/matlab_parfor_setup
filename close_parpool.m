%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function closes the running parallel pool.
%
% Input:
%    Null
%
% Output:
%    Null
%
% https://github.com/yzhang-engr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function close_parpool()

poolobj = gcp('nocreate');
if isempty(poolobj)
    fprintf('No running parallel pool!');
else
    delete(poolobj)
end
