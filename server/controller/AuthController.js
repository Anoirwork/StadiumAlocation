//in AuthController.js

const { User } = require('../models/UserModel');
exports.RegisterUser = async (req, res) => {
    const user = new User(req.body);
    await user.save((err, doc) => {
        if (err) {
            return res.status(422).json({ errors: err })
        } else {
            user.generateToken((err, user) => {
                if (err) {
                    return res.status(400).send({ err });
                } else {
                    const data = {
                        userID: user._id,
                        username: user.username,
                        email: user.email,
                        token: user.token
                    }
                    //saving token to cookie
                    res.cookie('authToken', user.token).status(200).json(
                        {
                            success: true,
                            message: 'Successfully Logged In!',
                            userData: data
                        })
                }
            });
        }
    });
}
exports.LoginUser = (req, res) => {
    User.findOne({ 'email': req.body.email }, (err, user) => {
        if (!user) {
            return res.status(404).json({ success: false, message: 'User email not found!' });
        } else {
            user.comparePassword(req.body.password, (err, isMatch) => {
                console.log(isMatch);
                //isMatch is eaither true or false
                if (!isMatch) {
                    return res.status(400).json({ success: false, message: 'Wrong Password!' });
                } else {
                    user.generateToken((err, user) => {
                        if (err) {
                            return res.status(400).send({ error :  "This is the error ??:" + err });
                        } else {
                            const data = {
                                userID: user._id,
                                username: user.username,
                                email: user.email,
                                token: user.token
                            }
                            //saving token to cookie
                            res.cookie('authToken', user.token).status(200).json(
                                {
                                    success: true,
                                    message: 'Successfully Logged In!',
                                    userData: data
                                })
                        }
                    });
                }
            });
        }
    });
}
exports.LogoutUser = (req, res) => {
    User.findByIdAndUpdate(
        { _id: req.user._id }
        , { token: '' },
        (err) => {
            if (err) return res.json({ success: false, err })
            return res.status(200).send({ success: true, message: 'Successfully Logged Out!' });
        })
}
//get authenticated user details
exports.getUserDetails = (req, res) => {
    return res.status(200).json({
        isAuthenticated: true,
        firstName: req.user.firstName,
        lastName: req.user.lastName,
        email: req.user.email,

    });
}
exports.GetUserInfo = (req, res) => {
    User.findOne({ '_id': req.body.id }, (err, user) => {
        if (err) {
            res.status(404).json({
                success: false,
                message: "User " + err,
            })
        }
        else {
            const data = {
                userID: user._id,
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                token: user.token
            }
            //saving token to cookie
            res.status(200).json(
                {
                    success: true,
                    message: 'Successfully Logged In!',
                    userData: data
                })
        }
    });
}
