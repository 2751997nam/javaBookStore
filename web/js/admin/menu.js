var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
        this.classList.toggle("active");
        console.log(this);
        var panel = this.nextElementSibling;
        console.log(panel);
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    });
}


/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
//function myFunction() {
//    document.getElementById("myDropdown").classList.toggle("show");
//}
//
//// Close the dropdown if the user clicks outside of it
//window.onclick = function(e) {
//  if (!e.target.matches('.dropbtn')) {
//    var myDropdown = document.getElementById("myDropdown");
//      if (myDropdown.classList.contains('show')) {
//        myDropdown.classList.remove('show');
//      }
//  }
//};
