const style = {
  container: {
    background: "rgba(255, 255, 255, 0.6)",
    border: 0,
    borderRadius: 36,
    width: 500,
    padding: 30,
    textAlign: "center",
  },
  input: {
    backgroundColor: "white",
    borderRadius: 24,
    padding: "0px 20px 0px 15px",
    width: "100%",
    fontSize: 20,
    margin: "7px 0",
    "& label.Mui-focused": {
      color: "black",
    },
    "& .MuiInput-underline:after": {
      borderBottomColor: "white",
    },
    "& .MuiOutlinedInput-root": {
      "& fieldset": {
        borderColor: "white",
        borderRadius: 24,
      },
      "&:hover fieldset": {
        borderColor: "white",
      },
      "&.Mui-focused fieldset": {
        borderColor: "white",
      },
    },
  },
  button: {
    padding: "10px 40px",
    borderRadius: 16,
    color: "#fff",
    backgroundColor: "#F44336",
    margin: 10,
    "&:hover": {
      backgroundColor: "#F65C51",
    },
  },
};

export default style;
