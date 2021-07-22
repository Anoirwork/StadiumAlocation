//finally in Index.js 
const app = require('express')();
require('dotenv').config();
var express = require('express');
const port = process.env.PORT;
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const mongoose = require('mongoose');
const cors = require('cors');
const multer = require('multer');
const fs = require('fs');
const path = require('path')
const { Stadium } = require('./models/StadiumModel')
mongoose.Promise = global.Promise;
mongoose.connect(process.env.DATABASE, { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true })
// app.use((req, res, next) => {
//     res.header('Access-Control-Allow-Origin', '*');
//     next();
// });

app.use('/uploads', express.static(__dirname +'/uploads'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(cookieParser());
app.use(cors());
app.listen(port, () => {
    console.log(`Server running at here ${port}`);
});
const { auth } = require('./middleware/auth')
const { Event } = require('./models/EventModel')
const { RegisterUser, LoginUser, LogoutUser, getUserDetails } = require('./controller/AuthController');
const { GetStadiumLocation, SaveStadium, getAllStadiums, getStadiumDetails, ReserveStadium , getStadiumUid } = require('./controller/StadiumController');

//user
app.post('/api/users/register', RegisterUser);
app.post('/api/users/login', LoginUser);
app.get('/api/users/get', auth, getUserDetails);
app.get('/api/users/logout', auth, LogoutUser);
//stadiul
app.get('/api/stadium/location', auth, GetStadiumLocation);


const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, new Date().toISOString() + file.originalname);
    }
});

const fileFilter = (req, file, cb) => {
    // reject a file
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
        cb(null, true);
    } else {
        cb(null, false);
    }
};

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5
    },
    fileFilter: fileFilter
});
app.post('/api/stadium/save', upload.single('photo'), async (req, res) => {
    var file = __dirname + '/' + req.file.path;
    fs.rename(req.file.path, file, async function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        } else {
            req.body.picPath = req.file.path
            req.body.rating = 0;
            const positions = {
                lat: req.body.lat,
                lng: req.body.lng
            }
            const stadium = new Stadium({
                name: req.body.name,
                description: req.body.description,
                price: req.body.price,
                positions: positions,
                rating: 0.0,
                picPath: req.body.picPath,
                uid: req.body.uid
            });
            await stadium.save((err, doc) => {
                if (err) {
                    console.log(err);
                    return res.status(422).json({ errors: err })
                } else {
                    const stadiumData = {
                        name: doc.name,
                        description: doc.description,
                        price: doc.price,
                        rating: doc.rating,
                        picPath: doc.picPath,
                        positions: {
                            lat: doc.positions.lat,
                            lng: doc.positions.lng
                        }
                    }
                    console.log("somedata has been returned")
                    return res.json({
                        success: true,
                        message: 'Successfully Signed Up',
                        stadiumData
                    })
                }
            });
        }
    })
});
app.get('/api/stadium/all', getAllStadiums);
app.get('/api/stadium/:id', getStadiumDetails);
app.post('/api/stadium/reserve', ReserveStadium);

app.get('/api/stadium/user/:uid', getStadiumUid);

app.post('/api/event/save', upload.single('photo'), async ( req, res ) => {
    var file = __dirname + '/' + req.file.path;
    fs.rename(req.file.path, file, async function (err) {
        if (err) {
            console.log(err);
            res.send(500);
        }else{
    console.log(req.body)
    const event = new Event({
        price: req.body.price,
        name: req.body.name,
        description: req.body.description,
        uid: req.body.uid,
        sid: req.body.sid,
        picPath: req.file.path,
        rating:0
    });
    await event.save((err, doc) => {
        console.log(doc)
        if(err)
            res.status(200).json({
                success: false,
                error: err
            })

        res.status(200).json({
            success: true,
            event: doc
        })
    })}
})

}) 
