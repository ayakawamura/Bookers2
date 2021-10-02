# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* def create
	@user=User.find(params[:relationship][:followed_id])
	binding.pry
	current_user.follow(@user)
	#redirect_back(fallback_location: root_path)
	redirect_to request.referer
  end

  def destroy
    @user=User.find(params[:relationship][:followed_id])
  	current_user.unfollow(@user)
  	redirect_to request.referer
  end

