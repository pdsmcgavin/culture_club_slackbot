defmodule CultureClubSlackbot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Slack.Bot.start_link(
      CultureClubSlackbot,
      [],
      System.get_env("SLACK_TOKEN")
    )
  end
end
