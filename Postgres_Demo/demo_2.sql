create table razmer (
	razmer_id serial primary key,
	razmer_name varchar(5000) not null
);

create table models (
	models_id serial primary key,
	models_name varchar(350) not null,
	proizvoditel_id int not null,
	categoria_id int not null,
	podcategoria_id int not null,
	sostav_id int not null,
	razmer_id int not null,
	infor varchar(550) not null,
	img varchar(100) not null,
	zena int not null,
	kolvo int not null,
	foreign key (proizvoditel_id) references proizvoditel(proizvoditel_id),
	foreign key (categoria_id) references categoria(categoria_id),
	foreign key (podcategoria_id) references podcategoria(podcategoria_id),
	foreign key (razmer_id) references razmer(razmer_id),
	foreign key (sostav_id) references sostav(sostav_id)
);

create table zakazi (
	zakazi_id serial primary key,
	users_id int not null,
	data_zakaza varchar(50) not null,
	zena int not null,
	kolvo int not null,
	foreign key (users_id) references users(users_id)
);

create table pozicia_zakazi (
	pozicia_zakazi_id serial primary key,
	models_id int not null,
	zakazi_id int not null,
	kolvo int not null,
	foreign key (models_id) references models(models_id),
	foreign key (zakazi_id) references zakazi(zakazi_id)
);