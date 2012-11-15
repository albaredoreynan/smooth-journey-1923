pdf.start_new_page
pdf.text "Employees Working Hours" , :style => :bold
pdf.move_down 10
pdf.font_size 6

rows1 = []
rows2 = []



@all_employees.each do |all_emp|
  @total_regular_hrs = Array.new
  @total_overtime_hrs = Array.new
  @total_night_diff_hrs = Array.new
  @total_legal_hol_hrs = Array.new
  @total_special_hol_hrs = Array.new
  @total_absent_hrs = Array.new
  @total_late_hrs = Array.new
  @total_rest_day_hrs = Array.new
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
    	@total_regular_hrs << all_employees_list_lh.regular.to_f
	    @total_overtime_hrs << all_employees_list_lh.overtime.to_f
	    @total_night_diff_hrs << all_employees_list_lh.night_differential.to_f
	    @total_legal_hol_hrs << all_employees_list_lh.legal_holiday.to_f
	    @total_special_hol_hrs << all_employees_list_lh.special_holiday.to_f
	    @total_absent_hrs << all_employees_list_lh.absent.to_f
	    @total_late_hrs << all_employees_list_lh.late.to_f
	    @total_rest_day_hrs << all_employees_list_lh.rest_day.to_f
    end
    rows1 << [
    			'Total Hours',
            	@total_regular_hrs.inject(:+),
            	@total_overtime_hrs.inject(:+),
            	@total_night_diff_hrs.inject(:+),
            	@total_legal_hol_hrs.inject(:+),
            	@total_special_hol_hrs.inject(:+),
                @total_absent_hrs.inject(:+),
             	@total_late_hrs.inject(:+),
             	@total_rest_day_hrs.inject(:+)
             ]
    rows1 << ['','','','','','','','','']
end

pdf.table rows1,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["FFFFFF", "FFFFFF"]
pdf.move_down 5


