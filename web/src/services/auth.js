export const isAuthenticated = () => {
  const token = localStorage.getItem("token");

  if (token === null) {
    return false;
  } else {
    return true;
  }
};
