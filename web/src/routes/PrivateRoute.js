import React from "react";
import { Route, Redirect } from "react-router-dom";

import { isAuthenticated } from "../services/auth";

const PrivateRoute = ({ component: Component, ...rest }) => (
  <Route
    {...rest}
    render={(props) =>
      isAuthenticated() ? (
        <Component {...props} />
      ) : (
        <Redirect to={{ pathname: "/signin", state: props.location }} />
      )
    }
  />
);

export default PrivateRoute;
