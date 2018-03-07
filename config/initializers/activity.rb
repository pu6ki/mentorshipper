module PublicActivity
  class Activity < inherit_orm('Activity')
    after_create :send_email

    def send_email
      puts '... Sending email for activity ...'
    end
  end
end
