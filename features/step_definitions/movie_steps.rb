Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create!(movie) # <<< --- Backround test passes OK
  end
#  flunk "Unimplemented"
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  #~ debugger
  #~ true
  Movie.find_by_title(title).director.should == director # works
end


# ----------------------------------------------------------------------
Given /all ratings selected/ do 
	# By default there are no PG-17 films in the DB
	#~ all_ratings = []
	#~ Movie.all.each {|r| all_ratings << r.rating}
	#~ all_ratings.uniq!
	
	all_ratings = ["G", "R", "PG-13", "PG", "NC-17"]
	
	#~ ddd all_ratings
	When %Q{I check the following ratings: #{all_ratings.join(", ")} }
	And %Q{I press "ratings_submit"}
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	
  #~ ddd uncheck
  #~ ddd uncheck.inspect
  rating_array = rating_list.split(",")
  if !uncheck
	  rating_array.each do |rating|
		 When %Q{I check "ratings_#{rating.strip}"}
		 #~ And %Q{I press "ratings_submit"}
	  end
  else 
	  rating_array.each do |rating|
		 When %Q{I uncheck "ratings_#{rating.strip}"}
	  end
  end
end
