# Trade lifecycle management in a bank
The trade lifecycle relational database helps to manage the lifecycle of trades from execution to settlement. It captures the trade details and tracks the status of trades in a bank’s trading system. The project was submitted as part of CFG Data and SQL course which helped me to further develop my skills beyond the SQL fundamentals of querying, filtering and aggregating data. 
The database manages the trade information by storing trade-related data in 6 tables and the stored data is also used to implement some advanced concepts into the database like trigger, event, stored function and procedure as below:

- Stored procedure to fetch trade details from a view(that combines multiple tables using joins).
- Stored function that calculates the total exposure to a counterparty.
- Trigger that monitors counterparty exposure limits and prevents trade from being inserted if it breaches the predefined limit.
- Event to automate purging of trades every 3 months that matured a long time ago. 

 A database(ER) diagram was also created in MySQL Workbench.
