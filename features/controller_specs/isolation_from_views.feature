Feature: do not render views

  By default, controller specs do not render views. This allows you specify
  which view template an action should try to render regardless of whether or
  not the template compiles cleanly.

  NOTE: unlike rspec-rails-1.x, the template must exist.

  Scenario: expect template that rendered by controller (passes)
    Given a file named "spec/controllers/widgets_controller_spec.rb" with:
      """
      require "spec_helper.rb"

      describe WidgetsController do
        describe "index" do
          it "renders the index template" do
            get :index
            response.should render_template("index")
            response.body.should =~ /generated by RSpec/
          end
          it "renders the widgets/index template" do
            get :index
            response.should render_template("widgets/index")
            response.body.should =~ /generated by RSpec/
          end
        end
      end
      """
    When I run "rspec ./spec"
    Then I should see "2 examples, 0 failures"

  Scenario: expect template that is not rendered by controller (fails)
    Given a file named "spec/controllers/widgets_controller_spec.rb" with:
      """
      require "spec_helper.rb"

      describe WidgetsController do
        describe "index" do
          it "renders the 'new' template" do
            get :index
            response.should render_template("new")
            response.body.should =~ /generated by RSpec/
          end
        end
      end
      """
    When I run "rspec ./spec"
    Then I should see "1 example, 1 failure"

  Scenario: set expectation about template content (fails with helpful message)
    Given a file named "spec/controllers/widgets_controller_spec.rb" with:
      """
      require "spec_helper.rb"

      describe WidgetsController do
        describe "index" do
          it "renders the 'new' template" do
            get :index
            response.should contain("foo")
            response.body.should =~ /generated by RSpec/
          end
        end
      end
      """
    When I run "rspec spec"
    Then I should see "Template source generated by RSpec"
