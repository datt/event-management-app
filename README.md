# README

Evaamo ;) - This is an event management application. 

# Problem Statement

The application has two main entities, Users and Events.
A user can create an event and can add other users as a part of the event, each user can update their rsvp for the event, 'yes', 'no', 'maybe'.
A user can choose to attend an event, in such case, if there is another overlapping event for the same user, it should automatically update the rsvp as 'no'.

## Assumptions

1. Phone validation is not correct, need to add proper validation. Need proper requirements as every country has it's own format.
2. Event field 'allday' default: false
3. Didn't want to commit csv files but to work, pushing
4. While Importing event first user considered as creator
5. User having more than one overlapping events. In such case consider the rsvp of last overlapping event to be `yes` - handled by callback
6. Didn't understand the 'Slot' thing, so assumed to filter by user id with date range.

## Tech Stack with version
  1. `Ruby 2.6.3`
  2. `Rails 6.0.2`
  3. `Postgres 9.5`
  4. CSS Framework - `Bootstrap 4`

## Standards to follow
  1. SOLID Principles
  2. Services Design pattern
  3. Decorator Pattern
  4. BEM CSS standards (limited but mostly bootstrap is used)
  5. Linters 

## Setup instructions
  1. Copy config/database.yml.example to config/database.yml
  2. copy env.example to .env and update the local config (for developement env only.)
  2. `yarn install`
  3. `rake db:create`
  4. `rake db:migrate`
  5. `rake db:seed`

## TODOs
Unit Test cases
Also Manual testing
Some TODOs are pending mentioned with #TODO