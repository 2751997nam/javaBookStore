/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var sliders = document.getElementsByClassName("slide-item");
var currentSlide = 0;
function showSlide(current) {
    for (var i = 0; i < sliders.length; i++) {
        sliders[i].style.display = "none";
    }
    sliders[current].style.display = "block";
    current++;
    if (current > sliders.length - 1) {
        current = 0;
    }
    var timeO = setTimeout(showSlide, 5000, current);
}
function plusSlide(n) {
    currentSlide += n;
    if (currentSlide < 0)
        currentSlide = sliders.length - 1;
    if (currentSlide > sliders.length - 1)
        currentSlide = 0;
    showSlide(currentSlide);
}
showSlide(currentSlide);
