import React, { Component } from "react";
import { NavLink, Redirect } from "react-router-dom";

import SimpleBackdrop from "../../components/SimpleBackdrop";
import NotifSnackbar from "../../components/NotifSnackbar";

import { LoginContainer } from "./components/LoginContainer";
import { LoginInput } from "./components/LoginInput";
import { LoginButton } from "./components/LoginButton";

import * as Session from "../../controllers/SessionController";

import { Box, Grid, Typography } from "@material-ui/core";

import Avatar from "../../components/SOSAvatar";
import Logo from "../../assets/images/image.png";

export default class Login extends Component {
  constructor(props) {
    super(props);
    this.state = this.getInitialState();
  }

  getInitialState() {
    return {
      email: "",
      pswd: "",
      rememberMe: false,
      isLoading: false,
      hasLoggedIn: false,
      toast: {
        isOpen: false,
        message: "",
        severity: "success",
      },
    };
  }

  handleChange = (ev) => {
    this.setState({ [ev.target.name]: ev.target.value });
  };

  handleRememberMe = (ev) => {
    this.setState({ [ev.target.name]: ev.target.checked });
  };

  handleSubmit = async (ev) => {
    try {
      ev.preventDefault();

      this.setState({ isLoading: true });

      const payload = {
        email: this.state.email,
        password: this.state.pswd,
      };

      const token = await Session.login(payload).catch((error) => {
        this.setState({
          isLoading: false,
          toast: { isOpen: true, message: error, severity: "warning" },
        });
      });

      if (token) {
        this.setState({ isLoading: false });

        localStorage.setItem("token", token);

        this.setState({ hasLoggedIn: true });
      }
    } catch (error) {
      this.setState({
        isLoading: false,
        toast: { isOpen: true, message: error, severity: "warning" },
      });
    }
  };

  handleSnackClose = () => {
    this.setState({
      toast: {
        isOpen: false,
        message: "",
        severity: "success",
      },
    });
  };

  render() {
    if (this.state.hasLoggedIn) {
      return <Redirect to="/" />;
    }

    return (
      <div className="login">
        <Grid
          container
          spacing={0}
          direction="column"
          alignItems="center"
          justify="center"
          style={{ minHeight: "100vh" }}
        >
          <Grid item>
            <Avatar src={Logo} />
          </Grid>

          <Grid item>
            <LoginContainer maxWidth="sm">
              <form onSubmit={this.handleSubmit}>
                <Typography
                  variant="h5"
                  component="h2"
                  style={{ fontWeight: "bolder", marginBottom: 20 }}
                >
                  Área do Operador
                </Typography>

                <LoginInput
                  placeholder="Email"
                  name="email"
                  type="email"
                  onChange={this.handleChange}
                />
                <LoginInput
                  placeholder="Senha"
                  name="pswd"
                  type="password"
                  onChange={this.handleChange}
                />

                <Box
                  display="flex"
                  justifyContent="flex-end"
                  alignItems="center"
                >
                  <NavLink
                    to="/about"
                    style={{
                      color: "black",
                      textDecoration: "none",
                      fontSize: 16,
                    }}
                  >
                    Esqueceu a senha?
                  </NavLink>
                </Box>

                <LoginButton>Entrar</LoginButton>
              </form>
            </LoginContainer>
          </Grid>
        </Grid>

        <SimpleBackdrop open={this.state.isLoading} />

        <NotifSnackbar
          open={this.state.toast.isOpen}
          onClose={this.handleSnackClose}
          message={this.state.toast.message}
          severity={this.state.toast.severity}
        />
      </div>
    );
  }
}
