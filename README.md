# Seraphine

Seraphine is an API library for the Riot Games API. More specifically the League of Legends part of the API only. (for now)    

The library is built to be part of a final project in one of the courses I'm currently enrolled in. I have no clue if this works well at scale, so if you want to be the one to find out, feel free too.  
Also, in regards to rate limiting, all this library will do is do it's best to prevent 429s, by failing requests that would exceed the rate limit locally, in other words, your application that utilizes will have to implement its own request queues, retries, etc. The library is just here to make sure that even if a request slips through it doesn't cause a rate limit to be hit by Riots servers.

