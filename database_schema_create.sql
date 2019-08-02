CREATE DATABASE volunteer_tracker

\c volunteer_tracker

CREATE TABLE projects (
	id serial PRIMARY KEY,
	title varchar NOT NULL
);

CREATE TABLE volunteers (
	id serial PRIMARY KEY,
	name varchar NOT NULL,
	project_id serial NOT NULL REFERENCES projects(id) ON DELETE CASCADE ON UPDATE CASCADE
);
