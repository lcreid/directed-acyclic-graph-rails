class ParentsController < EdgeController
  def update
    super do
      if params[:checked] == "0"
        @person.parents.delete(@relative)
      else
        @person.parents << @relative
      end
    end
  end

  private

  def others_partial_path
    "children"
  end
end
