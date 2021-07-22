window.onload = async ()  => {
    let uid = JSON.parse(localStorage.getItem('userInfo'))
    await fetch('http://localhost:3000/api/stadium/user/'+uid.userID, {
                    method: 'GET', mode: "cors"
                })
        .then(res => res.json())
        .then(res => {
            console.log(res)
            stadiums = document.getElementById('stadium');
            let stads = res.stadium;
            stads.forEach(e => {
                console.log(e);
                stadiums.options[stadiums.options.length] = new Option(e.name, e._id);
            });
            remove()
        })
        .catch(err => {
            console.log(err)
            remove()
        })

    function remove(){
        let spinner = document.getElementById('spinner');
        spinner.remove()
    }
    let save = document.getElementById('save');
    save.addEventListener('click', async () => {
        event.preventDefault();
        save.innerHTML = "<div class='loader'></div> Loading..."
            let name = document.getElementById('sname').value;
            let description = document.getElementById('sdesc').value;
            let price = document.getElementById('sprice').value;
            let file = document.getElementById("spics").files[0];
            let uid = JSON.parse(localStorage.getItem('userInfo'));
            let sid = document.getElementById('stadium').value;
             console.log(sid)
            let formData = new FormData();
            formData.append('photo', file);
            formData.append('name', name);
            formData.append('description', description);
            formData.append('price', price);
            formData.append('uid', uid.userID);
            formData.append('sid', sid)
            if (name.length > 6 && description.length > 10 && price != "") {
                await fetch('http://localhost:3000/api/event/save', {
                    method: 'POST',
                    body: formData
                })
                    .then(res => res.json())
                    .then((res) => {
                        console.log(res);
                        save.innerHTML = "<i class='fa fa-check'></i> Save"

                        toastr.options = {
                            "closeButton": true,
                            "debug": false,
                            "newestOnTop": false,
                            "progressBar": false,
                            "positionClass": "toast-top-right",
                            "preventDuplicates": false,
                            "onclick": null,
                            "showDuration": "300",
                            "hideDuration": "1000",
                            "timeOut": "5000",
                            "extendedTimeOut": "1000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        }
                        toastr.success("Success", "Stadiuum has been added successfuly")
                    })
                    .catch(err => {
                        console.log(err)

                        toastr.error("Error", "Please fill the form")
                        save.innerHTML = "<i class='fa fa-check'></i> Save"
                    })
            }
        
    });
}