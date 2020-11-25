import {
  Avatar,
  Container,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Typography,
  withStyles,
} from "@material-ui/core";
import React from "react";

const StyledListItem = withStyles({
  root: {
    fontWeight: "bolder",
    fontSize: 20,
    borderRadius: 20,
    height: 60,
    marginBottom: 5,

    "&:hover": {
      backgroundColor: "rgba(255,255,255,.5)",
    },
    "&.Mui-selected": {
      backgroundColor: "rgba(255,255,255,.5)",
    },
  },
})(ListItem);

export default function ListContainer({ id, data, history }) {
  return (
    <Container>
      <List
        component="nav"
        // aria-label="main mailbox folders"
        style={{
          maxHeight: "90vh",
          overflow: "auto",
        }}
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
              <Typography style={{ fontSize: 20, fontWeight: "bolder" }}>
                {item.title}
              </Typography>
            </ListItemText>
          </StyledListItem>
        ))}
      </List>
    </Container>
  );
}
