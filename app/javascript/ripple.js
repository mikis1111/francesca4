document.addEventListener("click", (event) => {
    const card = event.target.closest(".card-pro");
    if (!card) return;
  
    const rect = card.getBoundingClientRect();
    card.style.setProperty("--x", `${event.clientX - rect.left}px`);
    card.style.setProperty("--y", `${event.clientY - rect.top}px`);
  });
  