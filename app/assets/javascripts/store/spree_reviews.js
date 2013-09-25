// Navigating to a page with ratings via TurboLinks shows the radio buttons
document.addEventListener("page:load", function(){
    $('input[type=radio].star').rating();
});