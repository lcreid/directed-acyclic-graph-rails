class EdgeController < ApplicationController
  def update
    @person = Person.find(params[:id])
    @relative = Person.find(params[:relative_id])
    # puts "IN EdgeController update @person #{@person.inspect} relative: #{@relative.inspect}"
    yield

    if @person.save
      respond_to do |format|
        format.js do
          render locals: { partial_path: others_partial_path }
        end
      end
    else
      render :edit
    end
  end
end
