classdef TestIsField < matlab.unittest.TestCase

  methods (Test)

    function testSingleNameChar(testCase)
      s = struct('a', [], 'b', []);

      testCase.verifyEqual(s_utils.is_field(s, 'a'), true, ...
                           'Did not find an existing field.')
      testCase.verifyEqual(s_utils.is_field(s, 'c'), false, ...
                           'Found a nonexistent field.')
    end

    function testSingleNameCell(testCase)
      s = struct('a', [], 'b', []);

      testCase.verifyEqual(s_utils.is_field(s, {'a'}), true, ...
                           'Did not find an existing field.')
      testCase.verifyEqual(s_utils.is_field(s, {'c'}), false, ...
                           'Found a nonexistent field.')
    end

    function testMultipleNames(testCase)
      s = struct('a', struct(), 'b', struct('c', struct('d', [])));

      testCase.verifyEqual(s_utils.is_field(s, {'b', 'c', 'd'}), true, ...
                           'Did not find an existing field.')
      testCase.verifyEqual(s_utils.is_field(s, {'a', 'c'}), false, ...
                           'Found a nonexistent field.')
    end

  end

end