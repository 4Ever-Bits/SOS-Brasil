import React from "react";

import { Box, Container, Fab, Typography } from "@material-ui/core";

import ClearRoundedIcon from "@material-ui/icons/ClearRounded";
import CheckRoundedIcon from "@material-ui/icons/CheckRounded";

import "../../../../../styles/list.css";
import "../../../../../styles/audio.css";
import { updateCall } from "../../../../../controllers/CallController";

export default function SpecsContainer({ data }) {
  const titleStyle = {
    fontWeight: "bold",
    margin: "5px 0 20px 0",
  };

  const imageURL = "http://localhost:3002/" + data.image_url;
  const audioURL = "http://localhost:3002/" + data.audio_url;

  const [call, setCall] = React.useState(data);
  React.useEffect(() => {
    setCall(data);
  }, [data]);

  const handleAcceptClick = async () => {
    const { id } = JSON.parse(localStorage.getItem("user"));
    const call_id = data.id;

    if (await updateCall(id, call_id, "accepted")) {
      window.location.reload();
    }
  };

  const handleDeniedClick = async () => {
    const { id } = JSON.parse(localStorage.getItem("user"));
    const call_id = data.id;

    if (await updateCall(id, call_id, "denied")) {
      window.location.reload();
    }
  };

  return (
    <Container style={{ padding: "0 10px" }}>
      <Box
        justifyContent="center"
        alignItems="center"
        maxHeight="90vh"
        className="BoxList"
        style={{ overflowY: "scroll", overflowX: "hidden" }}
      >
        <Typography
          variant="h5"
          component="h1"
          style={titleStyle}
          align="center"
        >
          {call.title}
        </Typography>

        <Typography
          paragraph
          align="justify"
          style={{ maxWidth: 300, margin: "5px auto 20px auto" }}
        >
          {call.description}
        </Typography>

        {call.audio_url !== null && call.audio_url !== "" ? (
          <Box display="flex" justifyContent="center" alignItems="center">
            <audio src={audioURL} controls />
          </Box>
        ) : (
          <></>
        )}

        <Box
          display="flex"
          justifyContent="center"
          alignItems="center"
          margin="20px 0"
        >
          {call.image_url !== null && call.image_url !== "" ? (
            <img
              src={imageURL}
              alt=""
              height={230}
              width={300}
              style={{ margin: "10px 0 10px 0" }}
            />
          ) : (
            <></>
          )}
        </Box>

        {call.status === null ? (
          <Box
            display="flex"
            justifyContent="center"
            alignItems="center"
            padding="0 80px"
            margin="10px 0 60px 0"
          >
            <Fab
              color="primary"
              aria-label="accept"
              style={{ margin: "0 20px", backgroundColor: "#14FC14" }}
              onClick={handleAcceptClick}
            >
              <CheckRoundedIcon fontSize="large" />
            </Fab>
            <Fab
              color="primary"
              aria-label="denie"
              style={{ margin: "0 20px", backgroundColor: "#FE1E1A" }}
              onClick={handleDeniedClick}
            >
              <ClearRoundedIcon fontSize="large" />
            </Fab>
          </Box>
        ) : (
          <>
            <Typography style={{ margin: 20 }}>
              <span style={titleStyle}>Status:</span>{" "}
              <span
                style={{
                  color: call.status !== "accepted" ? "#f00" : "#0f0",
                }}
              >
                {call.status}
              </span>
            </Typography>
          </>
        )}
      </Box>
    </Container>
  );
}
