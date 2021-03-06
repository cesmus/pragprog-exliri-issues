defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"} ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response(%{status_code: 200, body: body}), do: { :ok, body }
  def handle_response(%{status_code: ___, body: body}), do: { :error, body }
end
