Feature: Helpers in helper specs are initialized

  Rails helpers are initialized; the pseud-helpers provided in specs should
  follow the same behaviour.

  Scenario: expect mock view returned by #helper to have been initialized exactly once
    Given a file named "spec/helpers/gadgets_helper_spec.rb" with:
      """
      require "spec_helper.rb"

      describe GadgetsHelper do
        it "should be initialized exactly once" do
          helper.respond_to?( :initialization_count ).should  == true
          helper.initialization_count.should                  == 1
          3.times { helper }
          # helper should still only be initialized once
          helper.initialization_count.should                  == 1
        end
      end
      """
    When I run "rspec ./spec"
    Then I should see "1 examples, 0 failures"

