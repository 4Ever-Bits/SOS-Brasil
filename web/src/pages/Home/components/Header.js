import React from "react";
import { Typography, Box, makeStyles } from "@material-ui/core";
import ReportProblemOutlinedIcon from "@material-ui/icons/ReportProblemOutlined";
import HelpOutlinedIcon from "@material-ui/icons/HelpOutlined";
import AccountCircleIcon from "@material-ui/icons/AccountCircle";
import { useHistory } from "react-router-dom";

const useStyles = makeStyles({
  icon: {
    color: "#fff",
    margin: 5,
    fontSize: 30,
  },
  text: {
    color: "#fff",
    fontSize: 17,
    cursor: "pointer",
  },
});

export default function Header() {
  const classes = useStyles();
  const history = useHistory();

  return (
    <Box display="flex" justifyContent="space-between" alignItems="center">
      <Typography className={classes.text} onClick={() => history.replace("/")}>
        Área do Operador
      </Typography>
      <Box>
        <ReportProblemOutlinedIcon className={classes.icon} />
        <HelpOutlinedIcon className={classes.icon} />
        <AccountCircleIcon className={classes.icon} />
      </Box>
    </Box>
  );
}
