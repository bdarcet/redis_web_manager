$(document).ready(function() {
    $(".nav-tabs a").click(function () {
        $(this).scrollTop(0);
        $(this).tab('show');
        $(this).scrollTop(0);
    });
});