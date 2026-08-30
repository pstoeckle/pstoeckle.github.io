(function () {
  var storageKey = 'theme';
  var root = document.documentElement;

  try {
    var savedTheme = localStorage.getItem(storageKey);
    if (savedTheme === 'light' || savedTheme === 'dark') {
      root.setAttribute('data-theme', savedTheme);
    }
  } catch (error) {
    // The site remains system-themed when storage is unavailable.
  }

  function isDarkTheme() {
    if (root.getAttribute('data-theme')) {
      return root.getAttribute('data-theme') === 'dark';
    }
    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  }

  function updateButton(button) {
    var darkTheme = isDarkTheme();
    button.setAttribute('aria-pressed', String(darkTheme));
    button.setAttribute('aria-label', darkTheme ? 'Use light mode' : 'Use dark mode');
    button.setAttribute('title', darkTheme ? 'Use light mode' : 'Use dark mode');
    button.innerHTML = darkTheme ? '&#9788;' : '&#9790;';
  }

  document.addEventListener('DOMContentLoaded', function () {
    var button = document.createElement('button');
    button.className = 'theme-toggle no-print';
    button.type = 'button';
    button.setAttribute('aria-pressed', 'false');
    button.addEventListener('click', function () {
      var newTheme = isDarkTheme() ? 'light' : 'dark';
      root.setAttribute('data-theme', newTheme);
      try {
        localStorage.setItem(storageKey, newTheme);
      } catch (error) {
        // The selected theme remains active until this page is closed.
      }
      updateButton(button);
    });
    document.body.appendChild(button);
    updateButton(button);
  });
}());
