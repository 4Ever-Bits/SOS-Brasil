import React from "react";
import { Snackbar } from "@material-ui/core";
import MuiAlert from "@material-ui/lab/Alert";

export default function NotifSnackbar(props) {
  return (
    <Snackbar
      anchorOrigin={{ vertical: "top", horizontal: "right" }}
      autoHideDuration={5000}
      open={props.open}
      onClose={props.onClose}
    >
      <MuiAlert
        elevation={6}
        variant="filled"
        severity={props.severity}
        onClose={props.onClose}
      >
        {props.message.toString()}
      </MuiAlert>
    </Snackbar>
  );
}
