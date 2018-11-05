function insertAfter(referenceNode, newNode) {
    referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}

function hidePreview(id, element) {
    element.parentElement.parentElement.parentNode.removeChild(element.parentElement.parentElement.nextSibling);
    element.onclick = function () {
        showPreview(id, element);
    };
}

function showPreview(id, element) {
    ajax({
        url: "orders/preview?id=" + id,
        method: "get"
    }, function (result) {
        var div = document.createElement("tr");
        div.innerHTML = result;
        insertAfter(element.parentElement.parentElement, div);
        element.onclick = function () {
            hidePreview(id, element);
        };
    });
}

function cancel(id, element, message) {
    if (!confirm(message)) {
        return;
    }
    var tr = element.parentElement.parentElement;
    tr.parentElement.removeChild(tr);

    ajax({
        url: "orders/cancel",
        method: "Post",
        data: {id: id}
    }, function (result) {
        element.parentElement.removeChild(element);
    });
}

function accept(id, element, message) {
    if(!confirm(message)) {
        return;
    }
    
    ajax({
        url: "orders",
        method: "post",
        data: {id: id}
    }, function (result) {
       element.parentElement.removeChild(element.nextSibling.nextSibling);
       element.parentElement.removeChild(element);
    });
}

function filter(value)
{
    var ele = document.getElementById("item_id");
    ele.value = value;
    document.getElementById("filter").submit();
}
