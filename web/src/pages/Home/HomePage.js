import React from "react";
import {
  makeStyles,
  Grid,
  Container,
  Box,
  Typography,
  withStyles,
  Tab,
  Tabs,
} from "@material-ui/core";
import LeftDrawer from "./components/LeftDrawer";
import Header from "./components/Header";
import ResquestTable from "./components/ResquetTable";

// import { Container } from './styles';

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    height: "100vh",
  },
  container: {
    borderRadius: 30,
    background: "#FFF",
    height: "80vh",
    padding: "20px 50px",
  },
  box: {
    marginLeft: 100,
  },
}));

export default function Home() {
  const classes = useStyles();

  return (
    <Box className={classes.root}>
      <Grid
        container
        alignItems="stretch"
        justify="space-between"
        direction="row"
      >
        <LeftDrawer />
        <OperatorArea />
      </Grid>
    </Box>
  );
}

const StyledTab = withStyles((theme) => ({
  root: {
    textTransform: "none",
    color: "#000",
    fontWeight: theme.typography.fontWeightRegular,
    fontSize: theme.typography.pxToRem(15),
    marginRight: theme.spacing(1),
    "&:focus": {
      opacity: 1,
    },
  },
}))((props) => <Tab disableRipple {...props} />);

const StyledTabs = withStyles({
  indicator: {
    display: "flex",
    justifyContent: "center",
    backgroundColor: "transparent",
    "& > span": {
      maxWidth: 120,
      width: "100%",
      backgroundColor: "#F44336",
    },
  },
})((props) => <Tabs {...props} TabIndicatorProps={{ children: <span /> }} />);

function OperatorArea() {
  const classes = useStyles();

  const [value, setValue] = React.useState(0);

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <Grid item xs={10}>
      <Box
        height="100vh"
        justifyContent="center"
        alignItems="stretch"
        paddingLeft={10}
      >
        <Header />
        <Container className={classes.container}>
          <Typography variant="h5" style={{ fontWeight: "bolder" }}>
            Listas
          </Typography>

          <StyledTabs
            value={value}
            onChange={handleChange}
            aria-label="styled tabs example"
          >
            <StyledTab label="Não atendidas" />
            <StyledTab label="Atendidas" />
          </StyledTabs>
          <Typography className={classes.padding} />

          <ResquestTable />
        </Container>
      </Box>
    </Grid>
  );
}
