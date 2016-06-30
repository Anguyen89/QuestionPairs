DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users(fname,lname)
VALUES
  ("alpha", "beta"), ("ralph", "cats");


DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY(author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
SELECT
  "Random Question", "TEXT TEXT TEXT", users.id
FROM
  users
WHERE
  users.lname = 'beta' AND users.fname = 'alpha';

INSERT INTO
  questions(title, body, author_id)
  SELECT
    "RANDOM question 2", "Some more text", users.id
  FROM
    users
  WHERE
    users.lname = "some name" AND users.fname = 'some first name';



DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "alpha" AND lname = "beta"),
    (SELECT id FROM questions WHERE title = "Random Question")),
  ((SELECT id FROM users WHERE fname = "some first name" AND lname = "some name"),
    (SELECT id FROM questions WHERE title = "RANDOM question 2"));




DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  body TEXT(255) NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id)
  FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
  FOREIGN KEY(author_id) REFERENCES users(id)

);


INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Random Question"),
  NULL,
  (SELECT id FROM users WHERE fname = "beta" AND lname = "alpha"),
  "Did you say NOW NOW NOW?"
);

INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Random Question"),
  (SELECT id FROM replies WHERE body = "Did you say NOW NOW NOW?"),
  (SELECT id FROM users WHERE fname = "beta" AND lname = "alpha"),
  "I think he said MEOW MEOW MEOW."
);


DROP TABLE IF EXISTS question_likes


CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(author_id) REFERENCES authors(id)
)
