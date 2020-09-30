import React from "react";
import {
  TableContainer,
  TableHead,
  TableRow,
  TableCell,
  TableBody,
  Table,
  makeStyles,
  Avatar,
  Box,
} from "@material-ui/core";

import "../../../../../styles/table.css";
import { useHistory } from "react-router-dom";
import convertTime from "../../../../../utils/timeConverter";

const useStyle = makeStyles({
  table: {
    border: "1px solid #C8C5C5",
    borderRadius: 10,
    margin: "37px 0",
    maxHeight: "60vh",
    overflow: "hidden",
    overflowY: "scroll",
  },

  head: {
    fontWeight: "bolder",
    backgroundColor: "#fff",
  },

  row: {
    "&.MuiTableRow-hover": {
      cursor: "pointer",
    },
  },

  body: {
    paddingLeft: 33,
    paddingRight: 33,
  },
  avatar: {
    marginRight: 15,
  },
});

function buildRow({ id, title, createdAt, status }, classes, history) {
  const handleRowClick = (id) => {
    history.push("/request/" + id);
  };

  if (status !== null) {
    return (
      <TableRow
        hover
        role="checkbox"
        key={id}
        tabIndex={-1}
        className={classes.row}
        onClick={() => handleRowClick(id)}
      >
        <TableCell component="th" scope="row">
          <Box display="flex" alignItems="center">
            <Avatar className={classes.avatar} />
            {title}
          </Box>
        </TableCell>
        <TableCell align="right">{convertTime(createdAt)[0]}</TableCell>
        <TableCell align="right">{convertTime(createdAt)[1]}</TableCell>
      </TableRow>
    );
  }
}

function buildHead(classes) {
  return (
    <TableRow>
      <TableCell className={classes.head}>Nome</TableCell>
      <TableCell align="right" className={classes.head}>
        Data
      </TableCell>
      <TableCell align="right" className={classes.head}>
        Horário
      </TableCell>
    </TableRow>
  );
}

export default function AttendedTable({ data }) {
  const classes = useStyle();
  const history = useHistory();

  const [calls, setCalls] = React.useState(data);

  React.useEffect(() => {
    setCalls(data);
  }, [data]);

  return (
    <TableContainer className={classes.table}>
      <Table stickyHeader aria-label="sticky table" className={classes.body}>
        <TableHead>{buildHead(classes)}</TableHead>
        <TableBody className={classes.body}>
          {calls.map((row) => buildRow(row, classes, history))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}
