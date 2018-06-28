% SYNC update one struct with another
%
%   SYNC(s1, s2) populates every field from `s2` into `s1`, overwriting the
%   values in `s1` when there is a conflict, and returns `s1`.
%
%   SYNC(s1, s2, 'soft') does not overwrite existing values in `s1`.
%
%   SYNC(s1, s2, 'top') is non-recursive. Fields of class `struct` are not
%   modified.
%
%   SYNC(s1, s2, 'flat') is equivalent to both `'soft'` and `'top'` options.

function s1 = sync(s1, s2, varargin)
end