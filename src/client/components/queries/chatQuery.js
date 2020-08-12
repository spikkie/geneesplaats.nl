import React, { Component } from 'react';
import { Query } from "react-apollo";
import Loading from '../loading';
import Error from '../error';
import gql from "graphql-tag";

const GET_CHAT = gql`
  query chat($ChatId: Int!) {
    chat(ChatId: $ChatId) {
      id
      users {
        id
        avatar
        username
      }
      messages {
        id
        text
        user {
            id
        }
      }
    }
  }
`;

export default class UserQuery extends Component {
    getVariables() {
        const { variables } = this.props;
        var query_variables = {};

        if(typeof variables.ChatId !== typeof undefined) {
            query_variables.ChatId = variables.ChatId;
        }

        return query_variables;
    }
    render() {
        const { children } = this.props;
        const variables = this.getVariables();
        return(
            <Query query={GET_CHAT} variables={variables}>
                {({ loading, error, data, subscribeToMore }) => {
                    if (loading) return <Loading/>;
                    if (error) return <Error><p>{error.message}</p></Error>;

                    const { chat } = data;
                    return React.Children.map(children, function(child){
                        return React.cloneElement(child, { chat, subscribeToMore });
                    })
                }}
            </Query>
        )
    }
}