import React from "react";
import { Box, Typography } from "@material-ui/core";
import { LoginAvatar } from "../pages/Login/components/LoginAvatar";

export default function Avatar({ src, classes }) {
  return (
    <div>
      <Box
        display="flex"
        flexDirection="column"
        justifyContent="center"
        alignItems="center"
        color="white"
        m="20px"
      >
        <LoginAvatar src={src} />
        <Typography variant="h4" component="h1" className={classes.title}>
          SOS Brasil
        </Typography>
      </Box>
    </div>
  );
}
