import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { Container } from "@material-ui/core";

import root from "./styles";

const useStyles = makeStyles(root);

export function LoginContainer(props) {
  const classes = useStyles();
  return (
    <Container maxWidth={props.maxWidth} className={classes.container}>
      {props.children}
    </Container>
  );
}
