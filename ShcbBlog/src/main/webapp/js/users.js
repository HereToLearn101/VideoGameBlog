$(document).ready(function () {


});

function addDeleteButton(id) {

    $('#deleteButtonDiv').empty();

    var deleteButton = '<a href = "/ShcbBlog/deleteUser?id=' + id + '">';
    deleteButton += '<button class="btn btn-danger">Delete</button>';
    deleteButton += '</a>';
    
    //data-dismiss="modal"
    
    $('#deleteButtonDiv').append(deleteButton);
}