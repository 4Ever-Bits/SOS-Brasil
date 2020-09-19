import React from "react";
import {
  Grid,
  Container,
  makeStyles,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  withStyles,
  Avatar,
  Typography,
  Box,
  Fab,
} from "@material-ui/core";
import { useHistory } from "react-router-dom";
import ClearRoundedIcon from "@material-ui/icons/ClearRounded";
import CheckRoundedIcon from "@material-ui/icons/CheckRounded";

import Photo from "../../../assets/images/Image_created_with_a_mobile_phone.png";

import "../../../styles/list.css";
import "../../../styles/audio.css";

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

const StyledListItem = withStyles({
  root: {
    fontWeight: "bolder",
    fontSize: 32,
    borderRadius: 20,
    height: 60,

    "&:hover": {
      backgroundColor: "rgba(255,255,255,.5)",
    },
    "&.Mui-selected": {
      backgroundColor: "rgba(255,255,255,.5)",
    },
  },
})(ListItem);

function ListContainer({ id, data, history }) {
  return (
    <Container>
      <List
        component="nav"
        aria-label="main mailbox folders"
        style={{ maxHeight: "90vh", overflow: "auto" }}
      >
        {data.map((item) => (
          <StyledListItem
            button
            key={item.id}
            selected={parseInt(id) === item.id}
            onClick={() => {
              history.replace("/request/" + item.id);
            }}
          >
            <ListItemIcon>
              <Avatar />
            </ListItemIcon>
            <ListItemText>
              <Typography style={{ fontSize: 24, fontWeight: "bolder" }}>
                {item.title}
              </Typography>
            </ListItemText>
          </StyledListItem>
        ))}
      </List>
    </Container>
  );
}

function SpecsContainer({ data }) {
  const titleStyle = {
    fontWeight: "bold",
    margin: "5px 0 20px 0",
  };
  return (
    <Container>
      <Box
        justifyContent="center"
        alignItems="center"
        maxHeight={"90vh"}
        className="BoxList"
        style={{ overflowY: "scroll", overflowX: "hidden" }}
      >
        <Typography
          variant="h5"
          component="h1"
          style={titleStyle}
          align="center"
        >
          {data.title}
        </Typography>

        <Typography paragraph align="justify">
          {data.description}
        </Typography>

        <Box display="flex" justifyContent="center" alignItems="center">
          <audio src="my_audio_file.ogg" autoPlay controls />
        </Box>

        <Box
          display="flex"
          justifyContent="center"
          alignItems="center"
          margin="20px 0"
        >
          <img
            src={Photo}
            alt=""
            height={230}
            style={{ margin: "10px 0 10px 0" }}
          />
        </Box>

        <Box
          display="flex"
          justifyContent="center"
          alignItems="center"
          padding="0 80px"
          margin="10px 0 60px 0"
        >
          <Fab
            color="primary"
            aria-label="add"
            style={{ margin: "0 20px", backgroundColor: "#14FC14" }}
          >
            <CheckRoundedIcon fontSize="large" />
          </Fab>
          <Fab
            color="primary"
            aria-label="add"
            style={{ margin: "0 20px", backgroundColor: "#FE1E1A" }}
          >
            <ClearRoundedIcon fontSize="large" />
          </Fab>
        </Box>
      </Box>
    </Container>
  );
}

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
        <Container>mama</Container>
      </Grid>
    </Grid>
  );
}

const getSpecifiedData = (id, data) => {
  for (var item of data) {
    if (item.id === parseInt(id)) return item;
  }
};
