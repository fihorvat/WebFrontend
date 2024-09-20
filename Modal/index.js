const modalContent = document.getElementsByClassName("modal-content")[0];
if (modalContent) modalContent.innerText = "lorem ipsum ".repeat(500);

const minimizeMaximize = document.getElementById("minimize-maximize");
minimizeMaximize?.addEventListener("click", () => {
  const modal = document.getElementsByClassName("modal")[0];
  modal.classList.toggle("fullscreen");
});

const showModalDiv = document.getElementById("show-modal");
showModalDiv.style.display = "none";

const closeModal = () => {
  const wrap = document.getElementsByClassName("wrap")[0];
  wrap.style.display = "none";
  showModalDiv.style.display = "block";
};

const close = document.getElementById("close");
close?.addEventListener("click", closeModal);
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    closeModal();
  }
});

const openModalButton = document.getElementById("open");
openModalButton?.addEventListener("click", () => {
  const wrap = document.getElementsByClassName("wrap")[0];
  wrap.style.display = "grid";
  showModalDiv.style.display = "none";
});
