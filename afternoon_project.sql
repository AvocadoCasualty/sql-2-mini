--Practice joins
--1
select * from invoice
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;
--2
select i.invoice_date, c.first_name, c.last_name, i.total from invoice i
join customer c on i.customer_id = c.customer_id
--3
select c.first_name, c.last_name, e.first_name, e.last_name from customer c
join employee e on c.support_rep_id = e.employee_id;
--4
select al.title, ar.name from album al
join artist ar on al.artist_id = ar.artist_id;
--5
select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_id
where p.name = 'Music';
--6
select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id = 5;
--7
select t.name, p.name
from track t
join playlist_track pt on pt.track_id = t.track_id
join playlist p on pt.playlist_id = p.playlist_id;
--8
select t.name, al.title
from track t
join album al on t.album_id = al.album_id
join genre g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';
--BlackDiamond
select t.name, g.name, al.title, ar.name
from track t
join album al on t.album_id = al.album_id
join genre g on g.genre_id = t.genre_id
join artist ar on ar.artist_id = al.artist_id
join playlist_track pt on pt.track_id = t.track_id
join playlist p on pt.playlist_id = p.playlist_id
where p.name = 'Music';
--Practice Nested Queries
--1
select *
from invoice
where invoice_id in ( select invoice_id from invoice_line where unit_price > 0.99 );
--2
select *
from playlist_track
where playlist_id in ( select playlist_id from playlist where name = 'Music' );
--3
select t.name
from track t
where track_id in ( select track_id from playlist_track where playlist_id = 5 );
--4
select *
from track
where genre_id in ( select genre_id from genre where genre.name = 'Comedy' );
--5
select *
from track
where album_id in ( select album_id from album where title = 'Fireball' );
--6
select *
from track
where album_id in (
  select album_id from album where artist_id IN (
  	select artist_id from artist where name = 'Queen'));
--Practice Updating ROWS
--1
update customer
set fax = null
where fax is not null;
--2
update customer
set company = "Self"
where company is null;
--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett';
--4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';
--5
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal')
and composer is null;
--Group by
--1
select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
group by g.name;
--2
select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;
--3
select ar.name, count(*)
from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;
--Use Distinct
--1
select distinct composer
from track;
--2
select distinct billing_postal_code
from invoice;
--3
select distinct company
from customer;
--Delete Rows
--1
delete from practice_delete
where type = 'bronze';
--2
delete from practice_delete
where type = 'silver';
--3
delete from practice_delete
where value = 150;
--eCommerce Simulation
--step 1
create table users (
	id serial primary key,
  name varchar(50),
  email varchar(150)
);
create table products(
	id serial primary key,
  product_name varchar(150),
  price int
);
create table orders(
	order_id serial primary key,
  product_id int
);
--step 2
insert into users (name, email)
values ('Lenovo','lenny@gmail.com'),('Dell','dellbert@go.com'),('Rupert','ruru@room.net');

insert into products (product_name, price)
value ('coffee', 2.50 )('tea', 3.00 )('rum', 9.99);

insert into orders (order_id, product_id)
values (1,1), (2,3), (3,1), (4,3);
--step 3
select p.product_name from products p
join orders o on o.product_id = p.id;

select * from orders o
join products p on o.product_id = p.id;

select sum(p.price) from orders o
join products p on o.product_id = p.id
where o.order_id = 1;

alter table orders
add column users_id int references users(id);

update orders
set users_id = 1
where users_id is null;

select * from orders o
join users u on u.id = o.users_id
where u.name = 'Lenovo';

select count(order_id) from orders 0
join users u on u.id = o.users_id;