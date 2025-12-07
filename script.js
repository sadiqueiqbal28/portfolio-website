document.addEventListener('DOMContentLoaded', function () {
  
  // --- 1. Mobile Menu Logic ---
  const menuToggle = document.querySelector('.menu-toggle');
  const headerMenu = document.querySelector('.header-menu');
  const body = document.body;

  if (menuToggle && headerMenu) {
    menuToggle.addEventListener('click', () => {
      // Toggle Classes
      menuToggle.classList.toggle('is-active');
      headerMenu.classList.toggle('is-open');
      
      // Toggle ARIA
      const isExpanded = menuToggle.getAttribute('aria-expanded') === 'true';
      menuToggle.setAttribute('aria-expanded', !isExpanded);

      // Lock Body Scroll when menu is open (Premium Feel)
      if (headerMenu.classList.contains('is-open')) {
        body.style.overflow = 'hidden';
      } else {
        body.style.overflow = 'auto';
      }
    });

    // Close menu when clicking a link inside it
    headerMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        menuToggle.classList.remove('is-active');
        headerMenu.classList.remove('is-open');
        menuToggle.setAttribute('aria-expanded', 'false');
        body.style.overflow = 'auto';
      });
    });
  }

  // --- 2. Scroll Animations (Fade In) ---
  const observerOptions = {
    threshold: 0.1 // Trigger when 10% of element is visible
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        // Optional: Stop observing once visible
        // observer.unobserve(entry.target); 
      }
    });
  }, observerOptions);

  document.querySelectorAll('.fade-in').forEach(el => {
    observer.observe(el);
  });

  // --- 3. Dynamic Footer Year ---
  const yearEl = document.getElementById('year');
  if (yearEl) {
    yearEl.textContent = new Date().getFullYear();
  }
});