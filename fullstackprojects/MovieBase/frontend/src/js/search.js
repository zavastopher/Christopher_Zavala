import APIClient from "./APIClient.js";
import HTMLElementBuilder from "./HTMLElementBuilder.js";
import { loadMedia } from "./media.js";

const QUERY_OPTIONS = ["Title", "Publisher", "CastCrew", "Genre", "StreamingService"];

const handleChangeSearchFilter = (event) => {
  document.querySelector(".query-filter").textContent = event.target.innerText;
}

const loadSearchDropdown = () => {
  const options = document.querySelector("#query-options");

  QUERY_OPTIONS.forEach(option => {
      const listItem = new HTMLElementBuilder("li").setAttribute("class", "dropdown-item").setText(option).build();
      listItem.addEventListener("click", handleChangeSearchFilter);
      options.appendChild(listItem);
  });

  document.querySelector(".query-filter").textContent = QUERY_OPTIONS[0];
}

document.getElementById("logout-item").addEventListener("click", () => {
  APIClient.logout().then(_ => {
    document.location = '/signin'
  })
  .catch(error => {
    console.log(error);
  })
})

document.getElementById("search-bar").addEventListener("keydown", (event) => {
  if (event.key === 'Enter') {
    // Prevent the default form submission behavior
    event.preventDefault();
    
    // Submit the form
    const submitEvent = new Event('submit');
    document.getElementById("search-media-form").dispatchEvent(submitEvent);
  }
})

try {
  document.getElementById("search-media-form").addEventListener("submit", (event) => {
    event.preventDefault();
  
    const form = event.target;
  
    const search = form.elements["search"].value;
    const filter =  document.querySelector(".query-filter").textContent;
    console.log(filter + " " + search)
    if(!search || search === "") {
      APIClient.fetchAllMedia().then(response => {
        loadMedia(response.data.results, false);
      })
    }
    else {
      APIClient.fetchSearch(filter, search).then(response => {
        loadMedia(response.data, false);
      })
      .catch(error => {
        console.log("Error fetching search results");
        console.log(error);
      })
    }

    return false;

  })
}
catch {
  console.log("Could not find form.")
}


loadSearchDropdown();

APIClient.fetchAllMedia().then(response => {
  loadMedia(response.data.results, false)
})


