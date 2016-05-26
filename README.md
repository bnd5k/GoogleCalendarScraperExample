# Overview

This is a Sinatra app that lists events pulled from a Google Calenda via the 
[google-api-ruby-client](https://github.com/google/google-api-ruby-client)
using in a server-side web environment.

It's based on a sample 
[provided here](https://github.com/google/google-api-ruby-client/tree/master/samples/web),
but whereas the Google's example relies on Redis, this example has no such dependency. 

# Setup

* Download this repo, navigate to its root directory on your mathcine and `bundle install`.
* Create a project at https://console.developers.google.com
* Go to the `API Manager` and enable the `Calendar` API
* Go to `Credentials` and create a new OAuth Client ID of type 
'Web application'. (Google should default naming it 'Web client 1'.)
* Use `http://localhost:4567/oauth2callback` as the redirect URL
* Use `http://localhost:4567` as the JavaScript origin
* Download your new credentials, which should consist of a client_id and secret.
* This project uses the dotenv gem, so to set environment variables, so you'll
add the credentials to the .env file (along with email).  Creat a .env file that looks like this

```
GOOGLE_CLIENT_ID="<Google client id>"   
GOOGLE_CLIENT_SECRET="<Google Sercret>" 
GCAL_EMAIL="<Email associated with Google Calendar>"
  # ^^ this should be the email address associated with the calendar you're inspecting

CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "gccal_scraper_example.yaml")
  # ^^ modidfy to whatever filepath you want
```
NOTE: without the environment variables about, your app will not run.



# Usage
* In terminal, run the program

```
ruby app.rb
```

* In your browser, open up the location where the server is running, which 
should default to `http://localhost:4567/`.
* The browser will show a list of the next 10 events from the calendar. 
