const { Event } = require('../models//EventModel');

exports.SaveEvent = async ( req, res ) => {
    console.log(req.body)
    const event = new Event({
        price: req.body.price,
        name: req.body.name,
        description: req.body.description,
        uid: req.body.uid,
        sid: req.body.sid
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
    })
}
