import React from "react";
import {
  Typography,
  Box,
  makeStyles,
  Button,
  withStyles,
} from "@material-ui/core";
import ReportProblemOutlinedIcon from "@material-ui/icons/ReportProblemOutlined";
import HelpOutlinedIcon from "@material-ui/icons/HelpOutlined";
import AccountCircleIcon from "@material-ui/icons/AccountCircle";
import { useHistory } from "react-router-dom";
import AlertDialog from "../../../components/AlertDialog";

const useStyles = makeStyles({
  icon: {
    color: "#fff",
    margin: 5,
    fontSize: 30,
    cursor: "pointer",
  },
  text: {
    color: "#fff",
    fontSize: 17,
    cursor: "pointer",
  },
});

const LogoutButton = withStyles({
  root: {
    width: 200,
    fontSize: 20,
    borderRadius: 30,
    backgroundColor: "#f44336",
    color: "#fff",

    "&:hover": {
      backgroundColor: "#EC827B",
    },
  },
})(Button);

export default function Header() {
  const classes = useStyles();
  const history = useHistory();

  const [open, setOpen] = React.useState(false);

  const handleClose = () => {
    setOpen(!open);
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    window.location.reload();
  };

  return (
    <>
      <Box display="flex" justifyContent="space-between" alignItems="center">
        <Typography
          className={classes.text}
          onClick={() => history.replace("/")}
        >
          Área do Operador
        </Typography>
        <Box>
          <ReportProblemOutlinedIcon className={classes.icon} />
          <HelpOutlinedIcon className={classes.icon} />
          <AccountCircleIcon className={classes.icon} onClick={handleClose} />
        </Box>
      </Box>
      <AlertDialog open={open} handleClose={handleClose}>
        <LogoutButton onClick={handleLogout}>Logout</LogoutButton>
      </AlertDialog>
    </>
  );
}
