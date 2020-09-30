import React from "react";
import { Grid, makeStyles } from "@material-ui/core";

import { useHistory } from "react-router-dom";

import ListContainer from "./Containers/ListContainer";
import SpecsContainer from "./Containers/SpecsContainer";
import UserContainer from "./Containers/UserContainer";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    height: "100%",
  },
  listContainer: {
    backgroundColor: "rgba(255,255,255,.3)",
    borderRadius: "30px 30px 0 0",
    padding: "20px 0px",
    margin: "0 1px",
  },
  specsContainer: {
    backgroundColor: "rgba(255,255,255,1)",
    borderRadius: "30px 30px 0 0",
    padding: "20px 0px",
    margin: "0 1px",
  },
  listText: {
    primary: {
      fontSize: 24,
    },
  },
}));

export default function RequestContainer({ id, data }) {
  const classes = useStyles();
  const history = useHistory();

  const selectedData = getSpecifiedData(id, data);

  return (
    <Grid container className={classes.root} direction="row" spacing={0}>
      <Grid item className={classes.listContainer} xs>
        <ListContainer id={id} history={history} data={data} />
      </Grid>
      <Grid item className={classes.specsContainer} xs>
        <SpecsContainer data={selectedData} />
      </Grid>
      <Grid item className={classes.specsContainer} xs>
        <UserContainer data={selectedData} />
      </Grid>
    </Grid>
  );
}

const getSpecifiedData = (id, data) => {
  for (var item of data) {
    if (item.id === parseInt(id)) return item;
  }
};
