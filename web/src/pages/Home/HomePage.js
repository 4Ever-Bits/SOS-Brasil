import React from "react";
import {
  makeStyles,
  Grid,
  Box,
  Backdrop,
  CircularProgress,
} from "@material-ui/core";
import LeftDrawer from "./components/LeftDrawer";
import Header from "./components/Header";
import { Redirect, useParams } from "react-router-dom";
import TableContainer from "./components/OperatorArea/TableContainer";
import RequestContainer from "./components/Call/RequestContainer";

import { getCalls } from "../../controllers/CallController";
import { subscribeToCalls, emitCallsCount } from "../../services/websocket";
import NotifSnackbar from "../../components/NotifSnackbar";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    maxHeight: "100vh",
    overflow: "hidden",
  },
  backdrop: {
    zIndex: theme.zIndex.drawer + 1,
    color: "#f44336",
  },
}));

export default function Home() {
  const classes = useStyles();
  const { id } = useParams();

  const [calls, setCalls] = React.useState([]);
  const [open, setOpen] = React.useState(false);
  const [length, setLength] = React.useState(0);
  const [alert, setAlert] = React.useState(false);

  React.useEffect(() => {
    setOpen(true);
    getCalls().then((data) => {
      setCalls(data);
      setOpen(false);
      setLength(data.length);
    });
  }, [setCalls]);

  React.useEffect(() => {
    emitCallsCount(length);
  }, [length]);

  subscribeToCalls((err, call) => {
    if (!err) {
      var aux = calls;

      var hasCall = false;
      if (calls.length > 0) {
        for (var c of aux) {
          if (c.id === call.id) hasCall = true;
        }
      }
      if (!hasCall) aux.unshift(call);

      setCalls(aux);
      setLength(length + 1);
      setAlert(true);
    }
  });

  if (id) {
    if (calls.length > 0) {
      let aux = false;
      for (var call of calls) {
        if (call.id === parseInt(id)) aux = true;
      }
      if (!aux) return <Redirect push to="/" />;
    }
  }

  return (
    <>
      <Box className={classes.root}>
        <Grid
          container
          alignItems="stretch"
          justify="space-between"
          direction="row"
        >
          <LeftDrawer />
          <Grid item xs={10}>
            <Box
              height="100vh"
              justifyContent="center"
              alignItems="stretch"
              paddingLeft={10}
            >
              <Header />
              {!id ? (
                <TableContainer data={calls} />
              ) : calls.length > 0 ? (
                <RequestContainer id={id} data={calls} />
              ) : (
                <Redirect to="/" />
              )}
            </Box>
          </Grid>
        </Grid>
      </Box>
      <NotifSnackbar
        open={alert}
        onClose={() => setAlert(false)}
        severity="warning"
        message="Nova emergência!"
      />
      <Backdrop className={classes.backdrop} open={open}>
        <CircularProgress color="inherit" />
      </Backdrop>
    </>
  );
}
