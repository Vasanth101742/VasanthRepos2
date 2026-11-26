create view [dbo].[vw_DeliveryTerms_Master] as
select '001' as DelvCode, 'FREIGHT PAID BASIS' as DelvDesc union
select '002', 'BY ROAD ON FRT. TOPAY BASIS' union
select '003', 'FREIGHT PAID - D/D AGST. C/C' union
select '004', 'PAID - DOOR DELY CC ATTACHED' union
select '005', 'PAID - DD AGST CC REIMBURSED' union
select '006', 'FREIGHT PAID - DIRECT DELIVERY' union
select '007', 'FREIGHT-TO PAY ON COD BASIS' union
select '008', 'FREIGHT PAID ON COD BASIS' union
select '009', 'FREIGHT PAID-D D (L C V)' union
select '010', 'PAID-DOOR DELY REIM-FTL' union
select '011', 'PAID-DOOR DELY REIM CC ATTACHD' union
select '012', 'PAID-DD AGAINST CC-REIM (FTL)' union
select '013', 'PAID-DD AGST CC REIM-PART LOAD' union
select '014', 'PAID - DOOR DELY REIM TAURUS' union
select '015', 'PAID - DOOR DELY TRAILER' union
select '016', 'PAID - DOOR DELY (TAURUS)' union
select '017', 'TOPAY-FTL GODOWN DELY-DACC' union
select '018', 'PAID-REIM DOOR DELY(TAURUS)' union
select '019', 'PAID- DOOR DELY REIMB-TRAILER' union
select '020', 'TOPAY - DOOR DELY OPEN TRUCK' union
select '021', 'PAID-DOOR DELY-PART LOAD REIM' union
select '022', 'PAID-DOOR DELY - OPEN TRUCK' union
select '023', 'TOPAY-DOOR DELY TRAILER' union
select '024', 'PAID-D/DELY(FTL)SPECIAL RATE' union
select '025', 'TOPAY DD WITHOUT CC FTL' union
select '026', 'PAID DD WITHOUT CC FTL' union
select '027', 'PAID DD REIM WITHOUT CC FTL' union
select '028', 'TOPAY DD WITHOUT CC PART LOAD' union
select '029', 'PAID DD WITHOUT CC PART LOAD' union
select '030', 'PAID DD REIM W/O CC PART LOAD' union
select '031', 'PAID GODOWN DELIVERY REIM' union
select '110', 'Del. by Rd at IH,pymt by ELGI' union
select '111', 'Del. by Rd at IH,pymt by Supp.' union
select '112', 'FREIGHT PAID - GODOWN DELIVERY' union
select '113', 'By Air' union
select '115', '10-12 Weeks' union
select '116', 'Inclusive of packing&forwardin' union
select '117', '100% Payment clearance' union
select '120', 'Del. by Rly at IH,Frt by ELGI' union
select '121', 'Del. by Rly at IH,Frt by Supp.' union
select '122', 'PAID DOOR DELIVERY WITHOUT CC' union
select '123', 'Door Delivery' union
select '130', 'Del.by Ship, Freight by ELGI' union
select '131', 'Del.by Ship, Freight by Suppl.' union
select '140', 'Del.by Air at IH, Frt by ELGI' union
select '141', 'Del.by Air at IH, Frt by Supp.' union
select '142', 'FCA - Free Carrier' union
select '150', 'Del.by Cour at IH,Frt by ELGI.' union
select '151', 'Del.by Cour at IH,Frt by Supp.' union
select '160', 'Del.by RPP  at IH,Frt by ELGI.' union
select '161', 'Del.by RPP  at IH,Frt by Supp.' union
select '170', 'Del.by Elgi Transport at IH  .' union
select '210', 'Del.by Rd, at Kurcy Frt- ELGI' union
select '211', 'Del.by Rd, at Kurcy Frt- Suppl' union
select '220', 'Del.by Rail at Kurcy,Frt-ELGI.' union
select '221', 'Del.by Rail at Kurcy,Frt-Suppl' union
select '240', 'Del.by Air  at Kurcy,Frt-ELGI.' union
select '241', 'Del.by Air  at Kurcy,Frt-Suppl' union
select '250', 'Del.by Cour at Kurcy,Frt-ELGI.' union
select '251', 'Del.by Cour at Kurcy,Frt-Suppl' union
select '252', 'Immediate' union
select '260', 'Del.by RPP  at Kurcy,Frt-ELGI.' union
select '261', 'Del.by RPP  at Kurcy,Frt-Suppl' union
select '270', 'Del.by RPP at Kurcy,Frt ELGI' union
select '310', 'Del.by Road at EIC,Frt by ELGI' union
select '311', 'Del.by Road at EIC, Frt by Sup' union
select '320', 'Del.by Rail at EIC,Frt by ELGI' union
select '321', 'Del.by Rail at EIC,Frt by Supp' union
select '340', 'Del.by Air, at EIC,Frt by ELGI' union
select '341', 'Del.by Air, at EIC,Frt by Supp' union
select '350', 'Del by Cour,at EIC,Frt by ELGI' union
select '351', 'Del by Cour,at EIC,Frt by Supp' union
select '360', 'Del by RPP.,at EIC,Frt by ELGI' union
select '361', 'Del by RPP.,at EIC,Frt by Supp' union
select '370', 'Del by Elgi Transport' union
select '410', 'Del Ex Wrks by Rd, Frt by ELGI' union
select '411', 'Del Ex Wrks by Rd, Frt by Supp' union
select '412', 'Deli by Road, FRT by Supplier' union
select '500', 'F.O.R COIMBATORE' union
select '501', 'FREIGHT PAID-REIMBURSED' union
select '502', 'BY RAIL-FREIGHT TO PAY' union
select '503', 'BY RAIL-FRT PAID-REIMBURSEMENT' union
select '504', 'FOB INDIAN PORT BY SEA/AIR' union
select '505', 'CIF COLOMBO' union
select '506', 'SEA FRT PAID/NO REIMBURSEMENT' union
select '507', 'HAND COLECTION BY CLIENT' union
select '508', 'TO PAY-D/D AGA CONSIGNEE COPY' union
select '509', 'TOPAY-DOOR DELIVERY CC ATTACHE' union
select '510', 'PREPAID-REIMBURSED' union
select '511', 'LOCAL DELIVERY-PARTY''S VEHICLE' union
select '512', 'EX-WORKS COIMBATORE' union
select '513', 'CIF - HAMBURG' union
select '514', 'C & F COLOMBO' union
select '515', 'CIF PORT LOUIS' union
select '516', 'C & F DOHA' union
select '517', 'C & F BENAPOLE' union
select '518', 'C & F NEW YORK' union
select '519', 'C & F KUWAIT' union
select '520', 'C & F DUBAI' union
select '521', 'C & F ALEXANDRIA' union
select '522', 'C & F RIYADH' union
select '523', 'CIF NEW YORK' union
select '524', 'C & F SULTAN OF QABOOS' union
select '525', 'C & F  TEMA' union
select '526', 'C & F  JEBEL ALI' union
select '527', 'FREIGHT PAID - GODOWN DELIVERY' union
select '528', 'C & F BAHRAIN' union
select '529', 'C I F BANGKOK' union
select '530', 'C I F HEIDENHEIM' union
select '531', 'C & F MOMBARA' union
select '532', 'C & AQABA PORT (JORDAN)' union
select '533', 'C & F LAGOS' union
select '534', 'C & F LATTAKIYA' union
select '535', 'C & F MUSCAT' union
select '536', 'C I F BEIRUT' union
select '537', 'C I F MELBOURNE' union
select '538', 'C & F AQABA' union
select '539', 'C & F CHITTAGONG' union
select '540', 'TOPAY - DOOR DELIVERY ( LCV)' union
select '541', 'PAID -DOOR DELIVERY FTL' union
select '542', 'TOPAY-DOOR DELIVERY BY COURIER' union
select '543', 'PAID-DOOR DELIVERY-LCV(REIMB)' union
select '544', 'TO PAY - GODOWN DELIVERY (LCV)' union
select '545', 'TO-PAY DOOR DELIVERY (FTL)' union
select '546', 'PAID - GODOWN DELIVERY' union
select '547', 'PAID - D/D AGNST C/COPY (LCV)' union
select '548', 'TOPAY - D/DELY ANGST C/C (LCV)' union
select '549', 'DDU-Coimbatore,Tamilnadu,India' union
select '550', 'PAID -D/DELY BY COURIER' union
select '551', 'DDP(DELIVERED DUTY PAID)' union
select '579', 'TOPAY-DOOR DELY AGNST C/C(FTL)' union
select '580', 'PAID-D/D AGNST C/C (FTL)' union
select '581', 'TOPAY - GODOWN DELIVERY' union
select '582', 'PAID-REIM  D/D ANST C/C (FTL)' union
select '583', 'CIF PORT KLANG, MALAYSIA' union
select '584', 'TOPAY -DELY AT TCI GODOWN PUNE' union
select '585', 'PAID -DOOR DELY -REIMSURED(FTL' union
select '586', 'C & F-NINGBO - CHINA' union
select '587', 'TOPAY-GODOWN DELY-TCI PANIPAT' union
select '588', 'TOPAY-D/D AGNST C/C FTL' union
select '589', 'TOPAY - GODOWN DELIVERY' union
select '590', 'FOB-ICD SINGANALLUR' union
select '591', 'FOB-INDIAN PORT' union
select '592', 'C I F' union
select '593', 'C N F' union
select '594', 'PAID -GODOWN DELIVERY' union
select '595', 'TOPAY - DOOR DELIVERY BY AIR' union
select '596', 'PAID-AIR FREIGHT' union
select '597', 'PAID - REIMBURSED -FTL' union
select '598', 'PAID - DOOR DELY (TAURUS) REIM' union
select '599', 'TOPAY - BY AIR' union
select '600', 'PAID-FTL AGAINST CONSIGNEE COY' union
select '601', 'PAID-DOOR DELY BY AIR' union
select '602', 'TOPAY-DOORDELY(TAURUS LOAD)' union
select '603', 'PAID- DOOR DELY PART LOAD' union
select '604', 'TOPAY- DOOR DELY PART LOAD' union
select '605', 'PAID-REIM-DACC (TAURUS)' union
select '606', 'PAID-DACC (TAURUS LOAD)' union
select '610', '15 Days from the Date of PO' union
select '613', '5 Days' union
select '614', '10to15 Days(Freight paid elgi)' union
select '615', 'After Payment' union
select '616', 'To pay' union
select '617', '6-8 WEEKS' union
select '618', '2 Weeks' union
select '619', 'By Road' union
select '620', 'By Elgi' union
select '621', 'Freight by Elgi' union
select '626', 'Ex-Works' union
select '627', 'CIP - CHENNAI AIRPORT' union
select '628', 'FOB - Freight on-board' union
select '630', '10 Days' union
select '631', '15 Days' union
select '632', 'FOB Ocean Freight Ship Charges' union
select '633', '4-6 Weeks' union
select '700', 'DELIVERY AT PLACE' union
select '728', 'Freight by Elgi' union
select '729', '100% Prior to Dispatch' union
select '730', '30 Days' union
select '910', 'Del.by Road at GSC,Frt by ELGI' union
select '911', 'Del.by Road at GSC, Frt by Sup' union
select '912', 'Del.by Road at ESCLFrt by ELGI' union
select '913', 'Del.by Road at ESCLFrt by Supp' union
select '914', 'Del.by Road at ACP,Frt by ELGI' union
select '915', 'Del.by Road at ACP,Frt by Supp' union
select '999', 'aaa' union
select 'A01', 'PREPAID - D A C C' union
select 'A02', 'PREPAID - DOOR DELIVERY' union
select 'NPF', 'Delivery at Nallatipalayam Far' union
select 'RLY', 'PAID - D/D AGNST C/COPY (LCV)'

GO

