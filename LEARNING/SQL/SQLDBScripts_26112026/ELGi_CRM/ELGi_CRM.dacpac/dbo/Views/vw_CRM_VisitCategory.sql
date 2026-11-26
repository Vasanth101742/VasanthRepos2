create view vw_CRM_VisitCategory as
select 'Visited - First PO received' as visitstatus,'Other productive visits' as VisitCategory union
select 'Visited - Customer met but Not interested','Productive for future 12 months' union
select 'Visited - Positive conversation','Productive for future 12 months' union
select 'Visited - Customer visited, Person not met','Non-Productive' union
select 'AMC Execution','Other productive visits' union
select 'Visited - Visit Successful, Potential Found','Productive for future 12 months' union
select 'Visited - No Current Demand','Other productive visits' union
select 'Visited - Fulfilled By customer stock','Other productive visits' union
select 'Visited - Not Entertaining','Other productive visits' union
select 'Visited - Follow up','Other productive visits' union
select 'Visited - Visit Attempted','Other productive visits' union
select 'Visited - Convinced','Productive for future 12 months' union
select 'Visited - Courtesy Visit','Other productive visits' union
select 'Air End Servicing','Other productive visits' union
select 'Visited - Companies visited','Other productive visits' union
select 'Visited - Positive conversations Customer','Productive for future 12 months' union
select 'Visit - Visit Successful, person met','Other productive visits' union
select 'Visited - Not Convinced','Other productive visits' union
select 'Visited - Total PO received','Other productive visits' union
select 'Not Visited - Change In Plan','Non-Productive' union
select 'Visited - Follow up done & customer convinced, health check pending','Other productive visits' union
select 'Visited - Enquiry Received (maturing within 3 months)','Other productive visits' union
select 'Visited - Positive Conversations, Potential Demand Identified','Productive for future 12 months' union
select 'Not Visited - On Leave','Non-Productive' union
select 'Visited - Does Not use Compressor','Non-Productive' union
select 'Visited - Customer not met','Non-Productive' union
select 'Visited - Quotes Submitted (Units)','Other productive visits' union
select 'Visited - Negotiation','Other productive visits' union
select 'Visited - Health check done and quotes sent, PO pending','Other productive visits' union
select 'Visited - Courtesy Visit.','Other productive visits' union
select 'Visited - Payment Collection/Payment Follow Up','Other productive visits' union
select 'Visited - Companies visited & person met','Other productive visits' union
select 'Visited - Order Won (Units)','Other productive visits' union
select 'Visited - Initial discussions positive, follow up required','Productive for future 12 months' union
select 'Not Visited - Customer Rescheduled/cancelled','Non-Productive' union
select 'Visited - Repeat PO received','Other productive visits'

GO

