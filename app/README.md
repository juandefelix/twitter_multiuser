This application uses OAuth to sign in with Twitter as a side task in the backend.
Also, in the front end runs two asyncronous tasks:  
 - A call to the tweeter poster method  
 - Checks every 3 seconds to see if the app actually tweeted. There's a time out time. It will display if the app successfully tweeted, is waiting or the time out expired.
