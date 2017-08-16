DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER NOT NULL,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Larissa', 'Schiavo'),
  ('Adrienne', 'Lin');

INSERT INTO
  questions (id, title, body, author_id)
VALUES
  (1, 'Applying', 'How do I apply?', (SELECT id FROM users WHERE fname = 'Larissa'));

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, (SELECT id FROM users WHERE fname = 'Adrienne'), 'click the apply button');
