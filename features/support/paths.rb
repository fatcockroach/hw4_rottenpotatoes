# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      #~ '/' # original version
      '/movies' # by default in test cases all checkboxes are not checked - movie list will be empty
      
      # to show all movies:
      #~ '/movies' + "?ratings[G]=1&ratings[NC-17]=1&ratings[PG]=1&ratings[PG-13]=1&ratings[R]=1&sort=release_date"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
  
    when /^the edit page for "(.*)"$/
      edit_movie_path(Movie.find_by_title($1)) # works
      #~ "/movies/#{Movie.find_by_title($1).id}/edit"
      #~ '/movies/' + Movie.find_by_title($1)[:id].to_s + '/edit' # works
      #~ '/movies/' + Movie.find_by_title($1).id.to_s + '/edit'
    when /^the details page for "(.*)"$/
      movie_path(Movie.find_by_title($1))
    when /^the Similar Movies page for "(.*)"$/
      #~ movies_by_director($1) # doesn't work
      puts '*'*30
      puts $1
      puts '*'*30
      Movie.find_by_title($1).director
      #~ '/movies/search_by_director/' + Movie.find_by_title($1).director
      '/movies/search_by_director/' + Movie.find_by_title($1).id.to_s
      
    
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
