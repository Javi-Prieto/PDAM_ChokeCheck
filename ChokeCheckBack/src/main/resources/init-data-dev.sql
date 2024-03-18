insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 7, 178, 0, 76, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'hola', 'hola', 'javi@gmail.com', 'javi', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'prieto', 'javi.prieto');
insert into user_roles ( roles, user_id ) values ( 1, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'hola', 'hola', 'apquito@gmail.com', 'paco', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'perez', 'paquito_er_chulo');
insert into user_roles ( roles, user_id ) values ( 0, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6');


insert into post(type, author_id, id , content , title ) values ( 0, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303', '3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring', 'My First Ever Training');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '04a1f811-c826-48aa-a601-7f72bd614303', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into rate (rate , author_id , post_id) values ( 3.9, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '04a1f811-c826-48aa-a601-7f72bd614303', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303');

insert into post(type, author_id, id , content , title) values ( 0, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring', 'My First Ever Training');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into rate (rate , author_id , post_id) values ( 2.5, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');

insert into post(type, author_id, id , content , title) values ( 1, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45', 'Do not jump over 3 min', 'My first advice');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'ecf22760-db7b-4939-9741-20fa46e46b45', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into rate (rate , author_id , post_id) values ( 4, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( 'ecf22760-db7b-4939-9741-20fa46e46b45', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45');

insert into post(type, author_id, id , content , title) values ( 2, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037', 'Javi just get a new belt', 'My First Ever Upgrade');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '4489c36e-8b0f-4d02-8811-a144c678d037', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into rate (rate , author_id , post_id) values ( 3, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '4489c36e-8b0f-4d02-8811-a144c678d037', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037');

insert into location (lat, lon, id, city) values (37.3656067070585, -5.960896330691125, 'ff7a7201-40ae-4fbb-9788-3a27c1292a03', 'Seville');
insert into gym (avg_level, id , location_id , name) values ( 6, '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', 'ff7a7201-40ae-4fbb-9788-3a27c1292a03', 'Sutemi MMA');

insert into location (lat, lon, id, city) values (37.37821574699546, -5.999276495573956, '58e001e7-cf8f-4322-95af-85df38b8dd6e', 'Seville');
insert into gym (avg_level, id , location_id,  name) values ( 6, '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '58e001e7-cf8f-4322-95af-85df38b8dd6e', 'Gracie');

insert into tournament (higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title , cost) values (6, 77, 72, 4, 100, 0, '2024-11-01 17:30:15', '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '2a71a182-4c16-46f2-9376-68b0fa407341', 'Nice tournament', 'Destroy' , 10);
insert into gym_tournaments (gym_id, tournaments_id) values ('83b8640e-b7d7-4f4b-8224-8f21f38b776a', '2a71a182-4c16-46f2-9376-68b0fa407341');

insert into tournament (higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (3, 78, 72, 8, 0, 0, '2024-09-01 17:30:15', '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '42f79261-e37a-4bc5-a9a9-dd74403d6598', 'Nice tournament', 'Nice opponent', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '42f79261-e37a-4bc5-a9a9-dd74403d6598');
insert into apply (author_id, tournament_id) values ('1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '42f79261-e37a-4bc5-a9a9-dd74403d6598');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ( '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '42f79261-e37a-4bc5-a9a9-dd74403d6598', '42f79261-e37a-4bc5-a9a9-dd74403d6598');

insert into tournament (higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (7, 77, 72, 8, 0, 0, '2024-08-01 17:30:15', '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '31c4c57d-6d39-4c13-b558-3f745f434e19', 'Nice tournament', 'Sparring Time', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('83b8640e-b7d7-4f4b-8224-8f21f38b776a', '31c4c57d-6d39-4c13-b558-3f745f434e19');
insert into apply (author_id, tournament_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '31c4c57d-6d39-4c13-b558-3f745f434e19');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ( 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '31c4c57d-6d39-4c13-b558-3f745f434e19', '31c4c57d-6d39-4c13-b558-3f745f434e19');

insert into tournament (higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (6, 77, 72, 8, 0, 0, '2024-02-01 17:30:15', '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '53bd8e14-f90b-45cb-801c-dc72f846bb29', 'Nice tournament', 'Sparring Time', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '53bd8e14-f90b-45cb-801c-dc72f846bb29');
insert into apply (author_id, tournament_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '53bd8e14-f90b-45cb-801c-dc72f846bb29');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '53bd8e14-f90b-45cb-801c-dc72f846bb29', '53bd8e14-f90b-45cb-801c-dc72f846bb29');