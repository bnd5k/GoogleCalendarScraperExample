# Overview

This is a Sinatra app that lists events pulled from a Google Calenda via the 
[google-api-ruby-client](https://github.com/google/google-api-ruby-client).

It's based on a sample provided, but whereas the Google's example relies on 
Redis, this example has no such dependency. 

# Setup

* Create a project at https://console.developers.google.com
* Go to the `API Manager` and enable the `Calendar` API
* Go to `Credentials` and create a new OAuth Client ID of type 
'Web application'. Google should default naming it 'Web client 1'.
* Use `http://localhost:4567/oauth2callback` as the redirect URL
* Use `http://localhost:4567` as the JavaScript origin
* Download your new credentials, which should consist of a client_id and secret.
* This project uses the dotenv gem, so to set environmetn variables, so you'll
add the credentials to the .env file (along with email)
* In terminal, run `bundle install`:w


# Usage
* In terminal, run the program

```
ruby app.rb
```

* In your browser, open up the location where the server is running, which 
should default to `http://localhost:4567/`.
* The browser will show a list of the next 10 events from the calendar. 
