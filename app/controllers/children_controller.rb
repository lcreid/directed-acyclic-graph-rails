class ChildrenController < EdgeController
  def update
    super do
      if params[:checked] == "0"
        @person.children.delete(@relative)
      else
        @person.children << @relative
      end
    end
  end

  private

  def others_partial_path
    "parents"
  end
end
