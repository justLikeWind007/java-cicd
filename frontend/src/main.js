import './style.css';

const resultEl = document.getElementById('result');
const loadBtn = document.getElementById('load-btn');

const apiBase = import.meta.env.VITE_API_BASE_URL || '';

async function loadMessage() {
  resultEl.textContent = 'Loading...';

  try {
    const response = await fetch(`${apiBase}/api/message`);
    if (!response.ok) {
      throw new Error(`Request failed: ${response.status}`);
    }

    const payload = await response.json();
    resultEl.textContent = JSON.stringify(payload, null, 2);
  } catch (error) {
    resultEl.textContent = `Error: ${error.message}`;
  }
}

loadBtn.addEventListener('click', loadMessage);
