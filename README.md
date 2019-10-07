# Forget Me Not List

This is a basic ruby on rails app that allows users to add, check/uncheck and delete items as part of a coding challenge.

![ForgetMeNot](https://user-images.githubusercontent.com/51078359/66297642-c9d48080-e93b-11e9-9606-38293cb453e6.gif)

## Installation instructions

Requires Ruby version 2.6.3.

Run `bundle install` in the CLI to install all required gems.

Run `rake db:migrate` to set up database

Run the app by typing `rails s` in the CLI.

Open http://localhost:3000/ by default unless you've specified otherwise in the configuration.


## Dependencies
- `jquery-rails` for help with manipulating the DOM. I didn't want to have to use jquery but the Rails Unobstrusive Javascript library was not working for me. 

## Testing
Test suite used for this app is RSPEC

To run tests type `rspec` into CLI

I enlisted the help of FactoryBot to help create sample data for testing.


## Design Decisions

### Home
- App only uses one page for simplicity
- Home controller loads all items to be used in the client
- Items are rendered using partials
- Has a form that adds new items via AJAX request to `/api/items/` POST using rails form_with helper

### Partial (for each item)
- Each item will render with a checkbox binded to the delete, checked and text fields
- It leverages the power of the form_with helper on each item to handle the API requests via AJAX and update the DOM
- When a checkbox is marked it triggers a change event and toggles the `checked?` field to true or false
- It also adds a class name to the item to gray out the item when its checked

  ### Note:
  - I tried using Rails JS native library, UJS, which worked great to make a request but unfortunately couldn’t figure out why it was unable to manipulate the DOM. I needed to install the `jquery-rails` gem to be able to modify the DOM after each request eg add items to the list or add ‘grayed-out’ classes to the checked item

### Testing
- Tested the API endpoint to ensure they were returning what was necessary for the front-end
- Items controller was tested using RSPEC test of type requests
- The home controller and views was a bit trickier as I was not sure how to write test for views, so will write tests after

### API endpoints
- Items resources were created inside the API namespace
- I only created the endpoints for update (for the checkbox), delete, and create as I didn't think it was necessary to be able to edit a list item
- End points accepts 2 formats in most methods
    - JS: useful to render JS in the native Rails was to execute the in the client on successful requests
    - JSON: which renders json and was mainly used to develop an test the API

### Database
- On the assumption that the app does not use sessions or have users, there is only one resource which is the list items
- There is one table in the database named `Items`
- It contains two fields (bar the default id and timestamps):
    - `text` (string - not betting on someone having more than 255 characters for a list item)
    - `checked?` (boolean, which can be toggled)
- SQLite3 was chosen for the ease of use and accessibility since it is a built-in database for Rails. For the size and purpose of the exercise, I thought it best to reduce the amount of dependencies

![app design](/public/app_design.png)
