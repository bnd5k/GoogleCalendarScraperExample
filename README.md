# Overview

This is a Sinatra app that lists events pulled from a Google Calenda via the 
[google-api-ruby-client](https://github.com/google/google-api-ruby-client)
using in a server-side web environment.

It's based on a sample 
[provided here](https://github.com/google/google-api-ruby-client/tree/master/samples/web),
but whereas the Google's example relies on Redis, this example simply stores the data locally
(using Google's Google::Auth::Stores::FileTokenStore class).

## Ruby Version

This was built with Ruby 2.3. It's been tested with Ruby 2.1

Gem versions are pinned to ensure that this app works as expected (i.e. to protect against
changes to Google's API client gem).

## Setup

* Clone or Download this repo, navigate to its root directory and run `bundle install`.
* Create a project at https://console.developers.google.com
* Go to the `API Manager` and enable the `Calendar` API
* Go to `Credentials` and create a new OAuth Client ID of type 
'Web application'. (Google should default naming it 'Web client 1'.)
* Use `http://localhost:4567/oauth2callback` as the redirect URL
* Use `http://localhost:4567` as the JavaScript origin
* Download your new credentials, which should consist of a client_id and secret.

## Configuration

This project uses the dotenv gem, so to set environment variables, so you'll
add the credentials to the .env file (along with email).  Creat a .env file that looks like this

```
GOOGLE_CLIENT_ID="<Google client id>"   
GOOGLE_CLIENT_SECRET="<Google Sercret>" 
GCAL_EMAIL="<Email associated with Google Calendar>"
  # ^^ this should be the email address associated with the calendar you're inspecting

CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "gccal_scraper_example.yaml")
  # ^^ modidfy to whatever filepath you want
```

You have the choice of configuring the app to store credentials in Redis or on the
filesystem.  If you set an environment variable for REDIS_STORE the app will use Google's
RedisTokenStore class to store token information.  

```
REDIS_STORE=true
```

If you don't set this environment variable, the app will use Google's 
FileTokenStore class by default. However, if you don't set the REDIS_STORE variable,
be sure to set the CREDENTIALS_PATH, since it's used by the FileTokenStore class.


## Usage
* In terminal, run the program

```
ruby app.rb
```

* In your browser, open up the location where the server is running, which 
should default to `http://localhost:4567/`.
* The browser will show a list of the next 10 events from the calendar. 
