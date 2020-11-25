import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { TextField, InputAdornment, IconButton } from "@material-ui/core";
import Visibility from "@material-ui/icons/Visibility";
import VisibilityOff from "@material-ui/icons/VisibilityOff";
import root from "./styles";

const useStyles = makeStyles(root);

export function LoginInput(props) {
  const classes = useStyles();

  const [values, setValues] = React.useState({
    showPassword: false,
  });

  const handleClickShowPassword = () => {
    setValues({ showPassword: !values.showPassword });
  };

  const handleMouseDownPassword = (event) => {
    event.preventDefault();
  };

  if (props.type !== "password") {
    return (
      <TextField
        name={props.name}
        className={classes.input}
        placeholder={props.placeholder}
        variant="outlined"
        onChange={props.onChange}
        type={props.type}
      />
    );
  } else {
    return (
      <TextField
        name={props.name}
        className={classes.input}
        placeholder={props.placeholder}
        variant="outlined"
        type={values.showPassword ? "text" : "password"}
        onChange={props.onChange}
        InputProps={{
          endAdornment: (
            <InputAdornment position="end">
              <IconButton
                aria-label="toggle password visibility"
                onClick={handleClickShowPassword}
                onMouseDown={handleMouseDownPassword}
                edge="end"
              >
                {values.showPassword ? <Visibility /> : <VisibilityOff />}
              </IconButton>
            </InputAdornment>
          ),
        }}
      />
    );
  }
}
