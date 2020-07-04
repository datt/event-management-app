# README

Evaamo ;) - This is an event management application. 

# Problem Statement

The application has two main entities, Users and Events.
A user can create an event and can add other users as a part of the event, each user can update their rsvp for the event, 'yes', 'no', 'maybe'.
A user can choose to attend an event, in such case, if there is another overlapping event for the same user, it should automatically update the rsvp as 'no'.

## Assumptions

1. Phone validation is not correct, need to add proper validation. Need proper requirements as every country has it's own format.
2. Event field 'allday' default: false
3. While Importing event first user considered as creator
4. User having more than one overlapping events. In such case consider the rsvp of last overlapping event to be `yes` - This is handled by model callback
5. Didn't understand the 'Slot' thing, so assumed to filter by user id with date range.
6. Didn't want to commit csv files but to make it work, commited files.

## Tech Stack with version
  1. `Ruby 2.6.3`
  2. `Rails 6.0.2`
  3. `Postgres 9.5`
  4. CSS Framework - `Bootstrap 4`

## Standards to follow
  1. [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
  2. [Services Objects](https://medium.com/@scottdomes/service-objects-in-rails-75ca74214b77)
  3. [Decorator Pattern](https://github.com/amatsuda/active_decorator)
  4. [BEM CSS standards](https://en.bem.info/methodology/quick-start/) (limited but mostly bootstrap is used)
  5. Linters
  (Presenter pattern could've been used)
  *Many things can be improved*

# Understanding Code 
  - Comments have been added, if not understood mail at duttdongare30@gmail.com
  - alternatively generate documentation using `yardoc app/services/**/*.rb app/models/**/*.rb` and open doc/index.html in browser


## Setup instructions
  1. Copy config/database.yml.example to config/database.yml
  2. copy env.example to .env and update the local config (for developement env only.)
  2. `yarn install`
  3. `rails db:create`
  4. `rails db:migrate`
  5. `rails db:seed`

## Pending.
  - Unit Test cases
  - Manual testing
  - Some TODOs are pending mentioned with #TODO
  - Code style corrections suggested by linters, Rubocop and Rails Best Practices
  - Presenter pattern could've been used instead of view logic and helpers