const createAlert = (error) => {
  const alertContainer = document.getElementById('alert-container');

  const alertElement = document.createElement('div');
  alertElement.classList.add('alert', 'alert-danger', 'd-flex', 'align-items-center', 'fade', 'show');
  alertElement.setAttribute('role', 'alert');
  alertElement.innerHTML = `
    ${error}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  `;

  alertContainer.appendChild(alertElement);
};

const handleError = async (res) => {
    if(!res.ok) {
      if(res.status == 401) {
        localStorage.removeItem('user');
        document.location = '/signin';
        throw new Error("Unauthenticated");
      }
      else {

        let errorData = undefined

        try {
          errorData = await res.json();
        } catch (jsonError) {
          // If parsing JSON fails, throw a generic error
          throw new Error("Error processing API response");
        }

        throw new Error(errorData.error || "Error");
      }
    }
  
    return res;
  };
  
export default {
    get: (url) => {
      return fetch(url).then(handleError).then(res => {
        return res.json();
      })
    },
  
    post: (url, data) => {
      return fetch(url, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
          'Content-Type': 'application/json',
        }
      }).then(handleError).then(res => {
        return res.json();
      })
      .catch(error => {
        createAlert(error);
        throw error;
      })
    },
  
    put: (url, data) => {
      return fetch(url, {
        method: 'PUT',
        body: JSON.stringify(data),
        headers: {
          'Content-Type': 'application/json',
        }
      }).then(handleError).then(res => {
        return res.json();
      })
    },
  
    delete: (url) => {
      return fetch(url, { method: 'DELETE', }).then(handleError).then(res => {
        return res.json();
      })
    }
  }