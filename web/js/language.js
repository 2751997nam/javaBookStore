function defaultSelect() {
    var element = document.getElementById("locale");
    element.value = document.documentElement.lang !== "" ? document.documentElement.lang : "en";
}

defaultSelect();
