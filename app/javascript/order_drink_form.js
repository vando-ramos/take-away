document.addEventListener("turbo:load", () => {
  const drinkSelect = document.getElementById("drink-select");
  const drinkOptionsSelect = document.getElementById("drink-options-select");

  if (drinkSelect) {
    drinkSelect.addEventListener("change", () => {
      const drinkId = drinkSelect.value;

      if (drinkId) {
        fetch(`/drinks/${drinkId}/drink_options`)
          .then((response) => response.json())
          .then((data) => {
            drinkOptionsSelect.innerHTML = '<option value="">Select a drink option</option>';

            data.forEach((option) => {
              const opt = document.createElement("option");
              opt.value = option.id;
              opt.textContent = option.description;
              drinkOptionsSelect.appendChild(opt);
            });
          })
          .catch((error) => {
            console.error("Error fetching drink options:", error);
          });
      } else {
        drinkOptionsSelect.innerHTML = '<option value="">Select a drink option</option>';
      }
    });
  }
});
