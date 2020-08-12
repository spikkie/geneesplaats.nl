import React, { Component } from "react";
import ChatWindow from "./components/chat/window";
import ChatQuery from "./components/queries/chatQuery";
import ChatsQuery from "./components/queries/chatsQuery";
import ChatsList from "./components/chat/list";
import { ToastContainer } from "react-toastify";
import MessageAddedSubscription from "./components/subscriptions/messageAdded";
import ChatNotification from "./components/chat/notification";

const ConsoleLog = ({ children }) => {
    console.log(children);
    return false;
};

export default class Chats extends Component {
    state = {
        openChats: []
    };
    openChat = id => {
        var openChats = this.state.openChats.slice();

        if (openChats.indexOf(id) === -1) {
            if (openChats.length > 2) {
                openChats = openChats.slice(1);
            }
            openChats.push(id);
        }

        this.setState({ openChats });
    };
    closeChat = id => {
        var openChats = this.state.openChats.slice();

        const index = openChats.indexOf(id);
        openChats.splice(index, 1);

        this.setState({ openChats });
    };
    render() {
        const { user } = this.props;
        const { openChats } = this.state;

        return (
            <div className="wrapper">
                <ConsoleLog>{this.props}</ConsoleLog>
                <ConsoleLog>{this.state}</ConsoleLog>
                <ToastContainer />
                <MessageAddedSubscription>
                    <ChatNotification />
                </MessageAddedSubscription>
                <ChatsQuery>
                    <ChatsList openChat={this.openChat} user={user} />
                </ChatsQuery>
                <div className="openChats">
                    {openChats.map((ChatId, i) => (
                        <ChatQuery
                            key={"chatWindow" + ChatId}
                            variables={{ ChatId }}
                        >
                            <ChatWindow
                                closeChat={this.closeChat}
                                user={user}
                            />
                        </ChatQuery>
                    ))}
                </div>
            </div>
        );
    }
}
