function setId(id) {
    document.getElementById("book_id").value = id;
    if(confirm("Do you want to delete this book?")) {
        document.getElementById("delete_book").submit();
    }
}