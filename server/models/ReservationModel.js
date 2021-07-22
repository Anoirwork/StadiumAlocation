const mongoose = require('mongoose');

const reservationSchema = mongoose.Schema({
    sid: {
        type: String,
        required: [true, 'The sid field is required!'],
    },
    uid: {
        type: String,
        requried: [true, 'The uid is required']
    },
    reservationDate: {
        type: String,
        required: [true, "specify the date "]
    }
}, { collection: 'Reservations' });

const Reservation = mongoose.model('Reservation', reservationSchema);
module.exports = { Reservation }