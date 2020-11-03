import React from "react";

import {
  Box,
  Container,
  Fab,
  IconButton,
  makeStyles,
  Typography,
} from "@material-ui/core";

import ClearRoundedIcon from "@material-ui/icons/ClearRounded";
import CheckRoundedIcon from "@material-ui/icons/CheckRounded";
import PlayArrowIcon from "@material-ui/icons/PlayArrow";
import PauseIcon from "@material-ui/icons/Pause";
import ReplayIcon from "@material-ui/icons/Replay";

import "../../../../../styles/list.css";
import "../../../../../styles/audio.css";
import { updateCall } from "../../../../../controllers/CallController";
import PCMPlayer from "../../../../../utils/pcmPlayer";
import Axios from "axios";

const titleStyle = {
  fontWeight: "bold",
  margin: "5px 0 20px 0",
};

const player = new PCMPlayer({
  inputCodec: "Int16",
  channels: 1,
  sampleRate: 8000,
  flushTime: 200,
});

const useStyles = makeStyles((theme) => ({
  audioContainer: {
    backgroundColor: "#f44336",
    width: "auto",
    borderRadius: 30,
  },

  audioButton: {
    color: "#FFF",
  },
}));

export default function SpecsContainer({ data }) {
  const imageURL = "http://localhost:3002/" + data.image_url;
  const audioURL = "http://localhost:3002/" + data.audio_url;

  const classes = useStyles();

  const [call, setCall] = React.useState(data);

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

  const handlePlayClick = async () => {
    await player.continue();
  };

  const handlePauseClick = async () => {
    await player.pause();
  };

  const handleReplay = async () => {
    const response = await Axios.get(audioURL, {
      responseType: "arraybuffer",
    });

    player.feed(response.data);
  };

  React.useEffect(() => {
    setCall(data);
  }, [data]);

  React.useEffect(() => {
    async function getPCMData() {
      const response = await Axios.get(audioURL, {
        responseType: "arraybuffer",
      });

      player.feed(response.data);
    }

    async function destroy() {
      await player.pause();
    }

    getPCMData();

    return () => {
      destroy();
    };
  }, [audioURL]);

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
            <Container className={classes.audioContainer}>
              <IconButton onClick={handlePlayClick}>
                <PlayArrowIcon htmlColor="#FFF" />
              </IconButton>

              <IconButton onClick={handlePauseClick}>
                <PauseIcon htmlColor="#FFF" />
              </IconButton>

              <IconButton onClick={handleReplay}>
                <ReplayIcon htmlColor="#FFF" />
              </IconButton>
            </Container>
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
