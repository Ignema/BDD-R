create table Client (no number(7), nom varchar2(40), prenom varchar2(40), Adresse varchar2(40), Ville varchar2(50),
Constraint Client_PK primary key (no));

create table Agence (no number(7), nom varchar2(40), Adresse varchar2(40), Ville varchar2(50),
Constraint Agence_PK primary key (no));

create table Type_Compte (no number(7), libelle_Compte varchar2(40), description varchar2(100),
Constraint Type_Compte_PK primary key (no));

create table Compte (no number(7), Type_Compte_no number(7), dateOuverture date, decouvert_autorise number(7,2), 
solde number(11,2), Client_no number(7), Agence_no number(7),
Constraint Compte_PK primary key (no), constraint Type_Compte_FK foreign key (Type_Compte_no) references Type_Compte(no), 
constraint Client_FK foreign key (Client_no) references Client(no), 
constraint Agence_FK foreign key (Agence_no) references Agence(no));


create table Type_Operation (no number(7), libelle_operation varchar2(40), description varchar2(100),
Constraint Type_Operation_PK primary key (no));


create table operation (no number(7), Type_Operation_no number(7), Compte_no number(7),
Constraint operation_PK primary key (no), 
constraint type_opration_FK foreign key (Type_Operation_no) references Type_Operation(no));

create sequence seq_Client order;
create sequence seq_Agence order;
create sequence seq_Compte order;
create sequence seq_Type_Compte order;
create sequence seq_operation order;
create sequence seq_Type_Operation order;


insert into Client
values (seq_Client.nextval, 'Naciri','Ahmed', 'Residence Nassim N12', 'Casablanca');

insert into Client
values (seq_Client.nextval, 'Filali','Rachid', 'Rue 4 N52', 'Casablanca');


insert into Client
values (seq_Client.nextval, 'Alaoui','Soufiane', 'Agdal N42', 'Rabat');

insert into Client
values (seq_Client.nextval, 'Drissi','Zouhair', 'Youssofia N123', 'Rabat');



insert into Client
values (seq_Client.nextval, 'Rachidi','Badr', 'Souissi N45', 'Rabat');


insert into Client
values (seq_Client.nextval, 'Tlamssani','Youness', 'Dior ejjamaa N17', 'Rabat');

insert into Client
values (seq_Client.nextval, 'Doukkali','Brahim', 'Oasis N5', 'Casablanca');


insert into Agence
values (seq_Agence.nextval, 'Agence assaada', 'Maarif N5', 'Casablanca');

insert into Agence
values (seq_Agence.nextval, 'Grande poste','Souissi N156', 'Rabat');



insert into Type_Compte
values (seq_Type_Compte.nextval, 'Epargne','Compte epargne');
insert into Type_Compte
values (seq_Type_Compte.nextval, 'Courant','Compte courant');


insert into Compte
values (seq_Compte.nextval, 1,TO_DATE('01/01/1997', 'DD/MM/YY'),2000, 12000, 1, 1);

insert into Compte
values (seq_Compte.nextval, 2,TO_DATE('11/01/1997', 'DD/MM/YY'),3000, 120000, 2, 1);

insert into Compte
values (seq_Compte.nextval, 2,TO_DATE('11/12/1997', 'DD/MM/YY'),3000, 150000, 3, 2);

insert into Compte
values (seq_Compte.nextval, 2,TO_DATE('11/01/1998', 'DD/MM/YY'),3000, 17000, 4, 2);

insert into Compte
values (seq_Compte.nextval, 2,TO_DATE('11/11/1998', 'DD/MM/YY'),3000, 120000, 5, 2);

insert into Compte
values (seq_Compte.nextval, 1,TO_DATE('11/12/1998', 'DD/MM/YY'),3500, 1800000, 6, 2);

insert into Compte
values (seq_Compte.nextval, 2,TO_DATE('11/12/1999', 'DD/MM/YY'),3000, 150000, 6, 2);

insert into Compte
values (seq_Compte.nextval, 1,TO_DATE('11/01/2000', 'DD/MM/YY'),3000, 120000, 7, 1);


insert into Type_Operation
values (seq_Type_Operation.nextval, 'virement','virement');
insert into Type_Operation
values (seq_Type_Operation.nextval, 'retrait','retrait');


insert into operation
values (seq_operation.nextval,1,1);
insert into operation
values (seq_operation.nextval,1,2);
insert into operation
values (seq_operation.nextval,2,1);
insert into operation
values (seq_operation.nextval,2,3);
insert into operation
values (seq_operation.nextval,2,4);
insert into operation
values (seq_operation.nextval,1,5);
insert into operation
values (seq_operation.nextval,2,6);
insert into operation
values (seq_operation.nextval,2,7);

commit;












