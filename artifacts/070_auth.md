## HMAC authorization

1. User registers by providing a username & password
2. Client sends username & password to server
3. Server generates a random private key
4. Server saves username, hashed password, and private key to database

5. Client logs in by sending username & password to /login/
6. Server returns private key

7. Client makes request
 a. username
 b. request body
 c. timestamp (utc)
 d. hash of private key + http method + request url + request body + timestamp (utc)
8. Server receives request
9. Server checks request timestamp vs. server time (utc)
 a. reject if out of reasonable time window (5 min?)
10. Retrieve private key from database, looking up via username
11. Server makes a hash of private key + http method + request url + request body + timestamp from request
12. Server compares its hash to the request's hash
 a. reject if they don't match
13. Server carries out request and returns response

