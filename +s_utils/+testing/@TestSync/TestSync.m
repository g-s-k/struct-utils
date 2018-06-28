classdef TestSync < matlab.unittest.TestCase

  methods (Test)

    function testValidation(testCase)
      testCase.verifyFail()
    end

    function testBasicSync(testCase)
      s1 = struct('a', 0);
      s2 = struct('b', 1);

      result = struct('a', 0, 'b', 1);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2), result, ...
          'Failed to perform a basic sync.')
    end

    function testOverridingSync(testCase)
      s1 = struct('a', 0, 'b', 2);
      s2 = struct('b', 1);

      result = struct('a', 0, 'b', 1);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2), result, ...
          'Failed to perform an overriding sync.')
    end

    function testHardSync(testCase)
      s1 = struct('a', 0, 'b', struct('c', 2), 'd', []);
      s2 = struct('a', 1, 'b', struct('c', 3));

      result = struct('a', 1, 'b', struct('c', 3), 'd', []);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2), result, ...
          'Failed to perform a "hard" sync.')
    end

    function testSoftSync(testCase)
      s1 = struct('a', 0, 'b', struct('c', 2), 'd', []);
      s2 = struct('a', 1, 'b', struct('c', 3), 'e', 4);

      result = struct('a', 0, 'b', struct('c', 2), 'd', [], 'e', 4);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2, 'soft'), result, ...
          'Failed to perform a "soft" sync.')
    end

    function testTopSync(testCase)
      s1 = struct('a', 0, 'b', struct('c', 2), 'd', []);
      s2 = struct('a', 1, 'b', struct('c', 3), 'e', 4);

      result = struct('a', 1, 'b', struct('c', 2), 'd', [], 'e', 4);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2, 'top'), result, ...
          'Failed to perform a non-recursive sync.')
    end

    function testFlatSync(testCase)
      s1 = struct('a', 0, 'b', struct('c', 2), 'd', []);
      s2 = struct('a', 1, 'b', struct('c', 3), 'e', 4);

      result = struct('a', 0, 'b', struct('c', 2), 'd', [], 'e', 4);

      testCase.verifyEqual( ...
          s_utils.sync(s1, s2, 'flat'), result, ...
          'Failed to perform a non-recursive "soft" sync.')
    end

  end

end