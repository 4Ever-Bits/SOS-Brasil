import React from "react";
import { makeStyles, Grid, Button, withStyles } from "@material-ui/core";
import Avatar from "../../../components/SOSAvatar";
import PhoneIcon from "@material-ui/icons/Phone";
import SettingsIcon from "@material-ui/icons/Settings";
import { useHistory } from "react-router-dom";

import Logo from "../../../assets/images/image.png";
import { logout } from "../../../controllers/SessionController";
import AlertDialog from "../../../components/AlertDialog";

const useStyles = makeStyles(() => ({
  title: {
    fontSize: 24,
  },
  button: {
    width: "100%",

    display: "flex",
    justifyContent: "left",

    paddingLeft: "10%",

    borderBottomRightRadius: 40,
    borderTopRightRadius: 40,

    marginBottom: 9,

    color: "#FFF",
  },
  p: {
    marginLeft: 15,
  },
}));

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

const LeftDrawer = () => {
  const classes = useStyles();
  const history = useHistory();

  const [open, setOpen] = React.useState(false);

  const handleLogout = () => {
    logout();
  };

  return (
    <>
      <Grid item xs={2}>
        <Grid container alignItems="center" justify="center">
          <Grid item sm>
            <Avatar classes={classes} src={Logo} />
          </Grid>

          <Grid item xs={12}>
            <Button
              className={classes.button}
              style={{ background: "rgba(255,255,255,0.45)" }}
              onClick={() => history.replace("/")}
            >
              <PhoneIcon fontSize="small" />{" "}
              <p className={classes.p}>Chamadas</p>
            </Button>
          </Grid>

          <Grid item xs={12}>
            <Button className={classes.button} onClick={() => setOpen(true)}>
              <SettingsIcon fontSize="small" />{" "}
              <p className={classes.p}>Configurações</p>
            </Button>
          </Grid>
        </Grid>
      </Grid>
      <AlertDialog open={open} handleClose={() => setOpen(false)}>
        <LogoutButton onClick={handleLogout}>Logout</LogoutButton>
      </AlertDialog>
    </>
  );
};

export default LeftDrawer;
