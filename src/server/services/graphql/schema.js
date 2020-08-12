const typeDefinitions = `
  directive @auth on QUERY | FIELD_DEFINITION | FIELD
  enum CacheControlScope {
    PUBLIC
    PRIVATE
  }
  directive @cacheControl (
    maxAge: Int
    scope: CacheControlScope
  ) on FIELD_DEFINITION | OBJECT | INTERFACE
  scalar Upload

  type User @cacheControl(maxAge: 120) {
    id: Int
    avatar: String @cacheControl(maxAge: 240)
    username: String
    email: String
    createdAt: String
    updatedAt: String
  }

  type Post {
    id: Int
    text: String
    user: User
  }

  type Message {  
    id: Int  
    text: String  
    chat: Chat  
    user: User
  }

  type Chat {  
    id: Int  
    messages: [Message]  
    users: [User]
    lastMessage: Message
  }

  type PostFeed {
    posts: [Post]
  }

  type File {
    filename: String!
    url: String!
  }
  input PostInput {
    text: String!
  }
  
  input UserInput {
    username: String!
    avatar: String!
  }
  input ChatInput {
    users: [Int]
  }

  input MessageInput {
    text: String!
    ChatId: Int!
  }
  type Response {
    success: Boolean
  }

  type UsersSearch {
    users: [User]
  }

  type Auth { 
    token: String
  }
  
  type RootMutation {
    addPost (
      post: PostInput!
    ): Post
    addChat (
      chat: ChatInput!
    ): Chat
    addMessage (
      message: MessageInput!
    ): Message
    updatePost (
      post: PostInput!
      postId: Int!
    ): Post
    deletePost (
      postId: Int!
    ): Response
    login ( 
      email: String!  
      password: String!
    ): Auth
    signup (
      username: String!
      email: String!
      password: String!
    ): Auth
    uploadAvatar (
      file: Upload!
    ): File @auth
    logout: Response @auth
  }

  type RootQuery {
    posts: [Post]
    chats: [Chat]
    users: [User]
    chatsByUser: [Chat]
    chat(ChatId: Int): Chat
    postsFeed(page: Int, limit: Int, username: String): PostFeed @auth
    user(username: String!): User @auth
    usersSearch(page: Int, limit: Int, text: String!): UsersSearch
    currentUser: User @auth
  }

  type RootSubscription {
    messageAdded: Message
  }

  schema {
    query: RootQuery
    mutation: RootMutation
    subscription: RootSubscription
  }
`;

export default [typeDefinitions];
