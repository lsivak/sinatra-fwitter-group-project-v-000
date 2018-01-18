class Helper < ActiveRecord::Base

def self.current_user(session)
  @user = User.find_by(session[:id])
end

def self.logged_in?(session)
  !!session[:user_id]
end

def slug
  self.name.gsub(" ","-" ).downcase
end

def find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end
