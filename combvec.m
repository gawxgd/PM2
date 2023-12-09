function result = combvec(varargin)
% Project 2
% Adam Grącikowski, 327350
%
% Creates all combinations of vectors

lengths = cellfun(@length, varargin);
if nargin == 0 || any(lengths == 0)
    result = []; return;
end % if

nC = prod(lengths);
result = zeros(nC, nargin);

for i = 1:nargin
    rep = nC / lengths(i);
    result(:, i) = repmat(reshape(repmat(varargin{i}, rep, 1), [], 1), ...
        size(result, 1)/(rep*lengths(i)), 1); 
    nC = nC / lengths(i);
end % for

end % function