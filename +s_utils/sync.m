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
%% constants
  modes = {'hard', 'soft', 'top', 'flat'};

%% inputs
  p = inputParser();
  p.addRequired('s1', @isstruct)
  p.addRequired('s2', @isstruct)
  p.addOptional('syncType', 'hard', @(a) any(validatestring(a, modes)))
  p.parse(s1, s2, varargin{:})

  recurse = ismember(p.Results.syncType, {'hard', 'soft'});
  override = ismember(p.Results.syncType, {'hard', 'top'});

%% do the sync
  % get field names
  fields_s1 = s_utils.field_names(s1, 'recursive', true);
  fields_s2 = s_utils.field_names(s2, 'recursive', true);

  for indx = 1:numel(fields_s2)
    % don't recurse in non-recursive modes
    if recurse || numel(fields_s2{indx}) == 1
      % don't overwrite in soft modes
      if ~override
        try
          getfield(s1, fields_s2{indx}{:});
          continue % try next field
        catch
          % keep going
        end
      end

      % actually set the value
      s1 = setfield( ...
          s1, fields_s2{indx}{:}, ...
          getfield(s2, fields_s2{indx}{:}) ...
          );
    end
  end

end