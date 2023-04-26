// sudo lsof -i :4500
// kill -9 <PID>

const mysql = require('mysql');
const express = require('express');
const jwt = require('jsonwebtoken');

const app = express();

app.use(express.json())

const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "Divyanshu30@",
  database: "DbmsProject"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

// Login Query

app.post('/login', (req, res) => {
   const {user_email, user_password} = req.body;
  con.query(`SELECT * FROM loginuser WHERE user_email = '${user_email}' AND user_password = '${user_password}'`, (err1, result1) => {
      if (err1) console.log(err1);
      if (result1.length > 0) {
          res.status(200).json({ message: 'Login successful!', statusCode: 200, data: result1 });
      } 
      else {
         res.status(400).json({ success: false, message: 'Invalid username or password.', statusCode: 400 });
      }
  });
});


// Search Query

app.post('/search', (req, res) => {
  const query = req.body;

  con.query(`SELECT fname FROM Students WHERE fname LIKE '%${query.fname}%'`, (err2, result2) => {
    if (err2) throw err2;

    console.log(result2);
    res.status(200).json(result2);
  });
});


// User Details Fetch

app.post('/accounts', (req, res) => {
  const user_email = req.body;
  con.query(`Select user_name, user_email, user_phoneno, user_position from loginuser where user_email = '${user_email.user_email}'`, (err3, result3) => {
    
    if (err3) console.log(err3);
      res.status(200).json(result3);
  });
});

// Events Data

app.get('/events', (req, res) => {
  con.query(`Select event_name, event_image, event_date_time from Events order by event_date_time asc`, (err6, result6) => {
    if (err6) console.log(err6);
    if(result6.length > 0){
      res.status(200).json(result6);
    }
    else
    res.status(400);
  })
});

// Register Team

app.post('/registerTeam', (req, res) => {
  const div = req.body
  con.query(`Insert into Team (team_name, college_name, team_contact, event_name) 
  values ('${div.team_name}', '${div.college_name}', '${div.team_contact}', '${div.event_name}')`, (err7) => {
    if (err7) console.log(err7);
    else{
      res.status(200).json({success: true});
    }
  });
});

// Fetch Team

app.post('/teamData', (req, res) => {
  const div1 = req.body;
  con.query(`Select team_name, college_name, team_contact from Team where event_name = '${div1.event_name}' order by team_name asc`, (err8, result8) => {
    if (err8) console.log(err8);
    if(result8.length > 0){
      res.status(200).json(result8);
    }
    else
    res.status(400);
  });
});

app.post('/notify', (req, res) => {
  const notification = req.body;
  con.query(`Insert into notifications (notifiation) values ('${notification.notification}')`, (err9) => {
    if (err9) console.log(err9);
    else{
      console.log('Notification inserted successfully');
      res.status(200).json({message: 'Notification inserted successfully'});
    }
  });
  con.query(`Select * from loginuser`, (err9, result9));
  if(err9) console.log(err9);

});

// Listening on Port

app.listen(4500, () => {
  console.log('Server started on port 4500!');
});

