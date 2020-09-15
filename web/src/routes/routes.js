import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import HomePage from "../pages/Home/HomePage";
import LoginPage from "../pages/Login/LoginPage";
import PrivateRoute from "./PrivateRoute";

const routes = () => (
  <BrowserRouter>
    <Switch>
      <PrivateRoute exact path="/" component={HomePage} />
      <Route exact path="/signin" component={LoginPage} />
    </Switch>
  </BrowserRouter>
);

export default routes;
