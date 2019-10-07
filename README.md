# Alta

### Members and teamwork

Below is the list of the members of our group:
* Chan Ken Lok
* Kassandra Yuen
* Tom Tonner (AquinasAhoy for some of the commits)
* Manas Sarpatwar
* Simonas Petkevicius
* Ibrahim Sinan Bicer
* Su Zhong Ying

Most of the work was split up by deciding what role would be best suited to each individual.

* Chan Ken Lok was allocated tasks mainly to do with the database and back-end
   code such as validation.

* Kassandra Yuen designed most of the ‘index’ and ‘my account’ pages and
   implemented the CSS and HTML to make it all work.

* Tom Tonner mainly helped with back-end coding with the admin settings, but also
   helped in other areas such as minitesting, debugging and writing the reports and
   story cards.

* Manas Sarpatwar was the main developer who designed and coded the dashboard,
   as well as the one who created all the cucumber tests.

* Simonas Petkevicius’ role was to do the marketing and Twitter analytics pages you
   see on the admin dashboard.

* Ibrahim Sinan Bicer’s main role was manual testing and reporting errors in the
   system.

* Su Zhong Ying helped with the manual testing and other small tasks to make sure
   The end product was worthy of distribution and stratified our clients.

In the first iteration most of our work was done on weekends and during meetings where
every member was present and worked on the code together, helping each other and
communicating in person.

During the second iteration however, we spent most of the time doing work at home and
communicating over slack and facebook. This change in work was largely due to the Easter
break.

## System setup before running (very important)

Make sure to follow each step exactly as stated in the following instructions before trying to
run our application.

### Clone the project git repository

Open the terminal and in the terminal type:

```
git clone https://github.com/manassarpatwar/Alta.git
```

### All other requirements

For all other requirements for our system, run the
following commands in the terminal:

Change directories
```
cd Alta:
```
Install ruby 2.6 with rvm if not installed (Works only on linux and macos):
```
rake installrvm
```

Next:
```
rake install
```
_Note: this will take a while and requires two confirmations to complete the process_


### How to run the app

Once all requirements are installed you can start running the app by making sure you’re in
the project directory (using ​cd ​if needed) and in the terminal running the command:
```
rake run
```
The website will be up and running on localhost at this url
```
http://localhost:4567/index
```

## Walkthrough the app

To help you see all of our features we’ve outlined our website by page and talked about all
the features of each page.

Firstly, as an overview this is our site map for our web-application:
![Overview](https://user-images.githubusercontent.com/44678221/66308823-e94db800-e8ff-11e9-976e-9d0ce2334179.png)

### Welcome page

Upon running the server and loading the web app you’ll be greeted by our welcome page,
which is available to view by anyone.

_Note: The ‘login’ link can be found on the top right of the navigation bar and the ‘logout’ link
and ‘my account’ link can be found at the bottom of the footer._

### Login

To login, first click the ‘login’ link on the right of the navigation bar. This will redirect you to
Twitter to login.


After logging into Twitter it will redirect you back to the welcome page but this time instead of
seeing ‘login’ on the right of the navigation bar you should see ‘my account’ or ‘admin
dashboard’ depending on which account you used to log in.

_Note: To access the admin dashboard and functionalities you_ ​ **_must_** _use the details for the
ise19team29 Twitter account._

### My account

To go to ‘my account’ click the link in the top right of the navigation bar (if logged in and not
an admin) or scroll to the footer of the welcome page and click the ‘my account’ link there.

Features of the ‘my account’ page:
* A summary section
* Delete account button
* A history section where users can view all their previous rides
    * All journey’s view which allows users to rate and comment about each individual journey
    * Search view which allows users to easily view and filter all journeys
* A general feedback and rating section

_Note: To go back to the home page or logout click the respective links at the footer of the
page or click the links in the header (logo or logout picture)._

### Admin dashboard

To access the admin dashboard you ​ **need** ​ to login as an admin (ise19team29).

Firstly the dashboard page is split into 3 sections:

1. Incoming tweets
2. Add a journey to the database section
3. List of available and unavailable taxis

The idea behind this layout is to see all tweets incoming and be able to reply and then add a
journey by taking details from the tweets and assigning a taxi to that journey.

Four buttons on the incoming tweets section:

1. Tick button: allows the admin to reply to the tweets and sets info in the journey
    section
2. X button: removes tweet from display as it is not relevant anymore
3. i button: which sends the admin to the link of the incoming tweet
4. Garbage button: deletes the tweet from timeline of ise19team29 (only shows up on
    replies made by ise19team29 to users, in case they have made an error)


With this layout it’s very easy for the employee to reply and assign taxis to the users. It also
means the information is easily and quickly added to the database so the employee can
assign more taxis to different users.

### Analytics

In the analytics page admins can view statistics on:
* Total number of users
* Total number of journeys
* Total amount of feedback
* Number of taxis registered

Each include the current total as well as a detailed graph into how they have changed over
each day, giving the employees the chance to see their ratings, growth and profits.

### Twitter marketing

The Twitter marketing page allows the employees to send tweets and follow users through
keywords.

Simply type a tweet message and press the tweet button. Or enter a keyword and press the
follow button.

### Admin settings

The first feature in the admin settings is the way to change the current deal on offer for
number of free rides. Simply enter a different number and press edit or the enter key.

The rest of the settings page is split into tables for the:
* User data
* Journey data
* Taxi data
* Feedback data

For each you can view all the data stored in the database and on top of that manually edit,
delete or add to each of the tables.

### Logout

Finally, the ‘logout’ link logs the user out of Twitter and redirects the user back to the
welcome page where they can no longer access other features unless they login again.

## The automated tests

After most of the main development was done we went back and developed automated tests
to make sure our system was fully tested and testing was rigorous.

However, in order for cucumber tests to run on codio, we set up ‘selenium’s chrome
headless javascript driver’ for capybara which allows us to sign in to Twitter and validate ajax
content in the tests. In order to run this driver, an external chromedriver has to be installed
on codio, which takes a fair amount of time to install. Due to a majority of the tests running
on the admin dashboard, each test scenario requires the user to be logged in as admin and
as such the tests tagged with ‘@javascript’ run slowly.

If tests are run multiple times in quick succession then the login feature will fail as Twitter will

think the login activity as suspicious and lock the account for a short while.

The mintests have 41 separate test cases for 6 different methods. The cucumber has 46
scenarios covering most of the rest of the code and features.

Minitest Results: 

![Minitest Results](https://user-images.githubusercontent.com/44678221/66309353-59107280-e901-11e9-99e1-1118e13018f6.png)

Cucumber Results:

![Cucumber Results](https://user-images.githubusercontent.com/44678221/66309481-af7db100-e901-11e9-838d-a47cadf183c2.png)

### Coverage level

Coverage Levels:

![Coverage Levels](https://user-images.githubusercontent.com/44678221/66309591-f10e5c00-e901-11e9-880f-c4a40482ad6d.png)

The testing combined covers 95.28% of the lines of code written. The ~5% not covered is
mainly due to a rescue clause that the twitter API methods have for hitting a Twitter rate limit
error. Although steps have been taken so that a user does not abuse the buttons and hit the
rate limit, a rescue clause is present in case it ever is raised. We attempted to cover this
manually in the manual test #24. Other lines not covered required specific scenarios and
looping over set of adding data, which would have further slowed down the testing time, so
were omitted in the automated testing. A more specific scenario of deleting account of a user
was tested manually in manual test #25.

To run the cucumber and minitest together, make sure you’re in the project directory (using
cd ​if needed) and simply enter the following command in the terminal:

```
rake test
```
To run the respective tests on their own type in the terminal either:

```
rake cucumber​ or ​rake minitests
```
The cucumber tests require a test database to be created. Before running individual feature
files, run:

```
rake createtestdb
```
After running individual feature files, run:

```
rake clean
```
to delete the created test database.
