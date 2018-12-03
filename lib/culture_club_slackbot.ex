defmodule CultureClubSlackbot do
  use Slack

  def handle_connect(slack, _state) do
    IO.puts("Connected as #{slack.me.name}")

    wanted_channels = ["dundee", "dundee-culture-club"]

    public_channels =
      Enum.reduce(slack.channels, [], fn {_id, info}, acc ->
        if Enum.any?(wanted_channels, fn channel -> info.name == channel end) do
          [%{id: info.id, name: info.name} | acc]
        else
          acc
        end
      end)

    private_channels =
      Enum.reduce(slack.groups, [], fn {_id, info}, acc ->
        if Enum.any?(wanted_channels, fn channel -> info.name == channel end) do
          [%{id: info.id, name: info.name} | acc]
        else
          acc
        end
      end)

    state = %{
      private_channels: private_channels,
      public_channels: public_channels,
      my_id: "<@" <> slack.me.id <> ">"
    }

    {:ok, state}
  end

  def handle_event(%{type: "message", channel: channel, text: text}, slack, state) do
    if Enum.any?(state.private_channels, fn private_channel -> private_channel.id === channel end) do
      if String.starts_with?(text, state.my_id <> " ") do
        dundee_channel =
          Enum.find(state.public_channels, fn public_channel ->
            public_channel.name === "dundee"
          end)

        cc_message = String.trim_leading(text, state.my_id)
        IO.puts("Sending message to dundee channel")
        send_message(cc_message, dundee_channel.id, slack)
      end
    end

    {:ok, state}
  end

  def handle_event(_, _, state), do: {:ok, state}

  def handle_info(_, _, state), do: {:ok, state}
end
