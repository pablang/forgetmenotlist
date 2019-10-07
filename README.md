# Forget Me Not List

This is a basic Ruby on Rails webapp part of a coding challenge that allows a user to add, check/uncheck and delete items. The data is stored on a database so that the app remembers the list items even if you close the window. The front end is able to access the backend API through the use of Ajax allowing minimal page re-renders.

![ForgetMeNotWConsole](https://user-images.githubusercontent.com/51078359/66303324-85021700-e946-11e9-96b5-1ef8d3762434.gif)

## Installation instructions

Requires Ruby version 2.6.3.

Run `bundle install` in the CLI to install all required gems.

Run `rake db:setup` to set up the database

Run the app by typing `rails s` in the CLI.

Open http://localhost:3000/ by default unless you've specified otherwise in the configuration.


## Dependencies
- `jquery-rails` to manipulate the DOM. I didn't want to have to add the extra jQuery dependency but the Rails Unobstrusive Javascript library was not working for me.
- `RSpec` used as the test suite
- `capybara` gem used to assist in testing views
- `FactoryBot` to help create sample data used during testing

All these dependencies should be met by running `bundle install`. There are no other external dependencies like database server, or any other service.

## Testing
The test suite used for this app is RSpec. To run tests type `rspec` into CLI.

This was my first project practising TDD on the whole app. There was alot to learn but luckily there is a lot of resources and documentation.

There are mainly 2 types of tests:
- API tests, using Rspec `type: request` tests, to ensure all API endpoints behave as expected and deal gracefully with situations other than the happy path, e.g. error handling, invalid parameters, etc.
- Views tests, using Rspec `type: view` tests, to ensure that the front end always include the elements that we expect: form elements, data, etc. and that partials are rendered with the correct information for each item on the list.

Work in progress: Creating some `feature` tests with Capybara and Selenium to do an end to end test of the app.

## Design Decisions

### Home
- The app only uses one page for simplicity
- The home controller loads all items to be used in the client
- The items are rendered using partials
- It has a form that adds new items via AJAX request to `POST /api/items/` using the rails form_with helper

### Partial (for each item)
- Each item will render a checkbox binded to the value of `item.checked?`, its text and a delete link
- It leverages the power of the form_with helper on each item to handle the API requests via AJAX and update the DOM
- When a checkbox is marked it triggers a change event (`PUT /api/item/:id`) and toggles the `checked?` field to true or false
- It also adds a class name to the item to gray out the item when its checked

  ### Note:
  - I tried using Rails JS native library, UJS, which worked great to make the requests but unfortunately couldn’t figure out why it was unable to manipulate the DOM. I needed to install the `jquery-rails` gem to be able to modify the DOM after each request e.g. add items to the list or add ‘grayed-out’ classes to the checked item

### API endpoints
- Items resources were created inside the API namespace
- I only created the endpoints for update (for the checkbox), delete, and create as I didn't think it was necessary to be able to edit a list item
- End points accepts 2 formats in most methods
    - JS: useful to render JS in the native Rails way to execute them in the client on successful requests
    - JSON: which renders json and was mainly used to develop an test the API

### Database
- Being a technical exercise with a defined (small) scope, to be run locally, I made the assumption of not adding users or session tables, meaning that all users would share a common list.
- With that in mind there is only one table in the database named `Items`
- It contains two fields (bar the `id` and `timestamps`):
    - `text` (string - limited to 255 characters for a list item)
    - `checked?` (boolean, which can be toggled)
- SQLite3 was chosen for the ease of use and accessibility since its support is built-in for Rails. Considering the size and purpose of the exercise, I thought it's best to reduce the amount of dependencies.

![app design](/public/app_design.png)
