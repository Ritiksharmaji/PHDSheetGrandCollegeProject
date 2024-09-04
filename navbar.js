function updateActiveSelector() {
    var activeItem = document.querySelector('#navbarSupportedContent .active');
    var horiSelector = document.querySelector('.hori-selector');

    if (activeItem) {
        var activeHeight = activeItem.offsetHeight;
        var activeWidth = activeItem.offsetWidth;
        var itemPos = activeItem.getBoundingClientRect();

        horiSelector.style.top = activeItem.offsetTop + "px";
        horiSelector.style.left = activeItem.offsetLeft + "px";
        horiSelector.style.height = activeHeight + "px";
        horiSelector.style.width = activeWidth + "px";
    }
}

document.querySelectorAll('#navbarSupportedContent .nav-item').forEach(function(navItem) {
    navItem.addEventListener('click', function() {
        document.querySelectorAll('#navbarSupportedContent .nav-item').forEach(function(item) {
            item.classList.remove('active');
        });
        this.classList.add('active');
        updateActiveSelector();
    });
});

// Trigger on initial load
window.addEventListener('load', function() {
    updateActiveSelector();
});
