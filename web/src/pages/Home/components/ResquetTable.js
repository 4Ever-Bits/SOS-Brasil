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

import "../../../styles/table.css";
import { useHistory } from "react-router-dom";

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

function buildRow({ id, title, createdAt }, classes, history) {
  const handleRowClick = (id) => {
    console.log(id);

    history.push("/request/" + id);
  };

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
      <TableCell align="right">{createdAt}</TableCell>
      <TableCell align="right">{createdAt}</TableCell>
    </TableRow>
  );
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

export default function ResquestTable({ data }) {
  const classes = useStyle();

  const history = useHistory();

  return (
    <TableContainer className={classes.table}>
      <Table stickyHeader aria-label="sticky table" className={classes.body}>
        <TableHead>{buildHead(classes)}</TableHead>
        <TableBody className={classes.body}>
          {data.map((row) => buildRow(row, classes, history))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}
