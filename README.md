# Week 3

The themes for this week are:

* Domain Modeling
* RESTful Architecture

This application contains a lot of prewritten code for you to study. We
will not review everything in class.  All prewritten code can be found here:

* app/assets/stylesheets/application.css
* app/controllers/*
* app/views/*
* config/routes.rb

### 1. Domain Modeling

In software engineering, a domain model is a conceptual model of the domain that incorporates both behavior and data. See https://en.wikipedia.org/wiki/Domain_model.

Next, see the [Notes on Rails Models](notes-models.md) in this folder.

### 2. RESTful Architecture

REST is an acronym for Representational State Transfer, as described in Roy Fielding's
Ph.D dissertation here: https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm

You're not expected to read the dissertation but I provide the link here for those
that are very interested in software architectural styles.

I can summarize it this way:

* URLs are nouns
* HTTP methods are verbs
* HTTP client software manipulates internet-based resources by using the combination of a verb and a noun; or an HTTP Method + URL.

See the [Notes on RESTful development](notes-restful.md).

### 3. Links I might mention in class

* https://httpstatuses.com/
* http://guides.rubyonrails.org/layouts_and_rendering.html#using-redirect-to
* http://api.rubyonrails.org/v5.1.1/classes/ActionView/Helpers/FormTagHelper.html

### 4. Miscellaneous Rails Goodies

**4.1 Controller Instance Variables**

Views are not responsible for gathering the data
they need to display.  That's the controller's job.
An action method can load data into member instance variables
and the corresponding view will have access to those same
variables.

``` ruby
class FavoritesController < ApplicationController

  def index
    @my_faves = ["cookies", 21, "Ruby"]
  end

end
```

``` html
<!-- index.html.erb -->
<h1>My Favorites</h1>

<ul>
<% @my_faves.each do |fave| %>
  <li><%= fave %></li>
<% end %>
</ul>
```

HTTP is stateless.  All instance variables are destroyed once the response has
been sent back. Instance variables cannot be used between one action and the next.


**4.2 Named Routes (optional feature)**

Each URL listed in your `routes.rb` file can be _named_.  Naming a URL
provides a level of indirection between the rest of you application code
and the URL itself.  The name establishes two Ruby methods that you can
call whenever you need the URL.  Instead of hardcoding URLs as strings
all over your application, you can invoke the named methods instead.


We add names to each URL by using the `as:` option.

``` ruby
# config/routes.rb
Rails.application.routes.draw do

  get '/' => 'stations#index', as: 'root'

  get '/stations' => 'stations#index', as: 'station_list'
  get '/stations/:id' => 'stations#show', as: 'station'

  # You can add more routes anywhere in this file
  # if needed.

end
```

This means that elsewhere in your application, instead of code like this:

``` erb
<%= link_to "See The List of Stations", "/stations" %>
```

you can write

``` erb
<%= link_to "See The List of Stations", stations_path %>
```

and instead of

``` erb
<%= link_to "My Station", "/stations/456" %>
```

you can write

``` erb
<%= link_to "My Station", station_path(456) %>
```

In controllers, you should use the fully-qualified URL by using the `*_url`
version:

``` ruby
def create
  # ...
  redirect_to stations_url
end
```

Remember: [view the source, Luke!](https://www.youtube.com/watch?v=o2we_B6hDrY)


**4.3 Redirection**

* HTTP defines a 301 status code, which tells the browser
that it must submit another request to a different resource.  
* If you send back a 301, you also need to include
a location header that provides the URL of the other location.  
* `redirect_to` can be used to respond with a properly-formatted
301 response.  It also supports an option to generate a "flash message" to display to the user.
* Flash messages can be displayed by adding code to the application layout to display notices and/or alerts.
