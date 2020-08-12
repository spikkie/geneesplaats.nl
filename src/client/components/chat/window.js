import React, { Component } from "react";
import AddMessageMutation from "../mutations/addMessage";
import ChatInput from "./input";

const ConsoleLog = ({ children }) => {
    console.log(children);
    return false;
};
//   <span> { user.id ==== chat.users[0].id ? chat.users[1].id : chat.users[0].id}</span>
export default class ChatWindow extends Component {
    render() {
        const { chat, closeChat, user } = this.props;
        return (
            <div className="chatWindow">
                <div className="header">
                    <span>
                        {user.id === chat.users[0].id
                            ? chat.users[1].username
                            : chat.users[0].username}
                    </span>
                    <ConsoleLog>{chat.users[1].username}</ConsoleLog>
                    <ConsoleLog>{chat.messages}</ConsoleLog>
                    <ConsoleLog>{user}</ConsoleLog>
                    <button
                        className="close"
                        onClick={() => closeChat(chat.id)}
                    >
                        X
                    </button>
                </div>
                <div className="messages">
                    {chat.messages.map((message, j) => (
                        <div
                            key={"message" + message.id}
                            className={
                                "message " +
                                (message.user.id === chat.users[1].id
                                    ? "left"
                                    : "right")
                            }
                        >
                            {message.text}
                        </div>
                    ))}
                </div>
                <AddMessageMutation chat={chat}>
                    <ChatInput chat={chat} />
                </AddMessageMutation>
            </div>
        );
    }
}
