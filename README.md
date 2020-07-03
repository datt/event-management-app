# README

Evaamo ;) - This is an event management application. 

# Problem Statement
The application has two main entities, Users and Events
A user can create an event and can add other users as a part of the event, each user can update their rsvp for the event, 'yes', 'no', 'maybe'
A user can choose to attend an event, in such case, if there is another overlapping event for the same user, it should automatically update the rsvp as 'no'


## Assumptions

1. Phone validation is not correct, need to add proper validation. Need proper requirements as every country has it's own format.
2. Event field 'allday' default: false
3. Didn't want to commit csv files but to work, pushing
4. While Importing event first user considered as creator
5. User having more than one overlapping events. In such case consider the rsvp of last overlapping event to be `yes` - handled by callback