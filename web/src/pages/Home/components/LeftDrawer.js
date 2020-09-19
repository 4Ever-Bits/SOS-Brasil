import React from "react";
import { makeStyles, Grid, Button } from "@material-ui/core";
import Avatar from "../../../components/SOSAvatar";
import PhoneIcon from "@material-ui/icons/Phone";
import SettingsIcon from "@material-ui/icons/Settings";
import { useHistory } from "react-router-dom";

const useStyles = makeStyles((theme) => ({
  title: {
    fontSize: 24,
  },
  button: {
    width: 225,

    borderBottomRightRadius: 40,
    borderTopRightRadius: 40,

    marginBottom: 9,

    color: "#FFF",
  },
}));

const LeftDrawer = () => {
  const classes = useStyles();
  const history = useHistory();

  return (
    <Grid item xs={2}>
      <Grid container alignItems="center" justify="center">
        <Grid item sm>
          <Avatar classes={classes} />
        </Grid>

        <Grid item xs={12}>
          <Button
            className={classes.button}
            style={{ background: "rgba(255,255,255,0.45)" }}
            onClick={() => history.replace("/")}
          >
            <PhoneIcon fontSize="small" /> Chamadas
          </Button>
        </Grid>

        <Grid item xs={12}>
          <Button className={classes.button}>
            <SettingsIcon fontSize="small" /> Configurações
          </Button>
        </Grid>
      </Grid>
    </Grid>
  );
};

export default LeftDrawer;
