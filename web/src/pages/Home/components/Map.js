import React from "react";

import RoomIcon from "@material-ui/icons/Room";
import { withStyles } from "@material-ui/core";

const Ping = withStyles({
  root: {
    color: "#f44336",
    position: "relative",
    bottom: 150,
    fontSize: 30,
  },
})(RoomIcon);

export default function LocationMap({ url }) {
  return (
    <>
      <iframe
        id="map"
        title="map"
        src={url}
        width="250"
        height="250"
        frameBorder="0"
        style={{ border: 0 }}
        allowFullScreen={true}
        aria-hidden={false}
        contentEditable={false}
        tabIndex="0"
      />

      <label htmlFor="#map">
        <Ping />
      </label>
    </>
  );
}
