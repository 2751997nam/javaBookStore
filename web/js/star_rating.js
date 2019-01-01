/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var countStar = 5;

function setStars(k) {
    countStar = k;
    document.getElementById("countStar").value = k;
    displayStars(countStar);
}

function displayStars(n) {
    var stars = document.getElementsByClassName("star");
    var white_stars = document.getElementsByClassName("white-star");
    for (var i = 0; i < 5; i++) {
        if (i < n) {
            stars[i].style.display = 'block';
            white_stars[i].style.display = 'none';
        } else {
            stars[i].style.display = 'none';
            white_stars[i].style.display = 'block';
        }

    }
}

function moveoverStar(n) {
    displayStars(n);
}

function clearMove() {
    displayStars(countStar);
}

function sendReview() {
    if (!checkTextArea()) {
        document.getElementsByClassName("error")[0].innerHTML = "Tối thiểu phải 50 ký tự."
        return;
    }
    ajax({
        url: "/bookstore/rating",
        method: "Post",
        data: {
            book_id: document.getElementById("book_id").value,
            star: document.getElementById("countStar").value,
            comment: document.getElementById("review-content").value
        }
    }, function (result) {
        var data = JSON.parse(result);
        if (data.error != null) {
            alert(data.error);
        } else {
            location.reload();
        }
    });
}

function checkTextArea() {
    return Boolean(document.getElementById("review-content").value.length >= 50);
}

function showRating(button) {
    button.style.display = "none";
    document.getElementById("hide-rating").style.display = "block";
    document.getElementById("form-rating").style.display = "block";
}

function hideRating(button) {
    button.style.display = "none";
    document.getElementById("form-rating").style.display = "none";
    document.getElementById("show-rating").style.display = "block";
}