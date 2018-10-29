function setId(id, message) {
    document.getElementById("item_id").value = id;
    if(confirm(message)) {
        document.getElementById("delete_item").submit();
    }
}