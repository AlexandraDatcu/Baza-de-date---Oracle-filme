whenever sqlerror exit failure;
drop table rating_tv_show;
drop table rating_movie;
drop table user_;
drop table movie_direction;
drop table tv_show_direction;
drop table tv_show_cast;
drop table movie_cast;
drop table director;
drop table writer;
drop table creator;
drop table tv_show_genres;
drop table movie_genres;
drop table genre;
drop table actor;
drop table movie;
drop table tv_show;


CREATE TABLE actor (
  actor_id NUMBER(10) PRIMARY KEY,
  actor_fname VARCHAR2(20) NOT NULL,
  actor_lname VARCHAR2(20) NOT NULL
);

ALTER TABLE actor
  add constraint actor_id_nn
  check (actor_id IS NOT NULL);

CREATE TABLE movie(
  movie_id NUMBER (10)PRIMARY KEY NOT NULL,
  title_movie VARCHAR2(30) NOT NULL,
  year_movie NUMBER(4),
  time_movie NUMBER(4) NOT NULL ,
  date_release date,
  country_release VARCHAR2(40) NOT NULL,
  language_spoken VARCHAR2(60)
);

CREATE TABLE movie_cast(
  actor_id NUMBER(10) REFERENCES actor (actor_id),
  movie_id NUMBER(10) REFERENCES movie (movie_id),
  role VARCHAR2(40)
);

CREATE TABLE tv_show(
  tv_show_id NUMBER (10)PRIMARY KEY NOT NULL,
  title_tv_show VARCHAR2(30),
  created_at TIMESTAMP WITH LOCAL TIME ZONE,
  year_tv_show NUMBER(4) NOT NULL,
  seasons_tv_show NUMBER(3),
  episodes_tv_show NUMBER(5) NOT NULL,
  date_release date,
  country_release VARCHAR2(40),
  language_spoken VARCHAR2(90)
);
CREATE TABLE tv_show_cast(
  actor_id NUMBER(10) REFERENCES actor (actor_id),
  tv_show_id NUMBER(10) REFERENCES tv_show (tv_show_id),
  role VARCHAR2(40)
);
CREATE TABLE director(
director_id NUMBER(10) PRIMARY KEY NOT NULL,
director_fname VARCHAR2(20) NOT NULL,
director_lname VARCHAR2(20) NOT NULL
);

CREATE TABLE writer(
writer_id NUMBER(10) PRIMARY KEY NOT NULL,
writer_fname VARCHAR2(20) NOT NULL,
writer_lname VARCHAR2(20)NOT NULL
);

CREATE TABLE movie_direction(
director_id NUMBER(10) REFERENCES director (director_id),
writer_id NUMBER(10) REFERENCES writer (writer_id),
movie_id NUMBER(10) REFERENCES movie (movie_id)
);

CREATE TABLE creator(
creator_id NUMBER(10) PRIMARY KEY NOT NULL,
creator_fname VARCHAR2(20),
creator_lname VARCHAR2(20)
);

CREATE TABLE tv_show_direction(
creator_id NUMBER(10) REFERENCES creator (creator_id),
tv_show_id NUMBER(10) REFERENCES tv_show (tv_show_id)
);

CREATE TABLE genre(
genre_id NUMBER(10) PRIMARY KEY NOT NULL,
genre_title VARCHAR2(20) NOT NULL
);

CREATE TABLE movie_genres(
movie_id NUMBER(10) REFERENCES movie (movie_id),
genre_id NUMBER(10) REFERENCES genre (genre_id)
);

CREATE TABLE tv_show_genres(
tv_show_id NUMBER(10) REFERENCES tv_show (tv_show_id),
genre_id NUMBER(10) REFERENCES genre (genre_id)
);

CREATE TABLE user_(
user_id NUMBER(10) PRIMARY KEY NOT NULL,
user_fname VARCHAR2(20) NOT NULL,
user_lname VARCHAR2(20) NOT NULL,
user_email VARCHAR2(50) NOT NULL,
fav_movie NUMBER(10) REFERENCES movie (movie_id),
fav_tv_show NUMBER(10) REFERENCES tv_show (tv_show_id),
price FLOAT,
months_ NUMBER(2),
invited_by NUMBER(10) REFERENCES user_(user_id),
member_since date
);

CREATE TABLE rating_movie(
movie_id NUMBER(10) REFERENCES movie (movie_id),
review_id NUMBER(10) REFERENCES user_ (user_id),
rating_m FLOAT(2)
);

CREATE TABLE rating_tv_show(
tvshow_id NUMBER(10) REFERENCES tv_show (tv_show_id),
review_id NUMBER(10) REFERENCES user_ (user_id),
rating_s FLOAT(2)
);

ALTER TABLE movie
 ADD CONSTRAINT check_year_valid  CHECK (year_movie >= 1870);
 
ALTER TABLE tv_show
 ADD CONSTRAINT check_year_tv_show_valid  CHECK (year_tv_show >= 1900);
 
ALTER TABLE user_
  ADD CONSTRAINT check_months_valid  CHECK (months_ >= 1);
  
ALTER TABLE rating_movie
  ADD CONSTRAINT one_rating_movie UNIQUE (movie_id,review_id);
  
ALTER TABLE rating_movie
  ADD CONSTRAINT check_rating_positive_m CHECK (rating_m >= 1 AND rating_m <= 10);

ALTER TABLE rating_tv_show
  ADD CONSTRAINT one_rating_tvshow UNIQUE (tvshow_id,review_id);
  
ALTER TABLE rating_tv_show
  ADD CONSTRAINT check_rating_positive_s CHECK (rating_s >= 1 AND rating_s <= 10);
 
ALTER TABLE user_
  ADD CONSTRAINT check_price_positive CHECK (price >= 0);
  
ALTER TABLE user_
  ADD CONSTRAINT check_months_positive CHECK (months_ >= 1);
  
ALTER TABLE user_
  ADD CONSTRAINT user_EMAIL_UK UNIQUE (user_email);

DROP SEQUENCE seq_movie_id;
CREATE SEQUENCE seq_movie_id
START WITH 20 INCREMENT BY 1
MINVALUE 20
MAXVALUE 100 NOCYCLE
ORDER;

--genre
INSERT INTO genre (genre_id,genre_title) VALUES ('1', 'Action');
INSERT INTO genre (genre_id,genre_title) VALUES ('2','Adventure');
INSERT INTO genre (genre_id,genre_title) VALUES ('3','Animation');
INSERT INTO genre (genre_id,genre_title) VALUES ('4','Biography');
INSERT INTO genre (genre_id,genre_title) VALUES ('5','Comedy');
INSERT INTO genre (genre_id,genre_title) VALUES ('6','Crime');
INSERT INTO genre (genre_id,genre_title) VALUES ('7','Documentary');
INSERT INTO genre (genre_id,genre_title) VALUES ('8','Drama');
INSERT INTO genre (genre_id,genre_title) VALUES ('9 ','Family');
INSERT INTO genre (genre_id,genre_title) VALUES ('10 ','Fantasy');
INSERT INTO genre (genre_id,genre_title) VALUES ('11','Game-Show');
INSERT INTO genre (genre_id,genre_title) VALUES ('12','History');
INSERT INTO genre (genre_id,genre_title) VALUES ('13','Horror');
INSERT INTO genre (genre_id,genre_title) VALUES ('14','Music');
INSERT INTO genre (genre_id,genre_title) VALUES ('15','Musical');
INSERT INTO genre (genre_id,genre_title) VALUES ('16','Mystery');
INSERT INTO genre (genre_id,genre_title) VALUES ('17','News');
INSERT INTO genre (genre_id,genre_title) VALUES ('18','Reality-TV');
INSERT INTO genre (genre_id,genre_title) VALUES ('19','Romance');
INSERT INTO genre (genre_id,genre_title) VALUES ('20','Sci-Fi');
INSERT INTO genre (genre_id,genre_title) VALUES ('21','Short');
INSERT INTO genre (genre_id,genre_title) VALUES ('23','Sport');
INSERT INTO genre (genre_id,genre_title) VALUES ('24','Talk-Show');
INSERT INTO genre (genre_id,genre_title) VALUES ('25','Thriller');
INSERT INTO genre (genre_id,genre_title) VALUES ('26','War');
INSERT INTO genre (genre_id,genre_title) VALUES ('27','Western');

--actors
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('1', 'Al', 'Pacino');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('2', 'Marlon', 'Brando');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('3', 'Robert', 'Duvall');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('4', 'Cillian', 'Murphy');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('5', 'Robert', 'De Niro');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('6', 'Wagner', 'Moura');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('7', 'Tom','Hanks');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('8', 'Helen', 'Hunt');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('9', 'Chazz', 'Palminteri');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('10', 'Kevin', 'Spacey');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('11', 'Morgan', 'Freeman');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('12', 'Brad', 'Pitt');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('13', 'Jack', 'Nicholson');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('14', 'Leonardo', 'DiCaprio');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('15', 'John', 'Travolta');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('16', 'Uma', 'Thurman');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('17', 'Joe', 'Pesci');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('18', 'Bryan', 'Cranston');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('19', 'Russell', 'Crowe');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('20', 'Paul', 'Giamatti');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('21', 'Damian', 'Lewis');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('22', 'James', 'Gandolfini');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('23', 'Dominic', 'West');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('24', 'Matthew', 'McConaughey');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('25', 'Benedict', 'Cumberbatch');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('26', 'Jared', 'Harris');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('27', 'James', 'Stewart');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('28', 'Joe', 'Pesci');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('29', 'Sharon', 'Stone');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('30', 'Ray', 'Liotta');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('31', 'Lorraine', 'Bracco');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('32', 'Jodie', 'Foster');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('33', 'Jessica', 'Lange');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('34', 'Juliette', 'Lewis');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('35', 'Michelle', 'Pfeiffer');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('36', 'Sean', 'Penn');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('37', 'Guy', 'Pearce');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('38', 'Giancarlo', 'Esposito');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('39', 'Anthony', 'Hopkins');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('40', 'Martin', 'Freeman');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('41', 'Billy Bob', 'Thornton');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('42', 'Bob', 'Odenkirk');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('43', 'Rami', 'Malek');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('44', 'Toby Leonard', 'Moore');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('45', 'James Badge', 'Dale');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('46', 'Kevin', 'McKidd');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('47', 'Evangeline', 'Lilly');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('48', 'Jorge', 'Garcia');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('49', 'Dominic', 'Purcell');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('50', 'Wentworth', 'Miller');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('51', 'Michael C.', 'Hall');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('52', 'Sarah', 'Wayne Callies');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('53', 'Andrew', 'Lincoln');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('54', 'Jerry', 'Seinfeld');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('55', 'Ernie', 'Hudson');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('56', 'Giovanni', 'Ribisi');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('57', 'Jon', 'Hamm');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('58', 'John', 'Slattery');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('59', 'Nicole', 'Kidman');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('60', 'John', 'Lennon');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('61', 'Emilia', 'Clarke');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('62', 'Kyle', 'MacLachlan');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('63', 'Jason', 'Bateman');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('64', 'Laura', 'Linney');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('65', 'Diego', 'Luna');
INSERT INTO actor (actor_id, actor_fname, actor_lname) VALUES ('66', 'Scoot', 'McNairy');

--directors
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('1', 'Francis Ford', 'Coppola');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('2', 'David', 'Fincher');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('3', 'Roman', 'Polanski');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('4', 'Quentin', 'Tarantino');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('5', 'Sergio', 'Leone');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('6', 'Steven', 'Spielberg');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('7', 'Christopher', 'Nolan');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('8', 'Sam', 'Mendes');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('9', 'Frank', 'Darabont');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('10', 'Ron', 'Howard');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('11', 'Robert', 'De Niro');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('12', 'Robert', 'Zemeckis');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('13', 'Martin', 'Brest');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('14', 'Michael', 'Mann');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('15', 'Alfred', 'Hitchcock');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('16', 'Martin', 'Scorsese');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('17', 'Brian', 'De Palma');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('18', 'Sidney', 'Lumet');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('19', 'Curtis', 'Hanson');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('20', 'Bryan', 'Singer');
INSERT INTO director (director_id, director_fname, director_lname) VALUES ('21', 'Jonathan', 'Demme');



--writer
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('1', 'Francis Ford', 'Coppola');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('2', 'Michael', 'Mann');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('3', 'Bo', 'Goldman');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('4', 'William Jr', 'Broyles');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('5', 'Andrew Kevin', 'Walker');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('6', 'Robert', 'Towne');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('7', 'Quentin', 'Tarantino');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('8', 'Sergio', 'Leone');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('9', 'Robert', 'Rodat');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('10', 'Christopher', 'Nolan');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('11', 'Alan', 'Ball');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('12', 'Frank', 'Darabont');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('13', 'Akiva', 'Goldsman');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('14', 'Chazz', 'Palminteri');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('15', 'Alec', 'Coppel');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('16', 'Samuel A.', 'Taylor');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('17', 'Terence', 'Winter');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('18', 'Oliver', 'Stone');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('19', 'Nicholas', 'Pileggi');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('20', 'Martin', 'Scorsese');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('21', 'Paul', 'Schrader');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('22', 'Wesley', 'Strick');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('23', 'Laeta', 'Kalogridis');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('24', 'Waldo', 'Salt');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('25', 'Norman', 'Wexler');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('26', 'David', 'Koepp');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('27', 'Eric', 'Roth');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('28', 'Cliff', 'Hollingsworth');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('29', 'Curtis', 'Hanson');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('30', 'Brian', 'Helgeland');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('31', 'Christopher', 'McQuarrie');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('32', 'Ted', 'Tally');
INSERT INTO writer (writer_id, writer_fname, writer_lname) VALUES ('33', 'William', 'Monahan');

--movies
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('1', 'The Godfather', '1972','175',to_date('24-03-1972', 'dd-mm-yyyy'),'United States','English,Italian,Latin');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('2', 'Heat', '1995','170',to_date('15-12-1995', 'dd-mm-yyyy'),'United States','English,Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('3', 'Scent of a Woman', '1992','156',to_date('23-12-1992', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('4', 'Cast Away', '2000','143',to_date('22-12-2000', 'dd-mm-yyyy'),'United States','English,Russian');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('5', 'A Bronx Tale', '1993','121',to_date('01-11-1993', 'dd-mm-yyyy'),'United States','English,Italian');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('6', 'Se7en', '1995','127',to_date('22-09-1995', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('7', 'Chinatown', '1974','130',to_date('20-06-1974', 'dd-mm-yyyy'),'United States','English,Cantonese,Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('8', 'Inglourious Basterds', '2009','153',to_date('21-08-2009', 'dd-mm-yyyy'),'United States, Germany','English,German,French,Italian');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('9', 'Pulp Fiction', '1994','154',to_date('14-10-1994', 'dd-mm-yyyy'),'United States','English,Spanish,French');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('10', 'The Wolf of Wall Street', '2013','180',to_date('25-12-2013', 'dd-mm-yyyy'),'United States','English,French');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('11', 'Once Upon a Time in America', '1984','229',to_date('01-06-1984', 'dd-mm-yyyy'),'United States,Italy','English,Italian,French,Yiddish,Hebrew');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('12', 'Saving Private Ryan', '1998','169',to_date('24-06-1998', 'dd-mm-yyyy'),'United States','English,French,German,Czech');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('13', 'Inception', '2010','148',to_date('16-07-2010', 'dd-mm-yyyy'),'United States,United Kingdom','English,Japanese,French');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('14', 'American Beauty', '1999','122',to_date('1-10-1999', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('15', 'The Shawshank Redemption', '1994','142',to_date('14-10-1994', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('16', 'Apocalypse Now', '1979','147',to_date('18-08-1979', 'dd-mm-yyyy'),'United States','English,French,Vietnamese');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('17', 'A Beautiful Mind', '2001','135',to_date('4-01-2001', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('18', 'Vertigo', '1958','148',to_date('22-05-1958', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES ('19', 'Casino', '1995','178',to_date('22-11-1995', 'dd-mm-yyyy'),'United States, France','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Goodfellas', '1990','146',to_date('21-09-1990', 'dd-mm-yyyy'),'United States','English,Italian');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Taxi Driver', '1976','114',to_date('09-02-1976', 'dd-mm-yyyy'),'United States','English, Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Cape Fear', '1991','128',to_date('15-11-1991', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Shutter Island', '2010','138',to_date('19-02-2010', 'dd-mm-yyyy'),'United States','English, German');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Scarface', '1983','170',to_date('09-12-1983', 'dd-mm-yyyy'),'United States','English, Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Serpico', '1973','130',to_date('05-12-1973', 'dd-mm-yyyy'),'United States,Italy','English, Italian,Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Carlito s''Way', '1993','144',to_date('12-11-1993', 'dd-mm-yyyy'),'United States','English, Spanish');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'The Insider', '1999','157',to_date('05-11-1999', 'dd-mm-yyyy'),'United States','English,Japanese,Arabic,Persian');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Cinderella Man','2005','144',to_date('03-06-2005', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'L.A. Confidential', '1997','138',to_date('19-09-1997', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'The Usual Suspects', '1995','106',to_date('16-08-1995', 'dd-mm-yyyy'),'United States,Germany','English,Hungarian,Spanish,French');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'The Silence of the Lambs', '1991','118',to_date('14-02-1991', 'dd-mm-yyyy'),'United States','English,Latin');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'Memento', '2000','113',to_date('05-09-2000', 'dd-mm-yyyy'),'United States','English');
INSERT INTO movie (movie_id,title_movie,year_movie,time_movie,date_release ,country_release,language_spoken ) VALUES (seq_movie_id.NEXTVAL, 'The Departed', '2006','151',to_date('06-10-2006', 'dd-mm-yyyy'),'United States,Hong Kong','English,Cantonese');


--movie cast
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '1', 'Michael');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '2', 'Lt. Vincent Hanna');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '3', 'Lt. Col. Frank Slade');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('2', '1', 'Don Vito Corleone');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('2', '16', 'Colonel Walter E. Kurtz');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('3', '1', 'Tom Hagen');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('3', '16', 'Lieutenant Colonel Bill Kilgore');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '5', 'Lorenzo');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '11', 'Noodles');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('7', '4', 'Chuck Noland');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('7', '12', 'Captain Miller');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('8', '4', 'Kelly Frears');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('9', '5', 'Sonny');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('10', '14', 'Lester Burnham');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('10', '6', 'John Doe');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('11', '15', 'Ellis Boyd Redding');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('11', '6', 'Somerset');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('12', '6', 'Mills');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('12', '8', 'Lt. Aldo Raine');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('13', '7', 'J.J. Gittes');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('14', '10', 'Jordan Belfort');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('14', '13', 'Cobb');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('15', '9', 'Vincent Vega');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('16', '9', 'Mia Wallace');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('17', '11', 'Frankie');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('19', '17', 'John Nash');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('24', '10', 'Mark Hanna');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('25', '18', 'John-Scottie Ferguson');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '19', 'Sam-Ace Rothstein');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('28', '19', 'Nicky Santoro');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('29', '19', 'Ginger McKenna');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '20', 'James Conway');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('28', '20', 'Tommy DeVito');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('30', '20', 'Henry Hill');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('31', '20', 'Karen Hill');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '21', 'Travis Bickle');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('32', '21', 'Iris');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('33', '22', 'Leigh Bowden');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('34', '22', 'Danielle Bowden');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('5', '22', 'Max Cady');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('14', '23', 'Teddy Daniels');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '24', 'Tony Montana');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('35', '24', 'Elvira');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '25', 'Serpico');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '26', 'Carlito');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('36', '26', 'Kleinfeld');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('1', '27', 'Lowell Bergman');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('19', '27', 'Jeffrey Wigand');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('19', '28', 'Jim Braddock');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('20', '28', 'Joe Gould');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('37', '29', 'Ed Exley');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('19', '29', 'Bud White');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('10', '29', 'Jack Vincennes');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('10', '30', 'Verbal');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('9', '30', 'Dave Kujan');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('38', '30', 'Jack Baer');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('28', '11', 'Frankie');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('32', '31', 'Clarice Starling');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('39', '31', 'Dr. Hannibal Lecter');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('37', '32', 'Leonard');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('14', '33', 'Billy');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('13', '33', 'Costello');
INSERT INTO movie_cast (actor_id, movie_id, role) VALUES ('45', '33', 'Barrigan');


--movie genres
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('1', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('2', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('3', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('4', '2');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('5', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('6', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('7', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('8', '2');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('9', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('10', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('11', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('12', '26');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('13', '20');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('14', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('15', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('16', '26');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('17', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('18', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('18', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('19', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('19', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('20', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('20', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('20', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('21', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('21', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('23', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('23', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('22', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('22', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('24', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('24', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('25', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('25', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('25', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('26', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('26', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('26', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('27', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('27', '25');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('27', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('28', '8');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('28', '4');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('28', '12');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('29', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('29', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('30', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('30', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('31', '6');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('31', '13');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('32', '16');
INSERT INTO movie_genres (movie_id, genre_id) VALUES ('33', '6');

--movie_direction
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('1', '1', '1');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('2', '5', '6');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('3', '6', '7');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('4', '7', '8');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('4', '7', '9');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('5', '8', '11');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('6', '9', '12');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('7', '10', '13');
INSERT INTO movie_direction (director_id,writer_id, movie_id) VALUES ('8', '11', '14');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('9', '12', '15');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('1', '1', '16');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('10', '13', '17');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('11', '14', '5');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('12', '4', '4');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('13', '3', '3');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('14', '2', '2');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('15', '15', '18');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('15', '16', '18');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '17', '10');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '20', '19');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '19', '19');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '19', '20');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '20', '20');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '20', '21');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '21', '21');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '22', '22');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '23', '23');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('17', '18', '24');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('18', '25', '25');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('18', '24', '25');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('17', '26', '26');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('14', '27', '27');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('14', '2', '27');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('10', '13', '28');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('10', '28', '28');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('19', '29', '29');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('19', '30', '29');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('20', '31', '30');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('21', '32', '31');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('7', '10', '32');
INSERT INTO movie_direction (director_id, writer_id, movie_id) VALUES ('16', '33', '33');

--tv_show
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show, date_release ,country_release,language_spoken ) VALUES ('1', 'Breaking Bad', '2008','5','62',to_date('20-01-2008', 'dd-mm-yyyy'),'United States','English,Spanish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('2', 'Band of Brothers', '2001','','10',to_date('09-09-2001', 'dd-mm-yyyy'),'United States, United Kingdom','English,Dutch,French,German,Lithuanian');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('3', 'The Wire', '2002','5','60',to_date('02-06-2002', 'dd-mm-yyyy'),'United States','English,Greek,Mandarin,Spanish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('4', 'The Sopranos', '1999','6','86',to_date('10-01-1999', 'dd-mm-yyyy'),'United States','English,Italian,Russian');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('5', 'Sherlock', '2010','4','15',to_date('24-10-2010', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('6', 'True Detective', '2014','3','24',to_date('12-01-2014', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('7', 'Billions', '2016','5','72',to_date('01-01-2016', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('8', 'Chernobyl', '2019','','5',to_date('06-05-2019', 'dd-mm-yyyy'),'United States,United Kingdom','English,Russian,Ukrainian');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('9', 'Narcos ', '2015','3','30',to_date('28-08-2015', 'dd-mm-yyyy'),'United States,Colombia,Mexico','English,Spanish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('10', 'Peaky Blinders', '2014','5','36',to_date('30-09-2014', 'dd-mm-yyyy'),'United Kingdom','English,Romanian,Irish Gaelic, Italian,Yiddish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('11', 'House of Cards', '2013','6','73',to_date('01-02-2013', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('12', 'Fargo', '2014','4','41',to_date('15-04-2014', 'dd-mm-yyyy'),'United States','English,German,Korean,Spanish,American Sign Language,French,Ukrainian,Hebrew,Russian');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('13', 'Better Call Saul', '2015','5','63',to_date('08-02-2015', 'dd-mm-yyyy'),'United States','English,Spanish,Vietnamese');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('14', 'Mr. Robot', '2015','4','45',to_date('24-06-2015', 'dd-mm-yyyy'),'United States','English,Swedish,Danish,Chinese,Persian,Spanish,Samoan,Arabic,German');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('15', 'The Pacific', '2010','','10',to_date('14-03-2010', 'dd-mm-yyyy'),'United States,Australia','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('16', 'Rome', '2005','2','22',to_date('28-08-2005', 'dd-mm-yyyy'),'United States,United Kingdom','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('17', 'Lost', '2004','6','119',to_date('22-09-2004', 'dd-mm-yyyy'),'United States','English,Portuguese,Spanish,Arabic,French,Korean,German,Latin,Russian,Japanese');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('18', 'Prison Break', '2005','5','90',to_date('29-08-2005', 'dd-mm-yyyy'),'United States,United Kingdom','English,Arabic,Spanish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('19', 'Dexter', '2006','8','96',to_date('01-10-2006', 'dd-mm-yyyy'),'United States','English,Spanish');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('20', 'The Walking Dead', '2010','11','177',to_date('31-10-2010', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('21', 'Seinfeld', '1989','9','172',to_date('05-07-1989', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('22', 'Oz', '1997','6','56',to_date('12-07-1997', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('23', 'Sneaky Pete', '2015','3','30',to_date('07-08-2015', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('24', 'Mad Men', '2007','7','92',to_date('19-07-2007', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('25', 'Big Little Lies', '2017','2','14',to_date('19-02-2017', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('26', 'The Beatles: Get Back', '2021','','3',to_date('25-11-2021', 'dd-mm-yyyy'),'United States,United Kingdom,New Zealand','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('27', 'Game of Thrones', '2011','8','73',to_date('17-04-2011', 'dd-mm-yyyy'),'United States,United Kingdom','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('28', 'Twin Peaks', '1990','2','30',to_date('08-04-1990', 'dd-mm-yyyy'),'United States','English,Icelandic,Afrikaans,Norwegian');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('29', 'Ozark', '2017','4','44',to_date('21-07-2017', 'dd-mm-yyyy'),'United States','English');
INSERT INTO tv_show (tv_show_id,title_tv_show,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES ('30', 'Narcos Mexico', '2018','3','30',to_date('16-11-2018', 'dd-mm-yyyy'),'United States,Mexico','English');

--tv_show genres
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('1', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('2', '12');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('3', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('4', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('5', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('6', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('7', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('8', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('9', '4');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('10', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('11', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('12', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('13', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('14', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('14', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('14', '25');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('15', '1');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('15', '2');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('15', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('16', '1');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('16', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('16', '12');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('17', '10');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('17', '2');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('18', '1');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('18', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('18', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('19', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('19', '16');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('20', '13');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('21', '5');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('22', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('23', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('24', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('25', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('25', '8');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('25', '16');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('26', '7');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('26', '14');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('27', '2');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('28', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('28', '16');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('29', '6');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('29', '25');
INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES ('30', '6');

--tv_show_cast
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('18', '1', 'Walter White');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('21', '2', 'Richard D. Winters');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('23', '3', 'Det. James McNulty');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('22', '4', 'Tony Soprano');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('25', '5', 'Sherlock Holmes');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('24', '6', 'Detective Rust Cohle');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('21', '7', 'Bobby Axelrod');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('26', '8', 'Valery Legasov');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('6', '9', 'Pablo Escobar');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('4', '10', 'Thomas Shelby');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('10', '11', 'Francis Underwood');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('38', '1', 'Gus Fring');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('40', '5', 'Dr. John Watson');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('40', '12', 'Lester Nygaard');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('41', '12', 'Lorne Malvo');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('38', '13', 'Gus Fring');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('42', '13', 'Jimmy McGill');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('42', '1', 'Saul Goodman');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('43', '14', 'Elliot Alderson');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('43', '15', 'PFC Merriell-Snafu Sheltonn');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('7', '15', 'Narrator');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('44', '15', '2nd Lt. Stone');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('44', '7', 'Bryan Connerty');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('45', '15', 'PFC Robert Leckie');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('46', '16', 'Lucius Vorenus');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('47', '17', 'Kate Austen');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('48', '17', 'Hugo-Hurley Reyes');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('49', '18', 'Lincoln-Linc Burrows');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('50', '18', 'Michael Scofield');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('51', '19', 'Dexter Morgan');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('52', '20', 'Lori Grimes');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('52', '18', 'Sara Tancredi');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('53', '20', 'Rick Grimes');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('54', '21', 'Jerry Seinfeld');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('55', '22', 'Warden Leo Glynn');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('56', '23', 'Marius Josipovic');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('57', '24', 'Don Draper');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('58', '24', 'Roger Sterling');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('59', '25', 'Celeste Wright');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('60', '26', 'John Lennon');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('61', '27', 'Daenerys Targaryen');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('62', '28', 'Special Agent Dale Cooper');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('63', '29', 'Martin-Marty Byrde');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('64', '29', 'Wendy Byrde');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('65', '30', 'Miguel Ángel Félix Gallardo');
INSERT INTO tv_show_cast (actor_id, tv_show_id, role) VALUES ('66', '30', 'Walt Breslin');

--creators
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('1', 'Vince', 'Gilligan');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('2', 'David ', 'Frankel');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('3', 'David', 'Simon');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('4', 'David', 'Chase');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('5', 'Steven', 'Moffat');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('6', 'Mark', 'Gatiss');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('7', 'Nic', 'Pizzolatto');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('8', 'Brian', 'Koppelman');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('9', 'David', 'Levien');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('10', 'Andrew Ross', 'Sorkin');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('11', 'Craig', 'Mazin');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('12', 'Carlo', 'Bernard');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('13', 'Chris', 'Brancato');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('14', 'Doug', 'Miro');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('15', 'Steven', 'Knight');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('16', 'Beau', 'Willimon');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('17', 'Noah', 'Hawley');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('18', 'Peter', 'Gould');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('19', 'Sam', 'Esmail');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('20', 'Jeremy', 'Podeswa');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('21', 'Bruno', 'Heller');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('22', 'William J.', 'MacDonald');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('23', 'John', 'Milius');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('24', 'J.J.', 'Abrams');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('25', 'Jeffrey', 'Lieber');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('26', 'Damon', 'Lindelof');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('27', 'Paul T.', 'Scheuring');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('28', 'James', 'Manos Jr.');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('29', 'Frank', 'Darabont');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('30', 'Jerry', 'Seinfeld');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('31', 'Larry', 'David');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('32', 'Tom', 'Fontana');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('33', 'David', 'Shore');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('34', 'Bryan', 'Cranston');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('35', 'Matthew', 'Weiner');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('36', 'David E.', 'Kelley');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('37', 'Peter', 'Jackson');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('38', 'David', 'Benioff');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('39', 'D.B.', 'Weiss');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('40', 'Mark', 'Frost');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('41', 'David', 'Lynch');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('42', 'Mark', 'Williams');
INSERT INTO creator (creator_id, creator_fname, creator_lname) VALUES ('43', 'Bill', 'Dubuque');

--tv_show_direction
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('1', '1');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('2', '2');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('3', '3');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('4', '4');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('5', '5');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('6', '5');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('7', '6');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('8', '7');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('9', '7');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('10', '7');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('11', '8');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('12', '9');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('13', '9');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('14', '9');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('15', '10');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('16', '11');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('17', '12');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('1', '13');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('18', '13');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('19', '14');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('20', '15');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('21', '16');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('22', '16');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('23', '16');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('24', '17');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('25', '17');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('26', '17');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('27', '18');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('28', '19');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('29', '20');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('30', '21');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('31', '21');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('32', '22');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('33', '23');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('34', '23');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('35', '24');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('36', '25');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('37', '26');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('38', '27');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('39', '27');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('40', '28');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('41', '28');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('42', '29');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('14', '30');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('13', '30');
INSERT INTO tv_show_direction (creator_id, tv_show_id) VALUES ('12', '30');

--users
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('1','Alexandra','Datcu','datcualexandra20@stud.ase.ro','1','1','4.99','2','',to_date('01-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('2','Irina','Vasile','irinavasile@gmail.com','2','11','3.99','4','1',to_date('02-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('3','Gigel','Popescu','gigelpopescu@gmail.com','10','10','4.99','6','1',to_date('02-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('4','Mircea','Badea','mirceabadea@gmail.com','4','9','4.99','2','1',to_date('02-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('5','Cristina','Dumintru','cristinadumitru@gmail.com','5','8','2.9','1','1',to_date('06-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('6','Mirel','Cristea','mirelcristea@gmail.com','6','7','10','9','1',to_date('06-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('7','Ana','State','anastate@gmail.com','15','6','2.40','5','1',to_date('07-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('8','Winston','Smith','winstonsmith@gmail.com','16','5','4.99','2','1',to_date('08-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('9','Emmanuel','Goldstein','emmanuelgoldstein@gmail.com','17','4.99','10','9','1',to_date('16-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('10','Andrei','Daniel','andreidaniel@gmail.com','10','3','2.99','1','1',to_date('01-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('11','Alexandra','Mustatea','alexandramustatea@gmail.com','1','1','4.99','8','10',to_date('24-10-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('12','Costel','Lazar','lazarcostel@gmail.com','5','9','4.99','8','10',to_date('01-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('13','Vlad','Costea','vladcostea@gmail.com','8','1','4.99','8','10',to_date('10-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('14','Camelia','Covaci','cameliacovaci@gmail.com','5','6','4.99','8','10',to_date('15-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('15','Dana','Marin','danamarin@gmail.com','6','3','4.99','2','10',to_date('20-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('16','Delia','Ganea','deliaganea@gmail.com','1','11','4.99','1','10',to_date('21-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('17','Gheorghe','Manea','gheorghemanea@gmail.com','9','10','4.99','6','10',to_date('21-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('18','Gabriela','Pana','gabrielapana@gmail.com','7','8','4.99','1','1',to_date('22-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('19','Adrian','Chivu','adrianchivu@gmail.com','16','6','4.99','5','1',to_date('23-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('20','Oana','Lupu','oanalupu@gmail.com','11','1','3.99','4','1',to_date('23-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('21','Victoria','Raducanu','victoriaraducanu@gmail.com','12','2','3.99','5','10',to_date('24-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('22','Maria','Zamfir','mariazamfir@gmail.com','9','9','4.99','3','10',to_date('25-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('23','Mihai','Nedelcu','mihainedelcu@gmail.com','13','3','3.99','1','10',to_date('26-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('24','Adelina','Costea','adelinacostea@gmail.com','18','5','4.99','6','10',to_date('26-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('25','Mirela','Sandu','mirelasandu@gmail.com','10','7','4.99','8','10',to_date('26-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('26','Alexandra','Vasile','alexandravasile@gmail.com','18','9','3.99','9','10',to_date('28-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('27','Alexandru','Mihail','alexandrumihail@gmail.com','10','4','3.99','2','10',to_date('28-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('28','Madalin','Voinea','madalinvoinea@gmail.com','14','4','4.99','7','10',to_date('29-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('29','Catalin','Bucur','catalinbucur@gmail.com','17','8','3.99','3','1',to_date('29-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('30','Madalina','Ioan','madalinaioan@gmail.com','15','3','4.99','5','10',to_date('29-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('31','Ilinca','Petre','ilincapetre@gmail.com','18','5','3.99','1','1',to_date('29-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('32','Cristian','Florea','cristianflorea@gmail.com','17','4','4.99','10','10',to_date('30-11-2021', 'dd-mm-yyyy'));
INSERT INTO user_ (user_id, user_fname,user_lname,user_email,fav_movie,fav_tv_show,price,months_,invited_by,member_since) VALUES ('33','George','Simon','georgesimon@gmail.com','10','7','2.4','1','10',to_date('01-12-2021', 'dd-mm-yyyy'));


--rating_movie
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('1','1','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('2','2','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('10','3','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('4','4','9.2');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('5','5','9.4');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('6','6','9.6');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('15','7','9.1');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('16','8','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('17','9','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('10','10','8.3');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('1','11','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('5','12','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('9','12','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('11','12','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('3','2','8.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('8','13','9.8');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('12','3','9.48');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('18','1','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('2','1','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('3','1','9.7');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('4','1','9.3');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('5','1','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('6','1','9.3');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('7','1','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('8','1','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('9','1','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('17','2','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('17','6','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('19','30','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('20','31','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('21','32','9.2');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('21','33','9.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('22','14','8.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('23','15','8');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('24','16','8.6');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('25','17','9');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('26','18','8.6');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('27','17','8.5');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('28','19','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('29','20','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('30','21','9.6');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('31','22','9.8');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('32','23','10');
INSERT INTO rating_movie(movie_id,review_id,rating_m) VALUES ('33','24','8');

--rating_tv_show
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('1','1','10');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('11','2','8.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('10','3','9.2');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('9','4','8.2');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('8','5','9.4');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('7','6','9.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('6','7','8.9');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('5','8','8.7');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('4','9','9.1');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('3','10','9.3');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('1','11','8');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('2','13','10');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('1','13','9');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('12','30','9');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('12','29','10');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('14','28','8');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('14','27','8.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('16','26','9.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('18','25','9');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('16','24','9.2');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('13','23','9.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('15','22','8.5');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('17','21','8.3');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('26','31','10');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('28','32','10');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('29','32','8.3');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('30','33','8');

CREATE OR REPLACE VIEW score_movies AS
SELECT movie_id,avg(rating_m )score
FROM rating_movie 
GROUP BY movie_id
ORDER BY movie_id;

CREATE OR REPLACE VIEW score_tv_shows AS
SELECT tvshow_id,avg(rating_s )score
FROM rating_tv_show
GROUP BY tvshow_id
ORDER BY tvshow_id;


CREATE INDEX idx_name_users ON user_ (user_fname, user_lname,user_email);
CREATE INDEX idx_title_movie ON movie (title_movie);
CREATE INDEX idx_year_m ON movie(year_movie);

--1.Sa se selecteze toti actorii din tabela actori
SELECT * FROM actor;
--2.Sa se selecte coloanele actor_fname, actor_lname din tabela actor
SELECT actor_fname, actor_lname FROM actor;
--3.Sa se selecteze doar filmele din categoria drama din tabela movie_genres (al caror genre_id este 2)
SELECT * FROM movie_genres
WHERE genre_id like '2';
--4.Sa se selecteze filmele in care joaca actorul cu actor_id =1
SELECT * FROM movie_cast
WHERE actor_id = 1
ORDER BY movie_id;
--5.Sa se selecteze toate filmele create in SUA si aparute dupa 1 ianuarie 2000
SELECT * FROM movie
WHERE country_release LIKE 'United States'
AND date_release > to_date('01-01-2000', 'dd-mm-yyyy');
--6.Sa se selecteze actor_id, movie_id,role din tabela movie_cast si title_movie din tabela movie si sa se realizeze jonctiunea dintre ele
SELECT c.actor_id, c.movie_id,c.role, m.title_movie
FROM  movie_cast c , movie m
WHERE  c.movie_id = m.movie_id;
--7.Sa se afiseze movie_id, rating_m, genre_id pentru filmele care nu fac parte din categoria Adventure(genre_id = 2) si care au ratinguri mai mici decat oricare dintre ratingurile filmelor de gen Adventure.
SELECT s.movie_id,g.genre_id, s.score
FROM movie_genres g, score_movies s
WHERE s.score < ANY (
    SELECT  s.score
    FROM score_movies s,movie_genres g
    WHERE g.movie_id = s.movie_id 
    AND g.genre_id = 2)
AND g.movie_id = s.movie_id 
AND g.genre_id <> 2
ORDER BY s.score;
--8 Sa se afiseze movie_id, rating_m si genre_id pentru filmele care nu fac parte din categoria action (genre_id = 2) si care au ratinguri mai mici decat fiecare dintre ratingurile filmelor de gen Adventure.
SELECT s.movie_id,g.genre_id, s.score
FROM movie_genres g, score_movies s
WHERE s.score < ALL (
    SELECT  s.score
    FROM score_movies s,movie_genres g
    WHERE g.movie_id = s.movie_id 
    AND g.genre_id = 2)
AND g.movie_id = s.movie_id 
AND g.genre_id <> 2
ORDER BY s.score;
--9 Sa se selecteze utilizatorii care au acordat review la serialul preferat (in clauza WHERE se va preciza conditia de legatura dintre tabele).
SELECT u.*, r.*
FROM user_ u, rating_tv_show r
WHERE u.fav_tv_show = r.tvshow_id
AND review_id = user_id;
--10 Sa se selecteze filmele in care a jucat actorul cu id = 1( produse in luna decembrie)
SELECT  m.*, c.*
FROM  movie m, movie_cast c
WHERE m.movie_id = c.movie_id
AND m.date_release like '%DEC%'
AND c.actor_id = 1; 
--11 Sa se calculeze pentru fiecare user (total_price=price*months) si sa se afiseze user_fname,user_lname,user_email,price,months_,total_price
select user_fname ,user_lname ,user_email ,price ,months_,
price * months_ as total_price
from user_;
--12 Sa se selecteze numai filme cuprinse intre anii 1990 si 2000.
SELECT title_movie,year_movie
FROM movie
WHERE year_movie BETWEEN 1990 AND 2000
ORDER BY year_movie;  
--13 Sa se afiseze id-ul filmului,numele filmului,durata si ratingul chiar daca nu au fost evaluate toate filmele 
SELECT DISTINCT m.movie_id,m.title_movie,m.time_movie,s.score
FROM movie m, score_movies s
WHERE m.movie_id = s.movie_id  (+)
ORDER BY m.movie_id;
--14 Sa se afiseze numele fiecarui utilizator invitat si numele celor care i-au invitat
select a.user_fname || ' ' || a.user_lname || ' a fost invitat de: ' ||b.user_fname ||' ' || b.user_lname
from user_ a , user_ b
where b.user_id = a.invited_by;
--15.Sa se selecteze utilizatorii care au acelasi film preferat(movie_id=1) ca utilizatorul cu user_fname='Alexandra'.
SELECT * FROM user_
WHERE fav_movie IN
(SELECT fav_movie FROM user_ WHERE user_fname='Alexandra');
--16 Sa se selecteze filmele care au cele mai mici ratinguri
SELECT m.movie_id,m.title_movie, s.score, s.movie_id
FROM score_movies s , movie m
WHERE m.movie_id = s.movie_id
AND s.score=(SELECT MIN(score) FROM score_movies);


--1 Sa se afiseze cu lietere mari rolul pe care il are actorul cu actor_id = 18
SELECT tv_show_id, UPPER(role)
FROM tv_show_cast
WHERE actor_id =18;
--2 Sa se afiseze filmele care incep cu litera T
SELECT movie_id, title_movie FROM movie WHERE title_movie LIKE 't%';
SELECT movie_id, title_movie FROM movie WHERE title_movie LIKE UPPER('t%');
--3 Sa se afiseze toti utilizatorii cu numele Alexandra utilizand functiile INITCAP, UPPER,LOWER
SELECT user_id,user_fname,user_lname FROM user_ WHERE INITCAP(user_fname)= 'Alexandra';
SELECT user_id,user_fname,user_lname FROM user_ WHERE UPPER(user_fname)= 'ALEXANDRA';
SELECT user_id,user_fname,user_lname FROM user_ WHERE LOWER(user_fname)= 'alexandra';
--4 Sa se afiseze filmele si anii in care au aparut
SELECT 'Filmul ' || INITCAP(title_movie) || ' a aparut in ' || year_movie
FROM movie;
--5 Sa se afiseze movie_id, title_movie concatenata cu lungimea titlului, year _movie doar pentru filmele produse in United States intre anii 2000-2010
SELECT movie_id, CONCAT(title_movie, year_movie), LENGTH(title_movie), country_release FROM movie
WHERE SUBSTR(country_release,1,13) = 'United States'
AND year_movie BETWEEN 2000 AND 2010;
--6 Sa se afiseze score=8.532 rotunjit la doua zecimale si rotunjit la numar intreg. Sa se aplice si functia TRUNC
SELECT ROUND(8.532,2), ROUND(8.532,0) FROM DUAL;
SELECT TRUNC(8.532,2), TRUNC(8.532,0) FROM DUAL;
--7 Sa se afiseze perioada de timp corespunzatoare(in ani) intre date_release si data curenta pentru filme
SELECT title_movie, date_release, FLOOR((SYSDATE-date_release)/365) AS ani
FROM movie;
--8 Afisati data curenta (se selecteaza data din tabela DUAL):
SELECT SYSDATE data_curenta FROM DUAL;
--9 Sa se afiseze movie_id, date_release, numarul de luni intre data curenta si date_release, urmatoarea zi de vineri dupa date_release, ultima zi din luna din care face parte date_release, precum si data corespunzatoare dupa 2 luni de la date_release
SELECT movie_id, date_release,
FLOOR(MONTHS_BETWEEN(sysdate, date_release)) AS months, 
NEXT_DAY(date_release, 'FRIDAY'), 
LAST_DAY(date_release),
ADD_MONTHS(date_release,2)
FROM movie; 
--10 Sa se afiseze filmele realizate in urma cu 252 de luni
SELECT title_movie,  date_release
FROM movie
WHERE FLOOR(MONTHS_BETWEEN(sysdate, date_release))= 252;
--11 Sa se afiseze filmele realizate in 2001. Se va rotunji date_release la prima zi din luna corespunzatoare daca date_release este in prima jumatate a lunii sau la prima zi din luna urmatoare:  
SELECT movie_id,title_movie, date_release, ROUND(date_release, 'MONTH') 
FROM movie
WHERE date_release LIKE '%-01%'; 
--12 Sa se afiseze serialele si date_release in formatul initial si in format “MM/YY” 
SELECT tv_show_id,title_tv_show, date_release, TO_CHAR(date_release, 'MM/YY') FROM tv_show;
--13 Sa se afiseze serialele aparute intre 11 ianuarie si 11 decembrie 2001. 
SELECT tv_show_id,title_tv_show, date_release 
FROM tv_show
WHERE date_release BETWEEN TO_DATE( 'January 11, 2001', 'Month dd,YYYY') AND TO_DATE( 'December 11, 2001', 'Month dd,YYYY');
--14 Sa se afiseze filmele realizate in anii 2000 si 2009
SELECT movie_id,title_movie,year_movie
FROM movie
WHERE EXTRACT(YEAR FROM date_release) IN (2000,2009);
--15 Sa se afiseze filmele realizate in lunile noiembrie si decembrie.
SELECT movie_id, title_movie,date_release FROM movie
WHERE EXTRACT(MONTH FROM date_release) IN (11,12);
--16 Sa se calculeze cate episoade sunt in medie pe un sezon 
SELECT tv_show_id, title_tv_show, seasons_tv_show, episodes_tv_show, FLOOR(episodes_tv_show/NVL(seasons_tv_show,1))
FROM tv_show;
--17 Sa se afiseze sezoanele pentru fiecare serial, iar pentru miniserii numarul de episoade
SELECT tv_show_id, title_tv_show, seasons_tv_show,NVL2(seasons_tv_show,seasons_tv_show,episodes_tv_show)
FROM tv_show;
--18 Sa se afiseze lungimea numelui, lungimea prenumelui unui regizor, iar daca acestea sunt egale sa se returneze nul ca rezultat, iar daca nu sunt egale se va returna lungimea prenumelui.
SELECT length(director_lname), length(director_fname), NULLIF(director_fname,director_lname) result
FROM director;
--19 Sa se afiseze sezoanele fircarui serial, daca acesta este nul, se va afisa id-ul serialului, iar daca si acesta este nul se va afisa -1.
SELECT tv_show_id, title_tv_show, seasons_tv_show, COALESCE(seasons_tv_show,tv_show_id,-1)
FROM tv_show;


--1 Sa se afiseze media preturilor, cel mai scump abonoamnet, cel mai ieftin si cate luni sunt in total
SELECT AVG (price), MAX(price),MIN(price),SUM(months_)
FROM user_;
--2 Sa se afiseze data celui mai recent film si celui mai vechi
SELECT MAX(date_release),MIN(date_release)
FROM movie;
--3 Sa se afiseze numarul de filme al caror rating > 9.5
SELECT COUNT(*)movies
FROM score_movies
where score>9.5;
--4 Sa se afiseze numarul de preturi distincte din tabela user_
SELECT COUNT(price) FROM user_; --33
SELECT COUNT(DISTINCT price) FROM user_; --6
--5 Sa se afiseze numarul total de emailuri din tabela user_
SELECT COUNT(user_email)email FROM user_;
--6 Sa se afiseze cati utilizatori au un abonament de 4.99 euro
SELECT COUNT(user_id) users
FROM user_
WHERE price = 4.99;
--7 Sa se afiseze media ratingurilor pentru fiecare film. 
--Sa se ordoneze dupa medie(se utilizeaza functia AVG() si clauza GROUP BY pentru gruparea datelor in functie de movie_id, iar ordonarea se realizeaza cu ajutorul functiei ORDER BY).
SELECT movie_id, AVG(RATING_M) score
FROM rating_movie
GROUP BY movie_id
ORDER BY  score desc;
--8 Sa se afiseze movie_id si media ratingurilor numai pentru acele filme al caror score > 9 
--(conditia se specifica in clauza HAVING si nu in clauza WHERE deoarece este utilizata functia de grup AVG si conditia este AVG(rating_m)>9).
SELECT movie_id, AVG(RATING_M) score
FROM rating_movie
GROUP BY movie_id 
HAVING AVG(RATING_M) > 9
ORDER BY  score desc;
--9 Sa se afiseze pentru fiecare regizor: numele regizorului, ratingul maxim obtinut pentru un film
SELECT DIRECTOR_FNAME || ' ' || DIRECTOR_LNAME AS NUME, RATING_MAX 
FROM DIRECTOR,
    (SELECT DIRECTOR.DIRECTOR_ID AS DIRECTOR_ID, MAX(SCORE) AS RATING_MAX 
    FROM  DIRECTOR, MOVIE_DIRECTION, SCORE_MOVIES
    WHERE DIRECTOR.DIRECTOR_ID = MOVIE_DIRECTION.DIRECTOR_ID
    AND   SCORE_MOVIES.MOVIE_ID = MOVIE_DIRECTION.MOVIE_ID
    GROUP BY DIRECTOR.DIRECTOR_ID
    ORDER BY RATING_MAX DESC) GROUPAT
WHERE GROUPAT.DIRECTOR_ID = DIRECTOR.DIRECTOR_ID; 
--10 Sa se afiseze doar regizorii care nu au filme cu rating mai slab de 9.5
SELECT DIRECTOR.DIRECTOR_FNAME || ' ' || DIRECTOR.DIRECTOR_LNAME AS NUME, GROUPAT.RATING_MIN 
FROM DIRECTOR,
    (SELECT DIRECTOR.DIRECTOR_ID AS DIRECTOR_ID, MIN(SCORE) RATING_MIN 
    FROM  DIRECTOR, MOVIE_DIRECTION, SCORE_MOVIES
    WHERE DIRECTOR.DIRECTOR_ID = MOVIE_DIRECTION.DIRECTOR_ID
    AND SCORE_MOVIES.MOVIE_ID = MOVIE_DIRECTION.MOVIE_ID
    GROUP BY DIRECTOR.DIRECTOR_ID
    HAVING MIN(SCORE) >= 9.5) GROUPAT
WHERE GROUPAT.DIRECTOR_ID = DIRECTOR.DIRECTOR_ID;
    

    
--1. Sa se afiseze utilizatorii si nivelul ierarhic al acestora pornind de la utilizatorul cu id-ul 1 (sa se ordoneze in functie de nivelul ierahic).
SELECT user_id, user_fname,user_lname, invited_by, 
LEVEL FROM user_
CONNECT BY PRIOR user_id= invited_by
START WITH user_id = 1
ORDER BY LEVEL;
--2. Afisati utilizatorii invitati de inregistrarea radacina sub forma de organigrama.
SELECT LEVEL, LPAD(' ', LEVEL)|| user_fname,user_lname FROM user_
CONNECT BY PRIOR  user_id= invited_by
START WITH user_id = 1
ORDER BY LEVEL;
--3.Afisati  utilizatorii invitati de inregistrarea radacina, specificand numarul de utilizatori superiori si toti superiorii sai, id-urile (se utilizeaza clauzele: SYS_CONNECT_BY_PATH, LEVEL-1):
SELECT user_id, user_fname,user_lname,  
LEVEL-1 Numar_Superiori, SYS_CONNECT_BY_PATH(user_id, '/') ID_Superiori
FROM user_
START WITH user_id = 1
CONNECT BY PRIOR user_id= invited_by;
--4.Sa se selecteze utilizatorii si gradul de invitatie numai pentru cei cu abonament de 4.99 si 3.99:
SELECT user_id, user_fname,user_lname, invited_by, level FROM user_
WHERE price IN (4.99 ,3.99)
CONNECT BY PRIOR user_id= invited_by
START WITH user_id  = 1;
--5.Sa se afiseze invitatii utilizatorilor aflati pe ultimul nivel ( cu user_email ):
SELECT user_id, user_fname,user_lname, LEVEL-1 Numar_Superiori, SYS_CONNECT_BY_PATH(user_email, '/') Email_Superiori
FROM user_
START WITH user_id = 1
CONNECT BY PRIOR user_id= invited_by
ORDER BY LEVEL desc;
--6 Sa se afiseze utilizatorii care l-au invitat pe userul cu emailul = "gigelpopescu@gmail.com":
SELECT user_id, user_fname,user_lname, invited_by, LEVEL FROM user_
CONNECT BY user_id = PRIOR invited_by
START WITH user_email= 'gigelpopescu@gmail.com';
--7.Sa se afiseze toti invitatii utilizatorului Andrei Daniel:
SELECT user_id, user_fname,user_lname,invited_by, LEVEL FROM user_
CONNECT BY PRIOR user_id= invited_by
START WITH user_fname = 'Andrei'
AND user_lname = 'Daniel'
ORDER BY LEVEL;
--8 Sa se afiseze toti utilizatorii care l-au inivitat pe utilizatorului Andrei Daniel:
SELECT user_id, user_fname,user_lname,invited_by, LEVEL
FROM user_
CONNECT BY user_id = PRIOR invited_by
START WITH user_fname = 'Andrei'
AND user_lname = 'Daniel'
ORDER BY LEVEL;
--9 . Sa se afiseze toti inivitatii lui 'Alexandra Datcu' si care au acelasi film preferat cu 'Andrei Daniel':
SELECT user_id, user_fname,user_lname,invited_by,fav_movie, LEVEL
FROM user_
WHERE fav_movie = (SELECT fav_movie FROM user_ WHERE user_fname = 'Andrei' AND user_lname = 'Daniel')
CONNECT BY  PRIOR user_id = invited_by
START WITH user_fname = 'Alexandra'
AND user_lname = 'Datcu' 
ORDER BY LEVEL;
--10. Sa se selecteze toti utilizatorii cu fav_movie = 10 si invitatii acestora:
SELECT user_id, user_fname,user_lname,invited_by,fav_movie, LEVEL FROM user_
CONNECT BY  PRIOR user_id = invited_by
START WITH fav_movie = 10
ORDER BY LEVEL;
--11.Sa se afiseze toti invitatii lui 'Andrei Daniel' fara cei cu filmul preferat!=1.
SELECT user_id, user_fname,user_lname,invited_by,fav_movie, LEVEL FROM user_
WHERE fav_movie != 1
CONNECT BY PRIOR user_id = invited_by
START WITH user_fname = 'Andrei'
AND user_lname = 'Daniel'
ORDER BY LEVEL;
--12. Sa se afiseze toti invitatii lui 'Alexandra Datcu' si mai putin cei care au serialele preferate 9 si 3.
SELECT user_id, user_fname,user_lname,invited_by,fav_tv_show, LEVEL FROM user_
WHERE fav_tv_show NOT IN (9,3)
CONNECT BY PRIOR user_id = invited_by 
START WITH user_fname = 'Alexandra'
AND user_lname = 'Datcu' 
ORDER BY LEVEL;
--13. Sa se afiseze toti invitatii lui 'Andrei Daniel' si cei ai lui 'Alexandra Datcu’:
SELECT user_id, user_fname,user_lname,invited_by, LEVEL FROM user_
CONNECT BY PRIOR user_id = invited_by 
START WITH (user_fname = 'Alexandra' AND user_lname = 'Datcu')
OR  (user_fname = 'Andrei' AND user_lname = 'Daniel')
ORDER BY LEVEL;
--14.Sa se afiseze toti invitatii de pe nivelul 3:
SELECT user_id, user_fname,user_lname,invited_by, LEVEL FROM user_
WHERE LEVEL=3
CONNECT BY PRIOR user_id = invited_by 
ORDER BY LEVEL;
--15. Sa se afiseze toti invitatii incepand cu nivelul 2:
SELECT user_id, user_fname,user_lname,invited_by, SYS_CONNECT_BY_PATH(user_id, '/'),LEVEL FROM user_
WHERE LEVEL >= 2
CONNECT BY PRIOR user_id = invited_by  
START WITH user_id =1
ORDER BY LEVEL;
--16. Sa se afiseze numarul total de inivitati ai lui 'Andrei Daniel' grupati dupa filmele lor favorite:
SELECT fav_movie,count(*) Total_Invitati 
from user_
CONNECT BY PRIOR user_id = invited_by
START WITH user_id = 10
GROUP BY fav_movie;
--17. Sa se selecteze toti invitatii utilizatorilor care au prenumele Andrei.
SELECT user_id, user_fname,user_lname,invited_by FROM user_
CONNECT BY PRIOR user_id = invited_by
START WITH upper(user_fname) LIKE '%ANDREI%'
ORDER BY LEVEL;

--1. Sa se afiseze id-ul serialului,numele serialului,episoadele si ratingul chiar daca nu au fost evaluate toate serialele
SELECT  t.tv_show_id,t.title_tv_show,t.episodes_tv_show,s.score
FROM tv_show t, score_tv_shows s
WHERE s.tvshow_id = t.tv_show_id (+)
ORDER BY t.tv_show_id;
--2. Sa se afiseze utilizatorii care au acordat minim un rating, precum si cei care nu au acordat niciun rating la categoria seriale.
SELECT u.user_fname, u.user_lname, r.review_id
FROM rating_tv_show r, user_ u
WHERE u.user_id = r.review_id (+);
--3.Sa se calculeze reducerea aferenta urmatoarelor abonamente:
-- 8% din price_without_discount ( price * months_) daca au abonament de 10 euro
-- 5% din price_without_discount ( price * months_) daca au abonament de 4.99 euro
--Pentru celelalte abonamente reducerea va fi 0
SELECT user_fname,user_lname,price AS price_month ,months_* price AS price_without_discount, 
(CASE
WHEN price = 10   THEN (1 - 0.08)
WHEN price = 4.99 THEN (1 - 0.05) 
ELSE 0 
END)* months_* price AS total_price
FROM user_;
--4.Sa se rezolve cerinta de la exercitiul 3 utilizand functia DECODE
SELECT user_fname,user_lname,price AS price_month ,months_* price AS price_without_discount,
DECODE(price, 4.99 ,(1 - 0.05) * months_* price,10,(1 - 0.08)* months_* price, 0 ) AS total_price
FROM user_;
--5. Sa se calculeze diferit discountul pentru utilizatori:
-- daca au un abonament >= de 6 luni primesc un discount de 10%
-- daca au un abonament de 2 luni primesc un discount de 5%
--Pentru celelalte abonamente reducerea va fi 0 
SELECT user_fname,user_lname,months_,price AS price_month ,months_* price AS price_without_discount, 
(CASE
WHEN months_ >= 6 THEN (1 - 0.1)
WHEN months_  = 2 THEN (1 - 0.05) 
ELSE 0 
END)* months_* price AS total_price
FROM user_;
 
--1. Sa se afiseze filmele produse intre anii 1990 si 2010 , fara cele produse in 1992 si 2001
SELECT * FROM movie WHERE year_movie BETWEEN 1990 AND 2010
MINUS 
SELECT * FROM movie WHERE year_movie IN (1992,2001);
/*2.Sa se calculeze reducerea aferenta urmatoarelor abonamente:
 daca au un abonament > 8 luni primesc un discount de 15%
 daca au un abonament >= de 6 luni primesc un discount de 10%
 daca au un abonament de 2 luni primesc un discount de 5%
Pentru celelalte abonamente reducerea va fi 0 
Din acestea sa se elimine abonamentele utilizatorilor al caror prenume incepe cu litera A. Ordonati descrescator in functie de numele utilizatorilor. 
*/
SELECT user_id,user_fname,user_lname,months_,price AS price_month ,months_* price AS price_without_discount, 
(CASE
WHEN months_ >  8 THEN (1 - 0.15)
WHEN months_ >= 6 THEN (1 - 0.1)
WHEN months_  = 2 THEN (1 - 0.05) 
ELSE 0 
END)* months_* price AS total_price
FROM user_
MINUS
SELECT user_id, user_fname,user_lname,months_,price AS price_month ,months_* price AS price_without_discount, 
(CASE
WHEN months_ >  8 THEN (1 - 0.15)
WHEN months_ >= 6 THEN (1 - 0.1)
WHEN months_  = 2 THEN (1 - 0.05) 
ELSE 0 
END)* months_* price AS total_price
FROM user_
WHERE UPPER(user_fname) LIKE 'A%'
ORDER BY user_lname;
/* 
3.Sa se calculeze reducerea aferenta urmatoarelor abonamente:  (folosind operatorul UNION)
daca au mai mult de 10 (inclusiv) ratinguri(la categoria filme) primesc un discount de 10%
daca au mai mult de 5  (inclusiv) ratinguri (la categoria filme) primesc un discount de 8%
daca au mai mult de 2  (inclusiv) ratinguri (la categoria filme) primesc un discount de 5% */
SELECT u.user_fname,u.user_lname,u.price AS price_month ,u.months_* u.price AS price_without_discount,(1 - 0.1)* u.months_* u.price AS total_price
FROM user_ u,
(SELECT review_id, COUNT(r.rating_m) AS rating_num 
FROM rating_movie r
GROUP BY r.review_id
HAVING COUNT(r.rating_m)  >= 10) GROUPAT
WHERE GROUPAT.review_id = u.user_id
UNION
SELECT u.user_fname,u.user_lname,u.price AS price_month ,u.months_* u.price AS price_without_discount,(1 - 0.08)* u.months_* u.price AS total_price
FROM user_ u,
(SELECT review_id, COUNT(r.rating_m) AS rating_num 
FROM rating_movie r
GROUP BY r.review_id
HAVING COUNT(r.rating_m)  BETWEEN 5 AND 9) GROUPAT
WHERE GROUPAT.review_id = u.user_id
UNION
SELECT u.user_fname,u.user_lname,u.price AS price_month ,u.months_* u.price AS price_without_discount,(1 - 0.05)* u.months_* u.price AS total_price
FROM user_ u,
(SELECT review_id, COUNT(r.rating_m) AS rating_num 
FROM rating_movie r
GROUP BY r.review_id
HAVING COUNT(r.rating_m)  BETWEEN 2 AND 4) GROUPAT
WHERE GROUPAT.review_id = u.user_id
;
--4. Sa se selecteze filmele care au mai mult de 3 ratinguri si care nu au fost produse in anii 1992 si 2001
SELECT m.title_movie,m.year_movie
FROM movie m ,
(SELECT r.movie_id,COUNT(r.rating_m) AS num_rating
    FROM rating_movie r
    GROUP BY r.movie_id
    HAVING COUNT(r.rating_m) >=3
)GROUPAT
WHERE GROUPAT.movie_id = m.movie_id
INTERSECT
SELECT m.title_movie, m.year_movie
FROM movie m
WHERE m.year_movie NOT IN (1992, 2001);

--1. Sa se realizeze o tabela virtuala cu toti utilizatorii care au filmul preferat fav_movie = 1. Sa se actualizeze pretul abonamentului.
CREATE OR REPLACE VIEW users_fav_movie
AS SELECT * FROM user_
WHERE fav_movie = 1;

SELECT * FROM users_fav_movie;

UPDATE users_fav_movie
SET PRICE = PRICE - 1;
--2. Sa se selecteze utilizatorii care au filmul preferat fav_movie = 1 si sunt membri din luna octombrie
SELECT * FROM users_fav_movie WHERE EXTRACT (MONTH FROM member_since)= 10;
--3. Sa se realizeze o tabela virtuala cu toti utilizatorii ( id, nume , prenume, email) si sa se adauge total_price = price* months_
CREATE OR REPLACE VIEW users_price
AS SELECT USER_ID, USER_FNAME,USER_LNAME,USER_EMAIL,PRICE, price* months_ total_price FROM user_;
SELECT * from users_price;
-- sa se actualizeze price; (+1 euro)
UPDATE users_price
SET price = price + 1;
--4. Sa se utilizeze optiunea WITH READ ONLY
CREATE OR REPLACE VIEW users_price
AS SELECT USER_ID, USER_FNAME,USER_LNAME,USER_EMAIL,PRICE, price* months_ total_price FROM user_
WITH READ ONLY;
--5. Sa se stearga tabela virtuala users_price. 
drop view users_price;
--6. Vizualizarea informatiilor despre tabelele virtuale:
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

--1. Sa se creeze un index pe tabela tv_show, pe coloana title_tv_show
CREATE INDEX idx_title_tvshow ON tv_show (title_tv_show);
--2. Vizualizarea idecsilor unui anumit utilizator:
SELECT * FROM USER_INDEXES;
--3.Sa se stearga indexul idx_title_tvshow
DROP INDEX idx_title_tvshow;



--1. Sa se creeze o secventa pentru asigurarea unicitatii cheii primare din tabela tv_show
CREATE SEQUENCE seq_tv_show_id
START WITH 31 INCREMENT BY 1
MINVALUE 31
MAXVALUE 100 NOCYCLE
;
INSERT INTO tv_show (tv_show_id,title_tv_show,created_at,year_tv_show, seasons_tv_show ,episodes_tv_show,date_release ,country_release,language_spoken ) VALUES (seq_tv_show_id.NEXTVAL, 'Boardwalk Empire',CAST(CURRENT_TIMESTAMP AS TIMESTAMP WITH TIME ZONE) ,'2010','5','57',to_date('19-09-2010', 'dd-mm-yyyy'),'United States','English');
INSERT INTO rating_tv_show(tvshow_id,review_id,rating_s) VALUES ('31','1','9');
--2.Sa se afiseze valoarea curenta a secventei:
SELECT seq_tv_show_id.CURRVAL FROM DUAL;
--3.Sa se modifice pasul de incrementare si valoarea maxima pentru secvanta anterioara:
ALTER SEQUENCE seq_tv_show_id INCREMENT BY 10;
ALTER SEQUENCE seq_tv_show_id MAXVALUE 200;
--4.Sa se vizualizeze informatiile despre secventele utilizatorilor:
SELECT * FROM USER_SEQUENCES;
--5.Sa se stearga secventa seq_tv_show_id
DROP SEQUENCE seq_tv_show_id;


--3. Sa se stearga sinonimul creat anterior:
DROP SYNONYM gen;
--1. Sa se creeze un sinonim pentru tabela genre:
CREATE SYNONYM gen FOR genre;
--2. Vizualizarea sinonimelor se realizeaza astfel:
SELECT * FROM USER_SYNONYMS;




SELECT user_fname, user_lname, price, months_,
FLOOR(AVG(PRICE) OVER
(
    PARTITION BY MONTHS_
)) medie_in_functie_de_nrluni
FROM user_;

SELECT DISTINCT M.movie_id, M.title_movie,M.year_movie, D.director_fname, D.director_lname, 
COUNT(DISTINCT MD.MOVIE_ID) OVER
(
PARTITION BY MD.DIRECTOR_ID
)NR_MOVIES_DIRECTOR
FROM DIRECTOR D, MOVIE_DIRECTION MD, MOVIE M
WHERE D.DIRECTOR_ID = MD.DIRECTOR_ID
AND M.movie_id = MD.movie_id
ORDER BY M.movie_id;




DROP TABLE  LIST_director;
DROP TABLE  LIST_movie;
DROP INDEX idx_movie_director_list;
DROP INDEX idx_director_list;
DROP CLUSTER MOVIE_DIRECTOR_LIST_CLS;
DROP CLUSTER  DIRECTOR_LIST_CLS;

CREATE CLUSTER MOVIE_DIRECTOR_LIST_CLS
(
    movie_id NUMBER(10)
);

CREATE CLUSTER  DIRECTOR_LIST_CLS
(
   movie_id NUMBER(10)
);


CREATE INDEX idx_movie_director_list
ON CLUSTER  MOVIE_DIRECTOR_LIST_CLS;

CREATE INDEX idx_director_list
ON CLUSTER  DIRECTOR_LIST_CLS;

CREATE TABLE LIST_movie
CLUSTER  MOVIE_DIRECTOR_LIST_CLS(movie_id)
AS SELECT * FROM movie;

CREATE TABLE LIST_director
CLUSTER DIRECTOR_LIST_CLS(movie_id)
AS SELECT * FROM movie_direction;

--Vizualizarea informatiilor despre clustere:
SELECT * FROM USER_CLUSTERS;