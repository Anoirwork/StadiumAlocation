const mongoose = require('mongoose');

const stadiumSchema = mongoose.Schema({
    name: {
        type: String,
        required: [true, 'The name field is required!'],
    },
    description: {
        type: String,
        required: [true, 'The description field is required!'],
    },
    rating: {
        type: Number,
        required: [true, 'The rating field is required!'],
    },
    price: {
        type: Number,
        required: [true, 'The price field is required!'],
    },
    picPath: {
        type: String,
        required: [true, "Picture path is needed "]
    },
    uid: {
        type: String,
        required: [true, 'heh']
    },
    positions:
    {
        lat: { type: Number },
        lng: { type: Number },
    }
}, { collection: 'Stadiums' });

const Stadium = mongoose.model('Stadium', stadiumSchema);
module.exports = { Stadium }