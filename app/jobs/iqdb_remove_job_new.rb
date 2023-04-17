class IqdbRemoveJobNew < ApplicationJob
  queue_as :iqdb_new

  def perform(post_id)
    IqdbProxyNew.remove_post(post_id)
  end
end
