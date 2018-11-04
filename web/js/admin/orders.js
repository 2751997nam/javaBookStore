function showPreview(id, element) {
    ajax({
        url: "orders/preview?id=" + id,
        method: "get",
        data: {id: id}
    }, function (result) {
        console.log(result);
    });
}
