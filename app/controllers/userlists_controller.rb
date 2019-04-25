
class UserlistsController < ApplicationController

#   def new
#   @userlist = Userlist.new    


#   end

  def create

    @userlist = Userlist.create(userlist_params)
    if @userlist.save
      redirect_to article_path(@userlist.article)
    
        # ajax to be used, and stay in the same page
     end

 

  end

private
def userlist_params

  params.require(:userlist).permit(:userlist, :article_id)
end

end
