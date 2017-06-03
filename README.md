+ chat-space

  DB設計

  users table
  | Column     | Type        | Option       |
  |:-----------|------------:|:------------:|
  | id         | integer     | null:false   |
  | name       | string      | null:false   |
  | email      | string      | null:false   |
  | passward   | string      | null:false   |

  assosiation
  * has_many  :messages
  * has_many  :groups; through: members
  * has_many  :members

  messages table
  | Column     | Type        | Option       |
  |:-----------|------------:|:------------:|
  | id         | integer     | null:false   |
  | text       | text        |              |
  | image      | text        |              |
  | user_id    | integer     |              |
  | left       | right       | center       |

  assosiation
  *belongs_to :user

  groups table
  | Column     | Type        | Option       |
  |:-----------|------------:|:------------:|
  | id         | integer     | null:false   |
  | name       | string      | null:false   |

  assotiation
  * has_many :users; through: members
  * has_meny :members

  members table
  | Column     | Type        | Option       |
  |:-----------|------------:|:------------:|
  | id         | integer     | null:false   |
  | group_id   | integer     |              |
  | user_id    | integer     |              |

  assosiation
  * belongs_to user
  * belongs_to group