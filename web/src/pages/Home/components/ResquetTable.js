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

const testObjectArray = [
  {
    id: 0,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 1,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 2,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 3,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 4,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 5,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 6,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
  {
    id: 7,
    name: "Teste",
    date: "04/09/2020",
    time: "16:47",
  },
];

const useStyle = makeStyles({
  table: {
    border: "1px solid #C8C5C5",
    margin: "37px 0",
    maxHeight: "80%",
    minHeight: "80%",
    overflow: "hidden",
    overflowY: "auto",
  },

  head: {
    fontWeight: "bolder",
  },

  body: {
    paddingLeft: 33,
    paddingRight: 33,
  },
  avatar: {
    marginRight: 15,
  },
});

export default function ResquestTable() {
  const classes = useStyle();

  return (
    <TableContainer className={classes.table}>
      <Table stickyHeader aria-label="sticky table">
        <TableHead>
          <TableRow>
            <TableCell className={classes.head}>Nome</TableCell>
            <TableCell align="right" className={classes.head}>
              Data
            </TableCell>
            <TableCell align="right" className={classes.head}>
              Horario
            </TableCell>
          </TableRow>
        </TableHead>
        <TableBody className={classes.body}>
          {testObjectArray.map((row) => (
            <TableRow hover role="checkbox" key={row.id} tabIndex={-1}>
              <TableCell component="th" scope="row">
                <Box display="flex" alignItems="center">
                  <Avatar className={classes.avatar} />
                  {row.name}
                </Box>
              </TableCell>
              <TableCell align="right">{row.date}</TableCell>
              <TableCell align="right">{row.time}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
}
