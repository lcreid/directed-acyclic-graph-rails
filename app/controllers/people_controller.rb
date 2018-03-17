class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.includes(:children).find(params[:id])
  end

  def create
    # puts pp(params.as_json)
    # puts pp(person_params.as_json)
    @person = Person.new(person_params)
    if @person.save(person_params)
      redirect_to person_path(@person)
    else
      render :new
    end
  end

  def update
    # puts pp(person_params.as_json)
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to person_path(@person)
    else
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:name,
                                   :id,
                                   child_ids: [],
                                   parent_ids: [],
                                   phones_attributes: [
                                     :id, :phone_type, :number, :_destroy
                                   ])
  end
end
