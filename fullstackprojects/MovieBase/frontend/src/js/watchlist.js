import APIClient from "./APIClient.js";
import { loadMedia } from "./media.js";

const user = await APIClient.currentUser();
const response = await APIClient.fetchUserList(user.id);

await loadMedia(response.data.results, true);