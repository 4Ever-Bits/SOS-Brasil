export const isAuthenticated = () => {
  const token = localStorage.getItem("token");

  if (!token && token === null) {
    return false;
  } else {
    return true;
  }
};
