import React from "react";
import { makeStyles, createStyles } from "@material-ui/core/styles";
import { Avatar } from "@material-ui/core";

const useStyles = makeStyles((theme) =>
  createStyles({
    large: {
      width: theme.spacing(10),
      height: theme.spacing(10),
    },
  })
);

export function LoginAvatar(props) {
  const classes = useStyles();
  return <Avatar className={classes.large} src={props.src} />;
}
