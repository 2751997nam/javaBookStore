var password = document.getElementById('password');
var cpassword = document.getElementById('cpassword');
function validatePassword(){
    if(password.value != cpassword.value){
        cpassword.setCustomValidity("Password don't match");
    }
    else{
        cpassword.setCustomValidity("");
    }
}
password.onchange = validatePassword;
cpassword.onkeyup = validatePassword;