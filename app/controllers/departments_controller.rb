class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order({ :created_at => :desc })

    render({ :template => "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @department = Department.find(the_id)
    render({ :template => "departments/show" })
  end

  def create
    @course = Course.new
    @course.title = params.fetch("query_name")
    @course.term_offered = params.fetch("query_term_offered")
    @course.department_id = params.fetch("query_department_id")

    if @course.save
      redirect_to("/courses", notice: "Course created successfully.")
    else
      redirect_to("/courses", notice: "Course failed to create successfully.")
    end
  end

  def update
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.name = params.fetch("query_name")

    if @department.valid?
      @department.save
      redirect_to("/departments/#{@department.id}", { :notice => "Department updated successfully."} )
    else
      redirect_to("/departments/#{@department.id}", { :alert => "Department failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.destroy

    redirect_to("/departments", { :notice => "Department deleted successfully."} )
  end
end
