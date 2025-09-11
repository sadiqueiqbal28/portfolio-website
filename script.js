document.addEventListener('DOMContentLoaded', function () {
  // Set current year in the footer
  const yearEl = document.getElementById('year');
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }

  // Hamburger menu functionality
  const menuToggle = document.querySelector('.menu-toggle');
  const headerMenu = document.querySelector('.header-menu');

  if (menuToggle && headerMenu) {
    menuToggle.addEventListener('click', () => {
      // Toggle active classes
      menuToggle.classList.toggle('is-active');
      headerMenu.classList.toggle('is-open');

      // Toggle ARIA attribute for accessibility
      const isExpanded = menuToggle.getAttribute('aria-expanded') === 'true';
      menuToggle.setAttribute('aria-expanded', !isExpanded);
    });

    // Close menu when a link inside it is clicked
    headerMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        // Only close if the menu is actually open
        if (headerMenu.classList.contains('is-open')) {
          menuToggle.classList.remove('is-active');
          headerMenu.classList.remove('is-open');
          menuToggle.setAttribute('aria-expanded', 'false');
        }
      });
    });
  }
});