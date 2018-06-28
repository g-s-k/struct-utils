% TEST run test suite for struct-utils module
%
%   TEST runs all of the tests present in the `+testing` directory
%   that follow MATLAB's unit test naming conventions.

% import testing framework
import matlab.unittest.*

% create test suite from subpackage
suite = TestSuite.fromPackage('s_utils.testing');

% run the tests
result = suite.run();

% make them into a table
rt = table(result);

% show the results
disp(rt)
