% FIELD_NAMES get field names of a struct
%
%   FIELD_NAMES(example_struct) returns the names of `example_struct`'s
%   fields in a cell array. This behavior is consistent with the built-in
%   function `fieldnames`.
%
%   FIELD_NAMES(foo, 'recursive', true) returns a cell array of cell arrays.
%   Each of its members can be expanded into the parameter list of `setfield`
%   or `getfield` to access the data contained within `foo` and its
%   sub-`struct`s.
%
%   Examples:
%
%   >> s1 = struct('a', [], 'b', struct('c', [], 'd', struct('e', [])));
%   >> basic = s_utils.field_names(s1)
%   basic =
%       'a'
%       'b'
%   >> recurse = s_utils.field_names(s1, 'recursive', true)
%   recurse =
%       'a'
%       {1x2 cell}
%       {1x3 cell}
%   >> recurse{2}
%   ans =
%       'b'     'c'
%   >> recurse{3}
%   ans =
%       'b'     'd'     'e'

function fnames = field_names(s, varargin)
%% inputs
  v_switch = @(a) validateattributes(a, {'logical', 'numeric'}, {'scalar'});

  p = inputParser();
  p.addRequired('s', @isstruct)
  p.addParameter('recursive', false, v_switch)
  p.parse(s, varargin{:})

%% analysis

  if p.Results.recursive
    fnames = get_field_names(s);
  else
    fnames = fieldnames(s);
  end
end

%% Recursive field name fetcher
function fnames = get_field_names(s, parent)
  % extract names and data
  f_names = fieldnames(s);
  c = struct2cell(s);

  fnames = {};
  for indx = 1:length(c)
    % add to stack of parent names
    if nargin > 1
      pointer = [parent, f_names(indx)];
    else
      pointer = f_names(indx);
    end

    % collect in `fnames`
    if isstruct(c{indx})
      fnames = [fnames; get_field_names(c{indx}, pointer)];
    else
      fnames{end + 1} = pointer;
    end
  end
end