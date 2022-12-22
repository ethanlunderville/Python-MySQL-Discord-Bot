# BUSINESS REQUIREMENTS

### GROUP BY / HAVING

1. Show the quantity of items that there is for every brand of shoe. Make sure to only show quantities if they are above 1.
   
   /show-brand-quantity
   
2. Show the longest video for each type of video category that is over 10 seconds long.

  /longest-videos

3. Show the sum of the cost of all orders made on a specific date but only if that sum is above 55 dollars.

  /order-sum-by-date

4. Show number reports made on the same piece of content. Make sure that the number is at least above 2.

  /number-of-reports

### NESTED/INNER QUERIES

5. Show the names of all students that are enrolled in a specific class (In my database the class will be CSC675).

  /show-names-of-students-CSC675

6. Show the email of the user who made a post.

  /show-email-on-post <postId>  

### TRIGGERS

7. After an admin reviews a content report. Iterate the reports reviewed column of the admin.

  /update-content-report
  /show-admins
   
8. After a user orders something. Iterate the items bought column for that user.

  /insert-into-orders
  /show-users

## PROCEDURES

9. Create a procedure that shows all posts and their comments in the same table.

  /show-posts-and-comments
    
11. Create a procedure that deletes all classes.

  /delete-classes
  /show-classes

### FUNCTIONS

11. Create a function that takes a price of a product as a parameter and outputs whether or not that price is cheap, medium price or expensive.

  price-determiner <price>

12. Create a function that returns how many days have passed since a given account was created.

  /days-passed <post>

### UPDATE BY JOINING

13. Update the banned users ban end date to null if the users banned boolean value is false.

-- OMITTED --

14. Update the most recent post time column in the user table to match the time of the most recent post from that user in the posts table.

-- OMITTED --

### DELETIONS

15. When a user is deleted it should cascade and delete the users account as well.

  /delete-user <userId>
  /show-users-accounts 

16. When a post is deleted, all comments on the post should also be deleted.

  /delete-post <postId>
  /show-posts-comments 

## COMMANDS

    1. /show-brand-quantity
    2. /longest-videos
   
    3. /order-sum-by-date
    4. /number-of-reports
    5. /show-students-csc675
    6. /show-email-on-post <postId>

    7. /update-content-report
    9. /show-admins // In order to see the effects of the trigger

    10. /insert-into-orders // use /show-users to see
    11. /show-users

    12. /show-posts-and-comments
    
    13. /delete-classes
    14. /show-classes
    
    15. /price-determiner <price>
    16. /days-passed <post>

    17. /delete-user <userId>
    18. /show-users-accounts // for /delete-user 

    19. /delete-post <postId>
    20. /show-posts-and-comments // for /delete-post 

    21. /reset-db
    22. /refresh-data