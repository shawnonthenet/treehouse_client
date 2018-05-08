defmodule TreehouseClient do
  @moduledoc """
  Documentation for TreehouseClient.
  """

  def log_event(type, data) do
    Neuron.Config.set(url: Application.get_env(:treehouse_client, :treehouse_url))
    product_id = Application.get_env(:treehouse_client, :product_id)
    token = Application.get_env(:treehouse_client, :token)

    event = build_event(product_id, type, data)

    Neuron.mutation("{createEvent(event: #{event}, token:\"#{token}\") { event { id } } }")
  end

  defp build_event(product_id, type, data) do
    time = DateTime.to_iso8601(DateTime.utc_now)
    data = data
           |> Enum.map(fn {k, v} -> "{ key: \"#{k}\", value: \"#{v}\" }" end)
           |> Enum.join(", ")
    "{eventTime: \"#{time}\", productId: \"#{product_id}\", eventType: \"#{type}\", data: [#{data}]}"
  end
end
