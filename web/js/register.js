window.onload = () => {


    let register = document.getElementById('register');

    register.addEventListener('click', async (e) => {
        e.preventDefault;
        if (document.getElementById('agree').checked) {
            if (document.getElementById('cpass').value === document.getElementById('password').value) {
                let fullName = document.getElementById('username').value;
                let email = document.getElementById('email').value;
                let password = document.getElementById('password').value;
                let phonenumber = document.getElementById('phonenumber').value;

                await fetch('http://localhost:3000/api/users/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json;charset=utf-8'
                    },
                    body: JSON.stringify({
                        email,
                        password,
                        username: fullName,
                        phonenumber
                    }
                    ), mode: "cors"
                })
                    .then(res => res.json())
                    .then((res) => {
                        console.log(res);
                        //localStorage.setItem('', );
                        //window.location.replace("./index.html");
                    })
                    .catch(err => console.log(err))
            }
            else {
                let alert = document.getElementById('wrong-pass');
                alert.classList.add('visible');
                alert.innerHTML = "Verify the wrong password";
                alert.style.display = "block";
                setInterval(() => { alert.classList.remove('visible'); alert.classList.add('invisible') }, 5000);
            }
        } else {
            alert('check it ');
        }


    });


}


var myInput = document.getElementById("password");
var letter = document.getElementById("letter");
var number = document.getElementById("number");
var length = document.getElementById("length");

// When the user clicks on the password field, show the message box
myInput.onfocus = function () {
    document.getElementById("message").style.display = "block";
}

// When the user clicks outside of the password field, hide the message box
myInput.onblur = function () {
    document.getElementById("message").style.display = "none";
}

// When the user starts to type something inside the password field
myInput.onkeyup = function () {
    // Validate lowercase letters
    var lowerCaseLetters = /[a-z]/g;
    if (myInput.value.match(lowerCaseLetters)) {
        letter.classList.remove("invalid");
        letter.classList.add("valid");

    } else {
        letter.classList.remove("valid");
        letter.classList.add("invalid");
    }

    // Validate numbers
    var numbers = /[0-9]/g;
    if (myInput.value.match(numbers)) {
        number.classList.remove("invalid");
        number.classList.add("valid");
    } else {
        number.classList.remove("valid");
        number.classList.add("invalid");
    }

    // Validate length
    if (myInput.value.length >= 8) {
        length.classList.remove("invalid");
        length.classList.add("valid");
    } else {
        length.classList.remove("valid");
        length.classList.add("invalid");
    }
}