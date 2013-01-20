CONTENTS = 'some contents'

# Given /^the file "([^"]*)" exists$/ do |file|
#   File.open(file,'w') { |file| file.puts(CONTENTS) }
# end
# Then /^the file "([^"]*)" should the same contents as "([^"]*)"$/ do |dest_file,source_file|
#   contents = File.read(dest_file)
#   contents.should == CONTENTS
# end