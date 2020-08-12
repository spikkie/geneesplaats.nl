import React, { Component } from 'react';
import loadable from 'react-loadable';
import Loading from './components/loading';
const User = loadable({
  loader: () => import('./User'),
  loading: Loading,
});
const Main = loadable({
  loader: () => import('./Main'),
  loading: Loading,
});
const LoginRegisterForm = loadable({
  loader: () => import('./components/loginregister'),
  loading: Loading,
});

const ReactRouter = require("react-router-dom");
let Router;
if (typeof window !== typeof undefined) {
    console.log("----------------------------------------------");
    console.log("------- typeof window !== typeof undefined ----------");
    console.log("----------------------------------------------");
    const { BrowserRouter } = ReactRouter;
    Router = BrowserRouter;
} else {
    console.log("----------------------------------------------");
    console.log("------- ELSE ypeof window !== typeof undefined ----------");
    console.log("----------------------------------------------");
    const { StaticRouter } = ReactRouter;
    Router = StaticRouter;
}
console.log("----------------------------------------------");
const { Route, Redirect, Switch } = ReactRouter;

console.log("----------------------------------------------");
const PrivateRoute = ({ component: Component, ...rest }) => (
    <Route
        {...rest}
        render={props =>
            rest.loggedIn === true ? (
                <Component {...props} />
            ) : (
                <Redirect
                    to={{
                        pathname: "/",
                        state: { from: props.location }
                    }}
                />
            )
        }
    />
);

console.log("----------------------------------------------");
class NotFound extends Component {
    render() {
        return <Redirect to="/" />;
    }
}

console.log("----------------------------------------------");
const LoginRoute = ({ component: Component, ...rest }) => (
    <Route
        {...rest}
        render={props =>
            rest.loggedIn === false ? (
                <Component {...props} />
            ) : (
                <Redirect
                    to={{
                        pathname:
                            typeof props.location.state !== typeof undefined
                                ? props.location.state.from.pathname
                                : "/app"
                    }}
                />
            )
        }
    />
);

console.log("----------------------------------------------");
export default class Routing extends Component {
    render() {
        console.log("----------------------------------------------");
        console.log("------- Routing render ----------");
        console.log(this.props);
        console.log("----------------------------------------------");
        return (
            <Router context={this.props.context} location={this.props.location}>
                <Switch>
                    <PrivateRoute
                        path="/app"
                        component={() => (
                            <Main
                                changeLoginState={this.props.changeLoginState}
                            />
                        )}
                        loggedIn={this.props.loggedIn}
                    />
                    <PrivateRoute
                        path="/user/:username"
                        component={props => (
                            <User
                                {...props}
                                changeLoginState={this.props.changeLoginState}
                            />
                        )}
                        loggedIn={this.props.loggedIn}
                    />
                    <LoginRoute
                        exact
                        path="/"
                        component={() => (
                            <LoginRegisterForm
                                changeLoginState={this.props.changeLoginState}
                            />
                        )}
                        loggedIn={this.props.loggedIn}
                    />
                    <Route component={NotFound} />
                </Switch>
            </Router>
        );
    }
}
