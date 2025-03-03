// NOTE : Ensure script is loaded in index.html for global usage ; didn't solve the issue though
// <script src="js/accordion.js"></script>

// NOTE : Ensure the accompanying CSS is loaded in index.html also ; didn't solve the issue either
// <link href="css/accordionGlobal.css" rel="stylesheet" />

// Variant enforcing script to load after page is complete ; didn't solve the issue either
document.addEventListener("DOMContentLoaded", function () {
    if (window.Blazor) {
        Blazor.start().then(() => {
            setupAccordion();
        });
    } else {
        setupAccordion();
    }
});

function setupAccordion() {
    document.querySelectorAll(".accordion").forEach(acc => {
        acc.addEventListener("click", function () {
            this.classList.toggle("active");
            let accordionPanel = this.nextElementSibling;
            accordionPanel.classList.toggle("active");

            if (accordionPanel.style.maxHeight) {
                accordionPanel.style.maxHeight = null;
            } else {
                accordionPanel.style.maxHeight = accordionPanel.scrollHeight + "px";
            }
        });
    });
}


// First variant of the script

//// Functionality for the fold-out accordions
//// Placed herein to be globally accessible

//document.addEventListener("DOMContentLoaded", function () {
//    const accordions = document.querySelectorAll(".accordion");

//    accordions.forEach(acc => {
//        acc.addEventListener("click", function () {
//            this.classList.toggle("active");
//            let accordionPanel = this.nextElementSibling;
//            accordionPanel.classList.toggle("active");

//            if (accordionPanel.style.maxHeight) {
//                accordionPanel.style.maxHeight = null; // Collapse
//            } else {
//                accordionPanel.style.maxHeight = accordionPanel.scrollHeight + "px"; // Expand
//            }
//        });
//    });
//});
