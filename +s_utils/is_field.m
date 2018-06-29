% IS_FIELD test membership in a struct
%
%   IS_FIELD(s, 'field_name') returns `true` if `field_name` is the name of a
%   field present in `s`, and `false` otherwise.
%
%   IS_FIELD(s, {'field1', 'sub_field1', 'sub_sub_field1'}) returns `true` if
%   `field1` is present in `s`, `sub_field` is present in s.field1, and
%   `sub_sub_field` is present in s.field1.sub_field1, and false otherwise.

function result = is_field(s, field)
  if ischar(field)
    result = isfield(s, field);
  else
    result = s_utils.is_field(s, field{1});
    if result && numel(field) > 1
      result = s_utils.is_field(s.(field{1}), field(2:end));
    end
  end
end