# @see https://developers.podio.com/doc/conversations
class Podio::ConversationEvent < ActivePodio::Base
  property :event_id, :integer
  property :action, :string # message, participant_add, participant_leave
  property :created_on, :datetime

  has_one :data, :class_property => :action, :class_map => { :message => 'ConversationMessage', :participant_leave => 'User', :participant_add => 'User' }
  has_one :created_by, :class => 'ByLine'
  has_one :created_via, :class => 'Via'

  alias_method :id, :event_id

  class << self
    # @see https://developers.podio.com/doc/conversations/get-conversation-events-35440697
    def find_all(conversation_id, options = {})
      list Podio.connection.get { |req|
        req.url("/conversation/#{conversation_id}/event/", options)
      }.body
    end
  end

end