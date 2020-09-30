import {
  Avatar,
  Box,
  Button,
  Divider,
  Typography,
  withStyles,
} from "@material-ui/core";
import React from "react";
import MailIcon from "@material-ui/icons/Mail";
import PhoneIcon from "@material-ui/icons/Phone";
import CreditCardIcon from "@material-ui/icons/CreditCard";
import BlockIcon from "@material-ui/icons/Block";
import LocationMap from "../../Map";

function UserDataField({ children, data }) {
  return (
    <Box display="flex" alignItems="center">
      {children} {data}
    </Box>
  );
}

const CustomDivider = withStyles({
  root: {
    marginTop: 10,
    marginBottom: 10,
  },
})(Divider);

export default function UserContainer({ data }) {
  const titleStyle = {
    fontWeight: "bold",
    margin: "5px 0 20px 10px",
  };

  const iconStyle = {
    color: "#f44336",
    marginRight: 10,
    marginBottom: 5,
  };

  const buttonStyle = {
    borderRadius: 30,
  };

  const iframeURL =
    "https://maps.google.com/maps?q=" +
    data.latitude +
    "," +
    data.longitude +
    "&hl=pt&z=14&amp&output=embed";

  return (
    <>
      <Box
        justifyContent="center"
        alignItems="center"
        maxHeight={"90vh"}
        className="BoxList"
        paddingX={2}
        style={{ overflowY: "scroll", overflowX: "hidden" }}
      >
        <Box display="flex" justifyContent="center">
          <Avatar />

          <Typography
            variant="h5"
            component="h1"
            style={titleStyle}
            align="center"
          >
            {data.user.first_name + " " + data.user.last_name}
          </Typography>
        </Box>

        <Box paddingX={2}>
          <UserDataField data={data.user.email}>
            <MailIcon style={iconStyle} />
          </UserDataField>

          <UserDataField data={data.user.phonenumber}>
            <PhoneIcon style={iconStyle} />
          </UserDataField>

          <UserDataField data={data.user.cpf}>
            <CreditCardIcon style={iconStyle} />
          </UserDataField>
        </Box>

        <CustomDivider />

        <Box
          display="flex"
          flexDirection="column"
          justifyContent="center"
          alignItems="center"
        >
          <Typography style={titleStyle}>Endereço da Solicitação</Typography>
          <LocationMap url={iframeURL} />
        </Box>

        <CustomDivider />

        <Button onClick={() => {}} style={buttonStyle}>
          <BlockIcon style={iconStyle} /> Bloquear cliente
        </Button>
      </Box>
    </>
  );
}
