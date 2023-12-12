.echo on

pivot "main"."main"."mart__fact_trips_by_borough" ON borough USING FIRST(all_trips);

SELECT 

  
    sum(
      
      case
      when borough = 'Queens'
        then 1
      else 0
      end
    )
    
      
            as "Queens"
      
    
    ,
  
    sum(
      
      case
      when borough = 'Brooklyn'
        then 1
      else 0
      end
    )
    
      
            as "Brooklyn"
      
    
    ,
  
    sum(
      
      case
      when borough = 'Manhattan'
        then 1
      else 0
      end
    )
    
      
            as "Manhattan"
      
    
    ,
  
    sum(
      
      case
      when borough = 'Staten Island'
        then 1
      else 0
      end
    )
    
      
            as "Staten Island"
      
    
    ,
  
    sum(
      
      case
      when borough = 'Bronx'
        then 1
      else 0
      end
    )
    
      
            as "Bronx"
      
    
    ,
  
    sum(
      
      case
      when borough = 'Unknown'
        then 1
      else 0
      end
    )
    
      
            as "Unknown"
      
    
    ,
  
    sum(
      
      case
      when borough = 'EWR'
        then 1
      else 0
      end
    )
    
      
            as "EWR"
      
    
    
  

FROM "main"."main"."mart__fact_trips_by_borough"