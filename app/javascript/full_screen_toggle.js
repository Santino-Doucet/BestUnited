document.addEventListener("DOMContentLoaded", function() {
  function goFullScreen() {
    // Check if we are on a mobile device
    if (window.matchMedia("(display-mode: standalone)").matches || window.navigator.standalone) {
      document.documentElement.requestFullscreen().catch((err) => {
        console.error(`Error attempting to enable full-screen mode: ${err.message}`);
      });
    }
  }

  // Attempt to enter full-screen mode when the page loads
  goFullScreen();

  // Listen for the user interacting with the page and request fullscreen again
  document.body.addEventListener('click', goFullScreen);
});
