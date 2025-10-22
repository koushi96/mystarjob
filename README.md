# MyStarJob

A myStarJob fair web application built using Node.js, MySQL, and Apache to manage job listings, candidate tracking, and applications.

1. **Clone the Repository**
    git clone https://github.com/koushi96/mystarjob.git

2.  cd mystarjob

3.  Install Dependencies 
    npm install

4.  Start Apache and MySQL
    Use XAMPP or any local server environment

5.  Set Up the Database
    Create a database named my_star_job
    Import the SQL file located at db/my_star_job_full.sql:

    Option A: Using MySQL CLI
    mysql -u your_username -p my_star_job < db/my_star_job_full.sql

    Option B: Using phpMyAdmin
    Open phpMyAdmin
    Create a new database my_star_job
    Go to Import → Select db/my_star_job_full.sql → Click Go

6.  Start the Application
    npm run dev


------Requirements------
Node.js (v18) or above
MySQL 
Apache (e.g., via XAMPP)
npm

------Project Structure------
db/my_star_job_full.sql – Full database export (schema + data)
src/ – Application source code

------README.md – Setup guide------

------Notes------
Default DB user: koushi (Update in your config if different)
Ensure database credentials match your local setup