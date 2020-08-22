import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { Button } from "@material-ui/core";

import root from "./styles";

const useStyles = makeStyles(root);

export function LoginButton(props) {
  const classes = useStyles();
  return (
    <Button
      type="submit"
      className={classes.button}
      variant="contained"
      disableElevation
    >
      {props.children}
    </Button>
  );
}
