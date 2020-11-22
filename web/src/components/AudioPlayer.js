import React from "react";
import Axios from "axios";

import { Box, Container, IconButton } from "@material-ui/core";

import PauseIcon from "@material-ui/icons/Pause";
import ReplayIcon from "@material-ui/icons/Replay";
import PlayArrowIcon from "@material-ui/icons/PlayArrow";
import PCMPlayer from "../utils/pcmPlayer";

var player = new PCMPlayer({
  inputCodec: "Int16",
  channels: 1,
  sampleRate: 8000,
  flushTime: 200,
});

export default function AudioPlayer({ className, src }) {
  //Play the audio
  React.useEffect(() => {
    async function getPCMData() {
      const response = await Axios.get(src, {
        responseType: "arraybuffer",
      });

      player.feed(response.data);
    }

    async function destroy() {
      await player.pause();
    }

    if (src !== null && src !== "") {
      getPCMData();
    }

    return () => {
      destroy();
    };
  }, [src]);

  //Audio component controllers
  const handlePlayClick = async () => {
    await player.continue();
  };

  const handlePauseClick = async () => {
    await player.pause();
  };

  const handleReplay = async () => {
    const response = await Axios.get(src, {
      responseType: "arraybuffer",
    });

    player.feed(response.data);
  };

  return (
    <Box display="flex" justifyContent="center" alignItems="center">
      <Container className={className}>
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
  );
}
