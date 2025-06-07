// ランディングページ用JavaScript

// カウントアップアニメーション
function animateCounter(element, target) {
  let current = 0;
  const increment = target / 100;
  const timer = setInterval(() => {
    current += increment;
    if (current >= target) {
      current = target;
      clearInterval(timer);
    }
    element.textContent = Math.floor(current);
  }, 20);
}

// ページ読み込み時にカウンターアニメーション実行
document.addEventListener('DOMContentLoaded', function () {
  const counters = document.querySelectorAll('[data-count]');
  counters.forEach(counter => {
    const target = parseInt(counter.getAttribute('data-count'));
    animateCounter(counter, target);
  });
});

// Turbo対応（Railsのページ遷移時にも実行）
document.addEventListener('turbo:load', function () {
  const counters = document.querySelectorAll('[data-count]');
  counters.forEach(counter => {
    const target = parseInt(counter.getAttribute('data-count'));
    animateCounter(counter, target);
  });
}); 