# Week 6

The theme for this week is:

![Refactor All The Things](http://i.imgur.com/wEioQuZ.jpg)

For the first half of class, we will explore a few techniques in Rails
that enable us to simply our code.

(The second half of class is the midterm.)


### Week 5

The themes for this week are:

* Models are everything
* Security is everything, too

### Model Validations

Recall that a domain model has two responsibilities:

1. Represent something in the real world
2. Be a gateway for data related to that real-world thing

Each model should also guarantee the integrity of the
data it persists to and from the database.  In Rails, the rules
pertaining to data values that can be stored in the
database are called _validation rules_.

Implementing data rules and policies belong in the model,
so Rails provides a DSL specific to validations.

When you call `.save`, `.create`, or `.update`, all validation
rules will be run, and the object will not be saved if any
of the validations fail.

You can know if something went wrong:

1. by checking the return value of `.save`
1. by checking the `.errors` collection on the object

Here's a handy tip: `.errors.full_messages` will return an array
of all of the validation failures.

Finally, did you know that HTTP is a stateless protocol?  You did?
Awesome.  So then you already know that if you're trying to save an
object and a validation rule fails, you'll need to cope with it
_during that same request_, or you'll lose all of the validation data.

For a complete overview of all validations, see the Rails Guides:

http://guides.rubyonrails.org/active_record_validations.html




### Security

**Authentication**

Last week we learned how to use cookies to let users sign in.  That
is called authentication.

**Authorization**

This week we will learn how _authorize_ users to perform certain actions.
The bad news is that there isn't just one way to authorize an action, there
are two.  The good news is, there are only two ways to authorize an action.

1. Put code in the controller action method to redirect the user away from
the action.  For example, if someone is trying to view a user profile that's
not their own, we can redirect them back to the home page instead.
2. Use conditional logic in the view to hide or disable the unauthorized
activity. For example, if only logged-in users should be able to write a review,
we can use an `if` statement to make sure someone is logged in before
rendering the form.

**Hiding Things**

* We use the `bcrypt` gem to help us encrypt passwords with a one-way hash.
* We use `has_secure_password` in our `User` model to automatically encrypt
passwords, but we must have a string column named `password_digest` in our model.
We will gain an in-memory-only attribute accessor named :password, and assigning
a value there will automatically be encrypted into the `password_digest` column.
We also get a very helpful method named `.authenticate()` that can test a plain-text
password against the encrypted hash on our behalf.  
* We generally use `password_field_tag` in HTML forms to try to hide the password.  It's not
very secure, though.

Details on `has_secure_password` here: http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password


That's all we need to know for this course, but if you're curious to learn more:
http://guides.rubyonrails.org/security.html

### Model Associations

In a relational database, we relate one table to the next by inventing
foriegn key columns and filling them with the correct values, so that
rows from one table will be related to another.  SQL queries can leverage
this to pull large swaths of related data from multiple tables in
one fell swoop.

But we prefer to use Ruby, not SQL.  We've already seen how to use
`.find_by` and `.where` to query for related rows of data from different
tables.  We can also write custom Ruby methods to do this work for us,
so that's what we'll be doing in class.


### RESTful Routing

Always use `rails routes` as the authority on the routes that your application supports.
Don't trust your eyes by simply reading the `config/routes.rb` file.

## WEEK 4

The themes for this week are:

* Cookies
* RESTful Architecture
* One-to-Many queries with `.where()`

This application contains a lot of prewritten code for you to study. We
will not review everything in class.  All prewritten code can be found here:

* config/routes.rb
* app/controllers/*
* app/views/*
* db/models.yml
* db/seeds.rb



Detailed requirements for the Project Milestone, which is due August 2, will be available this weekend.


### `rails db:seed`

An optional feature of Rails is `rails db:seed` which will execute any
Ruby script code found in `db/seeds.rb`.  We tend to use this script
to provide a "factory reset" for the database, or to "seed" the database
with initial data that's required in order for our application to run
properly.

I will be using `rails db:seed` in class as a way for you to instantly
hydrate your database with lots of useful test data so that you can avoid
the tedium of using the `rails console` to create rows of data to play with.

### HTTP is a Stateless Protocol

HTTP 1.x is a request-response protocol. Each request-response cycle is independent.  The
server cannot maintain state from one request
to the next.  Once a response has been sent
to the client, the server loses any state
it had accumulated during the processing of
the request.


### Cookies and Sessions

* A *browser cookie* is a simple name-value pair of strings (with a few other attributes)
* Cookies are created by the server and transmitted as part of a response
* Cookies are stored on the client's filesystem
* The client may limit the number of cookies that can be created per website
* Rails views and controllers can use the `cookies` hash and/or `session` hash
* Pre-existing cookies are always transmitted to the server with every request
* Cookies can "expire", which means that we hope the browser deletes it

Creating a user "session" cookie (logging in) and deleting the session cookie
are generally handled by a separate controller called _SessionsController_.

The typical user signup/login/logout cycle is usually implemented as follows:

1. Sign Up creating a row in the `users` table
2. Login creates a session cookie to store the value of the user's primary key
3. Logout destroys the cookie

Rails is very nice, in that it relieves us of having to learn how to manually
create and destroy the propery HTTP headers corresponding to cookie values.
We are given a pre-made Ruby hash called `cookies` that we simply modify
as needed, and Rails will translate any hash modifications into HTTP headers.

Similarly, we do not need to be experts at cryptography to create encrypted
tamper-proof cookies.  We can simply use the `session` hash and Rails will
take care of the rest.


### Model Queries: Calculations

All calculation methods work directly on a model:

``` ruby
Client.count
# SELECT count(*) AS count_all FROM clients
```

Or on a relation:

``` ruby
Client.where(first_name: 'Ryan').count
# SELECT count(*) AS count_all FROM clients WHERE (first_name = 'Ryan')
```

You can also use various finder methods on a relation for performing complex calculations:

``` ruby
Client.includes("orders").where(first_name: 'Ryan', orders: { status: 'received' }).count
```

which will execute:

``` sql
SELECT count(DISTINCT clients.id) AS count_all FROM clients
  LEFT OUTER JOIN orders ON orders.client_id = clients.id WHERE
  (clients.first_name = 'Ryan' AND orders.status = 'received')
```

**Count**

If you want to see how many records are in your model's table you could call `Client.count` and that will return the number. If you want to be more specific and find all the clients with their age present in the database you can use `Client.count(:age)`.


**Average**

If you want to see the average of a certain number in one of your tables you can call the `.average` method on the class that relates to the table. This method call will look something like this:

`Client.average("orders_count")`

This will return a number (possibly a floating point number such as 3.14159265) representing the average value in the field.

**Minimum**

If you want to find the minimum value of a field in your table you can call the `.minimum` method on the class that relates to the table. This method call will look something like this:

`Client.minimum("age")`

**Maximum**

If you want to find the maximum value of a field in your table you can call the `.maximum` method on the class that relates to the table. This method call will look something like this:

`Client.maximum("age")`


**Sum**

If you want to find the sum of a field for all records in your table you can call the `.sum` method on the class that relates to the table. This method call will look something like this:

`Client.sum("orders_count")`

<hr>


## WEEK 3

### Domain Modeling

In software engineering, a domain model is a conceptual model of the domain that incorporates both behavior and data. See https://en.wikipedia.org/wiki/Domain_model.

Next, see the [Notes on Rails Models](notes-models.md) in this folder.

### RESTful Architecture

REST is an acronym for Representational State Transfer, as described in Roy Fielding's
Ph.D dissertation here: https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm

You're not expected to read the dissertation but I provide the link here for those
that are very interested in software architectural styles.

I can summarize it this way:

* URLs are nouns
* HTTP methods are verbs
* HTTP client software manipulates internet-based resources by using the combination of a verb and a noun; or an HTTP Method + URL.

See the [Notes on RESTful development](notes-restful.md).

### Links from class

* https://httpstatuses.com/
* http://guides.rubyonrails.org/layouts_and_rendering.html#using-redirect-to
* http://api.rubyonrails.org/v5.1.1/classes/ActionView/Helpers/FormTagHelper.html

### Miscellaneous Rails Goodies

**Controller Instance Variables**

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


**Named Routes (optional feature)**

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


**Redirection**

* HTTP defines a 302 status code, which tells the browser
that it must re-submit the request to a different resource.  
* If you send back a 302, you must include
a location header that provides the URL of the other location.  
* `redirect_to` can be used to respond with a properly-formatted
302 response.  It also supports an option to generate a "flash message" to display to the user.
* Flash messages can be displayed by adding code to the application layout to display notices and/or alerts.
