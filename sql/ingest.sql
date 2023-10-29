--This is sql code to get all the data from the S3 buckets and put it in our duckdb database 
create table yellow_tripdata 
as select * from 
read_parquet('./data/taxi/yellow_tripdata*.parquet', 
union_by_name=True, filename=True);

create table green_tripdata 
as select * from 
read_parquet('./data/taxi/green_tripdata*.parquet', 
union_by_name=True, filename=True);

create table fhv_tripdata 
as select * from 
read_parquet('./data/taxi/fhv_tripdata*.parquet', 
union_by_name=True, filename=True);

create table fhvhv_tripdata 
as select * from 
read_parquet('./data/taxi/fhvhv_tripdata*.parquet', 
union_by_name=True, filename=True);

create table fhv_bases 
as select * from  
read_csv_auto('./data/fhv_bases.csv', 
union_by_name=True, filename=True);

create table central_park_weather 
as select * from  
read_csv_auto('./data/central_park_weather.csv', 
union_by_name=True, filename=True);

create table bike_data 
as select * from  
read_csv_auto('./data/citibike-tripdata.csv.gz', compression=gzip,
union_by_name=True, filename=True);