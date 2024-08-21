document.addEventListener('DOMContentLoaded', function() {
  const readMoreButton = document.querySelector('.read-more');
  if (readMoreButton) {
    readMoreButton.addEventListener('click', function(e) {
      e.preventDefault();
      const description = document.querySelector('.product-description');
      if (description.style.display === 'none' || description.style.display === '') {
        description.style.display = 'block';
        this.textContent = 'Read Less';
      } else {
        description.style.display = 'none';
        this.textContent = 'Read More';
      }
    });
  }
});
