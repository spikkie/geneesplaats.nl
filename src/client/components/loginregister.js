import React, { Component } from "react";
import Error from "./error";
import LoginMutation from "./mutations/login";
import RegisterMutation from "./mutations/signup";
import BrowserInfo from "./browserInfo";

class LoginForm extends Component {
    state = {
        email: "",
        password: ""
    };
    login = event => {
        event.preventDefault();
        this.props.login({
            variables: {
                email: this.state.email,
                password: this.state.password
            }
        });
    };

    render() {
        const { error } = this.props;
        return (
            <div className="login">
                <form onSubmit={this.login}>
                    <label>Email</label>
                    <input
                        type="text"
                        onChange={event =>
                            this.setState({ email: event.target.value })
                        }
                    />
                    <label>Password</label>
                    <input
                        type="password"
                        onChange={event =>
                            this.setState({ password: event.target.value })
                        }
                    />
                    <input type="submit" value="Login" />
                </form>
                {error && (
                    <Error>
                        <p>There was an error logging in!</p>
                    </Error>
                )}
            </div>
        );
    }
}

class RegisterForm extends Component {
    state = {
        email: "",
        password: "",
        username: ""
    };
    login = event => {
        event.preventDefault();
        this.props.signup({
            variables: {
                email: this.state.email,
                password: this.state.password,
                username: this.state.username
            }
        });
    };
    render() {
        const { error } = this.props;
        return (
            <div className="login">
                <form onSubmit={this.login}>
                    <label>Email</label>
                    <input
                        type="text"
                        onChange={event =>
                            this.setState({ email: event.target.value })
                        }
                    />
                    <label>Username</label>
                    <input
                        type="text"
                        onChange={event =>
                            this.setState({ username: event.target.value })
                        }
                    />
                    <label>Password</label>
                    <input
                        type="password"
                        onChange={event =>
                            this.setState({ password: event.target.value })
                        }
                    />
                    <input type="submit" value="Sign up" />
                </form>
                {error && (
                    <Error>
                        <p>There was an error logging in!!!!!</p>
                    </Error>
                )}
            </div>
        );
    }
}

export default class LoginRegisterForm extends Component {
    constructor(props) {
        super(props);
        this.state = { showLogin: true };
    }

    toggleLoginSignup = e => {
        e.preventDefault();
        console.log(this.state);
        console.log(this.props);
        console.log(e.target);
        console.log(e.type);
        // console.dir(e);
        // console.table(e);
        // console.log(util.inspect(e, {showHidden: false, depth: null}));
        // console.log(JSON.stringify(e, null, 4));
        // alert(this.props);
        this.setState(state => ({ showLogin: !state.showLogin }));
    };

    render() {
        const { changeLoginState } = this.props;
        const { showLogin } = this.state;
        return (
            <div className="authModal">
                {showLogin && (
                    <div>
                        <LoginMutation changeLoginState={changeLoginState}>
                            <LoginForm />
                        </LoginMutation>
                        <a
                            onclick=""
                            style={{cursor: "pointer"}}
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onTouchStart={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to sign up 0.1.17? Click here
                        </a>
                        <button
                            onclick=""
                            style={{cursor: "pointer"}}
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onTouchStart={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to sign up 0.1.17? Click here
                        </button>
                        <h2
                            onclick=""
                            style={{cursor: "pointer"}}
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onTouchStart={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to sign up 0.1.17? Click here
                        </h2>
                        <BrowserInfo />
                    </div>
                )}
                {!showLogin && (
                    <div>
                        <RegisterMutation changeLoginState={changeLoginState}>
                            <RegisterForm />
                        </RegisterMutation>
                        <a onclick=""
                            style={{cursor: "pointer"}}
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to login 0.1.17? Click here2
                        </a>
                        <button
                            style={{cursor: "pointer"}}
                            onclick=""
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onTouchStart={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to login 0.1.17? Click here2
                        </button>
                        <h2
                            style={{cursor: "pointer"}}
                            onclick=""
                            className="LoginSignUpSelector"
                            onTouchEnd={this.toggleLoginSignup}
                            onTouchStart={this.toggleLoginSignup}
                            onClick={this.toggleLoginSignup}
                            // onTouchEnd={() => {
                            //     this.setState({ showLogin: true });
                            // }}
                        >
                            Want to login 0.1.17? Click here2
                        </h2>
                        <BrowserInfo />
                    </div>
                )}
            </div>
        );
    }
}
