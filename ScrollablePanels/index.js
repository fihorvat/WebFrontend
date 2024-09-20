const contentPanels = document.getElementsByClassName("content");
if (contentPanels) {
  for (let i = 0; i < contentPanels.length; i++) {
    contentPanels[i].innerText = "lorem ipsum ".repeat(1000);
  }
}
