window.onload = () => {
    let button = document.getElementById('sub');
    button.addEventListener('click', async (e) => {
        e.preventDefault();
        document.getElementById('sub').innerHTML = "<div class='loader'>Loading...</div>"
        let email = document.getElementById('email').value;
        let password = document.getElementById('password').value;

        await fetch('http://localhost:3000/api/users/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json;charset=utf-8'
            },
            body: JSON.stringify({
                email,
                password
            }
            ), mode: "cors"
        })
            .then(res => res.json())
            .then((res) => {
                console.log(res);
                    if(res.success)
                        localStorage.setItem('userInfo', JSON.stringify(res.userData));
                        window.location.replace("./dashboard.html");
                        document.getElementById('sub').innerHTML = "Log In"    
            })
            .catch(err =>{ console.log(err); 
                document.getElementById('sub').innerHTML = "Log In"})
    });
}
