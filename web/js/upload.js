function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            var element = document.getElementById('thumbnail');
            element.setAttribute('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}