module ProfilesHelper

    def profile_previleges(user)
      profile_type = user.profile.profile_type
    
      case profile_type
      when "adminstrador"
         return Profile.profile_types.except(:super_adminstrador)
      when "funcionario"
         return Profile.profile_types.except(:super_adminstrador, :adminstrador)
      else
         return Profile.profile_types
      end
      
    end
end
