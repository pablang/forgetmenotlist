# Forget Me Not List

This is a basic ruby on rails app that allows users to add, check/uncheck and delete items as part of a coding challenge.


## Installation instructions

Requires Ruby version 2.6.3.

Run `bundle install` in the CLI to install all required gems.

Run `rake db:migrate` to set up database

Run the app by typing `rails s` in the CLI.

Open http://localhost:3000/ by default unless you've specified otherwise in the configuration.


## Dependencies
- 'jquery-rails'

## Testing
Test suite used for this app is RSPEC

To run tests type `rspec` into CLI


## Design Decisions

### Home
- App only uses one page for simplicity
- Home controller loads all items
- Items are rendered using partials
- Has a form that adds new items via AJAX request to `/api/items/` POST using rails form_with helper

### Partial (for each item)
- Each item will render with a checkbox binded to the checked, text and delete button
- It leverages form_with on each item to handle the API requests via AJAX
- When checkbox is marked it triggers a change event and updates the database field => `checked?: true`
- It also adds a class name to the item to gray out the item when its checked

  ### Note:
  - I tried using Rails JS native library which worked great to make a request but unfortunately couldn’t figure out why it was unable to manipulate the DOM. I needed to install the `jquery-rails` gem to be able to modify the DOM and after each request eg add items to the list or add ‘grayed-out’ classes

### Testing
- Tested the API endpoint to ensure they were returning what was necessary for the front-end
- Items controller was tested using RSPEC test of type requests
- The home controller and views was a bit trickier as I was not sure how to write test for views, so will write tests after

### API endpoints
- Items resource created inside the API namespace
- Uses HTTP verbs to crud the items
- Accepts 2 formats in most methods
    - JS : useful to render JS in the native Rails was to execute the in the client on successful requests
    - JSON : which renders json and was mainly used to develop an test the API

### Database
- On the assumption that the app does not use sessions or have users, there is only one resource which is the list items
- It contains two fields (bar the default id and timestamps):
    - text (string - not betting on someone having more than 255 characters for a list item)
    - Checked? (boolean, which can be toggled)
- SQLite3 was chosen for the ease of use and accessibility since it is a built-in database for Rails. For the size and purpose of the exercise, I thought it best to reduce the amount of dependencies

