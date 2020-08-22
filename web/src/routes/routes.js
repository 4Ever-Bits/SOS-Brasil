import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import HomePage from "../pages/Home/HomePage";
import LoginPage from "../pages/Login/LoginPage";

const routes = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path="/" component={HomePage} />
      <Route exact path="/login" component={LoginPage} />
    </Switch>
  </BrowserRouter>
);

export default routes;
