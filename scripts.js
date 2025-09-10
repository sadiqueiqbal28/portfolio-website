document.addEventListener('DOMContentLoaded', function () {
  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  // Smooth scroll for internal links
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href.length > 1) {
        e.preventDefault();
        const el = document.querySelector(href);
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    })
  })

  // Contact form simple handler (no backend) — show success and clear
  const form = document.getElementById('contactForm');
  if (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      const name = form.name.value.trim();
      if (!name) { alert('Please enter name'); return }
      // simple success toast
      const btn = form.querySelector('button');
      btn.textContent = 'Sending...';
      setTimeout(() => {
        btn.textContent = 'Send message';
        alert('Thanks ' + name + " — I will get back to you soon (this is a demo form).\nReplace form handler with your email/endpoint to receive messages.");
        form.reset();
      }, 900);
    })
  }
});
