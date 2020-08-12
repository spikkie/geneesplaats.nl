import React, { Component } from "react";
import SearchBar from "./search";
import Clock from "./clock";
import UserBar from "./user";
import { UserConsumer } from "../context/user";
import Logout from "./logout";
import Home from "./home";
import LogoutMutation from "../mutations/logout";

export default class Bar extends Component {
    render() {
        return (
            <div className="topbar">
                <div className="inner">
                    <Clock />
                    <SearchBar />
                    <UserConsumer>
                        <UserBar />
                    </UserConsumer>
                </div>
                <div className="buttons">
                    <Home />
                    <LogoutMutation>
                        <Logout
                            changeLoginState={this.props.changeLoginState}
                        />
                    </LogoutMutation>
                </div>
            </div>
        );
    }
}
