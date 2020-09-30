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

import { getCalls, updateCall } from "../../controllers/CallController";

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
  const [open, setOpen] = React.useState(true);

  React.useEffect(() => {
    setOpen(true);
    getCalls().then((data) => {
      setCalls(data);
      setOpen(false);
    });
  }, [setCalls]);

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
              {calls.length > 0 ? (
                !id ? (
                  <TableContainer data={calls} />
                ) : (
                  <RequestContainer id={id} data={calls} />
                )
              ) : (
                <></>
              )}
            </Box>
          </Grid>
        </Grid>
      </Box>
      <Backdrop className={classes.backdrop} open={open}>
        <CircularProgress color="inherit" />
      </Backdrop>
    </>
  );
}
