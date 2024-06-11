insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 7, 178, 0, 76, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'hola', 'hola', 'javi@gmail.com', 'javi', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'prieto', 'javi.prieto');
insert into user_roles ( roles, user_id ) values ( 1, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'hola', 'hola', 'apquito@gmail.com', 'paco', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'perez', 'paquito_er_chulo');
insert into user_roles ( roles, user_id ) values ( 0, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, '0fa762a2-05bb-44e7-8af4-0ec72107289a', 'hola', 'hola', 'orlo@gmail.com', 'orlo', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'german', 'orlito_er_bjj');
insert into user_roles ( roles, user_id ) values ( 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, '457321e6-2208-44fc-97b0-924ad40a584b', 'hola', 'hola', 'joeregan@gmail.com', 'joe', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'regan', 'joe_bjj');
insert into user_roles ( roles, user_id ) values ( 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, 'd6c884c5-0c6c-41a3-8233-7daccc3998a1', 'hola', 'hola', 'charles@gmail.com', 'charles', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'oliveira', 'charles_world');
insert into user_roles ( roles, user_id ) values ( 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a');

insert into users (age  , belt_color   , height  , sex  , weight  , id, avatar , belt_photo , email , name , password , surname , username ) values (19, 1, 178, 0, 76, '68bbb6fe-f4d2-49ab-8c88-3beaf6e854d2', 'hola', 'hola', 'illo@gmail.com', 'illo', '{bcrypt}$2a$12$RtYIPopxzo6sCUrg3xOT7eCFdhxjFV2m0vMDeIPTHCwlR.AtjC4xa', 'juan', 'illojuan');
insert into user_roles ( roles, user_id ) values ( 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a', '8b4eb69f-bda5-4e64-b751-291fac989149', '3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring', 'My First Ever Training', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE,  1, '0fa762a2-05bb-44e7-8af4-0ec72107289a', '4f1da3d3-c42b-488b-bba0-af025a5f7dcb', 'Practice more peekaboo style', 'My first advice', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303', '3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring', 'My First Ever Training', '');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '04a1f811-c826-48aa-a601-7f72bd614303', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into rate (rate , author_id , post_id) values ( 3.9, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '04a1f811-c826-48aa-a601-7f72bd614303', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '04a1f811-c826-48aa-a601-7f72bd614303');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE,  0, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '3x3min|Jump Ropes,4x3min|Pads,5x3min|Sparring', 'My First Ever Training', '');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into rate (rate , author_id , post_id) values ( 2.5, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '399e5bd9-933e-4a7f-bdf9-4ca51fd6bcf6');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE,  1, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45', 'Do not jump over 3 min', 'My first advice', '');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'ecf22760-db7b-4939-9741-20fa46e46b45', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into rate (rate , author_id , post_id) values ( 4, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( 'ecf22760-db7b-4939-9741-20fa46e46b45', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'ecf22760-db7b-4939-9741-20fa46e46b45');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 2, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037', 'Javi just get a new belt', 'My First Ever Upgrade', '');
insert into favourite(author_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into post_likes (likes_author_id, likes_post_id, post_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '4489c36e-8b0f-4d02-8811-a144c678d037', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into rate (rate , author_id , post_id) values ( 3, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037');
insert into post_rating (post_id, rating_author_id , rating_post_id) values ( '4489c36e-8b0f-4d02-8811-a144c678d037', '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '4489c36e-8b0f-4d02-8811-a144c678d037');

insert into location (lat, lon, id, city) values (37.3656067070585, -5.960896330691125, 'ff7a7201-40ae-4fbb-9788-3a27c1292a03', 'Seville');
insert into gym (avg_level, id , location_id , name) values ( 6, '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', 'ff7a7201-40ae-4fbb-9788-3a27c1292a03', 'Sutemi MMA');

insert into location (lat, lon, id, city) values (37.37821574699546, -5.999276495573956, '58e001e7-cf8f-4322-95af-85df38b8dd6e', 'Seville');
insert into gym (avg_level, id , location_id,  name) values ( 6, '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '58e001e7-cf8f-4322-95af-85df38b8dd6e', 'Gracie');

insert into tournament (created_at, higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title , cost) values (CURRENT_DATE, 6, 77, 72, 4, 100, 0, '2024-11-01 17:30:15', '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '2a71a182-4c16-46f2-9376-68b0fa407341', 'Nice tournament', 'Destroy' , 10);
insert into gym_tournaments (gym_id, tournaments_id) values ('83b8640e-b7d7-4f4b-8224-8f21f38b776a', '2a71a182-4c16-46f2-9376-68b0fa407341');

insert into tournament (created_at, higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (CURRENT_DATE,3, 78, 72, 8, 0, 0, '2024-09-01 17:30:15', '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '42f79261-e37a-4bc5-a9a9-dd74403d6598', 'Nice tournament', 'Nice opponent', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '42f79261-e37a-4bc5-a9a9-dd74403d6598');
insert into apply (created_at, author_id, tournament_id) values (CURRENT_DATE, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '42f79261-e37a-4bc5-a9a9-dd74403d6598');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ( '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '42f79261-e37a-4bc5-a9a9-dd74403d6598', '42f79261-e37a-4bc5-a9a9-dd74403d6598');

insert into tournament (created_at, higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (CURRENT_DATE, 7, 77, 72, 8, 0, 0, '2024-08-01 17:30:15', '83b8640e-b7d7-4f4b-8224-8f21f38b776a', '31c4c57d-6d39-4c13-b558-3f745f434e19', 'Nice tournament', 'Sparring Time', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('83b8640e-b7d7-4f4b-8224-8f21f38b776a', '31c4c57d-6d39-4c13-b558-3f745f434e19');
insert into apply (created_at, author_id, tournament_id) values (CURRENT_DATE, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '31c4c57d-6d39-4c13-b558-3f745f434e19');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ( 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '31c4c57d-6d39-4c13-b558-3f745f434e19', '31c4c57d-6d39-4c13-b558-3f745f434e19');

insert into tournament (created_at, higher_belt, max_weight , min_weight , participants , prize , sex , begin_date, author_id , id, description , title, cost) values (CURRENT_DATE, 6, 77, 72, 8, 0, 0, '2024-02-01 17:30:15', '96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '53bd8e14-f90b-45cb-801c-dc72f846bb29', 'Nice tournament', 'Sparring Time', 0);
insert into gym_tournaments (gym_id, tournaments_id) values ('96c7fea6-489e-4a2b-b2dc-53d51ce31c84', '53bd8e14-f90b-45cb-801c-dc72f846bb29');
insert into apply (created_at, author_id, tournament_id) values (CURRENT_DATE, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '53bd8e14-f90b-45cb-801c-dc72f846bb29');
insert into tournament_applies (applies_author_id, applies_tournament_id, tournament_id) values ('c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '53bd8e14-f90b-45cb-801c-dc72f846bb29', '53bd8e14-f90b-45cb-801c-dc72f846bb29');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '9d1b63d9-2b6a-4c0e-9200-1b7a792c7c1d', '3x5min|Jump Ropes,4x3min|Pads,5x5min|Sparring', 'Intense Morning Session', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', 'c3f8e1ad-68d7-4fbe-b0d6-846dabc74a1a', 'Remember to always keep your hands up and stay on your toes.', 'Defensive Drills', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, '1ce9c1c7-7a02-4c7f-bf69-6d0306cbed68', '39dbb6ae-4863-4420-a0f0-6bc1f02b23fc', 'Just received my blue belt after months of hard work!', 'Achieved Blue Belt', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'd2ecf2b3-4153-47f1-936b-5dbd8c2e2c3e', '4x3min|Jump Ropes,3x5min|Pads,6x3min|Sparring', 'Evening Training', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', '3eae35c7-ef33-4b28-9b57-474451b671f2', 'Focus on your footwork to improve your speed and agility.', 'Footwork Fundamentals', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, 'c2f86ad9-8e2c-448d-92e6-39b25e690ec6', 'b0f3d6a8-4bb9-4c74-bf96-2329b1bb92f4', 'Participated in my first competition today!', 'First Competition Experience', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '0fa762a2-05bb-44e7-8af4-0ec72107289a', '8c96d3b4-30cc-4b9c-8a57-fcf3a8d8d6e1', '5x3min|Jump Ropes,5x3min|Pads,7x3min|Sparring', 'Afternoon Sparring Session', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, '0fa762a2-05bb-44e7-8af4-0ec72107289a', '99d4d0ab-49e2-4a1d-8aef-2b80e5d504e7', 'Drill your escapes every session to stay sharp.', 'Escape Drills', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, '0fa762a2-05bb-44e7-8af4-0ec72107289a', '6d9d4179-8ab7-42f0-85f7-fb1563b486b1', 'Excited to share that I have been promoted to assistant coach!', 'New Role Announcement', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '457321e6-2208-44fc-97b0-924ad40a584b', 'c5f8b25b-dba6-4c7c-9454-85a2d91d3f5b', '4x4min|Jump Ropes, 3x5min|Pads, 6x4min|Sparring', 'Saturday Morning Drills', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, '457321e6-2208-44fc-97b0-924ad40a584b', 'a2d6f2f4-712b-4c4b-b8b2-b6e77b9a54bc', 'Work on your breathing techniques to enhance endurance.', 'Breathing Techniques', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, '457321e6-2208-44fc-97b0-924ad40a584b', 'ec8a6d7a-1744-49bc-8cc4-e2d4c6e43978', 'I have switched to a new training gym and it is amazing!', 'New Training Gym', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, 'd6c884c5-0c6c-41a3-8233-7daccc3998a1', 'c4e9e8a7-7166-41b6-8bda-2f43e1e6b2a7', '4x5min|Jump Ropes,3x4min|Pads,5x5min|Sparring', 'Sunday Evening Session', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, 'd6c884c5-0c6c-41a3-8233-7daccc3998a1', 'e1dbba2e-2a7d-4e37-9eb0-0cf4b19415e4', 'Make sure to hydrate well before and after training.', 'Hydration Tips', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, 'd6c884c5-0c6c-41a3-8233-7daccc3998a1', 'ab3b4baf-9f6a-4267-b96d-cd7d7a6dfbd0', 'I am excited to announce my first victory in a local tournament!', 'First Tournament Win', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 0, '68bbb6fe-f4d2-49ab-8c88-3beaf6e854d2', 'ddc1e25c-2f4b-4e1c-87f8-f2d8e9a3fc1a', '3x3min|Jump Ropes,4x5min|Pads,6x3min|Sparring', 'Midweek Intense Workout', '');

insert into post(created_at, type, author_id, id , content , title, file_name) values (CURRENT_DATE, 1, '68bbb6fe-f4d2-49ab-8c88-3beaf6e854d2', 'dcaebce7-3787-437a-ae8e-68eadddd94d7', 'Do not forget to stretch well before and after sessions.', 'Stretching Importance', '');

insert into post(created_at, type, author_id, id , content , title, file_name ) values (CURRENT_DATE, 2, '68bbb6fe-f4d2-49ab-8c88-3beaf6e854d2', 'a4c69a9a-9a02-4c6f-9d08-1a2fb8dc0749', 'I have just completed a month of consistent training!', 'Training Milestone', '');
