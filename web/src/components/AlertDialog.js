import {
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
} from "@material-ui/core";
import React from "react";

export default function AlertDialog({ title, children, open, handleClose }) {
  return (
    <Dialog
      open={open}
      onClose={handleClose}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      {title ? (
        <DialogTitle id="alert-dialog-title">{title}</DialogTitle>
      ) : (
        <></>
      )}
      <DialogContent>{children}</DialogContent>
      <DialogActions />
    </Dialog>
  );
}
