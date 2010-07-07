generate('rspec:install')
generate('controller wombats index')
generate('integration_test widgets')
generate('mailer Notifications signup')
generate('model thing name:string')
generate('helper things')
generate('scaffold widget name:string category:string instock:boolean')
generate('observer widget')
generate('scaffold gadget ') # scaffold with no attributes

puts "    Creating helper"
File.open( "#{File.dirname(__FILE__)}/../tmp/example_app/app/helpers/gadgets_helper.rb", "w" ) do |f|
  f.puts "
module GadgetsHelper
  attr_reader   :initialization_count

  def initialize( *args, &block )
    super *args, &block

    @initialization_count ||=  0
    @initialization_count +=   1
  end

end
  "
end

run('rake db:migrate')
run('rake db:test:prepare')
