  
CREATE procedure PCR_Status_data_inserting as   
  
begin   
  
truncate table [pcr_status]  
  
insert into [pcr_status] 

select distinct    
a.pcr_id 'PCR_ID',a.pcr_date'PCR Raised At',j.emp_name 'PCR raised by',f.name'Plant',d.name'Function',g.name 'Subfunction',c.name 'Type of change',e.name'Category of change'  
,b.name'Reason for Change',a.change_reason_comments 'Reason for Change-Comments',change_benefit'Benefit of Change',present_details'Present Details',proposed_details,process_stepno,  
process_name,process_diarefno,change_period 'Change Impacting Period',change_period_fdt'Change Impacting Period - From Date',change_period_tdt 'Change Impacting Period - To Date',  
change_eval 'Change evaluation criteria / parameter',trial_qty,k.emp_name 'Reporting Manager',hod_appr_comments 'Approval / Rejection Comments',h.resp_name 'Responsible Function',pilot_lot,pilot_lot_reason  'If Pilot Lot NO, Reason',  
r1_changeeval 'Pilot Lot - Change Evaluation Criteria / Parameter',r1_actual 'Pilot Lot - Actual',change_effect 'Pilot Lot - Is any adverse effect of change',  
change_effect_reason 'Pilot Lot - If YES, Reason',  
r2_changeeval 'Production Lot - Change Evaluation Criteria / Parameter',r2_actual'Production Lot - Actual',  
r2_change_effect 'Production Lot - Is any adverse effect of change',r2_change_effect_reason 'Production Lot - If YES, Reason',pro_tardt'Proposed Target Date',pcr_closing_date 'Actual Completion Date',  
pcn_no 'PCN Number',  
case when a.pcr_status='A' then concat('Pending with ',i.Function_name ,' for approval')  
when a.pcr_status='A1' then concat('Pilot lot waiting for approval with ',i.function_name)  
when a.pcr_status='A2' then concat('Final approval pending with ',i.Function_name)  
when a.pcr_status='P' then 'Pending with Reporting manager approval'  
when a.pcr_status='C' then 'Closed'  
when a.pcr_status='CL' then 'Clarification'  
when a.pcr_status='R1' then concat('Pending with  ',h.resp_name,' for pilot lot updation')  
when a.pcr_status='R2' then concat('Pending with ', h.resp_name,' for production lot updation')  
when a.pcr_status='REJ' or a.pcr_status='R' then 'Rejected'  
END 'PCR Status1',  
  
--Summarizing w/o function names  
case   
when a.pcr_status='P' OR a.pcr_status='A'  then 'Pending with CFT approval'  
when a.pcr_status='A1' then 'Pending for Pilot lot approval'  
when a.pcr_status='A2' then 'Pending for Final approval'  
when a.pcr_status='C' then 'Closed'  
when a.pcr_status='CL' then 'Clarification'  
when a.pcr_status='R1' then 'Pending for Pilot lot updation'  
when a.pcr_status='R2' then 'Pending for Production lot updation'  
when a.pcr_status='REJ' or a.pcr_status='R' then 'Rejected'  
  
end 'PCR_status2',  
case   
when a.pcr_status='P' OR a.pcr_status='A'  then 3  
when a.pcr_status='A1' then 5  
when a.pcr_status='A2' then 7  
when a.pcr_status='C' then 8  
when a.pcr_status='CL' then 1  
when a.pcr_status='R1' then 4  
when a.pcr_status='R2' then 6  
when a.pcr_status='REJ' or a.pcr_status='R' then 2  
  
end 'PCR_status2_Ordering',  
  
  
  
--For A & P alone employee name should come   
case when a.pcr_status='A'  then concat('Approval Pending with ',l.emp_name)   
 when a.pcr_status='A1' then concat('Pilot lot waiting for approval with ',i.function_name)  
 when a.pcr_status='A2' then concat('Final approval pending with ',i.Function_name)  
    when a.pcr_status='P' then concat('Approval Pending with Reporting manager ',k.emp_name)  
 when a.pcr_status='R1' then concat('PCR pending with ',h.resp_name)  
 when a.pcr_status='R2' then concat('PCR pending with ',h.resp_name)  
end 'PCR Pending with whom',  
case when datediff(d,a.pcr_date,GETDATE()) <=30 then '<30'  
  when datediff(d,a.pcr_date,GETDATE()) >=31 and  datediff(d,a.pcr_date,GETDATE()) <=60 then '31-60'  
  when datediff(d,a.pcr_date,GETDATE()) >=61 and  datediff(d,a.pcr_date,GETDATE()) <=90 then '61-90'  
  when datediff(d,a.pcr_date,GETDATE()) >=91 and  datediff(d,a.pcr_date,GETDATE()) <=150 then '91-150'  
  when datediff(d,a.pcr_date,GETDATE()) >=151 and  datediff(d,a.pcr_date,GETDATE()) <=300 then '151-300'  
  when datediff(d,a.pcr_date,GETDATE()) >300 then '>300'  
  end 'Ageing',  
case when datediff(d,a.pcr_date,GETDATE()) <=30 then 1  
  when datediff(d,a.pcr_date,GETDATE()) >=31 and  datediff(d,a.pcr_date,GETDATE()) <=60 then 2  
  when datediff(d,a.pcr_date,GETDATE()) >=61 and  datediff(d,a.pcr_date,GETDATE()) <=90 then 3  
  when datediff(d,a.pcr_date,GETDATE()) >=91 and  datediff(d,a.pcr_date,GETDATE()) <=150 then 4  
  when datediff(d,a.pcr_date,GETDATE()) >=151 and  datediff(d,a.pcr_date,GETDATE()) <=300 then 5  
  when datediff(d,a.pcr_date,GETDATE()) >300 then 6  
  end 'Ageing_sorting'  
      
FROM pcr_master a  
  
left join pcr_change_reason_master b on a.change_reason=b.id  
left join pcr_change_type_master c on a.change_type=c.id  
left join pcr_function_master d on a.[function]=d.id  
left join pcr_change_category_master e on a.change_category=e.id  
left join pcr_plant_master f on a.plant=f.id  
left join pcr_subfunction_master g on a.subfunction=g.id  
left join pcr_respfunction_master h on a.responsible_function=h.resp_id  
left join (select[function] 'Function_name',pcr_id,appr_status,[type],appr_code from pcr_approvals) i on i.pcr_id=a.pcr_id   
and i.appr_status='P'  
left join employee_detail j on  a.created_by=j.emp_code  

--for reporting manager purpose
join employee_detail k on j.isemp_code=k.emp_code  
  
--for Pending approval with whom except pending approval with reporting manager  
left join employee_detail l on i.appr_code=l.emp_code  
  
end

GO

