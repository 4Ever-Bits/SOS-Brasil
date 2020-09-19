import React from "react";
import { makeStyles, Grid, Box } from "@material-ui/core";
import LeftDrawer from "./components/LeftDrawer";
import Header from "./components/Header";
import { useParams } from "react-router-dom";
import TableContainer from "./components/TableContainer";
import RequestContainer from "./components/RequestContainer";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    maxHeight: "100vh",
    overflow: "hidden",
  },
}));

export default function Home() {
  const classes = useStyles();
  const { id } = useParams();

  const data = testObjectArray;

  return (
    <Box className={classes.root}>
      <Grid
        container
        alignItems="stretch"
        justify="space-between"
        direction="row"
      >
        <LeftDrawer />
        <OperatorArea id={id} data={data} />
      </Grid>
    </Box>
  );
}

function OperatorArea({ id, data }) {
  return (
    <Grid item xs={10}>
      <Box
        height="100vh"
        justifyContent="center"
        alignItems="stretch"
        paddingLeft={10}
      >
        <Header />
        {!id ? (
          <TableContainer data={data} />
        ) : (
          <RequestContainer id={id} data={data} />
        )}
      </Box>
    </Grid>
  );
}

const testObjectArray = [
  {
    id: 0,
    title: "Mama",
    description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dignissim eros quis ipsum pulvinar sodales. Proin et condimentum justo. Pellentesque ac finibus massa. In ultricies .",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 1,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 2,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 3,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 4,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 5,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 6,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
  {
    id: 7,
    title: "DataTypes.STRING",
    description: "DataTypes.TEXT",
    image_url: "DataTypes.STRING",
    audio_url: "DataTypes.STRING",
    latitude: "DataTypes.FLOAT",
    longitude: "DataTypes.FLOAT",
    ispersonal: "DataTypes.BOOLEAN",
    user_id: "DataTypes.INTEGER",
    attendant_id: "DataTypes.INTEGER",
    status: "DataTypes.BOOLEAN",
    createdAt: "10/09/20",
  },
];
