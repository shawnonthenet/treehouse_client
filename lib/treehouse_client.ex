defmodule TreehouseClient do
  @moduledoc """
  Documentation for TreehouseClient.
  """

  #
  ##
  ## Events
  ##
  #
  def log_event(type, data) do
    Neuron.Config.set(url: Application.get_env(:treehouse_client, :treehouse_url))
    product_id = Application.get_env(:treehouse_client, :product_id)
    token = Application.get_env(:treehouse_client, :token)

    event = build_event(product_id, type, data)

    #run in a separate process because we don't care about the response
    Task.async(fn -> Neuron.mutation("{createEvent(event: #{event}, token:\"#{token}\") { event { id } } }") end)
  end

  defp build_event(product_id, type, data) do
    time = DateTime.to_iso8601(DateTime.utc_now)
    data = data
           |> Enum.map(fn {k, v} -> "{ key: \"#{k}\", value: \"#{v}\" }" end)
           |> Enum.join(", ")
    "{eventTime: \"#{time}\", productId: \"#{product_id}\", eventType: \"#{type}\", data: [#{data}]}"
  end

  #
  ##
  ## Support Messages
  ##
  #
  def create_support_ticket(user_id, email, subject, message) do
    Neuron.Config.set(url: Application.get_env(:treehouse_client, :treehouse_url))
    product_id = Application.get_env(:treehouse_client, :product_id)
    token = Application.get_env(:treehouse_client, :token)

    ticket = build_ticket(product_id, user_id, email, subject, message)
    Task.async(fn -> Neuron.mutation("{createSupportTicket(ticket: #{ticket}, token:\"#{token}\") { ticket { id } }}") end)
  end

  defp build_ticket(product_id, user_id, email, subject, issue) do
    "{productId: \"#{product_id}\", userId: #{user_id}, userEmail: \"#{email}\", subject: \"#{subject}\", issue: \"#{issue}\"}"
  end
end
