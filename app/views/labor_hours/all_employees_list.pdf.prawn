pdf.start_new_page
pdf.text "Employees Working Hours" , :style => :bold
pdf.move_down 10
pdf.font_size 6

rows1 = []
rows2 = []

@total_regular_hrs = Array.new
@total_overtime_hrs = Array.new
@total_night_diff_hrs = Array.new
@total_legal_hol_hrs = Array.new
@total_special_hol_hrs = Array.new
@total_absent_hrs = Array.new
@total_late_hrs = Array.new
@total_rest_day_hrs = Array.new

@all_employees.each do |all_emp|
  @all_employees_list_lh = LaborHour.find(:all, :conditions => { :employee_id => all_emp.id } )
  
	  @fullname = all_emp.first_name.upcase + " " + all_emp.last_name.upcase
	  rows1 << ['Name :', @fullname, '', '', '', '', '', 'Branch :', all_emp.branch.location]
	  
	  rows1 << ['Date', 'Regular', 'Overtime', 'Night Differential', 'Legal Holiday', 'Special Holiday', 'Absent', 'Late', 'Rest Day']
	  
	@all_employees_list_lh.each do |all_employees_list_lh| 	  
	  	rows1 << [
	  	          all_employees_list_lh.working_date, 
	  			  all_employees_list_lh.regular, 
	  			  all_employees_list_lh.overtime, 
	  			  all_employees_list_lh.night_differential,
	  			  all_employees_list_lh.legal_holiday, 
	              all_employees_list_lh.special_holiday, 
	              all_employees_list_lh.absent, 
	              all_employees_list_lh.late, 
	              all_employees_list_lh.rest_day 	
	  			 ]
    
    end
    pdf.move_down 5
end

pdf.table rows1,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["FFFFFF", "FFFFFF"]


