module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        # コネクションの識別キーとしてcookieからser_idを取り出す
        session_key = cookies.encrypted[Rails.application.config.session_options[:key]]
        unless session_key['warden.user.user.key'] == nil
          verified_id = session_key['warden.user.user.key'][0][0]
          verified_user = User.find_by(id: verified_id)
          return reject_unauthorized_connection unless verified_user
          verified_user
        end
      end
  end
end
