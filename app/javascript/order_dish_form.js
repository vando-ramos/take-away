document.addEventListener("turbo:load", () => {
  const dishSelect = document.getElementById("dish-select");
  const dishOptionsSelect = document.getElementById("dish-options-select");

  if (dishSelect) {
    dishSelect.addEventListener("change", () => {
      const dishId = dishSelect.value;

      if (dishId) {
        fetch(`/dishes/${dishId}/dish_options`)
          .then((response) => response.json())
          .then((data) => {
            dishOptionsSelect.innerHTML = '<option value="">Select a dish option</option>';

            data.forEach((option) => {
              const opt = document.createElement("option");
              opt.value = option.id;
              opt.textContent = option.description;
              dishOptionsSelect.appendChild(opt);
            });
          })
          .catch((error) => {
            console.error("Error fetching dish options:", error);
          });
      } else {
        dishOptionsSelect.innerHTML = '<option value="">Select a dish option</option>';
      }
    });
  }
});