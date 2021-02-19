class Users::InvitationsController < Devise::InvitationsController
    before_action -> { require_role(:root, :admin) }, only: [:new, :create]
end
